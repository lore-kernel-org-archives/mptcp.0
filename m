Content-Type: multipart/mixed; boundary="===============2188845676799556961=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Mon, 02 Dec 2019 09:27:57 -0800
Message-ID: <20191202172757.GA84163@MacBook-Pro-64.local>
In-Reply-To: 83BFBFD6-255E-4022-96D4-BE183B709CB2@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2749

--===============2188845676799556961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Alan,

On 29/11/19 - 21:13:38, Alan Ford wrote:
> > On 28 Nov 2019, at 19:49, Christoph Paasch <cpaasch(a)apple.com> wrote:
> >> On Nov 28, 2019, at 8:16 AM, Alan Ford <alan.ford(a)gmail.com <mailto:=
alan.ford(a)gmail.com>> wrote:
> >>> On 27 Nov 2019, at 19:29, Christoph Paasch <cpaasch(a)apple.com <mail=
to:cpaasch(a)apple.com>> wrote:
> >>> Section 3.3.1, page 32 & 33, "A data sequence mapping does not need..=
."
> >>> =

> >>> This paragraph states that it is permissive to send a mapping in adva=
nce. Late-mapping is specified a bit higher around the sentence =

> >>> "Implementations MAY hold onto such unmapped data for a short while i=
n the expectation that a mapping will arrive shortly"
> >>> =

> >>> This kind of early/late mapping announcements are difficult to handle=
 in an implementation. The Linux Kernel implementation of multipath-tcp.org=
 <http://multipath-tcp.org/> has always disallowed such kind of mappings. M=
eaning, whenever a DSS-option is received such that the range specified by =
the relative subflow-sequence number in the DSS-option and the data-length =
does not (partially) cover the TCP sequence number of the packet itself, th=
e subflow will be killed with a TCP-RST. The problem around handling such e=
arly/late mappings is that it is unclear for how long the stack needs to re=
member these mappings (in the early-mapping case), or for how long he needs=
 to hold on to the data (in the late-mapping case).
> >>> =

> >>> We thus suggest to change this to the following:
> >>> Whenever a DSS-option is received on a packet such that the mapping o=
f the subflow-sequence space does not partially cover the TCP-sequence numb=
er of  the packet itself, the host MUST discard this mapping and MAY destro=
y the subflow with a TCP-RST. It should be noted that a DATA_FIN that does =
not come with data has a relative subflow-sequence number of 0 and thus sho=
uld be handled separately.
> >> =

> >> This one I do have an issue with:
> >> =

> >> - It is a technical change
> >> - Wording to this effect has been in the document since pretty much th=
e beginning
> >> - It is a MAY which might as well say =E2=80=9Cthere is no guarantee t=
his would work=E2=80=9D
> > =

> > The problem with the MAY is that the sender can't really know if the re=
ceiver accepts it (more regarding this below)
> > =

> >> Most importantly, the replacement text seems not to address this issue=
 at all. If I read it correctly, it says that the data sequence mapping opt=
ion MUST partially cover the subflow sequence space of the packet itself. B=
ut that has nothing to do with late or early mapping, both could partially =
cover the subflow sequence space and preceding data.
> >> =

> >> Can you clarify exactly what you want to permit and prevent, here?
> > =

> > Let me try to clarify what exactly we mean with early/late mapping so t=
hat we are all on the same terms here:
> > =

> > Early mapping:
> > =

> > A TCP-segment with sequence-number 1 holds a DSS-option with subflow-se=
quence number 1001 and data-length 100. This means we need to allocate spac=
e to store this DSS-option so that when the TCP-segment with seqno 1001 arr=
ives we can know the mapping. There may be coming more of these DSS-options=
 which all need to be stored in allocated memory. It is unclear what the li=
mit to this is and there is no way to communicate this limit to the sender.
> =

> I don=E2=80=99t think we have ever intended to support a mapping like thi=
s. If the text is not clear here then yes, we might have an issue.

