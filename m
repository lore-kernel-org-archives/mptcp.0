Content-Type: multipart/mixed; boundary="===============9000182523081138707=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: MPTCP implementation feedback for RFC6824bis
Date: Fri, 06 Dec 2019 08:38:30 -0800
Message-ID: <57D92694-5886-4672-B80D-D562DE9811D4@apple.com>
In-Reply-To: 6978C97F-24D5-4CF0-8CEB-2F58BE26D174@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2827

--===============9000182523081138707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FYI, in case emails aren=E2=80=99t going through yet


Begin forwarded message:

> From: Alan Ford <alan.ford(a)gmail.com>
> Date: December 6, 2019 at 7:58:31 AM PST
> To: Christoph Paasch <cpaasch(a)apple.com>
> Cc: MultiPath TCP - IETF WG <multipathtcp(a)ietf.org>, Yoshifumi Nishida =
<nsd.ietf(a)gmail.com>, Philip Eardley <philip.eardley(a)bt.com>, Mirja Kue=
hlewind <ietf(a)kuehlewind.net>, mptcp Upstreaming <mptcp(a)lists.01.org>
> Subject: Re:  MPTCP implementation feedback for RFC6824bis
> =

> =EF=BB=BFHi all,
> =

> Following on from the discussion of implementation feedback with Christop=
h, I propose the following edits to RFC6824bis - which is currently in AUTH=
48 - as clarifications.
> =

> ADs, please can you confirm you consider these edits sufficiently editori=
al to fit into AUTH48.
> =

> WG participants, please speak up if you have any concerns.
> =

> =

> Edit 1, clarifying reliability of MP_CAPABLE
> =

> Change the sentence reading:
> =

>    The SYN with MP_CAPABLE occupies the first octet of data sequence spac=
e, although this does not need to be acknowledged at the connection level u=
ntil the first data is sent (see Section 3.3).
> =

> To:
> =

>    The SYN with MP_CAPABLE occupies the first octet of data sequence spac=
e, and this MUST be acknowledged at the connection level at or before the t=
ime the first data is sent or received (see Section 3.3).
> =

> =

> Change the sentence reading:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE can be inferred by the receipt of this data with an MPTCP Data Se=
quence Signal (DSS) option (Section 3.3). =

> =

> To:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE is ensured by the receipt of this data with an MPTCP Data Sequenc=
e Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPABL=
E (which is the first octet of the data sequence space).
> =

> =

> In my personal opinion either one of these edits would be sufficient for =
making the point, however clearly this has caused some confusion amongst th=
e implementor community so making both these changes should make it absolut=
ely clear as to the expected behaviour here.
> =

> =

> Edit 2, mapping constraint
> =

> Change the sentence reading:
> =

>    A Data Sequence Mapping does not need to be included in every MPTCP pa=
cket, as long as the subflow sequence space in that packet is covered by a =
mapping known at the receiver.
> =

> To:
> =

>    A Data Sequence Mapping MUST appear on a TCP segment which is covered =
by the mapping. It does not need to be included in every MPTCP packet, as l=
ong as the subflow sequence space in that packet is covered by a mapping kn=
own at the receiver.
> =

> =

> Best regards,
> Alan
> =

>=20

