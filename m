Content-Type: multipart/mixed; boundary="===============1829783414671916008=="
MIME-Version: 1.0
From: Alan Ford <alan.ford at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Fri, 13 Dec 2019 12:38:26 +0000
Message-ID: <48314EB0-E515-40DC-B8D3-E7512DAA35BC@gmail.com>
In-Reply-To: CAKuKrBmpqv026QaKnYirTgpXmmjoyorbLAUOkF7KJbpofHEgQA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2932

--===============1829783414671916008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

> On 13 Dec 2019, at 00:10, Matthieu Baerts <matthieu.baerts(a)tessares.net=
> wrote:
> =

> Hi Alan,
> =

> =

> On Thu, Dec 12, 2019 at 10:19 PM Alan Ford <alan.ford(a)gmail.com <mailto=
:alan.ford(a)gmail.com>> wrote:
> Hi Christoph (and Matthieu & Pablo),
> =

> WRT checksums, we do say:
> =

>    For example,
>    if the initiator sets A=3D0 in the SYN but the responder sets A=3D1 in
>    the SYN/ACK, checksums MUST be used in both directions, and the
>    initiator will set A=3D1 in the ACK.  =

> =

>    If A=3D1 is received by a host that does not
>    want to use checksums, it MUST fall back to regular TCP by ignoring
>    the MP_CAPABLE option as if it was invalid.
> =

> Which would seem to cover all these eventualities. The =E2=80=9CC=E2=80=
=9D bit is purely an indicator, and the crypto negotiation is clearly speci=
fied too.
> =

> Thank you for your answer, that's clearer for the A bit.
> Our concern was mainly about the version. How should we react if, as a se=
rver supporting only v1, we have this sequence:
> =

> SYN (MP_CAPABLE: v2)  =E2=86=92
> =E2=86=90  SYN+ACK (MP_CAPABLE: v1)
> ACK (MP_CAPABLE v2) =E2=86=92
> =

> In other words, the server told the client that the maximum version it su=
pports is v1. But in the ACK+MP_CAPABLE, the client sends v2 again.
> =

> According to the RFC, the negotiation is done in the SYN and SYN+ACK. How=
 do we react if the following ACK is sending a version (e.g. v2) which is n=
ot the expected one (e.g. v1)?
> =

> For the moment in our implementation, we fallback to regular TCP.
> It means that future versions of MPTCP have to set the proper version in =
the 3rd ACK -- the negotiated one -- and not a copy of what has been sent i=
n the SYN.
> =

> Should we add a clarification for that?

I see your point but I don=E2=80=99t feel we need any clarification here. T=
he exchange as you rightly point out is done on the SYN/SYN+ACK. So when th=
e server sends the SYN+ACK with v1, that is the decision that has been made=
. Sending an ACK with v2 is not a valid response. So if the server receives=
 this, it treats it as any other invalid option and ignores it, so it treat=
s it as if the ACK does not have an MP_CAPABLE, and thus it will fall back =
to regular TCP.

Regards,
Alan




