Content-Type: multipart/mixed; boundary="===============7314098425549961545=="
MIME-Version: 1.0
From: Yoshifumi Nishida <nsd.ietf at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Sun, 15 Dec 2019 03:05:25 -0800
Message-ID: <CAAK044SYBVQjk3ch5B_+oUewHvihTFFcWThr9RLP=Wxz_wjFyw@mail.gmail.com>
In-Reply-To: fa6b23f5763c.5df53382@nic.in
X-Status: 
X-Keywords:                  
X-UID: 3070

--===============7314098425549961545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
One concern I have here is this may mean we end up want all implementations
to support late mapping feature.
Because if an implementation that supports the feature uses it to send
data, the receiver who doesn't support it will discard the packets. To
avoid it, we need to mandate receivers to support it.
--
Yoshi

On Sat, Dec 14, 2019 at 5:40 AM V Anil Kumar <anil(a)csir4pi.in> wrote:

> Hi Christoph,
>
> On 12/13/19 11:54 PM, *Christoph Paasch * <cpaasch(a)apple.com> wrote:
>
> On 13/12/19 - 23:41:25, V Anil Kumar wrote:
> > Hi Christoph,
> >
> > Thanks again for your reply. My response is given inline.
> >
> > On 12/13/19 09:59 PM, Christoph Paasch  <cpaasch(a)apple.com> wrote:
> > >
> > >
> > >
> > >
> > >
> > >
> > > Hello,
> > >
> > >
> > >
> > > > On Dec 12, 2019, at 9:53 PM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> > > >
> > > >
> > >
> > >
> > > >
> > > >  Hi Christoph,
> > > >
> > > > Thanks for your reply. Please see inline.
> > > >
> > > > On 12/12/19 12:52 AM, Christoph Paasch  <cpaasch(a)apple.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > On Dec 10, 2019, at 12:04 PM, V Anil Kumar
> > > > > > <anil(a)csir4pi.in(javascript:main.compose()> wrote:
> > > > > >
> > > > > >
> > > > > > Hi Alan,
> > > > > >
> > > > > >
> > > > > >
> > > > > > Please see inline.
> > > > > >
> > > > > > On 12/06/19 09:28 PM,Alan
> > > > > > Ford<alan.ford(a)gmail.com(javascript:main.compose()> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Following on from the discussion of implementation feedback
> with
> > > > > > > Christoph, I propose the following edits to RFC6824bis - which
> > > > > > > is currently in AUTH48 - as clarifications.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > ADs, please can you confirm you consider these edits
> > > > > > > sufficiently editorial to fit into AUTH48.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > WG participants, please speak up if you have any concerns.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Edit 1, clarifying reliability of MP_CAPABLE
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Change the sentence reading:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  The SYN with MP_CAPABLE occupies the first octet of data
> > > > > > >  sequence space, although this does not need to be acknowledg=
ed
> > > > > > >  at the connection level until the first data is sent (see
> > > > > > >  Section 3.3).
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > To:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  The SYN with MP_CAPABLE occupies the first octet of data
> > > > > > >  sequence space, and this MUST be acknowledged at the
> connection
> > > > > > >  level at or before the time the first data is sent or receiv=
ed
> > > > > > >  (see Section 3.3).
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Change the sentence reading:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  If B has data to send first, then the reliable delivery of t=
he
> > > > > > >  ACK + MP_CAPABLE can be inferred by the receipt of this data
> > > > > > >  with an MPTCP Data Sequence Signal (DSS) option (Section
> 3.3).
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > To:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  If B has data to send first, then the reliable delivery of t=
he
> > > > > > >  ACK + MP_CAPABLE is ensured by the receipt of this data with
> an
> > > > > > >  MPTCP Data Sequence Signal (DSS) option (Section 3.3)
> > > > > > >  containing a DATA_ACK for the MP_CAPABLE (which is the first
> > > > > > >  octet of the data sequence space).
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > In my personal opinion either one of these edits would be
> > > > > > > sufficient for making the point, however clearly this has
> caused
> > > > > > > some confusion amongst the implementor community so making bo=
th
> > > > > > > these changes should make it absolutely clear as to the
> expected
> > > > > > > behaviour here.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Edit 2, mapping constraint
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Change the sentence reading:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  A Data Sequence Mapping does not need to be included in every
> > > > > > >  MPTCP packet, as long as the subflow sequence space in that
> > > > > > >  packet is covered by a mapping known at the receiver.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > To:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  A Data Sequence Mapping MUST appear on a TCP segment which is
> > > > > > >  covered by the mapping. It does not need to be included in
> > > > > > >  every MPTCP packet, as long as the subflow sequence space in
> > > > > > >  that packet is covered by a mapping known at the receiver.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > As far as I understand, the proposed change introduces a =E2=80=
=9CMUST=E2=80=9D
> to
> > > > > > insist that the map in a segment must cover at least some data =
in
> > > > > > the segment. But the document does not talk anything about the
> > > > > > rational behind it. I guess it is purely an
> > > > > >
> > > > > > ease of implementation?
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > > For two reasons:
> > > > >
> > > > > 1. Ease of implementation 2. If an implementation tries to
> > > > > "remember" early mappings, it is not clear how many of these an
> > > > > implementation can hold. Thus, the sender does not know how many
> > > > > early mappings he can send. So, it is hard for a sender to do the
> > > > > right thing.
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > I think the design/format of the Data Sequence Mapping permits
> the
> > > > > > map to stand independent of the data being carried in a segment.
> > > > > > So, as long as an implementation is willing to deal with the
> > > > > > complexity of storing and processing late and early mappings
> (with
> > > > > > respect to the data arrival), it could be permitted provided th=
at
> > > > > > the received map is for an in-window data.
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > > What is the concrete use-case for such early mappings? What are t=
he
> > > > > benefits of it? I think that if we want to enable such
> > > > > implementation-complexity, we need a compelling use-case with a b=
ig
> > > > > benefit.
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > > Consider a case where a MPTCP connection consists of two subflows,
> and
> > > > the data segments are scheduled for transmission in the order shown
> > > > below below.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > Subflow-1: segment-1 segment-3 segment-5 segment-6
> > > >
> > > >  bytes:1-100 bytes:201-300 bytes:401-500 bytes:501-600
> > > >
> > > >  no map map for 1-100 map for 401-600 no map
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > Subflow-2: segment-2 segment-4 segment-7 segment-8
> > > >
> > > >  bytes: 101-200 bytes:301-400 bytes: 601-700 bytes:701-800
> > > >
> > > >  map for 101-200 map for 301-400 map for 601-800 no map
> > > >
> > > >
> > > >
> > > > In the above case, the map for data in segment-1 is included in
> > > > segment-3.
> > > >
> > > >
> > > >
> > >
> > >
> > > The question here is why would the stack not put the mapping for
> segment
> > > 1 on segment 1 itself. And what is the benefit of doing so?
> > >
> > >
> > >
> > >
> > >
> >
> > Well it could just be due to the lack of option space insegment-1. For
> > example, the sender ofsegment-1 at that instant wants to transmit
> multiple
> > TCP options (e.g.timestamp, SACK, DSS and ADD_ADDR). Obviously, they all
> > cannot fit into optionfield of one segment, and eventually the DSS
> > transmission got slightly delayedby a segment or two.
>
> The implementation needs to enforce a strict priority of DSS over SACK and
> ADD_ADDR.
>
> TCP options have evolved over a period of time, and I do not think as such
> any document/guidelines exist on  enforcing priority for one over the
> other, though it turns out be an interesting topic.  Also, more TCP optio=
ns
> could come up in future for implementing  new features.  So, it is likely
> that implementations would follow different strategy when it come to opti=
on
> priority.
>
>
>
> If the ADD_ADDR does not fit in the TCP-option space, it can send the
> ADD_ADDR on a pure ACK. The echo-bit in the ADD_ADDR guarantee the reliab=
le
> delivery of it.
>
> I noticed this new feature in RFC 6824-bis to deliver ADD_ADDR in pure ACK
> and still achieve the reliability. The ability to deliver MPTCP options in
> pure ACK will be useful, especially for options like ADD_ADDR.
>
>
>
> Sure, one could argue that favoring SACK over DSS is more important. But I
> think we would need data to justify that. Only very specific traffic
> patterns will fall in this use-case.
>
> The bottomline is that in the event of a map being slightly delayed, i.e.,
> delivered late with respect to the corresponding data, should  it result =
in
> resetting the subflow?
>
> As far as the specification is concerned, it could be liberal on accepting
> such maps, rather than being restrictive. Even if a current implementation
> cannot support this, future implementations may like to, provided the
> specification permits this and the implementation is willing to cop up wi=
th
> the associated complexity.
>
> Best regards,
>
> Anil
>
>
>
> Christoph
>
> >
> >
> >
> > With regards,
> >
> >
> >
> > Anil
> >
> >
> >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > Christoph
> > >
> > >
> > > >
> > > >
> > > >
> > > > Further, segment-3 cannot combine/cover the data in segment-1 and
> segment-3 in a "single map", as the data sequence space is not continuous,
> i.e., some in between data (segment-2) is mapped and transmitted through
> subflow-2. Here, the map in segment-3 does not even partially cover the
> data it carries.
> > > >
> > > >
> > > >
> > > >
> > > > Both RFC 6824 and the 6824-bis do not restrict the above scenario,
> and I guess the change proposed now does not permit this to happen.
> > > >
> > > >
> > > >
> > > >
> > > > Best regards,
> > > >
> > > >
> > > >
> > > >
> > > > Anil
> > > >
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > That's the reason why we (the MPTCP-upstreaming community) vouch
> to have this case restricted.
> > > > >
> > > > >
> > > > >
> > > > > Cheers,
> > > > > Christoph
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Anil
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Best regards,
> > > > > > >
> > > > > > > Alan
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > >
> > >
> > >
> > >
> > >
> > >
>
> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org
> https://www.ietf.org/mailman/listinfo/multipathtcp
>

--===============7314098425549961545==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2Pk9uZSBjb25jZXJuIEkgaGF2ZSBoZXJl
IGlzIHRoaXMgbWF5IG1lYW4gd2UgZW5kIHVwIHdhbnQgYWxsIGltcGxlbWVudGF0aW9ucyB0byBz
dXBwb3J0IGxhdGUgbWFwcGluZyBmZWF0dXJlLjxicj48L2Rpdj48ZGl2PkJlY2F1c2UgaWYgYW4g
aW1wbGVtZW50YXRpb24gdGhhdCBzdXBwb3J0cyB0aGUgZmVhdHVyZSB1c2VzIGl0IHRvIHNlbmQg
ZGF0YSwgdGhlIHJlY2VpdmVyIHdobyBkb2VzbiYjMzk7dCBzdXBwb3J0IGl0IHdpbGwgZGlzY2Fy
ZCB0aGUgcGFja2V0cy4gVG8gYXZvaWQgaXQsIHdlIG5lZWQgdG8gbWFuZGF0ZSByZWNlaXZlcnMg
dG8gc3VwcG9ydCBpdC48L2Rpdj48ZGl2Pi0tPC9kaXY+PGRpdj5Zb3NoaTwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9u
IFNhdCwgRGVjIDE0LCAyMDE5IGF0IDU6NDAgQU0gViBBbmlsIEt1bWFyICZsdDs8YSBocmVmPSJt
YWlsdG86YW5pbEBjc2lyNHBpLmluIj5hbmlsQGNzaXI0cGkuaW48L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPkhpIENocmlzdG9waCw8YnI+PGJyPjxzcGFuPk9uIDEyLzEzLzE5IDExOjU0
IFBNLCA8Yj5DaHJpc3RvcGggUGFhc2NoIDwvYj4gJmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2No
QGFwcGxlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDsgd3Jv
dGU6PC9zcGFuPjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDAs
MCwyNTUpO3BhZGRpbmctbGVmdDoxM3B4O21hcmdpbi1sZWZ0OjBweCIgdHlwZT0iY2l0ZSI+PGRp
dj5PbiAxMy8xMi8xOSAtIDIzOjQxOjI1LCBWIEFuaWwgS3VtYXIgd3JvdGU6PGJyPiZndDsgSGkg
Q2hyaXN0b3BoLDxicj4mZ3Q7IDxicj4mZ3Q7IFRoYW5rcyBhZ2FpbiBmb3IgeW91ciByZXBseS4g
TXkgcmVzcG9uc2UgaXMgZ2l2ZW4gaW5saW5lLjxicj4mZ3Q7IDxicj4mZ3Q7IE9uIDEyLzEzLzE5
IDA5OjU5IFBNLCBDaHJpc3RvcGggUGFhc2NowqAgJmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2No
QGFwcGxlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDsgd3Jv
dGU6IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgSGVsbG8sPGJyPiZn
dDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IE9u
IERlYyAxMiwgMjAxOSwgYXQgOTo1MyBQTSwgViBBbmlsIEt1bWFyICZsdDs8YSBocmVmPSJtYWls
dG86YW5pbEBjc2lyNHBpLmluIiB0YXJnZXQ9Il9ibGFuayI+YW5pbEBjc2lyNHBpLmluPC9hPiZn
dDsgd3JvdGU6PGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAm
Z3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0O8Kg
IEhpIENocmlzdG9waCw8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IFRoYW5r
cyBmb3IgeW91ciByZXBseS4gUGxlYXNlIHNlZSBpbmxpbmUuPGJyPiZndDsgJmd0OyAmZ3Q7IDxi
cj4mZ3Q7ICZndDsgJmd0OyBPbiAxMi8xMi8xOSAxMjo1MiBBTSwgQ2hyaXN0b3BoIFBhYXNjaMKg
ICZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5j
cGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7IHdyb3RlOiA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyBIZWxsbyw8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgT24gRGVj
IDEwLCAyMDE5LCBhdCAxMjowNCBQTSwgViBBbmlsIEt1bWFyPGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgdGFyZ2V0PSJfYmxh
bmsiPmFuaWxAY3NpcjRwaS5pbjwvYT4oamF2YXNjcmlwdDptYWluLmNvbXBvc2UoKSZndDsgd3Jv
dGU6PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgSGkgQWxhbiwgPGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBQbGVhc2Ugc2VlIGlu
bGluZS48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgT24gMTIvMDYvMTkgMDk6MjggUE0sQWxhbjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgRm9yZCZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmFsYW4uZm9yZEBnbWFpbC5jb208L2E+KGphdmFzY3JpcHQ6bWFpbi5jb21wb3NlKCkm
Z3Q7IHdyb3RlOiA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBIaSBhbGwsPGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBGb2xsb3dp
bmcgb24gZnJvbSB0aGUgZGlzY3Vzc2lvbiBvZiBpbXBsZW1lbnRhdGlvbiBmZWVkYmFjayB3aXRo
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IENocmlzdG9waCwgSSBwcm9wb3NlIHRo
ZSBmb2xsb3dpbmcgZWRpdHMgdG8gUkZDNjgyNGJpcyAtIHdoaWNoPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IGlzIGN1cnJlbnRseSBpbiBBVVRINDggLSBhcyBjbGFyaWZpY2F0aW9u
cy48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IEFEcywgcGxlYXNlIGNhbiB5b3UgY29uZmlybSB5b3UgY29uc2lkZXIgdGhlc2UgZWRpdHM8YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgc3VmZmljaWVudGx5IGVkaXRvcmlhbCB0byBm
aXQgaW50byBBVVRINDguPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyBXRyBwYXJ0aWNpcGFudHMsIHBsZWFzZSBzcGVhayB1cCBpZiB5b3UgaGF2
ZSBhbnkgY29uY2VybnMuPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyBFZGl0IDEsIGNsYXJpZnlpbmcgcmVsaWFiaWxpdHkgb2YgTVBfQ0FQQUJMRTxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQ2hhbmdlIHRoZSBz
ZW50ZW5jZSByZWFkaW5nOjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCBUaGUgU1lOIHdpdGggTVBfQ0FQQUJMRSBvY2N1cGllcyB0aGUgZmly
c3Qgb2N0ZXQgb2YgZGF0YTxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIHNlcXVl
bmNlIHNwYWNlLCBhbHRob3VnaCB0aGlzIGRvZXMgbm90IG5lZWQgdG8gYmUgYWNrbm93bGVkZ2Vk
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgYXQgdGhlIGNvbm5lY3Rpb24gbGV2
ZWwgdW50aWwgdGhlIGZpcnN0IGRhdGEgaXMgc2VudCAoc2VlPGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgU2VjdGlvbiAzLjMpLjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgVG86PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIFRoZSBTWU4gd2l0aCBNUF9DQVBBQkxFIG9j
Y3VwaWVzIHRoZSBmaXJzdCBvY3RldCBvZiBkYXRhPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7wqAgc2VxdWVuY2Ugc3BhY2UsIGFuZCB0aGlzIE1VU1QgYmUgYWNrbm93bGVkZ2VkIGF0
IHRoZSBjb25uZWN0aW9uPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgbGV2ZWwg
YXQgb3IgYmVmb3JlIHRoZSB0aW1lIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgb3IgcmVjZWl2ZWQ8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCAoc2VlIFNlY3Rpb24gMy4zKS48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IENoYW5nZSB0aGUgc2VudGVu
Y2UgcmVhZGluZzo8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7wqAgSWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJs
ZSBkZWxpdmVyeSBvZiB0aGU8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCBBQ0sg
KyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGE8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCB3aXRoIGFuIE1QVENQIERhdGEgU2Vx
dWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAzLjMpLiA8YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRvOjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCBJZiBCIGhhcyBkYXRh
IHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIHRoZTxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIEFDSyArIE1QX0NBUEFCTEUgaXMgZW5zdXJlZCBi
eSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0O8KgIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2Vj
dGlvbiAzLjMpPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgY29udGFpbmluZyBh
IERBVEFfQUNLIGZvciB0aGUgTVBfQ0FQQUJMRcKgKHdoaWNoIGlzIHRoZSBmaXJzdDxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIG9jdGV0IG9mIHRoZSBkYXRhIHNlcXVlbmNlIHNw
YWNlKS48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEluIG15IHBl
cnNvbmFsIG9waW5pb24gZWl0aGVyIG9uZSBvZiB0aGVzZSBlZGl0cyB3b3VsZCBiZTxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBzdWZmaWNpZW50IGZvciBtYWtpbmcgdGhlIHBvaW50
LCBob3dldmVyIGNsZWFybHkgdGhpcyBoYXMgY2F1c2VkPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IHNvbWUgY29uZnVzaW9uIGFtb25nc3QgdGhlIGltcGxlbWVudG9yIGNvbW11bml0
eSBzbyBtYWtpbmcgYm90aDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyB0aGVzZSBj
aGFuZ2VzIHNob3VsZCBtYWtlIGl0IGFic29sdXRlbHkgY2xlYXIgYXMgdG8gdGhlIGV4cGVjdGVk
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IGJlaGF2aW91ciBoZXJlLjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgRWRpdCAyLCBtYXBwaW5nIGNvbnN0
cmFpbnQ8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IENoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgQSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcg
ZG9lcyBub3QgbmVlZCB0byBiZSBpbmNsdWRlZCBpbiBldmVyeTxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIE1QVENQwqBwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2Vx
dWVuY2Ugc3BhY2UgaW4gdGhhdDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIHBh
Y2tldCBpc8KgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgVG86PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIEEg
RGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgYXBwZWFyIG9uIGEgVENQIHNlZ21lbnQgd2hpY2gg
aXM8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCBjb3ZlcmVkIGJ5IHRoZSBtYXBw
aW5nLiBJdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1ZGVkIGluPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgZXZlcnkgTVBUQ1DCoHBhY2tldCwgYXMgbG9uZyBhcyB0aGUgc3Vi
ZmxvdyBzZXF1ZW5jZSBzcGFjZSBpbjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IHRoYXQgcGFja2V0IGlzwqBjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2
ZXIuPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
O8KgIDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgQXMgZmFyIGFzIEkgdW5kZXJz
dGFuZCwgdGhlIHByb3Bvc2VkIGNoYW5nZSBpbnRyb2R1Y2VzIGEg4oCcTVVTVOKAnSB0bzxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgaW5zaXN0IHRoYXQgdGhlIG1hcCBpbiBhIHNlZ21lbnQg
bXVzdCBjb3ZlciBhdCBsZWFzdCBzb21lIGRhdGEgaW48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IHRoZSBzZWdtZW50LiBCdXQgdGhlIGRvY3VtZW50IGRvZXMgbm90IHRhbGsgYW55dGhpbmcg
YWJvdXQgdGhlPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyByYXRpb25hbCBiZWhpbmQgaXQu
IEkgZ3Vlc3MgaXQgaXMgcHVyZWx5IGFuIDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBlYXNlIG9mIGltcGxlbWVudGF0aW9uPzxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyBGb3IgdHdvIHJlYXNvbnM6PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgMS4gRWFzZSBvZiBpbXBsZW1lbnRhdGlvbiAyLiBJZiBhbiBpbXBsZW1l
bnRhdGlvbiB0cmllcyB0bzxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZxdW90O3JlbWVtYmVyJnF1
b3Q7IGVhcmx5IG1hcHBpbmdzLCBpdCBpcyBub3QgY2xlYXIgaG93IG1hbnkgb2YgdGhlc2UgYW48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBpbXBsZW1lbnRhdGlvbiBjYW4gaG9sZC4gVGh1cywgdGhl
IHNlbmRlciBkb2VzIG5vdCBrbm93IGhvdyBtYW55PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgZWFy
bHkgbWFwcGluZ3MgaGUgY2FuIHNlbmQuIFNvLCBpdCBpcyBoYXJkIGZvciBhIHNlbmRlciB0byBk
byB0aGU8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyByaWdodCB0aGluZy48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEkgdGhpbmsgdGhlIGRlc2lnbi9mb3Jt
YXQgb2YgdGhlIERhdGEgU2VxdWVuY2UgTWFwcGluZyBwZXJtaXRzIHRoZTxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgbWFwIHRvIHN0YW5kIGluZGVwZW5kZW50IG9mIHRoZSBkYXRhIGJlaW5n
IGNhcnJpZWQgaW4gYSBzZWdtZW50Ljxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgU28sIGFz
IGxvbmcgYXMgYW4gaW1wbGVtZW50YXRpb24gaXMgd2lsbGluZyB0byBkZWFsIHdpdGggdGhlPGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBjb21wbGV4aXR5IG9mIHN0b3JpbmcgYW5kIHByb2Nl
c3NpbmcgbGF0ZSBhbmQgZWFybHkgbWFwcGluZ3MgKHdpdGg8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IHJlc3BlY3QgdG8gdGhlIGRhdGEgYXJyaXZhbCksIGl0IGNvdWxkIGJlIHBlcm1pdHRl
ZCBwcm92aWRlZCB0aGF0PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyB0aGUgcmVjZWl2ZWQg
bWFwIGlzIGZvciBhbiBpbi13aW5kb3cgZGF0YS48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgV2hhdCBpcyB0aGUg
Y29uY3JldGUgdXNlLWNhc2UgZm9yIHN1Y2ggZWFybHkgbWFwcGluZ3M/IFdoYXQgYXJlIHRoZTxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IGJlbmVmaXRzIG9mIGl0PyBJIHRoaW5rIHRoYXQgaWYgd2Ug
d2FudCB0byBlbmFibGUgc3VjaDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IGltcGxlbWVudGF0aW9u
LWNvbXBsZXhpdHksIHdlIG5lZWQgYSBjb21wZWxsaW5nIHVzZS1jYXNlIHdpdGggYSBiaWc8YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyBiZW5lZml0Ljxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgPGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyBDb25zaWRl
ciBhIGNhc2Ugd2hlcmUgYSBNUFRDUCBjb25uZWN0aW9uIGNvbnNpc3RzIG9mIHR3byBzdWJmbG93
cywgYW5kPGJyPiZndDsgJmd0OyAmZ3Q7IHRoZSBkYXRhIHNlZ21lbnRzIGFyZSBzY2hlZHVsZWQg
Zm9yIHRyYW5zbWlzc2lvbiBpbiB0aGUgb3JkZXIgc2hvd248YnI+Jmd0OyAmZ3Q7ICZndDsgYmVs
b3cgYmVsb3cuwqAgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDvCoCA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgU3ViZmxvdy0xOiBzZWdtZW50LTEgc2Vn
bWVudC0zIHNlZ21lbnQtNSBzZWdtZW50LTYgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgJmd0O8KgIGJ5dGVzOjEtMTAwIGJ5dGVzOjIwMS0zMDAgYnl0ZXM6NDAxLTUwMCBieXRlczo1
MDEtNjAwIDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDvCoCBubyBtYXAgbWFw
IGZvciAxLTEwMCBtYXAgZm9yIDQwMS02MDAgbm8gbWFwIDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+
Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7wqAgPGJyPiZndDsgJmd0OyAmZ3Q7IDxi
cj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDvCoCA8YnI+Jmd0OyAmZ3Q7ICZndDsg
PGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsg
U3ViZmxvdy0yOiBzZWdtZW50LTIgc2VnbWVudC00IHNlZ21lbnQtNyBzZWdtZW50LTggPGJyPiZn
dDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0O8KgIGJ5dGVzOiAxMDEtMjAwIGJ5dGVzOjMw
MS00MDAgYnl0ZXM6IDYwMS03MDAgYnl0ZXM6NzAxLTgwMMKgIDxicj4mZ3Q7ICZndDsgJmd0OyA8
YnI+Jmd0OyAmZ3Q7ICZndDvCoCBtYXAgZm9yIDEwMS0yMDAgbWFwIGZvciAzMDEtNDAwIG1hcCBm
b3IgNjAxLTgwMCBubyBtYXAgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0O8Kg
wqAgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyBJbiB0aGUgYWJvdmUgY2Fz
ZSwgdGhlIG1hcCBmb3IgZGF0YSBpbiBzZWdtZW50LTEgaXMgaW5jbHVkZWQgaW48YnI+Jmd0OyAm
Z3Q7ICZndDsgc2VnbWVudC0zLiA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyBUaGUgcXVlc3Rpb24gaGVyZSBpcyB3aHkgd291bGQgdGhlIHN0YWNrIG5vdCBwdXQgdGhl
IG1hcHBpbmcgZm9yIHNlZ21lbnQ8YnI+Jmd0OyAmZ3Q7IDEgb24gc2VnbWVudCAxIGl0c2VsZi4g
QW5kIHdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgZG9pbmcgc28/PGJyPiZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0O8KgIDxicj4mZ3Q7ICZndDsgPGJyPiZn
dDsgPGJyPiZndDsgV2VsbCBpdCBjb3VsZCBqdXN0IGJlIGR1ZSB0byB0aGUgbGFjayBvZiBvcHRp
b24gc3BhY2UgaW5zZWdtZW50LTEuIEZvcjxicj4mZ3Q7IGV4YW1wbGUsIHRoZSBzZW5kZXIgb2Zz
ZWdtZW50LTEgYXQgdGhhdCBpbnN0YW50IHdhbnRzIHRvIHRyYW5zbWl0IG11bHRpcGxlPGJyPiZn
dDsgVENQIG9wdGlvbnMgKGUuZy50aW1lc3RhbXAsIFNBQ0ssIERTUyBhbmQgQUREX0FERFIpLiBP
YnZpb3VzbHksIHRoZXkgYWxsPGJyPiZndDsgY2Fubm90IGZpdCBpbnRvIG9wdGlvbmZpZWxkIG9m
IG9uZSBzZWdtZW50LCBhbmQgZXZlbnR1YWxseSB0aGUgRFNTPGJyPiZndDsgdHJhbnNtaXNzaW9u
IGdvdCBzbGlnaHRseSBkZWxheWVkYnkgYSBzZWdtZW50IG9yIHR3by48YnI+PGJyPlRoZSBpbXBs
ZW1lbnRhdGlvbiBuZWVkcyB0byBlbmZvcmNlIGEgc3RyaWN0IHByaW9yaXR5IG9mIERTUyBvdmVy
IFNBQ0sgYW5kIEFERF9BRERSLjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PlRDUCBvcHRpb25zIGhh
dmUgZXZvbHZlZCBvdmVyIGEgcGVyaW9kIG9mIHRpbWUsIGFuZCBJIGRvIG5vdCB0aGluayBhcyBz
dWNoIGFueSBkb2N1bWVudC9ndWlkZWxpbmVzIGV4aXN0IG9uIMKgZW5mb3JjaW5nIHByaW9yaXR5
IGZvciBvbmUgb3ZlciB0aGUgb3RoZXIsIHRob3VnaCBpdCB0dXJucyBvdXQgYmUgYW4gaW50ZXJl
c3RpbmcgdG9waWMuwqAgQWxzbywgbW9yZSBUQ1Agb3B0aW9ucyBjb3VsZCBjb21lIHVwIGluIGZ1
dHVyZSBmb3IgaW1wbGVtZW50aW5nIMKgbmV3IGZlYXR1cmVzLsKgIFNvLCBpdCBpcyBsaWtlbHkg
dGhhdCBpbXBsZW1lbnRhdGlvbnMgd291bGQgZm9sbG93IGRpZmZlcmVudCBzdHJhdGVneSB3aGVu
IGl0IGNvbWUgdG8gb3B0aW9uIHByaW9yaXR5LsKgPC9kaXY+PGJsb2NrcXVvdGUgc3R5bGU9ImJv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7bWFyZ2lu
LWxlZnQ6MHB4IiB0eXBlPSJjaXRlIj48ZGl2Pjxicj48YnI+SWYgdGhlIEFERF9BRERSIGRvZXMg
bm90IGZpdCBpbiB0aGUgVENQLW9wdGlvbiBzcGFjZSwgaXQgY2FuIHNlbmQgdGhlPGJyPkFERF9B
RERSIG9uIGEgcHVyZSBBQ0suIFRoZSBlY2hvLWJpdCBpbiB0aGUgQUREX0FERFIgZ3VhcmFudGVl
IHRoZSByZWxpYWJsZTxicj5kZWxpdmVyeSBvZiBpdC48YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjxk
aXY+SSBub3RpY2VkIHRoaXMgbmV3IGZlYXR1cmUgaW4gUkZDIDY4MjQtYmlzIHRvIGRlbGl2ZXIg
QUREX0FERFIgaW4gcHVyZSBBQ0sgYW5kIHN0aWxsIGFjaGlldmUgdGhlIHJlbGlhYmlsaXR5LiBU
aGUgYWJpbGl0eSB0byBkZWxpdmVyIE1QVENQIG9wdGlvbnMgaW4gcHVyZSBBQ0sgd2lsbCBiZSB1
c2VmdWwsIGVzcGVjaWFsbHkgZm9yIG9wdGlvbnMgbGlrZSBBRERfQUREUi4gwqDCoDwvZGl2Pjxi
bG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDAsMCwyNTUpO3BhZGRp
bmctbGVmdDoxM3B4O21hcmdpbi1sZWZ0OjBweCIgdHlwZT0iY2l0ZSI+PGRpdj48YnI+PGJyPlN1
cmUsIG9uZSBjb3VsZCBhcmd1ZSB0aGF0IGZhdm9yaW5nIFNBQ0sgb3ZlciBEU1MgaXMgbW9yZSBp
bXBvcnRhbnQuIEJ1dCBJPGJyPnRoaW5rIHdlIHdvdWxkIG5lZWQgZGF0YSB0byBqdXN0aWZ5IHRo
YXQuIE9ubHkgdmVyeSBzcGVjaWZpYyB0cmFmZmljPGJyPnBhdHRlcm5zIHdpbGwgZmFsbCBpbiB0
aGlzIHVzZS1jYXNlLjxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5UaGUgYm90dG9tbGluZSBp
cyB0aGF0IGluIHRoZSBldmVudCBvZiBhIG1hcCBiZWluZyBzbGlnaHRseSBkZWxheWVkLCBpLmUu
LCBkZWxpdmVyZWQgbGF0ZSB3aXRoIHJlc3BlY3QgdG8gdGhlIGNvcnJlc3BvbmRpbmcgZGF0YSwg
c2hvdWxkIMKgaXQgcmVzdWx0IGluIHJlc2V0dGluZyB0aGUgc3ViZmxvdz/CoDwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+QXMgZmFyIGFzIHRoZSBzcGVjaWZpY2F0aW9uIGlzIGNvbmNlcm5lZCwg
aXQgY291bGQgYmUgbGliZXJhbCBvbiBhY2NlcHRpbmcgc3VjaCBtYXBzLCByYXRoZXIgdGhhbiBi
ZWluZyByZXN0cmljdGl2ZS4gRXZlbiBpZiBhIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2Fubm90
IHN1cHBvcnQgdGhpcywgZnV0dXJlIGltcGxlbWVudGF0aW9ucyBtYXkgbGlrZSB0bywgcHJvdmlk
ZWQgdGhlIHNwZWNpZmljYXRpb24gcGVybWl0cyB0aGlzIGFuZCB0aGUgaW1wbGVtZW50YXRpb24g
aXMgd2lsbGluZyB0byBjb3AgdXAgd2l0aCB0aGUgYXNzb2NpYXRlZCBjb21wbGV4aXR5LsKgPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5BbmlsPC9kaXY+PGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMCwwLDI1NSk7cGFkZGluZy1sZWZ0OjEzcHg7bWFyZ2luLWxlZnQ6MHB4IiB0eXBlPSJjaXRl
Ij48ZGl2Pjxicj48YnI+Q2hyaXN0b3BoPGJyPjxicj4mZ3Q7IDxicj4mZ3Q7wqAgPGJyPiZndDsg
PGJyPiZndDsgV2l0aCByZWdhcmRzLDxicj4mZ3Q7IDxicj4mZ3Q7wqAgPGJyPiZndDsgPGJyPiZn
dDsgQW5pbDxicj4mZ3Q7IDxicj4mZ3Q7wqAgPGJyPiZndDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IENocmlzdG9waDxicj4mZ3Q7ICZndDsg
PGJyPiZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgRnVydGhlciwgc2VnbWVudC0zIGNhbm5v
dCBjb21iaW5lL2NvdmVyIHRoZSBkYXRhIGluIHNlZ21lbnQtMSBhbmQgc2VnbWVudC0zIGluIGEg
JnF1b3Q7c2luZ2xlIG1hcCZxdW90OywgYXMgdGhlIGRhdGEgc2VxdWVuY2Ugc3BhY2UgaXMgbm90
IGNvbnRpbnVvdXMsIGkuZS4sIHNvbWUgaW4gYmV0d2VlbiBkYXRhIChzZWdtZW50LTIpIGlzIG1h
cHBlZCBhbmQgdHJhbnNtaXR0ZWQgdGhyb3VnaCBzdWJmbG93LTIuIEhlcmUsIHRoZSBtYXAgaW4g
c2VnbWVudC0zIGRvZXMgbm90IGV2ZW4gcGFydGlhbGx5IGNvdmVyIHRoZSBkYXRhIGl0IGNhcnJp
ZXMuIDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAm
Z3Q7wqAgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyBCb3RoIFJGQyA2ODI0
IGFuZCB0aGUgNjgyNC1iaXMgZG8gbm90IHJlc3RyaWN0IHRoZSBhYm92ZSBzY2VuYXJpbywgYW5k
IEkgZ3Vlc3MgdGhlIGNoYW5nZSBwcm9wb3NlZCBub3cgZG9lcyBub3QgcGVybWl0IHRoaXMgdG8g
aGFwcGVuLiA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgJmd0O8KgIDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgQmVzdCByZWdh
cmRzLCA8YnI+Jmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsg
Jmd0O8KgIDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgQW5pbCA8YnI+Jmd0
OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBUaGF0JiMzOTtzIHRoZSByZWFz
b24gd2h5IHdlICh0aGUgTVBUQ1AtdXBzdHJlYW1pbmcgY29tbXVuaXR5KSB2b3VjaCB0byBoYXZl
IHRoaXMgY2FzZSByZXN0cmljdGVkLjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7IENoZWVycyw8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyBDaHJpc3RvcGg8YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEFuaWwgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyBCZXN0IHJlZ2FyZHMsPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBBbGFuPGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IDxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgPGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgPGJyPiZndDsgJmd0OyAmZ3Q7
IDxicj4mZ3Q7ICZndDsgJmd0OyA8YnI+Jmd0OyAmZ3Q7IDxicj4mZ3Q7ICZndDsgPGJyPiZndDsg
Jmd0OyA8YnI+Jmd0OyAmZ3Q7wqAgPGJyPiZndDsgJmd0OzwvZGl2PjwvYmxvY2txdW90ZT4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4KbXVsdGlw
YXRodGNwIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm11bHRpcGF0aHRjcEBpZXRm
Lm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT48YnI+CjxhIGhy
ZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlwYXRodGNwIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5pZXRmLm9yZy9tYWls
bWFuL2xpc3RpbmZvL211bHRpcGF0aHRjcDwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rp
dj4K

--===============7314098425549961545==--