--===============9000182523081138707==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPjxkaXYgZGlyPSJs
dHIiPkZZSSwgaW4gY2FzZSBlbWFpbHMgYXJlbuKAmXQgZ29pbmcgdGhyb3VnaCB5ZXQ8YnI+PGJy
Pjxicj5CZWdpbiBmb3J3YXJkZWQgbWVzc2FnZTo8YnI+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiPjxkaXYgZGlyPSJsdHIiPjxiPkZyb206PC9iPiBBbGFuIEZvcmQgJmx0O2FsYW4u
Zm9yZEBnbWFpbC5jb20mZ3Q7PGJyPjxiPkRhdGU6PC9iPiBEZWNlbWJlciA2LCAyMDE5IGF0IDc6
NTg6MzEgQU0gUFNUPGJyPjxiPlRvOjwvYj4gQ2hyaXN0b3BoIFBhYXNjaCAmbHQ7Y3BhYXNjaEBh
cHBsZS5jb20mZ3Q7PGJyPjxiPkNjOjwvYj4gTXVsdGlQYXRoIFRDUCAtIElFVEYgV0cgJmx0O211
bHRpcGF0aHRjcEBpZXRmLm9yZyZndDssIFlvc2hpZnVtaSBOaXNoaWRhICZsdDtuc2QuaWV0ZkBn
bWFpbC5jb20mZ3Q7LCBQaGlsaXAgRWFyZGxleSAmbHQ7cGhpbGlwLmVhcmRsZXlAYnQuY29tJmd0
OywgTWlyamEgS3VlaGxld2luZCAmbHQ7aWV0ZkBrdWVobGV3aW5kLm5ldCZndDssIG1wdGNwIFVw
c3RyZWFtaW5nICZsdDttcHRjcEBsaXN0cy4wMS5vcmcmZ3Q7PGJyPjxiPlN1YmplY3Q6PC9iPiA8
Yj5SZTombmJzcDsgTVBUQ1AgaW1wbGVtZW50YXRpb24gZmVlZGJhY2sgZm9yIFJGQzY4MjRiaXM8
L2I+PGJyPjxicj48L2Rpdj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PGRp
diBkaXI9Imx0ciI+77u/SGkgYWxsLDxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+Rm9sbG93aW5nIG9uIGZyb20gdGhlIGRpc2N1c3Npb24gb2YgaW1wbGVtZW50
YXRpb24gZmVlZGJhY2sgd2l0aCBDaHJpc3RvcGgsIEkgcHJvcG9zZSB0aGUgZm9sbG93aW5nIGVk
aXRzIHRvIFJGQzY4MjRiaXMgLSB3aGljaCBpcyBjdXJyZW50bHkgaW4gQVVUSDQ4IC0gYXMgY2xh
cmlmaWNhdGlvbnMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBj
bGFzcz0iIj5BRHMsIHBsZWFzZSBjYW4geW91IGNvbmZpcm0geW91IGNvbnNpZGVyIHRoZXNlIGVk
aXRzIHN1ZmZpY2llbnRseSBlZGl0b3JpYWwgdG8gZml0IGludG8gQVVUSDQ4LjwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V0cgcGFydGljaXBhbnRz
LCBwbGVhc2Ugc3BlYWsgdXAgaWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2
PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+RWRpdCAxLCBjbGFyaWZ5aW5nIHJlbGlhYmlsaXR5
IG9mIE1QX0NBUEFCTEU8L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hhbmdlIHRoZSBzZW50ZW5jZSByZWFkaW5n
OjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5i
c3A7ICZuYnNwO1RoZSBTWU4gd2l0aCBNUF9DQVBBQkxFIG9jY3VwaWVzIHRoZSBmaXJzdCBvY3Rl
dCBvZiBkYXRhIHNlcXVlbmNlIHNwYWNlLCBhbHRob3VnaCB0aGlzIGRvZXMgbm90IG5lZWQgdG8g
YmUgYWNrbm93bGVkZ2VkIGF0IHRoZSBjb25uZWN0aW9uIGxldmVsIHVudGlsIHRoZSBmaXJzdCBk
YXRhIGlzIHNlbnQgKHNlZSBTZWN0aW9uIDMuMykuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ubzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtUaGUgU1lOIHdpdGggTVBfQ0FQ
QUJMRSBvY2N1cGllcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgZGF0YSBzZXF1ZW5jZSBzcGFjZSwgYW5k
IHRoaXMgTVVTVCBiZSBhY2tub3dsZWRnZWQgYXQgdGhlIGNvbm5lY3Rpb24gbGV2ZWwgYXQgb3Ig
YmVmb3JlIHRoZSB0aW1lIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgb3IgcmVjZWl2ZWQgKHNlZSBT
ZWN0aW9uIDMuMykuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBj
bGFzcz0iIj48YiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+
Q2hhbmdlIHRoZSBzZW50ZW5jZSByZWFkaW5nOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2Vu
ZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyArIE1QX0NBUEFC
TEUgY2FuIGJlIGluZmVycmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1Q
VENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAzLjMpLiZuYnNw
OzwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VG86
PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJz
cDsgJm5ic3A7SWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBk
ZWxpdmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBpcyBlbnN1cmVkIGJ5IHRoZSByZWNlaXB0
IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9w
dGlvbiAoU2VjdGlvbiAzLjMpIGNvbnRhaW5pbmcgYSBEQVRBX0FDSyBmb3IgdGhlIE1QX0NBUEFC
TEUmbmJzcDsod2hpY2ggaXMgdGhlIGZpcnN0IG9jdGV0IG9mIHRoZSBkYXRhIHNlcXVlbmNlIHNw
YWNlKS48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIi
PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkluIG15IHBlcnNvbmFsIG9waW5pb24g
ZWl0aGVyIG9uZSBvZiB0aGVzZSBlZGl0cyB3b3VsZCBiZSBzdWZmaWNpZW50IGZvciBtYWtpbmcg
dGhlIHBvaW50LCBob3dldmVyIGNsZWFybHkgdGhpcyBoYXMgY2F1c2VkIHNvbWUgY29uZnVzaW9u
IGFtb25nc3QgdGhlIGltcGxlbWVudG9yIGNvbW11bml0eSBzbyBtYWtpbmcgYm90aCB0aGVzZSBj
aGFuZ2VzIHNob3VsZCBtYWtlIGl0IGFic29sdXRlbHkgY2xlYXIgYXMgdG8gdGhlIGV4cGVjdGVk
IGJlaGF2aW91ciBoZXJlLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+
RWRpdCAyLCBtYXBwaW5nIGNvbnN0cmFpbnQ8L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+PC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hhbmdlIHRoZSBzZW50
ZW5jZSByZWFkaW5nOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYg
Y2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0EgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXMgbm90IG5l
ZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkgTVBUQ1AmbmJzcDtwYWNrZXQsIGFzIGxvbmcgYXMg
dGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgaW4gdGhhdCBwYWNrZXQgaXMmbmJzcDtjb3ZlcmVk
IGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuPC9kaXY+PGRpdiBjbGFzcz0iIj48
YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ubzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtBIERhdGEgU2VxdWVu
Y2UgTWFwcGluZyBNVVNUIGFwcGVhciBvbiBhIFRDUCBzZWdtZW50IHdoaWNoIGlzIGNvdmVyZWQg
YnkgdGhlIG1hcHBpbmcuIEl0IGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkg
TVBUQ1AmbmJzcDtwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2Ug
aW4gdGhhdCBwYWNrZXQgaXMmbmJzcDtjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUg
cmVjZWl2ZXIuPC9kaXY+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9i
PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QmVz
dCByZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+QWxhbjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwv
Yj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9ib2R5PjwvaHRtbD4=
--===============9000182523081138707==--
