Content-Type: multipart/mixed; boundary="===============5036281708227537002=="
MIME-Version: 1.0
From: V Anil Kumar <anil at csir4pi.in>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Sat, 14 Dec 2019 19:09:54 +0530
Message-ID: <fa6b23f5763c.5df53382@nic.in>
In-Reply-To: fa9985d3d9b.5df4e5ef@nic.in
X-Status: 
X-Keywords:                  
X-UID: 3068

--===============5036281708227537002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 12/13/19 11:54 PM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> =

> On 13/12/19 - 23:41:25, V Anil Kumar wrote:
> > Hi Christoph,
> > =

> > Thanks again for your reply. My response is given inline.
> > =

> > On 12/13/19 09:59 PM, Christoph Paasch <cpaasch(a)apple.com> wrote: =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Hello,
> > > =

> > > =

> > > =

> > > > On Dec 12, 2019, at 9:53 PM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> > > > =

> > > > =

> > > =

> > > =

> > > > =

> > > > Hi Christoph,
> > > > =

> > > > Thanks for your reply. Please see inline.
> > > > =

> > > > On 12/12/19 12:52 AM, Christoph Paasch <cpaasch(a)apple.com> wrote: =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > Hello,
> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > > =

> > > > > > On Dec 10, 2019, at 12:04 PM, V Anil Kumar
> > > > > > <anil(a)csir4pi.in(javascript:main.compose()> wrote:
> > > > > > =

> > > > > > =

> > > > > > Hi Alan, =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Please see inline.
> > > > > > =

> > > > > > On 12/06/19 09:28 PM,Alan
> > > > > > Ford<alan.ford(a)gmail.com(javascript:main.compose()> wrote: =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Hi all,
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Following on from the discussion of implementation feedback w=
ith
> > > > > > > Christoph, I propose the following edits to RFC6824bis - which
> > > > > > > is currently in AUTH48 - as clarifications.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > ADs, please can you confirm you consider these edits
> > > > > > > sufficiently editorial to fit into AUTH48.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > WG participants, please speak up if you have any concerns.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Edit 1, clarifying reliability of MP_CAPABLE
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Change the sentence reading:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > The SYN with MP_CAPABLE occupies the first octet of data
> > > > > > > sequence space, although this does not need to be acknowledged
> > > > > > > at the connection level until the first data is sent (see
> > > > > > > Section 3.3).
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > To:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > The SYN with MP_CAPABLE occupies the first octet of data
> > > > > > > sequence space, and this MUST be acknowledged at the connecti=
on
> > > > > > > level at or before the time the first data is sent or received
> > > > > > > (see Section 3.3).
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Change the sentence reading:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > If B has data to send first, then the reliable delivery of the
> > > > > > > ACK + MP_CAPABLE can be inferred by the receipt of this data
> > > > > > > with an MPTCP Data Sequence Signal (DSS) option (Section 3.3)=
. =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > To:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > If B has data to send first, then the reliable delivery of the
> > > > > > > ACK + MP_CAPABLE is ensured by the receipt of this data with =
an
> > > > > > > MPTCP Data Sequence Signal (DSS) option (Section 3.3)
> > > > > > > containing a DATA_ACK for the MP_CAPABLE=C2=A0(which is the f=
irst
> > > > > > > octet of the data sequence space).
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > In my personal opinion either one of these edits would be
> > > > > > > sufficient for making the point, however clearly this has cau=
sed
> > > > > > > some confusion amongst the implementor community so making bo=
th
> > > > > > > these changes should make it absolutely clear as to the expec=
ted
> > > > > > > behaviour here.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Edit 2, mapping constraint
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Change the sentence reading:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > A Data Sequence Mapping does not need to be included in every
> > > > > > > MPTCP=C2=A0packet, as long as the subflow sequence space in t=
hat
> > > > > > > packet is=C2=A0covered by a mapping known at the receiver.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > To:
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > A Data Sequence Mapping MUST appear on a TCP segment which is
> > > > > > > covered by the mapping. It does not need to be included in
> > > > > > > every MPTCP=C2=A0packet, as long as the subflow sequence spac=
e in
> > > > > > > that packet is=C2=A0covered by a mapping known at the receive=
r.
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > =

> > > > > > As far as I understand, the proposed change introduces a =E2=80=
=9CMUST=E2=80=9D to
> > > > > > insist that the map in a segment must cover at least some data =
in
> > > > > > the segment. But the document does not talk anything about the
> > > > > > rational behind it. I guess it is purely an =

> > > > > > =

> > > > > > ease of implementation?
> > > > > > =

> > > > > > =

> > > > > =

> > > > > =

> > > > > For two reasons:
> > > > > =

> > > > > 1. Ease of implementation 2. If an implementation tries to
> > > > > "remember" early mappings, it is not clear how many of these an
> > > > > implementation can hold. Thus, the sender does not know how many
> > > > > early mappings he can send. So, it is hard for a sender to do the
> > > > > right thing.
> > > > > =

> > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > I think the design/format of the Data Sequence Mapping permits =
the
> > > > > > map to stand independent of the data being carried in a segment.
> > > > > > So, as long as an implementation is willing to deal with the
> > > > > > complexity of storing and processing late and early mappings (w=
ith
> > > > > > respect to the data arrival), it could be permitted provided th=
at
> > > > > > the received map is for an in-window data.
> > > > > > =

> > > > > > =

> > > > > =

> > > > > =

> > > > > What is the concrete use-case for such early mappings? What are t=
he
> > > > > benefits of it? I think that if we want to enable such
> > > > > implementation-complexity, we need a compelling use-case with a b=
ig
> > > > > benefit.
> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > =

> > > > Consider a case where a MPTCP connection consists of two subflows, =
and
> > > > the data segments are scheduled for transmission in the order shown
> > > > below below. =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Subflow-1: segment-1 segment-3 segment-5 segment-6 =

> > > > =

> > > > bytes:1-100 bytes:201-300 bytes:401-500 bytes:501-600 =

> > > > =

> > > > no map map for 1-100 map for 401-600 no map =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Subflow-2: segment-2 segment-4 segment-7 segment-8 =

> > > > =

> > > > bytes: 101-200 bytes:301-400 bytes: 601-700 bytes:701-800 =

> > > > =

> > > > map for 101-200 map for 301-400 map for 601-800 no map =

> > > > =

> > > > =

> > > > =

> > > > In the above case, the map for data in segment-1 is included in
> > > > segment-3. =

> > > > =

> > > > =

> > > > =

> > > =

> > > =

> > > The question here is why would the stack not put the mapping for segm=
ent
> > > 1 on segment 1 itself. And what is the benefit of doing so?
> > > =

> > > =

> > > =

> > > =

> > > =

> > =

> > Well it could just be due to the lack of option space insegment-1. For
> > example, the sender ofsegment-1 at that instant wants to transmit multi=
ple
> > TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, they all
> > cannot fit into optionfield of one segment, and eventually the DSS
> > transmission got slightly delayedby a segment or two.
> =

> The implementation needs to enforce a strict priority of DSS over SACK an=
d ADD_ADDR.
> =


TCP options have evolved over a period of time, and I do not think as such =
any document/guidelines exist on enforcing priority for one over the other,=
 though it turns out be an interesting topic. Also, more TCP options could =
come up in future for implementing new features. So, it is likely that impl=
ementations would follow different strategy when it come to option priority=
. =


> =

> =

> =

> If the ADD_ADDR does not fit in the TCP-option space, it can send the
> ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the reliab=
le
> delivery of it.
> =


I noticed this new feature in RFC 6824-bis to deliver ADD_ADDR in pure ACK =
and still achieve the reliability. The ability to deliver MPTCP options in =
pure ACK will be useful, especially for options like ADD_ADDR. =


> =

> =

> =

> Sure, one could argue that favoring SACK over DSS is more important. But I
> think we would need data to justify that. Only very specific traffic
> patterns will fall in this use-case.
> =


The bottomline is that in the event of a map being slightly delayed, i.e., =
delivered late with respect to the corresponding data, should it result in =
resetting the subflow? =


As far as the specification is concerned, it could be liberal on accepting =
such maps, rather than being restrictive. Even if a current implementation =
cannot support this, future implementations may like to, provided the speci=
fication permits this and the implementation is willing to cop up with the =
associated complexity. =


Best regards,

Anil

> =

> =

> =

> Christoph
> =

> > =

> > =

> > =

> > With regards,
> > =

> > =

> > =

> > Anil
> > =

> > =

> > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Christoph
> > > =

> > > =

> > > > =

> > > > =

> > > > =

> > > > Further, segment-3 cannot combine/cover the data in segment-1 and s=
egment-3 in a "single map", as the data sequence space is not continuous, i=
.e., some in between data (segment-2) is mapped and transmitted through sub=
flow-2. Here, the map in segment-3 does not even partially cover the data i=
t carries. =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Both RFC 6824 and the 6824-bis do not restrict the above scenario, =
and I guess the change proposed now does not permit this to happen. =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Best regards, =

> > > > =

> > > > =

> > > > =

> > > > =

> > > > Anil =

> > > > =

> > > > =

> > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > That's the reason why we (the MPTCP-upstreaming community) vouch =
to have this case restricted.
> > > > > =

> > > > > =

> > > > > =

> > > > > Cheers,
> > > > > Christoph
> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > Anil =

> > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > Best regards,
> > > > > > > =

> > > > > > > Alan
> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > > =

> > > > > > =

> > > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > > =

> > > > =

> > > > =

> > > =

> > > =

> > > =

> > > =

> > >
>=20

--===============5036281708227537002==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQ2hyaXN0b3BoLDxiciAvPjxiciAvPjxzcGFuPk9uIDEyLzEzLzE5IDExOjU0IFBNLCA8YiBj
bGFzcz0ibmFtZSI+Q2hyaXN0b3BoIFBhYXNjaCA8L2I+ICZsdDtjcGFhc2NoQGFwcGxlLmNvbSZn
dDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1b3RlIGNpdGU9Im1pZDoyMDE5MTIxMzE4MjQwOS5HQjk0
MzBATWFjQm9vay1Qcm8tNjQubG9jYWwiIGNsYXNzPSJpd2NRdW90ZSIgc3R5bGU9ImJvcmRlci1s
ZWZ0OiAxcHggc29saWQgIzAwRjsgcGFkZGluZy1sZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMDsi
IHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0eXBlLXRleHQtcGxhaW4iPk9uIDEzLzEyLzE5
IC0gMjM6NDE6MjUsIFYgQW5pbCBLdW1hciB3cm90ZTo8YnIgLz4mZ3Q7IEhpIENocmlzdG9waCw8
YnIgLz4mZ3Q7IDxiciAvPiZndDsgVGhhbmtzIGFnYWluIGZvciB5b3VyIHJlcGx5LiBNeSByZXNw
b25zZSBpcyBnaXZlbiBpbmxpbmUuPGJyIC8+Jmd0OyA8YnIgLz4mZ3Q7IE9uIDEyLzEzLzE5IDA5
OjU5IFBNLCBDaHJpc3RvcGggUGFhc2NooCAmbHQ7Y3BhYXNjaEBhcHBsZS5jb20mZ3Q7IHdyb3Rl
OiA8YnIgLz4mZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsg
SGVsbG8sPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgT24gRGVjIDEyLCAyMDE5LCBhdCA5OjUzIFBNLCBWIEFuaWwgS3Vt
YXIgJmx0O2FuaWxAY3NpcjRwaS5pbiZndDsgd3JvdGU6PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0O6AgSGkgQ2hyaXN0b3BoLDxiciAvPiZn
dDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IFRoYW5rcyBmb3IgeW91ciByZXBseS4g
UGxlYXNlIHNlZSBpbmxpbmUuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgT24gMTIvMTIvMTkgMTI6NTIgQU0sIENocmlzdG9waCBQYWFzY2igICZsdDtjcGFhc2NoQGFw
cGxlLmNvbSZndDsgd3JvdGU6IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAm
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7IEhlbGxvLDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyBPbiBEZWMgMTAsIDIwMTksIGF0IDEyOjA0IFBNLCBWIEFuaWwgS3VtYXI8YnIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmx0O2FuaWxAY3NpcjRwaS5pbihqYXZhc2NyaXB0Om1haW4u
Y29tcG9zZSgpJmd0OyB3cm90ZTo8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBI
aSBBbGFuLCA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgUGxlYXNlIHNlZSBpbmxpbmUuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBPbiAxMi8wNi8xOSAwOToy
OCBQTSxBbGFuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEZvcmQmbHQ7YWxhbi5mb3Jk
QGdtYWlsLmNvbShqYXZhc2NyaXB0Om1haW4uY29tcG9zZSgpJmd0OyB3cm90ZTogPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgSGkgYWxsLDxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEZvbGxv
d2luZyBvbiBmcm9tIHRoZSBkaXNjdXNzaW9uIG9mIGltcGxlbWVudGF0aW9uIGZlZWRiYWNrIHdp
dGg8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBDaHJpc3RvcGgsIEkgcHJvcG9z
ZSB0aGUgZm9sbG93aW5nIGVkaXRzIHRvIFJGQzY4MjRiaXMgLSB3aGljaDxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IGlzIGN1cnJlbnRseSBpbiBBVVRINDggLSBhcyBjbGFyaWZp
Y2F0aW9ucy48YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyBBRHMsIHBsZWFzZSBjYW4geW91IGNvbmZpcm0geW91IGNvbnNpZGVy
IHRoZXNlIGVkaXRzPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgc3VmZmljaWVu
dGx5IGVkaXRvcmlhbCB0byBmaXQgaW50byBBVVRINDguPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgV0cgcGFydGljaXBhbnRz
LCBwbGVhc2Ugc3BlYWsgdXAgaWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLjxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEVkaXQgMSwgY2xh
cmlmeWluZyByZWxpYWJpbGl0eSBvZiBNUF9DQVBBQkxFPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQ2hhbmdlIHRoZSBzZW50
ZW5jZSByZWFkaW5nOjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBUaGUgU1lOIHdpdGggTVBfQ0FQQUJMRSBvY2N1cGllcyB0
aGUgZmlyc3Qgb2N0ZXQgb2YgZGF0YTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
oCBzZXF1ZW5jZSBzcGFjZSwgYWx0aG91Z2ggdGhpcyBkb2VzIG5vdCBuZWVkIHRvIGJlIGFja25v
d2xlZGdlZDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBhdCB0aGUgY29ubmVj
dGlvbiBsZXZlbCB1bnRpbCB0aGUgZmlyc3QgZGF0YSBpcyBzZW50IChzZWU8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6AgU2VjdGlvbiAzLjMpLjxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRvOjxiciAvPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
oCBUaGUgU1lOIHdpdGggTVBfQ0FQQUJMRSBvY2N1cGllcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgZGF0
YTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBzZXF1ZW5jZSBzcGFjZSwgYW5k
IHRoaXMgTVVTVCBiZSBhY2tub3dsZWRnZWQgYXQgdGhlIGNvbm5lY3Rpb248YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6AgbGV2ZWwgYXQgb3IgYmVmb3JlIHRoZSB0aW1lIHRoZSBm
aXJzdCBkYXRhIGlzIHNlbnQgb3IgcmVjZWl2ZWQ8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0O6AgKHNlZSBTZWN0aW9uIDMuMykuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQ2hhbmdlIHRoZSBzZW50ZW5jZSByZWFkaW5n
OjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7oCBJZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxl
IGRlbGl2ZXJ5IG9mIHRoZTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBBQ0sg
KyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGE8
YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6Agd2l0aCBhbiBNUFRDUCBEYXRhIFNl
cXVlbmNlIFNpZ25hbCAoRFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKS4gPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgVG86PGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDugIElmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVs
aXZlcnkgb2YgdGhlPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDugIEFDSyArIE1Q
X0NBUEFCTEUgaXMgZW5zdXJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbjxi
ciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBNUFRDUCBEYXRhIFNlcXVlbmNlIFNp
Z25hbCAoRFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7oCBjb250YWluaW5nIGEgREFUQV9BQ0sgZm9yIHRoZSBNUF9DQVBBQkxFoCh3aGlj
aCBpcyB0aGUgZmlyc3Q8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6Agb2N0ZXQg
b2YgdGhlIGRhdGEgc2VxdWVuY2Ugc3BhY2UpLjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEluIG15IHBlcnNvbmFsIG9waW5pb24gZWl0
aGVyIG9uZSBvZiB0aGVzZSBlZGl0cyB3b3VsZCBiZTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IHN1ZmZpY2llbnQgZm9yIG1ha2luZyB0aGUgcG9pbnQsIGhvd2V2ZXIgY2xlYXJs
eSB0aGlzIGhhcyBjYXVzZWQ8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBzb21l
IGNvbmZ1c2lvbiBhbW9uZ3N0IHRoZSBpbXBsZW1lbnRvciBjb21tdW5pdHkgc28gbWFraW5nIGJv
dGg8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyB0aGVzZSBjaGFuZ2VzIHNob3Vs
ZCBtYWtlIGl0IGFic29sdXRlbHkgY2xlYXIgYXMgdG8gdGhlIGV4cGVjdGVkPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgYmVoYXZpb3VyIGhlcmUuPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgRWRpdCAyLCBtYXBwaW5n
IGNvbnN0cmFpbnQ8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyBDaGFuZ2UgdGhlIHNlbnRlbmNlIHJlYWRpbmc6PGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDug
IEEgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4g
ZXZlcnk8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6AgTVBUQ1CgcGFja2V0LCBh
cyBsb25nIGFzIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoYXQ8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6AgcGFja2V0IGlzoGNvdmVyZWQgYnkgYSBtYXBwaW5nIGtu
b3duIGF0IHRoZSByZWNlaXZlci48YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBUbzo8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O6AgQSBEYXRhIFNlcXVlbmNl
IE1hcHBpbmcgTVVTVCBhcHBlYXIgb24gYSBUQ1Agc2VnbWVudCB3aGljaCBpczxiciAvPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nLiBJdCBkb2Vz
IG5vdCBuZWVkIHRvIGJlIGluY2x1ZGVkIGluPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDugIGV2ZXJ5IE1QVENQoHBhY2tldCwgYXMgbG9uZyBhcyB0aGUgc3ViZmxvdyBzZXF1ZW5j
ZSBzcGFjZSBpbjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCB0aGF0IHBhY2tl
dCBpc6Bjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuPGJyIC8+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDug
IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQXMgZmFyIGFzIEkgdW5k
ZXJzdGFuZCwgdGhlIHByb3Bvc2VkIGNoYW5nZSBpbnRyb2R1Y2VzIGEgk01VU1SUIHRvPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IGluc2lzdCB0aGF0IHRoZSBtYXAgaW4gYSBzZWdtZW50
IG11c3QgY292ZXIgYXQgbGVhc3Qgc29tZSBkYXRhIGluPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IHRoZSBzZWdtZW50LiBCdXQgdGhlIGRvY3VtZW50IGRvZXMgbm90IHRhbGsgYW55dGhp
bmcgYWJvdXQgdGhlPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IHJhdGlvbmFsIGJlaGlu
ZCBpdC4gSSBndWVzcyBpdCBpcyBwdXJlbHkgYW4gPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBlYXNlIG9mIGltcGxlbWVudGF0aW9u
PzxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgRm9yIHR3byByZWFzb25zOjxiciAvPiZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAxLiBFYXNlIG9mIGltcGxlbWVu
dGF0aW9uIDIuIElmIGFuIGltcGxlbWVudGF0aW9uIHRyaWVzIHRvPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmcXVvdDtyZW1lbWJlciZxdW90OyBlYXJseSBtYXBwaW5ncywgaXQgaXMgbm90IGNs
ZWFyIGhvdyBtYW55IG9mIHRoZXNlIGFuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBpbXBsZW1l
bnRhdGlvbiBjYW4gaG9sZC4gVGh1cywgdGhlIHNlbmRlciBkb2VzIG5vdCBrbm93IGhvdyBtYW55
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBlYXJseSBtYXBwaW5ncyBoZSBjYW4gc2VuZC4gU28s
IGl0IGlzIGhhcmQgZm9yIGEgc2VuZGVyIHRvIGRvIHRoZTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgcmlnaHQgdGhpbmcuPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyBJIHRoaW5rIHRoZSBkZXNpZ24vZm9ybWF0IG9mIHRoZSBEYXRh
IFNlcXVlbmNlIE1hcHBpbmcgcGVybWl0cyB0aGU8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgbWFwIHRvIHN0YW5kIGluZGVwZW5kZW50IG9mIHRoZSBkYXRhIGJlaW5nIGNhcnJpZWQgaW4g
YSBzZWdtZW50LjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBTbywgYXMgbG9uZyBhcyBh
biBpbXBsZW1lbnRhdGlvbiBpcyB3aWxsaW5nIHRvIGRlYWwgd2l0aCB0aGU8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgY29tcGxleGl0eSBvZiBzdG9yaW5nIGFuZCBwcm9jZXNzaW5nIGxh
dGUgYW5kIGVhcmx5IG1hcHBpbmdzICh3aXRoPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IHJlc3BlY3QgdG8gdGhlIGRhdGEgYXJyaXZhbCksIGl0IGNvdWxkIGJlIHBlcm1pdHRlZCBwcm92
aWRlZCB0aGF0PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IHRoZSByZWNlaXZlZCBtYXAg
aXMgZm9yIGFuIGluLXdpbmRvdyBkYXRhLjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgV2hhdCBp
cyB0aGUgY29uY3JldGUgdXNlLWNhc2UgZm9yIHN1Y2ggZWFybHkgbWFwcGluZ3M/IFdoYXQgYXJl
IHRoZTxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgYmVuZWZpdHMgb2YgaXQ/IEkgdGhpbmsgdGhh
dCBpZiB3ZSB3YW50IHRvIGVuYWJsZSBzdWNoPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBpbXBs
ZW1lbnRhdGlvbi1jb21wbGV4aXR5LCB3ZSBuZWVkIGEgY29tcGVsbGluZyB1c2UtY2FzZSB3aXRo
IGEgYmlnPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBiZW5lZml0LjxiciAvPiZndDsgJmd0OyAm
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7oCA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7IENvbnNpZGVyIGEgY2FzZSB3aGVyZSBhIE1QVENQIGNvbm5lY3Rpb24g
Y29uc2lzdHMgb2YgdHdvIHN1YmZsb3dzLCBhbmQ8YnIgLz4mZ3Q7ICZndDsgJmd0OyB0aGUgZGF0
YSBzZWdtZW50cyBhcmUgc2NoZWR1bGVkIGZvciB0cmFuc21pc3Npb24gaW4gdGhlIG9yZGVyIHNo
b3duPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgYmVsb3cgYmVsb3cuoCA8YnIgLz4mZ3Q7ICZndDsgJmd0
OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0O6AgPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgU3ViZmxvdy0xOiBzZWdtZW50LTEgc2VnbWVudC0zIHNlZ21lbnQtNSBz
ZWdtZW50LTYgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDugIGJ5dGVz
OjEtMTAwIGJ5dGVzOjIwMS0zMDAgYnl0ZXM6NDAxLTUwMCBieXRlczo1MDEtNjAwIDxiciAvPiZn
dDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7oCBubyBtYXAgbWFwIGZvciAxLTEwMCBt
YXAgZm9yIDQwMS02MDAgbm8gbWFwIDxiciAvPiZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7oCA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0O6AgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7
ICZndDsgU3ViZmxvdy0yOiBzZWdtZW50LTIgc2VnbWVudC00IHNlZ21lbnQtNyBzZWdtZW50LTgg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDugIGJ5dGVzOiAxMDEtMjAw
IGJ5dGVzOjMwMS00MDAgYnl0ZXM6IDYwMS03MDAgYnl0ZXM6NzAxLTgwMKAgPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDugIG1hcCBmb3IgMTAxLTIwMCBtYXAgZm9yIDMw
MS00MDAgbWFwIGZvciA2MDEtODAwIG5vIG1hcCA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0O6CgIDxiciAvPiZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7
IEluIHRoZSBhYm92ZSBjYXNlLCB0aGUgbWFwIGZvciBkYXRhIGluIHNlZ21lbnQtMSBpcyBpbmNs
dWRlZCBpbjxiciAvPiZndDsgJmd0OyAmZ3Q7IHNlZ21lbnQtMy4gPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAm
Z3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgVGhlIHF1ZXN0aW9uIGhlcmUgaXMg
d2h5IHdvdWxkIHRoZSBzdGFjayBub3QgcHV0IHRoZSBtYXBwaW5nIGZvciBzZWdtZW50PGJyIC8+
Jmd0OyAmZ3Q7IDEgb24gc2VnbWVudCAxIGl0c2VsZi4gQW5kIHdoYXQgaXMgdGhlIGJlbmVmaXQg
b2YgZG9pbmcgc28/PGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZn
dDsgPGJyIC8+Jmd0OyAmZ3Q7oCA8YnIgLz4mZ3Q7ICZndDsgPGJyIC8+Jmd0OyA8YnIgLz4mZ3Q7
IFdlbGwgaXQgY291bGQganVzdCBiZSBkdWUgdG8gdGhlIGxhY2sgb2Ygb3B0aW9uIHNwYWNlIGlu
c2VnbWVudC0xLiBGb3I8YnIgLz4mZ3Q7IGV4YW1wbGUsIHRoZSBzZW5kZXIgb2ZzZWdtZW50LTEg
YXQgdGhhdCBpbnN0YW50IHdhbnRzIHRvIHRyYW5zbWl0IG11bHRpcGxlPGJyIC8+Jmd0OyBUQ1Ag
b3B0aW9ucyAoZS5nLnRpbWVzdGFtcCwgU0FDSywgRFNTIGFuZCBBRERfQUREUikuIE9idmlvdXNs
eSwgdGhleSBhbGw8YnIgLz4mZ3Q7IGNhbm5vdCBmaXQgaW50byBvcHRpb25maWVsZCBvZiBvbmUg
c2VnbWVudCwgYW5kIGV2ZW50dWFsbHkgdGhlIERTUzxiciAvPiZndDsgdHJhbnNtaXNzaW9uIGdv
dCBzbGlnaHRseSBkZWxheWVkYnkgYSBzZWdtZW50IG9yIHR3by48YnIgLz48YnIgLz5UaGUgaW1w
bGVtZW50YXRpb24gbmVlZHMgdG8gZW5mb3JjZSBhIHN0cmljdCBwcmlvcml0eSBvZiBEU1Mgb3Zl
ciBTQUNLIGFuZCBBRERfQUREUi48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5UQ1Agb3B0aW9ucyBo
YXZlIGV2b2x2ZWQgb3ZlciBhIHBlcmlvZCBvZiB0aW1lLCBhbmQgSSBkbyBub3QgdGhpbmsgYXMg
c3VjaCBhbnkgZG9jdW1lbnQvZ3VpZGVsaW5lcyBleGlzdCBvbiCgZW5mb3JjaW5nIHByaW9yaXR5
IGZvciBvbmUgb3ZlciB0aGUgb3RoZXIsIHRob3VnaCBpdCB0dXJucyBvdXQgYmUgYW4gaW50ZXJl
c3RpbmcgdG9waWMuIKBBbHNvLCBtb3JlIFRDUCBvcHRpb25zIGNvdWxkIGNvbWUgdXAgaW4gZnV0
dXJlIGZvciBpbXBsZW1lbnRpbmcgoG5ldyBmZWF0dXJlcy4goFNvLCBpdCBpcyBsaWtlbHkgdGhh
dCBpbXBsZW1lbnRhdGlvbnMgd291bGQgZm9sbG93IGRpZmZlcmVudCBzdHJhdGVneSB3aGVuIGl0
IGNvbWUgdG8gb3B0aW9uIHByaW9yaXR5LqA8L2Rpdj48YmxvY2txdW90ZSBjaXRlPSJtaWQ6MjAx
OTEyMTMxODI0MDkuR0I5NDMwQE1hY0Jvb2stUHJvLTY0LmxvY2FsIiBjbGFzcz0iaXdjUXVvdGUi
IHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkICMwMEY7IHBhZGRpbmctbGVmdDogMTNweDsg
bWFyZ2luLWxlZnQ6IDA7IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSJtaW1ldHlwZS10ZXh0LXBs
YWluIj48YnIgLz48YnIgLz5JZiB0aGUgQUREX0FERFIgZG9lcyBub3QgZml0IGluIHRoZSBUQ1At
b3B0aW9uIHNwYWNlLCBpdCBjYW4gc2VuZCB0aGU8YnIgLz5BRERfQUREUiBvbiBhIHB1cmUgQUNL
LiBUaGUgZWNoby1iaXQgaW4gdGhlIEFERF9BRERSIGd1YXJhbnRlZSB0aGUgcmVsaWFibGU8YnIg
Lz5kZWxpdmVyeSBvZiBpdC48YnIgLz48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5JIG5vdGljZWQg
dGhpcyBuZXcgZmVhdHVyZSBpbiBSRkMgNjgyNC1iaXMgdG8gZGVsaXZlciBBRERfQUREUiBpbiBw
dXJlIEFDSyBhbmQgc3RpbGwgYWNoaWV2ZSB0aGUgcmVsaWFiaWxpdHkuIFRoZSBhYmlsaXR5IHRv
IGRlbGl2ZXIgTVBUQ1Agb3B0aW9ucyBpbiBwdXJlIEFDSyB3aWxsIGJlIHVzZWZ1bCwgZXNwZWNp
YWxseSBmb3Igb3B0aW9ucyBsaWtlIEFERF9BRERSLiCgoDwvZGl2PjxibG9ja3F1b3RlIGNpdGU9
Im1pZDoyMDE5MTIxMzE4MjQwOS5HQjk0MzBATWFjQm9vay1Qcm8tNjQubG9jYWwiIGNsYXNzPSJp
d2NRdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgIzAwRjsgcGFkZGluZy1sZWZ0
OiAxM3B4OyBtYXJnaW4tbGVmdDogMDsiIHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0eXBl
LXRleHQtcGxhaW4iPjxiciAvPjxiciAvPlN1cmUsIG9uZSBjb3VsZCBhcmd1ZSB0aGF0IGZhdm9y
aW5nIFNBQ0sgb3ZlciBEU1MgaXMgbW9yZSBpbXBvcnRhbnQuIEJ1dCBJPGJyIC8+dGhpbmsgd2Ug
d291bGQgbmVlZCBkYXRhIHRvIGp1c3RpZnkgdGhhdC4gT25seSB2ZXJ5IHNwZWNpZmljIHRyYWZm
aWM8YnIgLz5wYXR0ZXJucyB3aWxsIGZhbGwgaW4gdGhpcyB1c2UtY2FzZS48YnIgLz48L2Rpdj48
L2Jsb2NrcXVvdGU+PGRpdj5UaGUgYm90dG9tbGluZSBpcyB0aGF0IGluIHRoZSBldmVudCBvZiBh
IG1hcCBiZWluZyBzbGlnaHRseSBkZWxheWVkLCBpLmUuLCBkZWxpdmVyZWQgbGF0ZSB3aXRoIHJl
c3BlY3QgdG8gdGhlIGNvcnJlc3BvbmRpbmcgZGF0YSwgc2hvdWxkIKBpdCByZXN1bHQgaW4gcmVz
ZXR0aW5nIHRoZSBzdWJmbG93P6A8L2Rpdj48ZGl2PjxiciAvPjwvZGl2PjxkaXY+QXMgZmFyIGFz
IHRoZSBzcGVjaWZpY2F0aW9uIGlzIGNvbmNlcm5lZCwgaXQgY291bGQgYmUgbGliZXJhbCBvbiBh
Y2NlcHRpbmcgc3VjaCBtYXBzLCByYXRoZXIgdGhhbiBiZWluZyByZXN0cmljdGl2ZS4gRXZlbiBp
ZiBhIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2Fubm90IHN1cHBvcnQgdGhpcywgZnV0dXJlIGlt
cGxlbWVudGF0aW9ucyBtYXkgbGlrZSB0bywgcHJvdmlkZWQgdGhlIHNwZWNpZmljYXRpb24gcGVy
bWl0cyB0aGlzIGFuZCB0aGUgaW1wbGVtZW50YXRpb24gaXMgd2lsbGluZyB0byBjb3AgdXAgd2l0
aCB0aGUgYXNzb2NpYXRlZCBjb21wbGV4aXR5LqA8L2Rpdj48ZGl2PjxiciAvPjwvZGl2PjxkaXY+
QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+PGJyIC8+PC9kaXY+PGRpdj5BbmlsPC9kaXY+PGJsb2Nr
cXVvdGUgY2l0ZT0ibWlkOjIwMTkxMjEzMTgyNDA5LkdCOTQzMEBNYWNCb29rLVByby02NC5sb2Nh
bCIgY2xhc3M9Iml3Y1F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAjMDBGOyBw
YWRkaW5nLWxlZnQ6IDEzcHg7IG1hcmdpbi1sZWZ0OiAwOyIgdHlwZT0iY2l0ZSI+PGRpdiBjbGFz
cz0ibWltZXR5cGUtdGV4dC1wbGFpbiI+PGJyIC8+PGJyIC8+Q2hyaXN0b3BoPGJyIC8+PGJyIC8+
Jmd0OyA8YnIgLz4mZ3Q7oCA8YnIgLz4mZ3Q7IDxiciAvPiZndDsgV2l0aCByZWdhcmRzLDxiciAv
PiZndDsgPGJyIC8+Jmd0O6AgPGJyIC8+Jmd0OyA8YnIgLz4mZ3Q7IEFuaWw8YnIgLz4mZ3Q7IDxi
ciAvPiZndDugIDxiciAvPiZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIg
Lz4mZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZn
dDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyBDaHJpc3RvcGg8YnIgLz4mZ3Q7ICZn
dDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAm
Z3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IEZ1cnRoZXIsIHNl
Z21lbnQtMyBjYW5ub3QgY29tYmluZS9jb3ZlciB0aGUgZGF0YSBpbiBzZWdtZW50LTEgYW5kIHNl
Z21lbnQtMyBpbiBhICZxdW90O3NpbmdsZSBtYXAmcXVvdDssIGFzIHRoZSBkYXRhIHNlcXVlbmNl
IHNwYWNlIGlzIG5vdCBjb250aW51b3VzLCBpLmUuLCBzb21lIGluIGJldHdlZW4gZGF0YSAoc2Vn
bWVudC0yKSBpcyBtYXBwZWQgYW5kIHRyYW5zbWl0dGVkIHRocm91Z2ggc3ViZmxvdy0yLiBIZXJl
LCB0aGUgbWFwIGluIHNlZ21lbnQtMyBkb2VzIG5vdCBldmVuIHBhcnRpYWxseSBjb3ZlciB0aGUg
ZGF0YSBpdCBjYXJyaWVzLiA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0
OyA8YnIgLz4mZ3Q7ICZndDsgJmd0O6AgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgQm90aCBSRkMgNjgyNCBhbmQgdGhlIDY4MjQtYmlzIGRvIG5vdCByZXN0cmljdCB0
aGUgYWJvdmUgc2NlbmFyaW8sIGFuZCBJIGd1ZXNzIHRoZSBjaGFuZ2UgcHJvcG9zZWQgbm93IGRv
ZXMgbm90IHBlcm1pdCB0aGlzIHRvIGhhcHBlbi4gPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDugIDxiciAvPiZndDsgJmd0OyAmZ3Q7
IDxiciAvPiZndDsgJmd0OyAmZ3Q7IEJlc3QgcmVnYXJkcywgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDugIDxiciAvPiZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7IEFuaWwgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxi
ciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgVGhhdCdzIHRoZSBy
ZWFzb24gd2h5IHdlICh0aGUgTVBUQ1AtdXBzdHJlYW1pbmcgY29tbXVuaXR5KSB2b3VjaCB0byBo
YXZlIHRoaXMgY2FzZSByZXN0cmljdGVkLjxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgQ2hlZXJzLDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgQ2hyaXN0b3Bo
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAv
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyBBbmlsIDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyBCZXN0IHJlZ2FyZHMsPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQWxhbjxiciAvPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7oCA8YnIgLz4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
IC8+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxiciAvPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7ICZndDsgJmd0O6AgPGJyIC8+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8YnIgLz4mZ3Q7ICZndDsgJmd0OyA8
YnIgLz4mZ3Q7ICZndDsgPGJyIC8+Jmd0OyAmZ3Q7IDxiciAvPiZndDsgJmd0OyA8YnIgLz4mZ3Q7
ICZndDugIDxiciAvPiZndDsgJmd0OzwvZGl2PjwvYmxvY2txdW90ZT4KCgo=

--===============5036281708227537002==--
