Content-Type: multipart/mixed; boundary="===============7179685359738241216=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Wed, 11 Dec 2019 11:28:53 -0800
Message-ID: <2689B456-2B1C-4D84-B36E-74FA0FFD2E3B@apple.com>
In-Reply-To: 63E04612-7410-4E38-BE19-F2351C23C7F7@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2876

--===============7179685359738241216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Alan,

there is one more thing that came up from the implementation experience (th=
anks to Matthieu & Paolo in CC).

It is unclear in the draft (or at least, I didn't find the text ;-) ), what=
 to do when the flags & version in the third ACK + MP_CAPABLE are inconsist=
ent with what was negotiated in the SYN-SYN/ACK exchange.

It would be good to spell this out and say that if there are any inconsiste=
ncies, a host should simply fallback to regular TCP.


Christoph

> On Dec 10, 2019, at 8:09 AM, Alan Ford <alan.ford(a)gmail.com> wrote:
> =

> Hi Yoshifumi,
> =

>> On 10 Dec 2019, at 05:30, Yoshifumi Nishida <nsd.ietf(a)gmail.com <mailt=
o:nsd.ietf(a)gmail.com>> wrote:
>> =

>> Hi Alan,
>> =

>> The texts look fine to me, but I have a few questions on them.
>> =

>> On Fri, Dec 6, 2019 at 7:58 AM Alan Ford <alan.ford(a)gmail.com <mailto:=
alan.ford(a)gmail.com>> wrote:
>> Hi all,
>> =

>> Following on from the discussion of implementation feedback with Christo=
ph, I propose the following edits to RFC6824bis - which is currently in AUT=
H48 - as clarifications.
>> =

>> ADs, please can you confirm you consider these edits sufficiently editor=
ial to fit into AUTH48.
>> =

>> WG participants, please speak up if you have any concerns.
>> =

>> =

>> Edit 1, clarifying reliability of MP_CAPABLE
>> =

>> Change the sentence reading:
>> =

>>    The SYN with MP_CAPABLE occupies the first octet of data sequence spa=
ce, although this does not need to be acknowledged at the connection level =
until the first data is sent (see Section 3.3).
>> =

>> To:
>> =

>>    The SYN with MP_CAPABLE occupies the first octet of data sequence spa=
ce, and this MUST be acknowledged at the connection level at or before the =
time the first data is sent or received (see Section 3.3).
>> =

>> What implementations should do when they receive the first data before M=
P_CAPABLE is acked?
>> They should terminate the connection or discard the data?
> =

> By asking this question you have made me realise that this text is in fac=
t incompatible with the case when A (the initiator) is also the first sende=
r of data.
> =

> Given the problem is only with B sending data first, let us forget this c=
hange, and revert to Christoph=E2=80=99s original problem text, and use onl=
y the below change:
> =

>> Change the sentence reading:
>> =

>>    If B has data to send first, then the reliable delivery of the ACK + =
MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data S=
equence Signal (DSS) option (Section 3.3). =

>> =

>> To:
>> =

>>    If B has data to send first, then the reliable delivery of the ACK + =
MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data Sequen=
ce Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPAB=
LE (which is the first octet of the data sequence space).
> =

> This will resolve the ambiguity in the case of B sending first.
> =

>> In my personal opinion either one of these edits would be sufficient for=
 making the point, however clearly this has caused some confusion amongst t=
he implementor community so making both these changes should make it absolu=
tely clear as to the expected behaviour here.
>> =

>> =

>> Edit 2, mapping constraint
>> =

>> Change the sentence reading:
>> =

>>    A Data Sequence Mapping does not need to be included in every MPTCP p=
acket, as long as the subflow sequence space in that packet is covered by a=
 mapping known at the receiver.
>> =

>> To:
>> =

>>    A Data Sequence Mapping MUST appear on a TCP segment which is covered=
 by the mapping. It does not need to be included in every MPTCP packet, as =
long as the subflow sequence space in that packet is covered by a mapping k=
nown at the receiver.
>> =

>> =

>> What implementations should do when a Data Sequence Mapping doesn't cove=
r the TCP segment that carries this option?
> =

> There are a number of cases where the MUST does not have a consequence; i=
t should be obvious from the text for similar failures that it can close it=
 with a RST.
> =

>> BTW, This is not a strong opinion, but I may prefer a text like: "A Data=
 Sequence Mapping MUST provide the mapping for the segment that carries thi=
s option.=E2=80=9D =

> =

> OK how about: "A Data Sequence Mapping MUST provide the mapping which inc=
ludes the segment that carries this option.=E2=80=9D =

> =

> Regards,
> Alan
> =

> =



--===============7179685359738241216==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8gQWxhbiw8ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48
L2Rpdj48ZGl2IGNsYXNzPSIiPnRoZXJlIGlzIG9uZSBtb3JlIHRoaW5nIHRoYXQgY2FtZSB1cCBm
cm9tIHRoZSBpbXBsZW1lbnRhdGlvbiBleHBlcmllbmNlICh0aGFua3MgdG8gTWF0dGhpZXUgJmFt
cDsgUGFvbG8gaW4gQ0MpLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+SXQgaXMgdW5jbGVhciBpbiB0aGUgZHJhZnQgKG9yIGF0IGxlYXN0LCBJIGRp
ZG4ndCBmaW5kIHRoZSB0ZXh0IDstKSApLCB3aGF0IHRvIGRvIHdoZW4gdGhlIGZsYWdzICZhbXA7
IHZlcnNpb24gaW4gdGhlIHRoaXJkIEFDSyArIE1QX0NBUEFCTEUgYXJlIGluY29uc2lzdGVudCB3
aXRoIHdoYXQgd2FzIG5lZ290aWF0ZWQgaW4gdGhlIFNZTi1TWU4vQUNLIGV4Y2hhbmdlLjwvZGl2
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+SXQgd291bGQg
YmUgZ29vZCB0byBzcGVsbCB0aGlzIG91dCBhbmQgc2F5IHRoYXQgaWYgdGhlcmUgYXJlIGFueSBp
bmNvbnNpc3RlbmNpZXMsIGEgaG9zdCBzaG91bGQgc2ltcGx5IGZhbGxiYWNrIHRvIHJlZ3VsYXIg
VENQLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hyaXN0b3BoPC9kaXY+PGRpdiBjbGFz
cz0iIj48ZGl2PjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48
ZGl2IGNsYXNzPSIiPk9uIERlYyAxMCwgMjAxOSwgYXQgODowOSBBTSwgQWxhbiBGb3JkICZsdDs8
YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+YWxhbi5mb3JkQGdt
YWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2Ut
bmV3bGluZSI+PGRpdiBjbGFzcz0iIj48bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNv
bnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCIgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29y
ZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyIgY2xhc3M9IiI+SGkgWW9zaGlmdW1pLDxiciBjbGFzcz0iIj48
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0i
Ij48ZGl2IGNsYXNzPSIiPk9uIDEwIERlYyAyMDE5LCBhdCAwNTozMCwgWW9zaGlmdW1pIE5pc2hp
ZGEgJmx0OzxhIGhyZWY9Im1haWx0bzpuc2QuaWV0ZkBnbWFpbC5jb20iIGNsYXNzPSIiPm5zZC5p
ZXRmQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJj
aGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkhpIEFsYW4sPC9kaXY+PGRpdiBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5UaGUgdGV4dHMgbG9vayBmaW5l
IHRvIG1lLCBidXQgSSBoYXZlIGEgZmV3IHF1ZXN0aW9ucyBvbiB0aGVtLjwvZGl2PjxiciBjbGFz
cz0iIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWls
X2F0dHIiPk9uIEZyaSwgRGVjIDYsIDIwMTkgYXQgNzo1OCBBTSBBbGFuIEZvcmQgJmx0OzxhIGhy
ZWY9Im1haWx0bzphbGFuLmZvcmRAZ21haWwuY29tIiBjbGFzcz0iIj5hbGFuLmZvcmRAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyIGNsYXNzPSIiPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJ3
b3JkLXdyYXA6YnJlYWstd29yZCIgY2xhc3M9IiI+SGkgYWxsLDxkaXYgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Rm9sbG93aW5nIG9uIGZyb20gdGhlIGRpc2N1c3Np
b24gb2YgaW1wbGVtZW50YXRpb24gZmVlZGJhY2sgd2l0aCBDaHJpc3RvcGgsIEkgcHJvcG9zZSB0
aGUgZm9sbG93aW5nIGVkaXRzIHRvIFJGQzY4MjRiaXMgLSB3aGljaCBpcyBjdXJyZW50bHkgaW4g
QVVUSDQ4IC0gYXMgY2xhcmlmaWNhdGlvbnMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5BRHMsIHBsZWFzZSBjYW4geW91IGNvbmZpcm0geW91IGNv
bnNpZGVyIHRoZXNlIGVkaXRzIHN1ZmZpY2llbnRseSBlZGl0b3JpYWwgdG8gZml0IGludG8gQVVU
SDQ4LjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+
V0cgcGFydGljaXBhbnRzLCBwbGVhc2Ugc3BlYWsgdXAgaWYgeW91IGhhdmUgYW55IGNvbmNlcm5z
LjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+RWRpdCAxLCBjbGFyaWZ5
aW5nIHJlbGlhYmlsaXR5IG9mIE1QX0NBUEFCTEU8L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hhbmdlIHRoZSBz
ZW50ZW5jZSByZWFkaW5nOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO1RoZSBTWU4gd2l0aCBNUF9DQVBBQkxFIG9jY3VwaWVz
IHRoZSBmaXJzdCBvY3RldCBvZiBkYXRhIHNlcXVlbmNlIHNwYWNlLCBhbHRob3VnaCB0aGlzIGRv
ZXMgbm90IG5lZWQgdG8gYmUgYWNrbm93bGVkZ2VkIGF0IHRoZSBjb25uZWN0aW9uIGxldmVsIHVu
dGlsIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgKHNlZSBTZWN0aW9uIDMuMykuPC9kaXY+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ubzo8L2Rpdj48ZGl2IGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtUaGUg
U1lOIHdpdGggTVBfQ0FQQUJMRSBvY2N1cGllcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgZGF0YSBzZXF1
ZW5jZSBzcGFjZSwgYW5kIHRoaXMgTVVTVCBiZSBhY2tub3dsZWRnZWQgYXQgdGhlIGNvbm5lY3Rp
b24gbGV2ZWwgYXQgb3IgYmVmb3JlIHRoZSB0aW1lIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgb3Ig
cmVjZWl2ZWQgKHNlZSBTZWN0aW9uIDMuMykuPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V2hhdCBpbXBsZW1lbnRh
dGlvbnMgc2hvdWxkIGRvIHdoZW4gdGhleSByZWNlaXZlIHRoZSBmaXJzdCBkYXRhIGJlZm9yZSBN
UF9DQVBBQkxFIGlzIGFja2VkPzwvZGl2PjxkaXYgY2xhc3M9IiI+VGhleSBzaG91bGQgdGVybWlu
YXRlIHRoZSBjb25uZWN0aW9uIG9yIGRpc2NhcmQgdGhlIGRhdGE/PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2
PkJ5IGFza2luZyB0aGlzIHF1ZXN0aW9uIHlvdSBoYXZlIG1hZGUgbWUgcmVhbGlzZSB0aGF0IHRo
aXMgdGV4dCBpcyBpbiBmYWN0IGluY29tcGF0aWJsZSB3aXRoIHRoZSBjYXNlIHdoZW4gQSAodGhl
IGluaXRpYXRvcikgaXMgYWxzbyB0aGUgZmlyc3Qgc2VuZGVyIG9mIGRhdGEuPC9kaXY+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5HaXZlbiB0aGUgcHJvYmxl
bSBpcyBvbmx5IHdpdGggQiBzZW5kaW5nIGRhdGEgZmlyc3QsIGxldCB1cyBmb3JnZXQgdGhpcyBj
aGFuZ2UsIGFuZCByZXZlcnQgdG8gQ2hyaXN0b3Bo4oCZcyBvcmlnaW5hbCBwcm9ibGVtIHRleHQs
IGFuZCB1c2Ugb25seSB0aGUgYmVsb3cgY2hhbmdlOjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPjxkaXYgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIiBjbGFzcz0iIj48
ZGl2IGNsYXNzPSIiPkNoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8L2Rpdj48ZGl2IGNsYXNz
PSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtJZiBCIGhh
cyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIHRoZSBB
Q0sgKyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRh
dGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNpZ25hbCAoRFNTKSBvcHRpb24gKFNlY3Rp
b24gMy4zKS4mbmJzcDs8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2
IGNsYXNzPSIiPlRvOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYg
Y2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0
aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyArIE1QX0NBUEFCTEUgaXMgZW5zdXJlZCBi
eSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNp
Z25hbCAoRFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKSBjb250YWluaW5nIGEgREFUQV9BQ0sgZm9y
IHRoZSBNUF9DQVBBQkxFJm5ic3A7KHdoaWNoIGlzIHRoZSBmaXJzdCBvY3RldCBvZiB0aGUgZGF0
YSBzZXF1ZW5jZSBzcGFjZSkuPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj5U
aGlzIHdpbGwgcmVzb2x2ZSB0aGUgYW1iaWd1aXR5IGluIHRoZSBjYXNlIG9mIEIgc2VuZGluZyBm
aXJzdC48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBj
bGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPjxkaXYgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIiBjbGFzcz0iIj48ZGl2IGNs
YXNzPSIiPkluIG15IHBlcnNvbmFsIG9waW5pb24gZWl0aGVyIG9uZSBvZiB0aGVzZSBlZGl0cyB3
b3VsZCBiZSBzdWZmaWNpZW50IGZvciBtYWtpbmcgdGhlIHBvaW50LCBob3dldmVyIGNsZWFybHkg
dGhpcyBoYXMgY2F1c2VkIHNvbWUgY29uZnVzaW9uIGFtb25nc3QgdGhlIGltcGxlbWVudG9yIGNv
bW11bml0eSBzbyBtYWtpbmcgYm90aCB0aGVzZSBjaGFuZ2VzIHNob3VsZCBtYWtlIGl0IGFic29s
dXRlbHkgY2xlYXIgYXMgdG8gdGhlIGV4cGVjdGVkIGJlaGF2aW91ciBoZXJlLjwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+RWRpdCAyLCBtYXBwaW5nIGNvbnN0cmFpbnQ8
L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9iPjwvZGl2
PjxkaXYgY2xhc3M9IiI+Q2hhbmdlIHRoZSBzZW50ZW5jZSByZWFkaW5nOjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0EgRGF0
YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkg
TVBUQ1AmbmJzcDtwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2Ug
aW4gdGhhdCBwYWNrZXQgaXMmbmJzcDtjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUg
cmVjZWl2ZXIuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFz
cz0iIj5Ubzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPiZuYnNwOyAmbmJzcDtBIERhdGEgU2VxdWVuY2UgTWFwcGluZyBNVVNUIGFwcGVhciBvbiBh
IFRDUCBzZWdtZW50IHdoaWNoIGlzIGNvdmVyZWQgYnkgdGhlIG1hcHBpbmcuIEl0IGRvZXMgbm90
IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkgTVBUQ1AmbmJzcDtwYWNrZXQsIGFzIGxvbmcg
YXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgaW4gdGhhdCBwYWNrZXQgaXMmbmJzcDtjb3Zl
cmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuPC9kaXY+PGRpdiBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V2hhdCBpbXBsZW1lbnRhdGlvbnMgc2hvdWxk
IGRvIHdoZW4gYSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgZG9lc24ndCBjb3ZlciB0aGUgVENQIHNl
Z21lbnQgdGhhdCBjYXJyaWVzIHRoaXMgb3B0aW9uPzwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNs
YXNzPSIiPlRoZXJlIGFyZSBhIG51bWJlciBvZiBjYXNlcyB3aGVyZSB0aGUgTVVTVCBkb2VzIG5v
dCBoYXZlIGEgY29uc2VxdWVuY2U7IGl0IHNob3VsZCBiZSBvYnZpb3VzIGZyb20gdGhlIHRleHQg
Zm9yIHNpbWlsYXIgZmFpbHVyZXMgdGhhdCBpdCBjYW4gY2xvc2UgaXQgd2l0aCBhIFJTVC48L2Rp
dj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBjbGFzcz0iIj5CVFcsIFRoaXMgaXMgbm90IGEgc3Ry
b25nIG9waW5pb24sIGJ1dCBJIG1heSBwcmVmZXIgYSB0ZXh0IGxpa2U6ICJBIERhdGEgU2VxdWVu
Y2UgTWFwcGluZyBNVVNUIHByb3ZpZGUgdGhlIG1hcHBpbmcgZm9yIHRoZSBzZWdtZW50IHRoYXQg
Y2FycmllcyB0aGlzIG9wdGlvbi7igJ0mbmJzcDs8YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPk9LIGhvdyBhYm91dDogIkEgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgcHJvdmlkZSB0
aGUgbWFwcGluZyB3aGljaCBpbmNsdWRlcyB0aGUgc2VnbWVudCB0aGF0IGNhcnJpZXMgdGhpcyBv
cHRpb24u4oCdJm5ic3A7PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRp
diBjbGFzcz0iIj5SZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+QWxhbjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48L2Jsb2Nr
cXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjwvYm9keT48L2h0bWw+
--===============7179685359738241216==--
