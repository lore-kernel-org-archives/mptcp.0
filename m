Content-Type: multipart/mixed; boundary="===============3265473686022093808=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] RFC6824bis edits based on implementation
 feedback
Date: Fri, 03 Jan 2020 11:04:17 +0100
Message-ID: <aff43662f7ad6e5c83c3614fe6626434327b2a76.camel@redhat.com>
In-Reply-To: 20200102182655.GB44237@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3253

--===============3265473686022093808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2020-01-02 at 10:26 -0800, Christoph Paasch wrote:
> On 01/01/20 - 22:51:32, Alan Ford wrote:
> > We=E2=80=99d love to get this to a state of completion as soon as possi=
ble, and to this end I am starting a new thread on this topic. In discussio=
n with the chairs, it is possible to make the desired changes in AUTH48 as =
long as there is WG consensus. The discussion so far has been fairly limite=
d in terms of participation.
> > =

> > I would ask the chairs please if it was possible to specify a time boun=
d for this discussion and a default conclusion.
> > =

> > Regarding the changes, in summary, there are two areas where changes ha=
ve been requested by the implementation community. As we are the IETF we ob=
viously have strong focus on =E2=80=9Crunning code=E2=80=9D and so ease of =
implementing standards-compliant code is strongly desirable. However, we do=
 not wish to reduce functionality agreed by the IETF community if it is con=
sidered a required feature by the community.
> > =

> > =

> > Change 1
> > =

> > Change the sentence reading:
> > =

> >    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data =
Sequence Signal (DSS) option (Section 3.3). =

> > =

> > To:
> > =

> >    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data Seque=
nce Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPA=
BLE (which is the first octet of the data sequence space).
> > =

> > What this means:
> > =

> > The current text is concerned only with ensuring a path is MPTCP capabl=
e, and so only cares that DSS option occurs on a data packet. However, the =
MP_CAPABLE option is defined to occupy the first octet of data sequence spa=
ce and thus, if analogous to TCP, must be acknowledged. From an implementat=
ion point of view it would make sense not to have this hanging around forev=
er and instead define it is acknowledged at the connection level as soon as=
 received. This change ensures the first data packet also DATA_ACKs this MP=
_CAPABLE octet.
> > =

> > =

> > Change 2
> > =

> > Change the sentence reading:
> > =

> >    A Data Sequence Mapping does not need to be included in every MPTCP =
packet, as long as the subflow sequence space in that packet is covered by =
a mapping known at the receiver.
> > =

> > To:
> > =

> >    The mapping provided by a Data Sequence Mapping MUST apply to some o=
r all of the subflow sequence space in the TCP segment which carries the op=
tion. It does not need to be included in every MPTCP packet, as long as the=
 subflow sequence space in that packet is covered by a mapping known at the=
 receiver.
> > =

> > What this means:
> > =

> > The current text does not place any restrictions on where a mapping cou=
ld appear. In theory a sender could define a thousand different mappings up=
 front, send them all, and expect a receiver to store this and reassemble d=
ata according to these mappings as it arrives. Indeed, this was never expli=
citly disallowed since it =E2=80=9Cmight have been useful=E2=80=9D. The imp=
lementation community, however, has expressed concerns over the difficulty =
of implementing this open-endedly. How many mappings is it reasonable to st=
ore? Is there a DoS risk here? Instead, it has been requested that thee spe=
cification restricts the placement of the DSS option to being within the su=
bflow sequence space to which it applies.
> > =

> > =

> > Please can members of the WG express whether they are happy with these =
changes, or concerned.
> =

> As an implementor and having been the one kicking off this discussion, I =
fully
> support this change.

As member of the community currently involved into the Linux MPTCP
implementation effort, I fully endorse both changes.

Thanks,

Paolo

--===============3265473686022093808==--
