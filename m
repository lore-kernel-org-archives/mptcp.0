Content-Type: multipart/mixed; boundary="===============0943477436641786737=="
MIME-Version: 1.0
From: V Anil Kumar <anil at csir4pi.in>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Fri, 13 Dec 2019 11:22:50 +0530
Message-ID: <f97420243acd.5df3748a@nic.in>
In-Reply-To: 49ED222B-9E71-4A8F-A280-2521ED650454@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2922

--===============0943477436641786737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Thanks for your reply. Please see inline.

On 12/12/19 12:52 AM, Christoph Paasch  <cpaasch(a)apple.com> wrote: =

> =

> =

> =

> =

> =

> Hello,
> =

> =

> =

> =

> > =

> > On Dec 10, 2019, at 12:04 PM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> > =

> > =

> > Hi Alan, =

> > =

> > =

> > =

> > Please see inline.
> > =

> > On 12/06/19 09:28 PM,  Alan Ford  <alan.ford(a)gmail.com> wrote: =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Hi all,
> > > =

> > > =

> > > =

> > > =

> > > Following on from the discussion of implementation feedback with Chri=
stoph, I propose the following edits to RFC6824bis - which is currently in =
AUTH48 - as clarifications.
> > > =

> > > =

> > > =

> > > =

> > > ADs, please can you confirm you consider these edits sufficiently edi=
torial to fit into AUTH48.
> > > =

> > > =

> > > =

> > > =

> > > WG participants, please speak up if you have any concerns.
> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Edit 1, clarifying reliability of MP_CAPABLE
> > > =

> > > =

> > > =

> > > =

> > > Change the sentence reading:
> > > =

> > > =

> > > =

> > > =

> > >  The SYN with MP_CAPABLE occupies the first octet of data sequence sp=
ace, although this does not need to be acknowledged at the connection level=
 until the first data is sent (see Section 3.3).
> > > =

> > > =

> > > =

> > > =

> > > To:
> > > =

> > > =

> > > =

> > > =

> > >  The SYN with MP_CAPABLE occupies the first octet of data sequence sp=
ace, and this MUST be acknowledged at the connection level at or before the=
 time the first data is sent or received (see Section 3.3).
> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Change the sentence reading:
> > > =

> > > =

> > > =

> > > =

> > >  If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data =
Sequence Signal (DSS) option (Section 3.3). =

> > > =

> > > =

> > > =

> > > =

> > > To:
> > > =

> > > =

> > > =

> > > =

> > >  If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data Seque=
nce Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPA=
BLE=C2=A0(which is the first octet of the data sequence space).
> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > In my personal opinion either one of these edits would be sufficient =
for making the point, however clearly this has caused some confusion amongs=
t the implementor community so making both these changes should make it abs=
olutely clear as to the expected behaviour here.
> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Edit 2, mapping constraint
> > > =

> > > =

> > > =

> > > =

> > > Change the sentence reading:
> > > =

> > > =

> > > =

> > > =

> > >  A Data Sequence Mapping does not need to be included in every MPTCP=
=C2=A0packet, as long as the subflow sequence space in that packet is=C2=A0=
covered by a mapping known at the receiver.
> > > =

> > > =

> > > =

> > > =

> > > To:
> > > =

> > > =

> > > =

> > > =

> > >  A Data Sequence Mapping MUST appear on a TCP segment which is covere=
d by the mapping. It does not need to be included in every MPTCP=C2=A0packe=
t, as long as the subflow sequence space in that packet is=C2=A0covered by =
a mapping known at the receiver.
> > > =

> > > =

> > > =

> > > =

> > >  =

> > > =

> > =

> > As far as I understand, the proposed change introduces a =E2=80=9CMUST=
=E2=80=9D to insist that the map in a segment must cover at least some data=
 in the segment. But the document does not talk anything about the rational=
 behind it. I guess it is purely an =

> > =

> > ease of implementation?
> > =

> > =

> =

> =

> For two reasons:
> =

> 1. Ease of implementation
> 2. If an implementation tries to "remember" early mappings, it is not cle=
ar how many of these an implementation can hold. Thus, the sender does not =
know how many early mappings he can send. So, it is hard for a sender to do=
 the right thing.
> =

> =

> > =

> > =

> > =