Yes, I do think that the text is not very clear on that  - we should clarify
that.

> We intend only to support: A TCP segment with sequence-number 1 holds a D=
SS option for SSN 1 and length 10000 (so multiple segments in the future).

Sounds good!

> Or, slightly more convoluted, a TCP segment with SN 100, length 100, whic=
h holds a DSS option for 151-250, and bytes 50-150 were already covered by =
a previous mapping.

Also good.

> I do not believe we have ever intended mappings on data segments where th=
e segments do not include any of the mapped data. We did, however, intend t=
o support mappings on pure ACKs in order to avoid any option space limits.

Mappings on a pure ACK are an unlikely use-case. The problem is that in the
end the mapping needs to reliably make it to the receiver as otherwise he
needs to throw the data away. Combining it with data implicitly makes it
reliable.

In case of option-space limits, it is better to send the options that do
consume a lot of space (ADD_ADDR,...) on the pure ACK.

> =

> > Late mapping:
> > =

> > The receiver receives data without DSS-options with TCP-sequence 1 to 1=
001. The corresponding DSS-option however arrives with the TCP-segment with=
 seqno 2001. Here, the receiver needs to hold on to this data, waiting for =
the TCP-segment with the DSS-option. At one point the receiver needs to dro=
p the data due to memory limits. Again, the sender has no way for knowing w=
hat this limit is.
> =

> So this is slightly more problematic, and this is what the MAY in the tex=
t is designed to discuss.
> =

> I believe we had intended to support a situation where you could have a s=
egment 1-1000 without a DSS option, and 1001-2000 also without, and then 20=
01-3000 with the option then providing a mapping for 1 to 2001 or higher.

I think this scenario is fine to some extend with a slight change that the
provided mapping should be for 1 to 2002 or higher (thus, including the byte
of the 2001-3000 segment).

> This would allow a sender to start pushing out data before it knew what a=
 mapping might look like.
> It does, however, seem an unlikely situation but you as a receiver could =
of course reduce the subflow window size in order to limit buffering. The t=
ext does recognise the memory issue and point out that this won=E2=80=99t b=
e DATA ACKed and as such a sender should soon realise and retransmit on a s=
eparate subflow and then this subflow may eventually be closed.

Yes, it seems like an unlikerly situation and I'm not sure about the
use-case for doing this.

> Another situation would involve two mappings on the same TCP segment. If =
the first 50 bytes of a segment are covered by the mapping provided in that=
 segment, but there are then also another 50 bytes, then the mapping can=E2=
=80=99t be provided until the next segment.

Yes, two mappings on a single packet are problematic simply because of the
lack of option-space.

> I guess my initial thought here is that this was intended to cover a numb=
er of corner cases but if it does not work for you then there are several c=
ompliant ways of dealing with it.
> =

> > When the DSS-option comes together with the corresponding TCP-sequence =
it is straight-forward to store it together with the data. There are no iss=
ues with memory-allocation,... as all of this is accounted together with th=
e announced window (yes, the memory is not counted against the window, but =
the receiver can foresee the DSS-option overhead when computing what window=
 he should announce).
> > =

> > When a receiver gets data without a DSS-option, he can store it for up =
to 64KB of data as that is the maximum data-level length and the last segme=
nt of the 64KB-train could be holding the DSS-option. After that he has to =
drop the data.
> > =

> > When the mapping partially covers the segment it also isn't a problem a=
s the unmapped part can safely be dropped and the mapped part can be passed=
 on to the MPTCP-layer.
> > =

> > All of this does not imply that every segment of a mapping needs to hol=
d the DSS-option. Just one of them needs to have it.
> =

> That last statement aligns with what was intended in the text. But are yo=
u really saying that, or are you saying that the first one needs to have it=
? Because that would be a change.

No, the first one does not need to have it. Just one of them.


Cheers,
Christoph

--===============2188845676799556961==--