--===============1829783414671916008==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+SGkgTWF0dGhpZXUsPGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNz
PSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gMTMg
RGVjIDIwMTksIGF0IDAwOjEwLCBNYXR0aGlldSBCYWVydHMgJmx0OzxhIGhyZWY9Im1haWx0bzpt
YXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0IiBjbGFzcz0iIj5tYXR0aGlldS5iYWVydHNAdGVz
c2FyZXMubmV0PC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5n
ZS1uZXdsaW5lIj48ZGl2IGNsYXNzPSIiPjxkaXYgZGlyPSJsdHIiIHN0eWxlPSJjYXJldC1jb2xv
cjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7
IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWln
aHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRl
eHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFs
OyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0
LWRlY29yYXRpb246IG5vbmU7IiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2
IGNsYXNzPSIiPkhpIEFsYW4sPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+
PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
IiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgMTA6MTkgUE0gQWxh
biBGb3JkICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+
YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBweCAwcHggMHB4IDAu
OGV4OyBib3JkZXItbGVmdC13aWR0aDogMXB4OyBib3JkZXItbGVmdC1zdHlsZTogc29saWQ7IGJv
cmRlci1sZWZ0LWNvbG9yOiByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDogMWV4OyI+
PGRpdiBzdHlsZT0ib3ZlcmZsb3ctd3JhcDogYnJlYWstd29yZDsiIGNsYXNzPSIiPkhpIENocmlz
dG9waCAoYW5kIE1hdHRoaWV1ICZhbXA7IFBhYmxvKSw8ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2IGNsYXNzPSIiPldSVCBjaGVja3N1bXMsIHdlIGRvIHNheTo8L2Rpdj48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+
Jm5ic3A7ICZuYnNwO0ZvciBleGFtcGxlLDwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNw
O2lmIHRoZSBpbml0aWF0b3Igc2V0cyBBPTAgaW4gdGhlIFNZTiBidXQgdGhlIHJlc3BvbmRlciBz
ZXRzIEE9MSBpbjwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3RoZSBTWU4vQUNLLCBj
aGVja3N1bXMgTVVTVCBiZSB1c2VkIGluIGJvdGggZGlyZWN0aW9ucywgYW5kIHRoZTwvZGl2Pjxk
aXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO2luaXRpYXRvciB3aWxsIHNldCBBPTEgaW4gdGhlIEFD
Sy4gJm5ic3A7PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFz
cz0iIj4mbmJzcDsgJm5ic3A7SWYgQT0xIGlzIHJlY2VpdmVkIGJ5IGEgaG9zdCB0aGF0IGRvZXMg
bm90PC9kaXY+PGRpdiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7d2FudCB0byB1c2UgY2hlY2tzdW1z
LCBpdCBNVVNUIGZhbGwgYmFjayB0byByZWd1bGFyIFRDUCBieSBpZ25vcmluZzwvZGl2PjxkaXYg
Y2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3RoZSBNUF9DQVBBQkxFIG9wdGlvbiBhcyBpZiBpdCB3YXMg
aW52YWxpZC48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2
IGNsYXNzPSIiPldoaWNoIHdvdWxkIHNlZW0gdG8gY292ZXIgYWxsIHRoZXNlIGV2ZW50dWFsaXRp
ZXMuIFRoZSDigJxD4oCdIGJpdCBpcyBwdXJlbHkgYW4gaW5kaWNhdG9yLCBhbmQgdGhlIGNyeXB0
byBuZWdvdGlhdGlvbiBpcyBjbGVhcmx5IHNwZWNpZmllZCB0b28uPC9kaXY+PC9kaXY+PC9ibG9j
a3F1b3RlPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj5UaGFuayB5b3UgZm9yIHlvdXIgYW5zd2VyLCB0aGF0J3MgY2xlYXJlciBmb3Ig
dGhlIEEgYml0LjwvZGl2PjxkaXYgY2xhc3M9IiI+T3VyIGNvbmNlcm4gd2FzIG1haW5seSBhYm91
dCB0aGUgdmVyc2lvbi4gSG93IHNob3VsZCB3ZSByZWFjdCBpZiwgYXMgYSBzZXJ2ZXIgc3VwcG9y
dGluZyBvbmx5IHYxLCB3ZSBoYXZlIHRoaXMgc2VxdWVuY2U6PC9kaXY+PGRpdiBjbGFzcz0iIj48
YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBjbGFzcz0iIj5TWU4gKE1QX0NBUEFCTEU6IHYyKSZuYnNwOyDihpI8L2Rpdj48ZGl2IHN0
eWxlPSJtYXJnaW4tbGVmdDogNDBweDsiIGNsYXNzPSIiPuKGkCZuYnNwOyBTWU4rQUNLIChNUF9D
QVBBQkxFOiB2MSk8L2Rpdj5BQ0sgKE1QX0NBUEFCTEUgdjIpIOKGkjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdiBjbGFzcz0iIj5JbiBvdGhlciB3b3JkcywgdGhlIHNlcnZlciB0b2xkIHRoZSBjbGll
bnQgdGhhdCB0aGUgbWF4aW11bSB2ZXJzaW9uIGl0IHN1cHBvcnRzIGlzIHYxLiBCdXQgaW4gdGhl
IEFDSytNUF9DQVBBQkxFLCB0aGUgY2xpZW50IHNlbmRzIHYyIGFnYWluLjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QWNjb3JkaW5nIHRvIHRoZSBS
RkMsIHRoZSBuZWdvdGlhdGlvbiBpcyBkb25lIGluIHRoZSBTWU4gYW5kIFNZTitBQ0suIEhvdyBk
byB3ZSByZWFjdCBpZiB0aGUgZm9sbG93aW5nIEFDSyBpcyBzZW5kaW5nIGEgdmVyc2lvbiAoZS5n
LiB2Mikgd2hpY2ggaXMgbm90IHRoZSBleHBlY3RlZCBvbmUgKGUuZy4gdjEpPzwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Rm9yIHRoZSBtb21lbnQg
aW4gb3VyIGltcGxlbWVudGF0aW9uLCB3ZSBmYWxsYmFjayB0byByZWd1bGFyIFRDUC48L2Rpdj48
ZGl2IGNsYXNzPSIiPkl0IG1lYW5zIHRoYXQgZnV0dXJlIHZlcnNpb25zIG9mIE1QVENQIGhhdmUg
dG8gc2V0IHRoZSBwcm9wZXIgdmVyc2lvbiBpbiB0aGUgM3JkIEFDSyAtLSB0aGUgbmVnb3RpYXRl
ZCBvbmUgLS0gYW5kIG5vdCBhIGNvcHkgb2Ygd2hhdCBoYXMgYmVlbiBzZW50IGluIHRoZSBTWU4u
PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYg
Y2xhc3M9IiI+U2hvdWxkIHdlIGFkZCBhIGNsYXJpZmljYXRpb24gZm9yIHRoYXQ/PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVy
ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBj
bGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBj
bGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSIiPjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj5JIHNl
ZSB5b3VyIHBvaW50IGJ1dCBJIGRvbuKAmXQgZmVlbCB3ZSBuZWVkIGFueSBjbGFyaWZpY2F0aW9u
IGhlcmUuIFRoZSBleGNoYW5nZSBhcyB5b3UgcmlnaHRseSBwb2ludCBvdXQgaXMgZG9uZSBvbiB0
aGUgU1lOL1NZTitBQ0suIFNvIHdoZW4gdGhlIHNlcnZlciBzZW5kcyB0aGUgU1lOK0FDSyB3aXRo
IHYxLCB0aGF0IGlzIHRoZSBkZWNpc2lvbiB0aGF0IGhhcyBiZWVuIG1hZGUuIFNlbmRpbmcgYW4g
QUNLIHdpdGggdjIgaXMgbm90IGEgdmFsaWQgcmVzcG9uc2UuIFNvIGlmIHRoZSBzZXJ2ZXIgcmVj
ZWl2ZXMgdGhpcywgaXQgdHJlYXRzIGl0IGFzIGFueSBvdGhlciBpbnZhbGlkIG9wdGlvbiBhbmQg
aWdub3JlcyBpdCwgc28gaXQgdHJlYXRzIGl0IGFzIGlmIHRoZSBBQ0sgZG9lcyBub3QgaGF2ZSBh
biBNUF9DQVBBQkxFLCBhbmQgdGh1cyBpdCB3aWxsIGZhbGwgYmFjayB0byByZWd1bGFyIFRDUC48
L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5BbGFu
PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGJy
IGNsYXNzPSIiPjwvYm9keT48L2h0bWw+
--===============1829783414671916008==--