> > I think the design/format of the Data Sequence Mapping permits the map =
to stand independent of the data being carried in a segment. So, as long as=
 an implementation is willing to deal with the complexity of storing and pr=
ocessing late and early mappings (with respect to the data arrival), it cou=
ld be permitted provided that the received map is for an in-window data.
> > =

> > =

> =

> =

> What is the concrete use-case for such early mappings? What are the benef=
its of it? I think that if we want to enable such implementation-complexity=
, we need a compelling use-case with a big benefit.
> =

> =

>  =

> =


Consider a case where a MPTCP connection consists of two subflows, and the =
data segments are scheduled for transmission in the order shown below below=
.  =



 =




Subflow-1: segment-1 segment-3 segment-5 segment-6 =


 bytes:1-100 bytes:201-300 bytes:401-500 bytes:501-600 =


 no map map for 1-100 map for 401-600 no map =



 =



 =




Subflow-2: segment-2 segment-4 segment-7 segment-8 =


 bytes: 101-200 bytes:301-400 bytes: 601-700 bytes:701-800  =


 map for 101-200 map for 301-400 map for 601-800 no map =


  =


In the above case, the map for data in segment-1 is included in segment-3. =
Further, segment-3 cannot combine/cover the data in segment-1 and segment-3=
 in a "single map", as the data sequence space is not continuous, i.e., som=
e in between data (segment-2) is mapped and transmitted through subflow-2. =
Here, the map in segment-3 does not even partially cover the data it carrie=
s. =



 =


Both RFC 6824 and the 6824-bis do not restrict the above scenario, and I gu=
ess the change proposed now does not permit this to happen. =



 =


Best regards, =



 =


Anil =




> =

> =

> =

> =

> =

> =

> =

> That's the reason why we (the MPTCP-upstreaming community) vouch to have =
this case restricted.
> =

> =

> =

> Cheers,
> Christoph
> =

> =

> =

> =

> =

> > =

> > =

> > =

> > =

> > =

> > =

> > Anil =

> > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > > Best regards,
> > > =

> > > Alan
> > > =

> > > =

> > >  =

> > > =

> > =

> > =

> =

> =

> =

> =

>  =

>=20

