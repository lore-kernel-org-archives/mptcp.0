Content-Type: multipart/mixed; boundary="===============4295990559163143664=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Fri, 13 Dec 2019 14:10:41 +0100
Message-ID: <CAKuKrBnaBKNPhJDnEYuiD=Cn=JsKx=6baTdNVN2o9gBXWSnQMA@mail.gmail.com>
In-Reply-To: 48314EB0-E515-40DC-B8D3-E7512DAA35BC@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2933

--===============4295990559163143664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Thank you for your reply.

On Fri, Dec 13, 2019 at 1:38 PM Alan Ford <alan.ford(a)gmail.com> wrote:

> Hi Matthieu,
>
> On 13 Dec 2019, at 00:10, Matthieu Baerts <matthieu.baerts(a)tessares.net>
> wrote:
>
> Hi Alan,
>
>
> On Thu, Dec 12, 2019 at 10:19 PM Alan Ford <alan.ford(a)gmail.com> wrote:
>
>> Hi Christoph (and Matthieu & Pablo),
>>
>> WRT checksums, we do say:
>>
>>    For example,
>>    if the initiator sets A=3D0 in the SYN but the responder sets A=3D1 in
>>    the SYN/ACK, checksums MUST be used in both directions, and the
>>    initiator will set A=3D1 in the ACK.
>>
>>    If A=3D1 is received by a host that does not
>>    want to use checksums, it MUST fall back to regular TCP by ignoring
>>    the MP_CAPABLE option as if it was invalid.
>>
>> Which would seem to cover all these eventualities. The =E2=80=9CC=E2=80=
=9D bit is purely
>> an indicator, and the crypto negotiation is clearly specified too.
>>
>
> Thank you for your answer, that's clearer for the A bit.
> Our concern was mainly about the version. How should we react if, as a
> server supporting only v1, we have this sequence:
>
> SYN (MP_CAPABLE: v2)  =E2=86=92
> =E2=86=90  SYN+ACK (MP_CAPABLE: v1)
> ACK (MP_CAPABLE v2) =E2=86=92
>
> In other words, the server told the client that the maximum version it
> supports is v1. But in the ACK+MP_CAPABLE, the client sends v2 again.
>
> According to the RFC, the negotiation is done in the SYN and SYN+ACK. How
> do we react if the following ACK is sending a version (e.g. v2) which is
> not the expected one (e.g. v1)?
>
> For the moment in our implementation, we fallback to regular TCP.
> It means that future versions of MPTCP have to set the proper version in
> the 3rd ACK -- the negotiated one -- and not a copy of what has been sent
> in the SYN.
>
> Should we add a clarification for that?
>
>
> I see your point but I don=E2=80=99t feel we need any clarification here.=
 The
> exchange as you rightly point out is done on the SYN/SYN+ACK. So when the
> server sends the SYN+ACK with v1, that is the decision that has been made.
> Sending an ACK with v2 is not a valid response. So if the server receives
> this, it treats it as any other invalid option and ignores it, so it trea=
ts
> it as if the ACK does not have an MP_CAPABLE, and thus it will fall back =
to
> regular TCP.
>

Even if at some point, we thought about not checking the version in the 3rd
ACK because it was a bit unclear for us, we now do fallback to regular TCP
if the version in the 3rd ACK is not the expected one.
So it seems that at the end, we correctly interpreted the RFC there. If you
feel that no clarification is needed for that, that's fine for us!

Best regards,
Matthieu
-- =

