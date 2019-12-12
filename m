Content-Type: multipart/mixed; boundary="===============8347342221284409511=="
MIME-Version: 1.0
From: Alan Ford <alan.ford at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Thu, 12 Dec 2019 21:19:21 +0000
Message-ID: <34FA5631-3ED2-4C12-A928-5BA8728CAC7E@gmail.com>
In-Reply-To: 2689B456-2B1C-4D84-B36E-74FA0FFD2E3B@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2893

--===============8347342221284409511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph (and Matthieu & Pablo),

WRT checksums, we do say:

   For example,
   if the initiator sets A=3D0 in the SYN but the responder sets A=3D1 in
   the SYN/ACK, checksums MUST be used in both directions, and the
   initiator will set A=3D1 in the ACK.  =


   If A=3D1 is received by a host that does not
   want to use checksums, it MUST fall back to regular TCP by ignoring
   the MP_CAPABLE option as if it was invalid.

Which would seem to cover all these eventualities. The =E2=80=9CC=E2=80=9D =
bit is purely an indicator, and the crypto negotiation is clearly specified=
 too.

Best regards,
Alan

> On 11 Dec 2019, at 19:28, Christoph Paasch <cpaasch(a)apple.com> wrote:
> =

> Hello Alan,
> =

> there is one more thing that came up from the implementation experience (=
thanks to Matthieu & Paolo in CC).
> =