--===============0943477436641786737==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQ2hyaXN0b3BoLDxkaXY+PGJyIC8+PC9kaXY+PGRpdj5UaGFua3MgZm9yIHlvdXIgcmVwbHku
IFBsZWFzZSBzZWUgaW5saW5lLjxiciAvPjxiciAvPjxzcGFuPk9uIDEyLzEyLzE5IDEyOjUyIEFN
LCA8YiBjbGFzcz0ibmFtZSI+Q2hyaXN0b3BoIFBhYXNjaCA8L2I+ICZsdDtjcGFhc2NoQGFwcGxl
LmNvbSZndDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1b3RlIGNpdGU9Im1pZDo0OUVEMjIyQi05RTcx
LTRBOEYtQTI4MC0yNTIxRUQ2NTA0NTRAYXBwbGUuY29tIiBjbGFzcz0iaXdjUXVvdGUiIHN0eWxl
PSJib3JkZXItbGVmdDogMXB4IHNvbGlkICMwMEY7IHBhZGRpbmctbGVmdDogMTNweDsgbWFyZ2lu
LWxlZnQ6IDA7IiB0eXBlPSJjaXRlIj48ZGl2IGNsYXNzPSJtaW1ldHlwZS10ZXh0LWh0bWwiPjxz
cGFuPjxwPjxtZXRhIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCIgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiAvPjx0YWJsZT48dGJvZHk+PHRyPjx0ZCBjbGFzcz0iIiBzdHlsZT0i
d29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJl
YWs6IGFmdGVyLXdoaXRlLXNwYWNlOyI+PHA+SGVsbG8sPGJyIGNsYXNzPSIiIC8+PC9wPjxkaXY+
PGJyIGNsYXNzPSIiIC8+PGJsb2NrcXVvdGUgY2xhc3M9IiIgdHlwZT0iY2l0ZSI+PGRpdiBjbGFz
cz0iIj5PbiBEZWMgMTAsIDIwMTksIGF0IDEyOjA0IFBNLCBWIEFuaWwgS3VtYXIgJmx0OzxhIGNs
YXNzPSIiIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iPmFuaWxAY3NpcjRwaS5pbjwvYT4m
Z3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSIgLz48
ZGl2IGNsYXNzPSIiPjxzcGFuIGNsYXNzPSIiIHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAs
IDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEzcHg7IGZvbnQtc3R5bGU6
IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsg
bGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAw
cHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNp
bmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246
IG5vbmU7IGZsb2F0OiBub25lOyBkaXNwbGF5OiBpbmxpbmUgIWltcG9ydGFudDsiPkhpIEFsYW4s
PC9zcGFuPjxkaXYgY2xhc3M9IiIgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZv
bnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNweDsgZm9udC1zdHlsZTogbm9ybWFs
OyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXIt
c3BhY2luZzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4
dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4
OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsi
PjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXYgY2xhc3M9IiIgc3R5bGU9ImNhcmV0LWNvbG9yOiBy
Z2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNweDsgZm9u
dC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDog
bm9ybWFsOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1p
bmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdv
cmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVj
b3JhdGlvbjogbm9uZTsiPlBsZWFzZSBzZWUgaW5saW5lLjxiciBjbGFzcz0iIiAvPjxiciBjbGFz
cz0iIiAvPjxzcGFuIGNsYXNzPSIiPk9uIDEyLzA2LzE5IDA5OjI4IFBNLDxiIGNsYXNzPSJuYW1l
Ij5BbGFuIEZvcmQ8L2I+Jmx0OzxhIGNsYXNzPSIiIGhyZWY9Im1haWx0bzphbGFuLmZvcmRAZ21h
aWwuY29tIj5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1
b3RlIGNpdGU9Im1pZDo2OTc4Qzk3Ri0yNEQ1LTRDRjAtOENFQi0yRjU4QkUyNkQxNzRAZ21haWwu
Y29tIiBjbGFzcz0iaXdjUXVvdGUiIHN0eWxlPSJib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3Jk
ZXItbGVmdC1zdHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMCwgMCwgMjU1KTsg
cGFkZGluZy1sZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMHB4OyIgdHlwZT0iY2l0ZSI+PGRpdiBj
bGFzcz0ibWltZXR5cGUtdGV4dC1odG1sIj48c3BhbiBjbGFzcz0iIj48cCBjbGFzcz0iIj48dGFi
bGUgY2xhc3M9IiI+PHRib2R5IGNsYXNzPSIiPjx0ciBjbGFzcz0iIj48dGQgY2xhc3M9IiIgc3R5
bGU9IndvcmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5l
LWJyZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiPjxwIGNsYXNzPSIiPkhpIGFsbCw8L3A+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNsYXNzPSIiPkZvbGxvd2luZyBvbiBm
cm9tIHRoZSBkaXNjdXNzaW9uIG9mIGltcGxlbWVudGF0aW9uIGZlZWRiYWNrIHdpdGggQ2hyaXN0
b3BoLCBJIHByb3Bvc2UgdGhlIGZvbGxvd2luZyBlZGl0cyB0byBSRkM2ODI0YmlzIC0gd2hpY2gg
aXMgY3VycmVudGx5IGluIEFVVEg0OCAtIGFzIGNsYXJpZmljYXRpb25zLjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj5BRHMsIHBsZWFzZSBjYW4g
eW91IGNvbmZpcm0geW91IGNvbnNpZGVyIHRoZXNlIGVkaXRzIHN1ZmZpY2llbnRseSBlZGl0b3Jp
YWwgdG8gZml0IGludG8gQVVUSDQ4LjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+
PC9kaXY+PGRpdiBjbGFzcz0iIj5XRyBwYXJ0aWNpcGFudHMsIHBsZWFzZSBzcGVhayB1cCBpZiB5
b3UgaGF2ZSBhbnkgY29uY2VybnMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIg
Y2xhc3M9IiI+RWRpdCAxLCBjbGFyaWZ5aW5nIHJlbGlhYmlsaXR5IG9mIE1QX0NBUEFCTEU8L2I+
PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2I+PC9kaXY+
PGRpdiBjbGFzcz0iIj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJlYWRpbmc6PC9kaXY+PGRpdiBjbGFz
cz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNsYXNzPSIiPsKgIMKgVGhlIFNZTiB3aXRo
IE1QX0NBUEFCTEUgb2NjdXBpZXMgdGhlIGZpcnN0IG9jdGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3Bh
Y2UsIGFsdGhvdWdoIHRoaXMgZG9lcyBub3QgbmVlZCB0byBiZSBhY2tub3dsZWRnZWQgYXQgdGhl
IGNvbm5lY3Rpb24gbGV2ZWwgdW50aWwgdGhlIGZpcnN0IGRhdGEgaXMgc2VudCAoc2VlIFNlY3Rp
b24gMy4zKS48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXYgY2xh
c3M9IiI+VG86PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNs
YXNzPSIiPsKgIMKgVGhlIFNZTiB3aXRoIE1QX0NBUEFCTEUgb2NjdXBpZXMgdGhlIGZpcnN0IG9j
dGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UsIGFuZCB0aGlzIE1VU1QgYmUgYWNrbm93bGVkZ2Vk
IGF0IHRoZSBjb25uZWN0aW9uIGxldmVsIGF0IG9yIGJlZm9yZSB0aGUgdGltZSB0aGUgZmlyc3Qg
ZGF0YSBpcyBzZW50IG9yIHJlY2VpdmVkIChzZWUgU2VjdGlvbiAzLjMpLjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj48YnIg
Y2xhc3M9IiIgLz48L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJl
YWRpbmc6PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNsYXNz
PSIiPsKgIMKgSWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBk
ZWxpdmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBjYW4gYmUgaW5mZXJyZWQgYnkgdGhlIHJl
Y2VpcHQgb2YgdGhpcyBkYXRhIHdpdGggYW4gTVBUQ1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERT
Uykgb3B0aW9uIChTZWN0aW9uIDMuMykuwqA8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
IiAvPjwvZGl2PjxkaXYgY2xhc3M9IiI+VG86PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiIgLz48L2Rpdj48ZGl2IGNsYXNzPSIiPsKgIMKgSWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0
LCB0aGVuIHRoZSByZWxpYWJsZSBkZWxpdmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBpcyBl
bnN1cmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1QVENQIERhdGEgU2Vx
dWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAzLjMpIGNvbnRhaW5pbmcgYSBEQVRB
X0FDSyBmb3IgdGhlIE1QX0NBUEFCTEXCoCh3aGljaCBpcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgdGhl
IGRhdGEgc2VxdWVuY2Ugc3BhY2UpLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+
PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNsYXNzPSIiPklu
IG15IHBlcnNvbmFsIG9waW5pb24gZWl0aGVyIG9uZSBvZiB0aGVzZSBlZGl0cyB3b3VsZCBiZSBz
dWZmaWNpZW50IGZvciBtYWtpbmcgdGhlIHBvaW50LCBob3dldmVyIGNsZWFybHkgdGhpcyBoYXMg
Y2F1c2VkIHNvbWUgY29uZnVzaW9uIGFtb25nc3QgdGhlIGltcGxlbWVudG9yIGNvbW11bml0eSBz
byBtYWtpbmcgYm90aCB0aGVzZSBjaGFuZ2VzIHNob3VsZCBtYWtlIGl0IGFic29sdXRlbHkgY2xl
YXIgYXMgdG8gdGhlIGV4cGVjdGVkIGJlaGF2aW91ciBoZXJlLjwvZGl2PjxkaXYgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiIgLz48L2Rpdj48
ZGl2IGNsYXNzPSIiPjxiIGNsYXNzPSIiPkVkaXQgMiwgbWFwcGluZyBjb25zdHJhaW50PC9iPjwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9iPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+Q2hhbmdlIHRoZSBzZW50ZW5jZSByZWFkaW5nOjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj7CoCDCoEEgRGF0YSBTZXF1ZW5j
ZSBNYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkgTVBUQ1DCoHBh
Y2tldCwgYXMgbG9uZyBhcyB0aGUgc3ViZmxvdyBzZXF1ZW5jZSBzcGFjZSBpbiB0aGF0IHBhY2tl
dCBpc8KgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ubzo8L2Rpdj48
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXYgY2xhc3M9IiI+wqAgwqBBIERh
dGEgU2VxdWVuY2UgTWFwcGluZyBNVVNUIGFwcGVhciBvbiBhIFRDUCBzZWdtZW50IHdoaWNoIGlz
IGNvdmVyZWQgYnkgdGhlIG1hcHBpbmcuIEl0IGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQg
aW4gZXZlcnkgTVBUQ1DCoHBhY2tldCwgYXMgbG9uZyBhcyB0aGUgc3ViZmxvdyBzZXF1ZW5jZSBz
cGFjZSBpbiB0aGF0IHBhY2tldCBpc8KgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhl
IHJlY2VpdmVyLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+PC9iPjwvZGl2PjwvdGQ+
PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBj
bGFzcz0iIj5BcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCB0aGUgcHJvcG9zZWQgY2hhbmdlIGludHJv
ZHVjZXMgYSDigJxNVVNU4oCdIHRvIGluc2lzdCB0aGF0IHRoZSBtYXAgaW4gYSBzZWdtZW50IG11
c3QgY292ZXIgYXQgbGVhc3Qgc29tZSBkYXRhIGluIHRoZSBzZWdtZW50LiBCdXQgdGhlIGRvY3Vt
ZW50IGRvZXMgbm90IHRhbGsgYW55dGhpbmcgYWJvdXQgdGhlIHJhdGlvbmFsIGJlaGluZCBpdC4g
SSBndWVzcyBpdCBpcyBwdXJlbHkgYW7CoDwvZGl2PjxkaXYgY2xhc3M9IiI+ZWFzZSBvZiBpbXBs
ZW1lbnRhdGlvbj88L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnIgY2xhc3M9
IiIgLz48L2Rpdj48ZGl2PkZvciB0d28gcmVhc29uczo8L2Rpdj48ZGl2PjxiciBjbGFzcz0iIiAv
PjwvZGl2PjxkaXY+MS4gRWFzZSBvZiBpbXBsZW1lbnRhdGlvbjwvZGl2PjxkaXY+Mi4gSWYgYW4g
aW1wbGVtZW50YXRpb24gdHJpZXMgdG8gJnF1b3Q7cmVtZW1iZXImcXVvdDsgZWFybHkgbWFwcGlu
Z3MsIGl0IGlzIG5vdCBjbGVhciBob3cgbWFueSBvZiB0aGVzZSBhbiBpbXBsZW1lbnRhdGlvbiBj
YW4gaG9sZC4gVGh1cywgdGhlIHNlbmRlciBkb2VzIG5vdCBrbm93IGhvdyBtYW55IGVhcmx5IG1h
cHBpbmdzIGhlIGNhbiBzZW5kLiBTbywgaXQgaXMgaGFyZCBmb3IgYSBzZW5kZXIgdG8gZG8gdGhl
IHJpZ2h0IHRoaW5nLjwvZGl2PjxiciBjbGFzcz0iIiAvPjxibG9ja3F1b3RlIGNsYXNzPSIiIHR5
cGU9ImNpdGUiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIiBzdHlsZT0iY2FyZXQtY29sb3I6
IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgZm9udC1zaXplOiAxM3B4OyBm
b250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFyaWFudC1jYXBzOiBub3JtYWw7IGZvbnQtd2VpZ2h0
OiBub3JtYWw7IGxldHRlci1zcGFjaW5nOiBub3JtYWw7IHRleHQtYWxpZ246IHN0YXJ0OyB0ZXh0
LWluZGVudDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vcm1hbDsg
d29yZC1zcGFjaW5nOiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6IDBweDsgdGV4dC1k
ZWNvcmF0aW9uOiBub25lOyI+PGRpdiBjbGFzcz0iIj5JIHRoaW5rIHRoZSBkZXNpZ24vZm9ybWF0
IG9mIHRoZSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgcGVybWl0cyB0aGUgbWFwIHRvIHN0YW5kIGlu
ZGVwZW5kZW50IG9mIHRoZSBkYXRhIGJlaW5nIGNhcnJpZWQgaW4gYSBzZWdtZW50LiBTbywgYXMg
bG9uZyBhcyBhbiBpbXBsZW1lbnRhdGlvbiBpcyB3aWxsaW5nIHRvIGRlYWwgd2l0aCB0aGUgY29t
cGxleGl0eSBvZiBzdG9yaW5nIGFuZCBwcm9jZXNzaW5nIGxhdGUgYW5kIGVhcmx5IG1hcHBpbmdz
ICh3aXRoIHJlc3BlY3QgdG8gdGhlIGRhdGEgYXJyaXZhbCksIGl0IGNvdWxkIGJlIHBlcm1pdHRl
ZCBwcm92aWRlZCB0aGF0IHRoZSByZWNlaXZlZCBtYXAgaXMgZm9yIGFuIGluLXdpbmRvdyBkYXRh
LjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIiAvPjwvZGl2
PjxkaXY+V2hhdCBpcyB0aGUgY29uY3JldGUgdXNlLWNhc2UgZm9yIHN1Y2ggZWFybHkgbWFwcGlu
Z3M/IFdoYXQgYXJlIHRoZSBiZW5lZml0cyBvZiBpdD8gSSB0aGluayB0aGF0IGlmIHdlIHdhbnQg
dG8gZW5hYmxlIHN1Y2ggaW1wbGVtZW50YXRpb24tY29tcGxleGl0eSwgd2UgbmVlZCBhIGNvbXBl
bGxpbmcgdXNlLWNhc2Ugd2l0aCBhIGJpZyBiZW5lZml0LjwvZGl2PjwvZGl2PjwvdGQ+PC90cj48
L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOiAxMHB0OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPkNvbnNpZGVyIGEg
Y2FzZSB3aGVyZSBhIE1QVENQIGNvbm5lY3Rpb24gY29uc2lzdHMgb2YgdHdvIHN1YmZsb3dzLCBh
bmQgdGhlIGRhdGEgc2VnbWVudHMgYXJlIHNjaGVkdWxlZCBmb3IgdHJhbnNtaXNzaW9uIGluIHRo
ZSBvcmRlciBzaG93biBiZWxvdyBiZWxvdy7CoDwvc3Bhbj48L2Rpdj48ZGl2PjxwIGNsYXNzPSJN
c29Ob3JtYWwiIHN0eWxlPSJtYXJnaW46IDBjbSAwY20gMC4wMDAxcHQ7IGZvbnQtc2l6ZTogMTJw
dDsgZm9udC1mYW1pbHk6IENhbWJyaWE7Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQt
c2l6ZTogMTBwdDsiPjxiciAvPjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9
Im1hcmdpbjogMGNtIDBjbSAwLjAwMDFwdDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTog
Q2FtYnJpYTsiPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNt
IDAuMDAwMXB0OyBmb250LXNpemU6IDEycHQ7IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PHNwYW4g
bGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij5TdWJmbG93LTE6wqAgwqAgwqAg
c2VnbWVudC0xwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VnbWVudC0zwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VnbWVudC01wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzZWdtZW50LTY8bzpwPjwvbzpwPjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1z
b05vcm1hbCIgc3R5bGU9Im1hcmdpbjogMGNtIDBjbSAwLjAwMDFwdDsgZm9udC1zaXplOiAxMnB0
OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1z
aXplOiAxMHB0OyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKg
wqDCoMKgIGJ5dGVzOjEtMTAwIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnl0ZXM6MjAx
LTMwMMKgIMKgIMKgIMKgIMKgIMKgIGJ5dGVzOjQwMS01MDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnl0ZXM6NTAxLTYwMDxvOnA+PC9vOnA+PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNv
Tm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNtIDAuMDAwMXB0OyBmb250LXNpemU6IDEycHQ7
IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNp
emU6IDEwcHQ7Ij7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDC
oMKgwqAgbm8gbWFwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXAgZm9y
IDEtMTAwwqAgwqAgwqAgwqAgwqAgwqAgbWFwIGZvciA0MDEtNjAwwqAgwqAgwqAgwqAgwqAgwqAg
bm8gbWFwPG86cD48L286cD48L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJt
YXJnaW46IDBjbSAwY20gMC4wMDAxcHQ7IGZvbnQtc2l6ZTogMTJwdDsgZm9udC1mYW1pbHk6IENh
bWJyaWE7Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiPjxiciAv
Pjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbjogMGNtIDBjbSAw
LjAwMDFwdDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPjxzcGFuIGxh
bmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+PGJyIC8+PC9zcGFuPjwvcD48cCBj
bGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNtIDAuMDAwMXB0OyBmb250LXNp
emU6IDEycHQ7IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PC9wPjxwIGNsYXNzPSJNc29Ob3JtYWwi
IHN0eWxlPSJtYXJnaW46IDBjbSAwY20gMC4wMDAxcHQ7IGZvbnQtc2l6ZTogMTJwdDsgZm9udC1m
YW1pbHk6IENhbWJyaWE7Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZTogMTBw
dDsiPlN1YmZsb3ctMjrCoCDCoCDCoCDCoHNlZ21lbnQtMsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHNlZ21lbnQtNMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VnbWVudC03
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWdtZW50LTg8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbjogMGNtIDBjbSAwLjAwMDFw
dDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPjxzcGFuIGxhbmc9IkVO
LVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVzOiAxMDEtMjAwwqDCoMKgwqDCoMKgwqDCoCBi
eXRlczozMDEtNDAwwqDCoMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKgIGJ5dGVzOiA2MDEtNzAwwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVzOjcwMS04MDDCoMKgwqA8bzpwPjwvbzpwPjwvc3Bh
bj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbjogMGNtIDBjbSAwLjAwMDFw
dDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPjxzcGFuIGxhbmc9IkVO
LVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgIG1hcCBmb3IgMTAxLTIwMMKgIMKgIMKgbWFwIGZvciAz
MDEtNDAwwqDCoMKgwqDCoMKgIMKgwqDCoMKgbWFwIGZvciA2MDEtODAwwqAgwqAgwqAgwqAgwqBu
byBtYXA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1h
cmdpbjogMGNtIDBjbSAwLjAwMDFwdDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2Ft
YnJpYTsiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDxvOnA+PC9vOnA+PC9zcGFuPjwvcD48cCBjbGFz
cz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNtIDAuMDAwMXB0OyBmb250LXNpemU6
IDEycHQ7IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJm
b250LXNpemU6IDEwcHQ7Ij5JbiB0aGUgYWJvdmUgY2FzZSwgdGhlIG1hcCBmb3IgZGF0YSBpbiBz
ZWdtZW50LTEgaXMgaW5jbHVkZWQgaW4gc2VnbWVudC0zLiBGdXJ0aGVyLCBzZWdtZW50LTMgY2Fu
bm90IGNvbWJpbmUvY292ZXIgdGhlIGRhdGEgaW4gc2VnbWVudC0xIGFuZCBzZWdtZW50LTMgaW4g
YSAmcXVvdDtzaW5nbGUgbWFwJnF1b3Q7LCBhcyB0aGUgZGF0YSBzZXF1ZW5jZSBzcGFjZSBpcyBu
b3QgY29udGludW91cywgaS5lLiwgc29tZSBpbiBiZXR3ZWVuIGRhdGEgKHNlZ21lbnQtMikgaXMg
bWFwcGVkIGFuZCB0cmFuc21pdHRlZCB0aHJvdWdoIHN1YmZsb3ctMi4gSGVyZSzCoCB0aGUgbWFw
IGluIHNlZ21lbnQtMyBkb2VzIG5vdCBldmVuIHBhcnRpYWxseSBjb3ZlciB0aGUgZGF0YSBpdCBj
YXJyaWVzLjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbjogMGNt
IDBjbSAwLjAwMDFwdDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2FtYnJpYTsiPjxz
cGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+PGJyIC8+PC9zcGFuPjwv
cD48cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNtIDAuMDAwMXB0OyBm
b250LXNpemU6IDEycHQ7IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PHNwYW4gbGFuZz0iRU4tVVMi
IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij5Cb3RoIFJGQyA2ODI0IGFuZCB0aGUgNjgyNC1iaXMg
ZG8gbm90IHJlc3RyaWN0IHRoZSBhYm92ZSBzY2VuYXJpbywgYW5kIEkgZ3Vlc3MgdGhlIGNoYW5n
ZSBwcm9wb3NlZCBub3cgZG9lcyBub3QgcGVybWl0IHRoaXMgdG8gaGFwcGVuLjxvOnA+PC9vOnA+
PC9zcGFuPjwvcD48cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luOiAwY20gMGNtIDAu
MDAwMXB0OyBmb250LXNpemU6IDEycHQ7IGZvbnQtZmFtaWx5OiBDYW1icmlhOyI+PHNwYW4gbGFu
Zz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6IDEwcHQ7Ij48YnIgLz48L3NwYW4+PC9wPjxwIGNs
YXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW46IDBjbSAwY20gMC4wMDAxcHQ7IGZvbnQtc2l6
ZTogMTJwdDsgZm9udC1mYW1pbHk6IENhbWJyaWE7Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9
ImZvbnQtc2l6ZTogMTBwdDsiPkJlc3QgcmVnYXJkcyw8L3NwYW4+PC9wPjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJtYXJnaW46IDBjbSAwY20gMC4wMDAxcHQ7IGZvbnQtc2l6ZTogMTJwdDsg
Zm9udC1mYW1pbHk6IENhbWJyaWE7Ij48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6
ZTogMTBwdDsiPjxiciAvPjwvc3Bhbj48L3A+PHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1h
cmdpbjogMGNtIDBjbSAwLjAwMDFwdDsgZm9udC1zaXplOiAxMnB0OyBmb250LWZhbWlseTogQ2Ft
YnJpYTsiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyI+QW5pbDwv
c3Bhbj48L3A+PGRpdj48YnIgLz48L2Rpdj48L2Rpdj48YmxvY2txdW90ZSBjaXRlPSJtaWQ6NDlF
RDIyMkItOUU3MS00QThGLUEyODAtMjUyMUVENjUwNDU0QGFwcGxlLmNvbSIgY2xhc3M9Iml3Y1F1
b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAjMDBGOyBwYWRkaW5nLWxlZnQ6IDEz
cHg7IG1hcmdpbi1sZWZ0OiAwOyIgdHlwZT0iY2l0ZSI+PGRpdiBjbGFzcz0ibWltZXR5cGUtdGV4
dC1odG1sIj48c3Bhbj48cD48dGFibGU+PHRib2R5Pjx0cj48dGQgY2xhc3M9IiIgc3R5bGU9Indv
cmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFr
OiBhZnRlci13aGl0ZS1zcGFjZTsiPjxkaXY+PGRpdiA+PGJyIC8+PC9kaXY+PGRpdj48YnIgY2xh
c3M9IiIgLz48L2Rpdj48ZGl2PlRoYXQncyB0aGUgcmVhc29uIHdoeSB3ZSAodGhlIE1QVENQLXVw
c3RyZWFtaW5nIGNvbW11bml0eSkgdm91Y2ggdG8gaGF2ZSB0aGlzIGNhc2UgcmVzdHJpY3RlZC48
L2Rpdj48ZGl2PjxiciBjbGFzcz0iIiAvPjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiIC8+PC9kaXY+
PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5DaHJpc3RvcGg8L2Rpdj48ZGl2PjxiciBjbGFzcz0iIiAv
PjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiIgLz48L2Rp
dj48YnIgY2xhc3M9IiIgLz48YmxvY2txdW90ZSBjbGFzcz0iIiB0eXBlPSJjaXRlIj48ZGl2IGNs
YXNzPSIiPjxkaXYgY2xhc3M9IiIgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZv
bnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTNweDsgZm9udC1zdHlsZTogbm9ybWFs
OyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXIt
c3BhY2luZzogbm9ybWFsOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4
dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4
OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsi
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRpdiBjbGFzcz0iIj5BbmlswqA8
L2Rpdj48YmxvY2txdW90ZSBjaXRlPSJtaWQ6Njk3OEM5N0YtMjRENS00Q0YwLThDRUItMkY1OEJF
MjZEMTc0QGdtYWlsLmNvbSIgY2xhc3M9Iml3Y1F1b3RlIiBzdHlsZT0iYm9yZGVyLWxlZnQtd2lk
dGg6IDFweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjogcmdi
KDAsIDAsIDI1NSk7IHBhZGRpbmctbGVmdDogMTNweDsgbWFyZ2luLWxlZnQ6IDBweDsiIHR5cGU9
ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0eXBlLXRleHQtaHRtbCI+PHNwYW4gY2xhc3M9IiI+PHAg
Y2xhc3M9IiI+PHRhYmxlIGNsYXNzPSIiPjx0Ym9keSBjbGFzcz0iIj48dHIgY2xhc3M9IiI+PHRk
IGNsYXNzPSIiIHN0eWxlPSJ3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2Rl
OiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hpdGUtc3BhY2U7Ij48ZGl2IGNsYXNzPSIiPjxi
IGNsYXNzPSIiPjxiciBjbGFzcz0iIiAvPjwvYj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFz
cz0iIiAvPjwvZGl2PjxkaXYgY2xhc3M9IiI+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9
IiI+QWxhbjwvZGl2PjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48
L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIiAv
PjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVvdGU+
PC9kaXY+Cg==

--===============0943477436641786737==--
