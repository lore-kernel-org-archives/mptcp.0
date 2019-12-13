Content-Type: multipart/mixed; boundary="===============3803419603683565427=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Fri, 13 Dec 2019 10:24:09 -0800
Message-ID: <20191213182409.GB9430@MacBook-Pro-64.local>
In-Reply-To: fb16f29f7ecc.5df421a5@nic.in
X-Status: 
X-Keywords:                  
X-UID: 2973

--===============3803419603683565427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/12/19 - 23:41:25, V Anil Kumar wrote:
> Hi Christoph,
> =

> Thanks again for your reply. My response is given inline.
> =

> On 12/13/19 09:59 PM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> > =

> > =

> > =

> > =

> > =

> > =

> > Hello,
> > =

> > =

> > =

> > > On Dec 12, 2019, at 9:53 PM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> > > =

> > > =

> > =

> > =

> > > =

> > >  Hi Christoph,
> > > =

> > > Thanks for your reply. Please see inline.
> > > =

> > > On 12/12/19 12:52 AM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Hello,
> > > > =

> > > > =

> > > > =

> > > > =

> > > > > =

> > > > > On Dec 10, 2019, at 12:04 PM, V Anil Kumar
> > > > > <anil(a)csir4pi.in(javascript:main.compose()> wrote:
> > > > > =

> > > > > =

> > > > > Hi Alan, =

> > > > > =

> > > > > =

> > > > > =

> > > > > Please see inline.
> > > > > =

> > > > > On 12/06/19 09:28 PM,Alan
> > > > > Ford<alan.ford(a)gmail.com(javascript:main.compose()> wrote: =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Hi all,
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Following on from the discussion of implementation feedback with
> > > > > > Christoph, I propose the following edits to RFC6824bis - which
> > > > > > is currently in AUTH48 - as clarifications.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > ADs, please can you confirm you consider these edits
> > > > > > sufficiently editorial to fit into AUTH48.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > WG participants, please speak up if you have any concerns.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Edit 1, clarifying reliability of MP_CAPABLE
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Change the sentence reading:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  The SYN with MP_CAPABLE occupies the first octet of data
> > > > > >  sequence space, although this does not need to be acknowledged
> > > > > >  at the connection level until the first data is sent (see
> > > > > >  Section 3.3).
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > To:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  The SYN with MP_CAPABLE occupies the first octet of data
> > > > > >  sequence space, and this MUST be acknowledged at the connection
> > > > > >  level at or before the time the first data is sent or received
> > > > > >  (see Section 3.3).
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Change the sentence reading:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  If B has data to send first, then the reliable delivery of the
> > > > > >  ACK + MP_CAPABLE can be inferred by the receipt of this data
> > > > > >  with an MPTCP Data Sequence Signal (DSS) option (Section 3.3). =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > To:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  If B has data to send first, then the reliable delivery of the
> > > > > >  ACK + MP_CAPABLE is ensured by the receipt of this data with an
> > > > > >  MPTCP Data Sequence Signal (DSS) option (Section 3.3)
> > > > > >  containing a DATA_ACK for the MP_CAPABLE=C2=A0(which is the fi=
rst
> > > > > >  octet of the data sequence space).
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > In my personal opinion either one of these edits would be
> > > > > > sufficient for making the point, however clearly this has caused
> > > > > > some confusion amongst the implementor community so making both
> > > > > > these changes should make it absolutely clear as to the expected
> > > > > > behaviour here.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Edit 2, mapping constraint
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Change the sentence reading:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  A Data Sequence Mapping does not need to be included in every
> > > > > >  MPTCP=C2=A0packet, as long as the subflow sequence space in th=
at
> > > > > >  packet is=C2=A0covered by a mapping known at the receiver.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > To:
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  A Data Sequence Mapping MUST appear on a TCP segment which is
> > > > > >  covered by the mapping. It does not need to be included in
> > > > > >  every MPTCP=C2=A0packet, as long as the subflow sequence space=
 in
> > > > > >  that packet is=C2=A0covered by a mapping known at the receiver.
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > >  =

> > > > > > =

> > > > > =

> > > > > As far as I understand, the proposed change introduces a =E2=80=
=9CMUST=E2=80=9D to
> > > > > insist that the map in a segment must cover at least some data in
> > > > > the segment. But the document does not talk anything about the
> > > > > rational behind it. I guess it is purely an =

> > > > > =

> > > > > ease of implementation?
> > > > > =

> > > > > =

> > > > =

> > > > =

> > > > For two reasons:
> > > > =

> > > > 1. Ease of implementation 2. If an implementation tries to
> > > > "remember" early mappings, it is not clear how many of these an
> > > > implementation can hold. Thus, the sender does not know how many
> > > > early mappings he can send. So, it is hard for a sender to do the
> > > > right thing.
> > > > =

> > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > I think the design/format of the Data Sequence Mapping permits the
> > > > > map to stand independent of the data being carried in a segment.
> > > > > So, as long as an implementation is willing to deal with the
> > > > > complexity of storing and processing late and early mappings (with
> > > > > respect to the data arrival), it could be permitted provided that
> > > > > the received map is for an in-window data.
> > > > > =

> > > > > =

> > > > =

> > > > =

> > > > What is the concrete use-case for such early mappings? What are the
> > > > benefits of it? I think that if we want to enable such
> > > > implementation-complexity, we need a compelling use-case with a big
> > > > benefit.
> > > > =

> > > > =

> > > >  =

> > > > =

> > > =

> > > Consider a case where a MPTCP connection consists of two subflows, and
> > > the data segments are scheduled for transmission in the order shown
> > > below below.  =

> > > =

> > > =

> > >  =

> > > =

> > > =

> > > =

> > > Subflow-1: segment-1 segment-3 segment-5 segment-6 =

> > > =

> > >  bytes:1-100 bytes:201-300 bytes:401-500 bytes:501-600 =

> > > =

> > >  no map map for 1-100 map for 401-600 no map =

> > > =

> > > =

> > >  =

> > > =

> > > =

> > >  =

> > > =

> > > =

> > > =

> > > Subflow-2: segment-2 segment-4 segment-7 segment-8 =

> > > =

> > >  bytes: 101-200 bytes:301-400 bytes: 601-700 bytes:701-800  =

> > > =

> > >  map for 101-200 map for 301-400 map for 601-800 no map =

> > > =

> > >   =

> > > =

> > > In the above case, the map for data in segment-1 is included in
> > > segment-3. =

> > > =

> > > =

> > > =

> > =

> > =

> > The question here is why would the stack not put the mapping for segment
> > 1 on segment 1 itself. And what is the benefit of doing so?
> > =

> > =

> > =

> >  =

> > =

> =

> Well it could just be due to the lack of option space insegment-1. For
> example, the sender ofsegment-1 at that instant wants to transmit multiple
> TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, they all
> cannot fit into optionfield of one segment, and eventually the DSS
> transmission got slightly delayedby a segment or two.

The implementation needs to enforce a strict priority of DSS over SACK and =
ADD_ADDR.

If the ADD_ADDR does not fit in the TCP-option space, it can send the
ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the reliable
delivery of it.


Sure, one could argue that favoring SACK over DSS is more important. But I
think we would need data to justify that. Only very specific traffic
patterns will fall in this use-case.


Christoph

> =

>  =

> =

> With regards,
> =

>  =

> =

> Anil
> =

>  =

> =

> > =

> > =

> > =

> > =

> > =

> > =

> > =

> > Christoph
> > =

> > =

> > > =

> > > =

> > > =

> > > Further, segment-3 cannot combine/cover the data in segment-1 and seg=
ment-3 in a "single map", as the data sequence space is not continuous, i.e=
., some in between data (segment-2) is mapped and transmitted through subfl=
ow-2. Here, the map in segment-3 does not even partially cover the data it =
carries. =

> > > =

> > > =

> > >  =

> > > =

> > > Both RFC 6824 and the 6824-bis do not restrict the above scenario, an=
d I guess the change proposed now does not permit this to happen. =

> > > =

> > > =

> > >  =

> > > =

> > > Best regards, =

> > > =

> > > =

> > >  =

> > > =

> > > Anil =

> > > =

> > > =

> > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > That's the reason why we (the MPTCP-upstreaming community) vouch to=
 have this case restricted.
> > > > =

> > > > =

> > > > =

> > > > Cheers,
> > > > Christoph
> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > Anil =

> > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Best regards,
> > > > > > =

> > > > > > Alan
> > > > > > =

> > > > > > =

> > > > > >  =

> > > > > > =

> > > > > =

> > > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > >  =

> > > > =

> > > =

> > > =

> > =

> > =

> > =

> >  =

> >
--===============3803419603683565427==--