> It is unclear in the draft (or at least, I didn't find the text ;-) ), wh=
at to do when the flags & version in the third ACK + MP_CAPABLE are inconsi=
stent with what was negotiated in the SYN-SYN/ACK exchange.
> =

> It would be good to spell this out and say that if there are any inconsis=
tencies, a host should simply fallback to regular TCP.
> =

> =

> Christoph
> =

>> On Dec 10, 2019, at 8:09 AM, Alan Ford <alan.ford(a)gmail.com <mailto:al=
an.ford(a)gmail.com>> wrote:
>> =

>> Hi Yoshifumi,
>> =

>>> On 10 Dec 2019, at 05:30, Yoshifumi Nishida <nsd.ietf(a)gmail.com <mail=
to:nsd.ietf(a)gmail.com>> wrote:
>>> =

>>> Hi Alan,
>>> =

>>> The texts look fine to me, but I have a few questions on them.
>>> =

>>> On Fri, Dec 6, 2019 at 7:58 AM Alan Ford <alan.ford(a)gmail.com <mailto=
:alan.ford(a)gmail.com>> wrote:
>>> Hi all,
>>> =

>>> Following on from the discussion of implementation feedback with Christ=
oph, I propose the following edits to RFC6824bis - which is currently in AU=
TH48 - as clarifications.
>>> =

>>> ADs, please can you confirm you consider these edits sufficiently edito=
rial to fit into AUTH48.
>>> =

>>> WG participants, please speak up if you have any concerns.
>>> =

>>> =

>>> Edit 1, clarifying reliability of MP_CAPABLE
>>> =

>>> Change the sentence reading:
>>> =

>>>    The SYN with MP_CAPABLE occupies the first octet of data sequence sp=
ace, although this does not need to be acknowledged at the connection level=
 until the first data is sent (see Section 3.3).
>>> =

>>> To:
>>> =

>>>    The SYN with MP_CAPABLE occupies the first octet of data sequence sp=
ace, and this MUST be acknowledged at the connection level at or before the=
 time the first data is sent or received (see Section 3.3).
>>> =

>>> What implementations should do when they receive the first data before =
MP_CAPABLE is acked?
>>> They should terminate the connection or discard the data?
>> =

>> By asking this question you have made me realise that this text is in fa=
ct incompatible with the case when A (the initiator) is also the first send=
er of data.
>> =

>> Given the problem is only with B sending data first, let us forget this =
change, and revert to Christoph=E2=80=99s original problem text, and use on=
ly the below change:
>> =

>>> Change the sentence reading:
>>> =

>>>    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data =
Sequence Signal (DSS) option (Section 3.3). =

>>> =

>>> To:
>>> =

>>>    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data Seque=
nce Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPA=
BLE (which is the first octet of the data sequence space).
>> =

>> This will resolve the ambiguity in the case of B sending first.
>> =

>>> In my personal opinion either one of these edits would be sufficient fo=
r making the point, however clearly this has caused some confusion amongst =
the implementor community so making both these changes should make it absol=
utely clear as to the expected behaviour here.
>>> =

>>> =

>>> Edit 2, mapping constraint
>>> =

>>> Change the sentence reading:
>>> =

>>>    A Data Sequence Mapping does not need to be included in every MPTCP =
packet, as long as the subflow sequence space in that packet is covered by =
a mapping known at the receiver.
>>> =

>>> To:
>>> =

>>>    A Data Sequence Mapping MUST appear on a TCP segment which is covere=
d by the mapping. It does not need to be included in every MPTCP packet, as=
 long as the subflow sequence space in that packet is covered by a mapping =
known at the receiver.
>>> =

>>> =

>>> What implementations should do when a Data Sequence Mapping doesn't cov=
er the TCP segment that carries this option?
>> =

>> There are a number of cases where the MUST does not have a consequence; =
it should be obvious from the text for similar failures that it can close i=
t with a RST.
>> =

>>> BTW, This is not a strong opinion, but I may prefer a text like: "A Dat=
a Sequence Mapping MUST provide the mapping for the segment that carries th=
is option.=E2=80=9D =

>> =

>> OK how about: "A Data Sequence Mapping MUST provide the mapping which in=
cludes the segment that carries this option.=E2=80=9D =

>> =

>> Regards,
>> Alan
>> =

>> =

> =



--===============8347342221284409511==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+SGkgQ2hyaXN0b3BoIChhbmQgTWF0dGhpZXUgJmFtcDsgUGFibG8p
LDxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V1JUIGNoZWNr
c3Vtcywgd2UgZG8gc2F5OjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7Rm9yIGV4YW1wbGUsPC9kaXY+
PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7aWYgdGhlIGluaXRpYXRvciBzZXRzIEE9MCBpbiB0
aGUgU1lOIGJ1dCB0aGUgcmVzcG9uZGVyIHNldHMgQT0xIGluPC9kaXY+PGRpdiBjbGFzcz0iIj4m
bmJzcDsgJm5ic3A7dGhlIFNZTi9BQ0ssIGNoZWNrc3VtcyBNVVNUIGJlIHVzZWQgaW4gYm90aCBk
aXJlY3Rpb25zLCBhbmQgdGhlPC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7aW5pdGlh
dG9yIHdpbGwgc2V0IEE9MSBpbiB0aGUgQUNLLiAmbmJzcDs8L2Rpdj48ZGl2IGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtJZiBBPTEgaXMgcmVj
ZWl2ZWQgYnkgYSBob3N0IHRoYXQgZG9lcyBub3Q8L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAm
bmJzcDt3YW50IHRvIHVzZSBjaGVja3N1bXMsIGl0IE1VU1QgZmFsbCBiYWNrIHRvIHJlZ3VsYXIg
VENQIGJ5IGlnbm9yaW5nPC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7dGhlIE1QX0NB
UEFCTEUgb3B0aW9uIGFzIGlmIGl0IHdhcyBpbnZhbGlkLjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V2hpY2ggd291bGQgc2VlbSB0byBj
b3ZlciBhbGwgdGhlc2UgZXZlbnR1YWxpdGllcy4gVGhlIOKAnEPigJ0gYml0IGlzIHB1cmVseSBh
biBpbmRpY2F0b3IsIGFuZCB0aGUgY3J5cHRvIG5lZ290aWF0aW9uIGlzIGNsZWFybHkgc3BlY2lm
aWVkIHRvby48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSIiPkFsYW48YnIgY2xhc3M9IiI+PGRp
dj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj5PbiAxMSBEZWMgMjAxOSwgYXQgMTk6MjgsIENocmlzdG9waCBQYWFzY2ggJmx0OzxhIGhy
ZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgY2xhc3M9IiI+Y3BhYXNjaEBhcHBsZS5jb208
L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9IkFwcGxlLWludGVyY2hhbmdlLW5ld2xpbmUi
PjxkaXYgY2xhc3M9IiI+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0
ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiIGNsYXNzPSIiPjxkaXYgc3R5bGU9IndvcmQtd3JhcDog
YnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBhZnRlci13
aGl0ZS1zcGFjZTsiIGNsYXNzPSIiPkhlbGxvIEFsYW4sPGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj50aGVyZSBpcyBvbmUgbW9yZSB0aGluZyB0aGF0IGNhbWUg
dXAgZnJvbSB0aGUgaW1wbGVtZW50YXRpb24gZXhwZXJpZW5jZSAodGhhbmtzIHRvIE1hdHRoaWV1
ICZhbXA7IFBhb2xvIGluIENDKS48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSIiPkl0IGlzIHVuY2xlYXIgaW4gdGhlIGRyYWZ0IChvciBhdCBsZWFzdCwg
SSBkaWRuJ3QgZmluZCB0aGUgdGV4dCA7LSkgKSwgd2hhdCB0byBkbyB3aGVuIHRoZSBmbGFncyAm
YW1wOyB2ZXJzaW9uIGluIHRoZSB0aGlyZCBBQ0sgKyBNUF9DQVBBQkxFIGFyZSBpbmNvbnNpc3Rl
bnQgd2l0aCB3aGF0IHdhcyBuZWdvdGlhdGVkIGluIHRoZSBTWU4tU1lOL0FDSyBleGNoYW5nZS48
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkl0IHdv
dWxkIGJlIGdvb2QgdG8gc3BlbGwgdGhpcyBvdXQgYW5kIHNheSB0aGF0IGlmIHRoZXJlIGFyZSBh
bnkgaW5jb25zaXN0ZW5jaWVzLCBhIGhvc3Qgc2hvdWxkIHNpbXBseSBmYWxsYmFjayB0byByZWd1
bGFyIFRDUC48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkNocmlzdG9waDwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5PbiBEZWMgMTAsIDIwMTksIGF0IDg6MDkgQU0sIEFs
YW4gRm9yZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20iIGNsYXNzPSIi
PmFsYW4uZm9yZEBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9IkFwcGxl
LWludGVyY2hhbmdlLW5ld2xpbmUiPjxkaXYgY2xhc3M9IiI+PG1ldGEgaHR0cC1lcXVpdj0iQ29u
dGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiIGNsYXNzPSIiPjxk
aXYgc3R5bGU9IndvcmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNl
OyBsaW5lLWJyZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiIGNsYXNzPSIiPkhpIFlvc2hpZnVtaSw8
YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5PbiAxMCBEZWMgMjAxOSwgYXQgMDU6MzAsIFlv
c2hpZnVtaSBOaXNoaWRhICZsdDs8YSBocmVmPSJtYWlsdG86bnNkLmlldGZAZ21haWwuY29tIiBj
bGFzcz0iIj5uc2QuaWV0ZkBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9
IkFwcGxlLWludGVyY2hhbmdlLW5ld2xpbmUiPjxkaXYgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IaSBBbGFuLDwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VGhlIHRl
eHRzIGxvb2sgZmluZSB0byBtZSwgYnV0IEkgaGF2ZSBhIGZldyBxdWVzdGlvbnMgb24gdGhlbS48
L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIi
IGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBGcmksIERlYyA2LCAyMDE5IGF0IDc6NTggQU0gQWxhbiBG
b3JkICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+YWxh
bi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIj48L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
PGRpdiBzdHlsZT0id29yZC13cmFwOmJyZWFrLXdvcmQiIGNsYXNzPSIiPkhpIGFsbCw8ZGl2IGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkZvbGxvd2luZyBvbiBmcm9t
IHRoZSBkaXNjdXNzaW9uIG9mIGltcGxlbWVudGF0aW9uIGZlZWRiYWNrIHdpdGggQ2hyaXN0b3Bo
LCBJIHByb3Bvc2UgdGhlIGZvbGxvd2luZyBlZGl0cyB0byBSRkM2ODI0YmlzIC0gd2hpY2ggaXMg
Y3VycmVudGx5IGluIEFVVEg0OCAtIGFzIGNsYXJpZmljYXRpb25zLjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QURzLCBwbGVhc2UgY2FuIHlvdSBj
b25maXJtIHlvdSBjb25zaWRlciB0aGVzZSBlZGl0cyBzdWZmaWNpZW50bHkgZWRpdG9yaWFsIHRv
IGZpdCBpbnRvIEFVVEg0OC48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48
ZGl2IGNsYXNzPSIiPldHIHBhcnRpY2lwYW50cywgcGxlYXNlIHNwZWFrIHVwIGlmIHlvdSBoYXZl
IGFueSBjb25jZXJucy48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiIGNsYXNzPSIiPkVk
aXQgMSwgY2xhcmlmeWluZyByZWxpYWJpbGl0eSBvZiBNUF9DQVBBQkxFPC9iPjwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvYj48L2Rpdj48ZGl2IGNsYXNzPSIi
PkNoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtUaGUgU1lOIHdpdGggTVBfQ0FQ
QUJMRSBvY2N1cGllcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgZGF0YSBzZXF1ZW5jZSBzcGFjZSwgYWx0
aG91Z2ggdGhpcyBkb2VzIG5vdCBuZWVkIHRvIGJlIGFja25vd2xlZGdlZCBhdCB0aGUgY29ubmVj
dGlvbiBsZXZlbCB1bnRpbCB0aGUgZmlyc3QgZGF0YSBpcyBzZW50IChzZWUgU2VjdGlvbiAzLjMp
LjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VG86
PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJz
cDsgJm5ic3A7VGhlIFNZTiB3aXRoIE1QX0NBUEFCTEUgb2NjdXBpZXMgdGhlIGZpcnN0IG9jdGV0
IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UsIGFuZCB0aGlzIE1VU1QgYmUgYWNrbm93bGVkZ2VkIGF0
IHRoZSBjb25uZWN0aW9uIGxldmVsIGF0IG9yIGJlZm9yZSB0aGUgdGltZSB0aGUgZmlyc3QgZGF0
YSBpcyBzZW50IG9yIHJlY2VpdmVkIChzZWUgU2VjdGlvbiAzLjMpLjwvZGl2PjwvZGl2PjwvYmxv
Y2txdW90ZT48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPldo
YXQgaW1wbGVtZW50YXRpb25zIHNob3VsZCBkbyB3aGVuIHRoZXkgcmVjZWl2ZSB0aGUgZmlyc3Qg
ZGF0YSBiZWZvcmUgTVBfQ0FQQUJMRSBpcyBhY2tlZD88L2Rpdj48ZGl2IGNsYXNzPSIiPlRoZXkg
c2hvdWxkIHRlcm1pbmF0ZSB0aGUgY29ubmVjdGlvbiBvciBkaXNjYXJkIHRoZSBkYXRhPzwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIiPjxiciBj
bGFzcz0iIj48L2Rpdj5CeSBhc2tpbmcgdGhpcyBxdWVzdGlvbiB5b3UgaGF2ZSBtYWRlIG1lIHJl
YWxpc2UgdGhhdCB0aGlzIHRleHQgaXMgaW4gZmFjdCBpbmNvbXBhdGlibGUgd2l0aCB0aGUgY2Fz
ZSB3aGVuIEEgKHRoZSBpbml0aWF0b3IpIGlzIGFsc28gdGhlIGZpcnN0IHNlbmRlciBvZiBkYXRh
LjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+R2l2
ZW4gdGhlIHByb2JsZW0gaXMgb25seSB3aXRoIEIgc2VuZGluZyBkYXRhIGZpcnN0LCBsZXQgdXMg
Zm9yZ2V0IHRoaXMgY2hhbmdlLCBhbmQgcmV2ZXJ0IHRvIENocmlzdG9waOKAmXMgb3JpZ2luYWwg
cHJvYmxlbSB0ZXh0LCBhbmQgdXNlIG9ubHkgdGhlIGJlbG93IGNoYW5nZTo8YnIgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29y
ZCIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJlYWRpbmc6PC9k
aXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJzcDsg
Jm5ic3A7SWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBkZWxp
dmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBjYW4gYmUgaW5mZXJyZWQgYnkgdGhlIHJlY2Vp
cHQgb2YgdGhpcyBkYXRhIHdpdGggYW4gTVBUQ1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERTUykg
b3B0aW9uIChTZWN0aW9uIDMuMykuJm5ic3A7PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ubzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtJZiBCIGhhcyBkYXRhIHRvIHNlbmQg
Zmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIHRoZSBBQ0sgKyBNUF9DQVBBQkxF
IGlzIGVuc3VyZWQgYnkgdGhlIHJlY2VpcHQgb2YgdGhpcyBkYXRhIHdpdGggYW4gTVBUQ1AgRGF0
YSBTZXF1ZW5jZSBTaWduYWwgKERTUykgb3B0aW9uIChTZWN0aW9uIDMuMykgY29udGFpbmluZyBh
IERBVEFfQUNLIGZvciB0aGUgTVBfQ0FQQUJMRSZuYnNwOyh3aGljaCBpcyB0aGUgZmlyc3Qgb2N0
ZXQgb2YgdGhlIGRhdGEgc2VxdWVuY2Ugc3BhY2UpLjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PC9kaXY+VGhpcyB3aWxsIHJlc29sdmUgdGhlIGFtYmlndWl0eSBpbiB0aGUgY2FzZSBv
ZiBCIHNlbmRpbmcgZmlyc3QuPGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29yZCIgY2xh
c3M9IiI+PGRpdiBjbGFzcz0iIj5JbiBteSBwZXJzb25hbCBvcGluaW9uIGVpdGhlciBvbmUgb2Yg
dGhlc2UgZWRpdHMgd291bGQgYmUgc3VmZmljaWVudCBmb3IgbWFraW5nIHRoZSBwb2ludCwgaG93
ZXZlciBjbGVhcmx5IHRoaXMgaGFzIGNhdXNlZCBzb21lIGNvbmZ1c2lvbiBhbW9uZ3N0IHRoZSBp
bXBsZW1lbnRvciBjb21tdW5pdHkgc28gbWFraW5nIGJvdGggdGhlc2UgY2hhbmdlcyBzaG91bGQg
bWFrZSBpdCBhYnNvbHV0ZWx5IGNsZWFyIGFzIHRvIHRoZSBleHBlY3RlZCBiZWhhdmlvdXIgaGVy
ZS48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiIGNsYXNzPSIiPkVkaXQgMiwgbWFwcGlu
ZyBjb25zdHJhaW50PC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPjwvYj48L2Rpdj48ZGl2IGNsYXNzPSIiPkNoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNw
OyAmbmJzcDtBIERhdGEgU2VxdWVuY2UgTWFwcGluZyBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1
ZGVkIGluIGV2ZXJ5IE1QVENQJm5ic3A7cGFja2V0LCBhcyBsb25nIGFzIHRoZSBzdWJmbG93IHNl
cXVlbmNlIHNwYWNlIGluIHRoYXQgcGFja2V0IGlzJm5ic3A7Y292ZXJlZCBieSBhIG1hcHBpbmcg
a25vd24gYXQgdGhlIHJlY2VpdmVyLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxkaXYgY2xhc3M9IiI+VG86PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7QSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgTVVT
VCBhcHBlYXIgb24gYSBUQ1Agc2VnbWVudCB3aGljaCBpcyBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5n
LiBJdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1ZGVkIGluIGV2ZXJ5IE1QVENQJm5ic3A7cGFj
a2V0LCBhcyBsb25nIGFzIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoYXQgcGFja2V0
IGlzJm5ic3A7Y292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLjwvZGl2
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPldoYXQgaW1wbGVtZW50
YXRpb25zIHNob3VsZCBkbyB3aGVuIGEgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXNuJ3QgY292
ZXIgdGhlIFRDUCBzZWdtZW50IHRoYXQgY2FycmllcyB0aGlzIG9wdGlvbj88L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
PC9kaXY+PGRpdiBjbGFzcz0iIj5UaGVyZSBhcmUgYSBudW1iZXIgb2YgY2FzZXMgd2hlcmUgdGhl
IE1VU1QgZG9lcyBub3QgaGF2ZSBhIGNvbnNlcXVlbmNlOyBpdCBzaG91bGQgYmUgb2J2aW91cyBm
cm9tIHRoZSB0ZXh0IGZvciBzaW1pbGFyIGZhaWx1cmVzIHRoYXQgaXQgY2FuIGNsb3NlIGl0IHdp
dGggYSBSU1QuPC9kaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNz
PSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9IiI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgY2xhc3M9IiI+QlRXLCBUaGlz
IGlzIG5vdCBhIHN0cm9uZyBvcGluaW9uLCBidXQgSSBtYXkgcHJlZmVyIGEgdGV4dCBsaWtlOiAi
QSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgTVVTVCBwcm92aWRlIHRoZSBtYXBwaW5nIGZvciB0aGUg
c2VnbWVudCB0aGF0IGNhcnJpZXMgdGhpcyBvcHRpb24u4oCdJm5ic3A7PGJyIGNsYXNzPSIiPjwv
ZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdiBjbGFzcz0iIj5PSyBob3cgYWJvdXQ6ICJBIERhdGEgU2VxdWVuY2UgTWFwcGluZyBN
VVNUIHByb3ZpZGUgdGhlIG1hcHBpbmcgd2hpY2ggaW5jbHVkZXMgdGhlIHNlZ21lbnQgdGhhdCBj
YXJyaWVzIHRoaXMgb3B0aW9uLuKAnSZuYnNwOzwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+UmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSIiPkFsYW48
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48YnIgY2xhc3M9IiI+PC9kaXY+
PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjwvYm9keT48L2h0bWw+
--===============8347342221284409511==--