[image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============4295990559163143664==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgQWxhbiw8YnI+PGRpdj48YnI+PC9kaXY+
PGRpdj5UaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gRnJpLCBE
ZWMgMTMsIDIwMTkgYXQgMTozOCBQTSBBbGFuIEZvcmQgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFu
LmZvcmRAZ21haWwuY29tIj5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJvdmVyZmxvdy13cmFwOiBicmVhay13b3JkOyI+SGkgTWF0
dGhpZXUsPGJyPjxkaXY+PGJyPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxkaXY+T24gMTMgRGVj
IDIwMTksIGF0IDAwOjEwLCBNYXR0aGlldSBCYWVydHMgJmx0OzxhIGhyZWY9Im1haWx0bzptYXR0
aGlldS5iYWVydHNAdGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRz
QHRlc3NhcmVzLm5ldDwvYT4mZ3Q7IHdyb3RlOjwvZGl2Pjxicj48ZGl2PjxkaXYgZGlyPSJsdHIi
IHN0eWxlPSJmb250LWZhbWlseTpIZWx2ZXRpY2E7Zm9udC1zaXplOjEycHg7Zm9udC1zdHlsZTpu
b3JtYWw7Zm9udC12YXJpYW50LWNhcHM6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDtsZXR0ZXIt
c3BhY2luZzpub3JtYWw7dGV4dC1hbGlnbjpzdGFydDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFu
c2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDt0ZXh0LWRlY29y
YXRpb246bm9uZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBBbGFuLDwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xh
c3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgRGVjIDEyLCAyMDE5IGF0IDEwOjE5IFBNIEFsYW4gRm9y
ZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2
PkhpIENocmlzdG9waCAoYW5kIE1hdHRoaWV1ICZhbXA7IFBhYmxvKSw8ZGl2Pjxicj48L2Rpdj48
ZGl2PldSVCBjaGVja3N1bXMsIHdlIGRvIHNheTo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxk
aXY+wqAgwqBGb3IgZXhhbXBsZSw8L2Rpdj48ZGl2PsKgIMKgaWYgdGhlIGluaXRpYXRvciBzZXRz
IEE9MCBpbiB0aGUgU1lOIGJ1dCB0aGUgcmVzcG9uZGVyIHNldHMgQT0xIGluPC9kaXY+PGRpdj7C
oCDCoHRoZSBTWU4vQUNLLCBjaGVja3N1bXMgTVVTVCBiZSB1c2VkIGluIGJvdGggZGlyZWN0aW9u
cywgYW5kIHRoZTwvZGl2PjxkaXY+wqAgwqBpbml0aWF0b3Igd2lsbCBzZXQgQT0xIGluIHRoZSBB
Q0suIMKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoCDCoElmIEE9MSBpcyByZWNlaXZlZCBi
eSBhIGhvc3QgdGhhdCBkb2VzIG5vdDwvZGl2PjxkaXY+wqAgwqB3YW50IHRvIHVzZSBjaGVja3N1
bXMsIGl0IE1VU1QgZmFsbCBiYWNrIHRvIHJlZ3VsYXIgVENQIGJ5IGlnbm9yaW5nPC9kaXY+PGRp
dj7CoCDCoHRoZSBNUF9DQVBBQkxFIG9wdGlvbiBhcyBpZiBpdCB3YXMgaW52YWxpZC48L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldoaWNoIHdvdWxkIHNlZW0gdG8gY292ZXIgYWxsIHRo
ZXNlIGV2ZW50dWFsaXRpZXMuIFRoZSDigJxD4oCdIGJpdCBpcyBwdXJlbHkgYW4gaW5kaWNhdG9y
LCBhbmQgdGhlIGNyeXB0byBuZWdvdGlhdGlvbiBpcyBjbGVhcmx5IHNwZWNpZmllZCB0b28uPC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5UaGFuayB5b3Ug
Zm9yIHlvdXIgYW5zd2VyLCB0aGF0JiMzOTtzIGNsZWFyZXIgZm9yIHRoZSBBIGJpdC48L2Rpdj48
ZGl2Pk91ciBjb25jZXJuIHdhcyBtYWlubHkgYWJvdXQgdGhlIHZlcnNpb24uIEhvdyBzaG91bGQg
d2UgcmVhY3QgaWYsIGFzIGEgc2VydmVyIHN1cHBvcnRpbmcgb25seSB2MSwgd2UgaGF2ZSB0aGlz
IHNlcXVlbmNlOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXY+U1lOIChNUF9DQVBBQkxFOiB2MinCoCDihpI8L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW4tbGVmdDo0MHB4Ij7ihpDCoCBTWU4rQUNLIChNUF9DQVBBQkxFOiB2MSk8L2Rpdj5BQ0sgKE1Q
X0NBUEFCTEUgdjIpIOKGkjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdj48
YnI+PC9kaXY+PGRpdj5JbiBvdGhlciB3b3JkcywgdGhlIHNlcnZlciB0b2xkIHRoZSBjbGllbnQg
dGhhdCB0aGUgbWF4aW11bSB2ZXJzaW9uIGl0IHN1cHBvcnRzIGlzIHYxLiBCdXQgaW4gdGhlIEFD
SytNUF9DQVBBQkxFLCB0aGUgY2xpZW50IHNlbmRzIHYyIGFnYWluLjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+QWNjb3JkaW5nIHRvIHRoZSBSRkMsIHRoZSBuZWdvdGlhdGlvbiBpcyBkb25lIGlu
IHRoZSBTWU4gYW5kIFNZTitBQ0suIEhvdyBkbyB3ZSByZWFjdCBpZiB0aGUgZm9sbG93aW5nIEFD
SyBpcyBzZW5kaW5nIGEgdmVyc2lvbiAoZS5nLiB2Mikgd2hpY2ggaXMgbm90IHRoZSBleHBlY3Rl
ZCBvbmUgKGUuZy4gdjEpPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Rm9yIHRoZSBtb21lbnQg
aW4gb3VyIGltcGxlbWVudGF0aW9uLCB3ZSBmYWxsYmFjayB0byByZWd1bGFyIFRDUC48L2Rpdj48
ZGl2Pkl0IG1lYW5zIHRoYXQgZnV0dXJlIHZlcnNpb25zIG9mIE1QVENQIGhhdmUgdG8gc2V0IHRo
ZSBwcm9wZXIgdmVyc2lvbiBpbiB0aGUgM3JkIEFDSyAtLSB0aGUgbmVnb3RpYXRlZCBvbmUgLS0g
YW5kIG5vdCBhIGNvcHkgb2Ygd2hhdCBoYXMgYmVlbiBzZW50IGluIHRoZSBTWU4uPGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+U2hvdWxkIHdlIGFkZCBhIGNsYXJpZmljYXRpb24gZm9yIHRo
YXQ/PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2Pkkgc2VlIHlvdXIgcG9pbnQgYnV0IEkgZG9u4oCZdCBmZWVsIHdlIG5l
ZWQgYW55IGNsYXJpZmljYXRpb24gaGVyZS4gVGhlIGV4Y2hhbmdlIGFzIHlvdSByaWdodGx5IHBv
aW50IG91dCBpcyBkb25lIG9uIHRoZSBTWU4vU1lOK0FDSy4gU28gd2hlbiB0aGUgc2VydmVyIHNl
bmRzIHRoZSBTWU4rQUNLIHdpdGggdjEsIHRoYXQgaXMgdGhlIGRlY2lzaW9uIHRoYXQgaGFzIGJl
ZW4gbWFkZS4gU2VuZGluZyBhbiBBQ0sgd2l0aCB2MiBpcyBub3QgYSB2YWxpZCByZXNwb25zZS4g
U28gaWYgdGhlIHNlcnZlciByZWNlaXZlcyB0aGlzLCBpdCB0cmVhdHMgaXQgYXMgYW55IG90aGVy
IGludmFsaWQgb3B0aW9uIGFuZCBpZ25vcmVzIGl0LCBzbyBpdCB0cmVhdHMgaXQgYXMgaWYgdGhl
IEFDSyBkb2VzIG5vdCBoYXZlIGFuIE1QX0NBUEFCTEUsIGFuZCB0aHVzIGl0IHdpbGwgZmFsbCBi
YWNrIHRvIHJlZ3VsYXIgVENQLjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9xdW90ZSI+PGRpdj48YnI+PC9kaXY+PGRpdj5FdmVuIGlmIGF0IHNvbWUgcG9p
bnQsIHdlIHRob3VnaHQgYWJvdXQgbm90IGNoZWNraW5nIHRoZSB2ZXJzaW9uIGluIHRoZSAzcmQg
QUNLIGJlY2F1c2UgaXQgd2FzIGEgYml0IHVuY2xlYXIgZm9yIHVzLCB3ZSBub3cgZG8gZmFsbGJh
Y2sgdG8gcmVndWxhciBUQ1AgaWYgdGhlIHZlcnNpb24gaW4gdGhlIDNyZCBBQ0sgaXMgbm90IHRo
ZSBleHBlY3RlZCBvbmUuPC9kaXY+PGRpdj5TbyBpdCBzZWVtcyB0aGF0IGF0IHRoZSBlbmQsIHdl
IGNvcnJlY3RseSBpbnRlcnByZXRlZCB0aGUgUkZDIHRoZXJlLiBJZiB5b3UgZmVlbCB0aGF0IG5v
IGNsYXJpZmljYXRpb24gaXMgbmVlZGVkIGZvciB0aGF0LCB0aGF0JiMzOTtzIGZpbmUgZm9yIHVz
ITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+TWF0dGhp
ZXU8YnI+PC9kaXY+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWdu
YXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0i
bHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRp
cj0ibHRyIj48dGFibGUgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZx
dW90OztsZXR0ZXItc3BhY2luZzpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3Jt
Om5vbmU7d29yZC1zcGFjaW5nOjBweCIgd2lkdGg9IjYwMCIgaGVpZ2h0PSIxMTAiIGJvcmRlcj0i
MCI+PHRib2R5Pjx0cj48dGQgcm93c3Bhbj0iMyIgc3R5bGU9InBhZGRpbmctbGVmdDo1cHg7cGFk
ZGluZy1yaWdodDo1cHgiIHdpZHRoPSIxMCIgdmFsaWduPSJ0b3AiIGFsaWduPSJsZWZ0Ij48YSBo
cmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPjxpbWcgc3JjPSJo
dHRwOi8vd3d3LnRlc3NhcmVzLm5ldC9zaWdsb2dvLnBuZyIgYWx0PSJUZXNzYXJlcyBTQSIgd2lk
dGg9IjgwIiBoZWlnaHQ9IjgwIiBib3JkZXI9IjAiPjwvYT48L3RkPjx0ZCBzdHlsZT0icGFkZGlu
ZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEw
cHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6Ym9s
ZDtjb2xvcjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+TWF0dGhpZXUgQmFlcnRzIHwg
UiZhbXA7RCBFbmdpbmVlcjwvc3Bhbj48L3RkPjwvdHI+PHRyPjx0ZCBzdHlsZT0icGFkZGluZzow
cHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEwcHgi
IGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRz
JTQwdGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246
bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRoaWV1LmJhZXJ0c0B0ZXNz
YXJlcy5uZXQ8YnI+PC9hPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250
LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgYWxpZ249
ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUp
O2Rpc3BsYXk6aW5saW5lIj5UZXNzYXJlcyBTQSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25zPGJy
Pjwvc3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgc3R5bGU9ImNvbG9yOnJn
YigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2Js
YW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxzcGFuPsKgPC9zcGFuPjxicj4xIEF2ZW51ZSBKZWFu
IE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPGJyPjxicj5EaXNjbGFpbWVy
OiA8YSBocmVmPSJodHRwczovL3d3dy50ZXNzYXJlcy5uZXQvbWFpbC1kaXNjbGFpbWVyLyIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3LnRlc3NhcmVzLm5ldC9tYWlsLWRpc2NsYWltZXIvPC9h
Pjxicj48L3RkPjwvdHI+PC90Ym9keT48L3RhYmxlPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============4295990559163143664==--
