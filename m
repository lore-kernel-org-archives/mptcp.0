Content-Type: multipart/mixed; boundary="===============5102071556342932680=="
MIME-Version: 1.0
From: Joe Touch <touch at strayalpha.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Sat, 14 Dec 2019 09:18:22 -0800
Message-ID: <A534F828-E876-454F-B734-1B5AC32FB027@strayalpha.com>
In-Reply-To: fa6b23f5763c.5df53382@nic.in
X-Status: 
X-Keywords:                  
X-UID: 3069

--===============5102071556342932680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Dec 14, 2019, at 5:39 AM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> =

>> The implementation needs to enforce a strict priority of DSS over SACK a=
nd ADD_ADDR.
> TCP options have evolved over a period of time, and I do not think as suc=
h any document/guidelines exist on  enforcing priority for one over the oth=
er, though it turns out be an interesting topic.  Also, more TCP options co=
uld come up in future for implementing  new features.  So, it is likely tha=
t implementations would follow different strategy when it come to option pr=
iority. =


FYI, this has come up as an issue before.

TCP options are individual and accepted in isolation. They are easily confi=
rmed only during SYN exchange; anything after that requires a stateful, rel=
iable transmission mechanism for coordination.

There is no way to retrofit any ordering constraints, or prioritization. If=
 you need that sort of feature, it needs to be built inside a single option=
 as =E2=80=9Csub options=E2=80=9D.

Joe

--===============5102071556342932680==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gRGVjIDE0LCAyMDE5LCBh
dCA1OjM5IEFNLCBWIEFuaWwgS3VtYXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGku
aW4iIGNsYXNzPSIiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFz
cz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSJT
aW5nbGV0b24iPjxibG9ja3F1b3RlIGNpdGU9Im1pZDoyMDE5MTIxMzE4MjQwOS5HQjk0MzBATWFj
Qm9vay1Qcm8tNjQubG9jYWwiIGNsYXNzPSJpd2NRdW90ZSIgdHlwZT0iY2l0ZSIgc3R5bGU9ImZv
bnQtZmFtaWx5OiBIZWx2ZXRpY2E7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1zdHlsZTogbm9ybWFs
OyBmb250LXZhcmlhbnQtY2Fwczogbm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXIt
c3BhY2luZzogbm9ybWFsOyBvcnBoYW5zOiBhdXRvOyB0ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1p
bmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdp
ZG93czogYXV0bzsgd29yZC1zcGFjaW5nOiAwcHg7IC13ZWJraXQtdGV4dC1zaXplLWFkanVzdDog
YXV0bzsgLXdlYmtpdC10ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5v
bmU7IGJvcmRlci1sZWZ0LXdpZHRoOiAxcHg7IGJvcmRlci1sZWZ0LXN0eWxlOiBzb2xpZDsgYm9y
ZGVyLWxlZnQtY29sb3I6IHJnYigwLCAwLCAyNTUpOyBwYWRkaW5nLWxlZnQ6IDEzcHg7IG1hcmdp
bi1sZWZ0OiAwcHg7Ij48ZGl2IGNsYXNzPSJtaW1ldHlwZS10ZXh0LXBsYWluIj5UaGUgaW1wbGVt
ZW50YXRpb24gbmVlZHMgdG8gZW5mb3JjZSBhIHN0cmljdCBwcmlvcml0eSBvZiBEU1Mgb3ZlciBT
QUNLIGFuZCBBRERfQUREUi48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBzdHlsZT0iY2FyZXQtY29s
b3I6IHJnYigwLCAwLCAwKTsgZm9udC1mYW1pbHk6IEhlbHZldGljYTsgZm9udC1zaXplOiAxMnB4
OyBmb250LXN0eWxlOiBub3JtYWw7IGZvbnQtdmFyaWFudC1jYXBzOiBub3JtYWw7IGZvbnQtd2Vp
Z2h0OiBub3JtYWw7IGxldHRlci1zcGFjaW5nOiBub3JtYWw7IHRleHQtYWxpZ246IHN0YXJ0OyB0
ZXh0LWluZGVudDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vcm1h
bDsgd29yZC1zcGFjaW5nOiAwcHg7IC13ZWJraXQtdGV4dC1zdHJva2Utd2lkdGg6IDBweDsgdGV4
dC1kZWNvcmF0aW9uOiBub25lOyIgY2xhc3M9IiI+VENQIG9wdGlvbnMgaGF2ZSBldm9sdmVkIG92
ZXIgYSBwZXJpb2Qgb2YgdGltZSwgYW5kIEkgZG8gbm90IHRoaW5rIGFzIHN1Y2ggYW55IGRvY3Vt
ZW50L2d1aWRlbGluZXMgZXhpc3Qgb24gJm5ic3A7ZW5mb3JjaW5nIHByaW9yaXR5IGZvciBvbmUg
b3ZlciB0aGUgb3RoZXIsIHRob3VnaCBpdCB0dXJucyBvdXQgYmUgYW4gaW50ZXJlc3RpbmcgdG9w
aWMuICZuYnNwO0Fsc28sIG1vcmUgVENQIG9wdGlvbnMgY291bGQgY29tZSB1cCBpbiBmdXR1cmUg
Zm9yIGltcGxlbWVudGluZyAmbmJzcDtuZXcgZmVhdHVyZXMuICZuYnNwO1NvLCBpdCBpcyBsaWtl
bHkgdGhhdCBpbXBsZW1lbnRhdGlvbnMgd291bGQgZm9sbG93IGRpZmZlcmVudCBzdHJhdGVneSB3
aGVuIGl0IGNvbWUgdG8gb3B0aW9uIHByaW9yaXR5LiZuYnNwOzwvZGl2PjwvZGl2PjwvZGl2Pjwv
YmxvY2txdW90ZT48L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5GWUksIHRoaXMgaGFz
IGNvbWUgdXAgYXMgYW4gaXNzdWUgYmVmb3JlLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VENQIG9wdGlvbnMgYXJlIGluZGl2aWR1YWwgYW5kIGFj
Y2VwdGVkIGluIGlzb2xhdGlvbi4gVGhleSBhcmUgZWFzaWx5IGNvbmZpcm1lZCBvbmx5IGR1cmlu
ZyBTWU4gZXhjaGFuZ2U7IGFueXRoaW5nIGFmdGVyIHRoYXQgcmVxdWlyZXMgYSBzdGF0ZWZ1bCwg
cmVsaWFibGUgdHJhbnNtaXNzaW9uIG1lY2hhbmlzbSBmb3IgY29vcmRpbmF0aW9uLjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VGhlcmUgaXMgbm8g
d2F5IHRvIHJldHJvZml0IGFueSBvcmRlcmluZyBjb25zdHJhaW50cywgb3IgcHJpb3JpdGl6YXRp
b24uIElmIHlvdSBuZWVkIHRoYXQgc29ydCBvZiBmZWF0dXJlLCBpdCBuZWVkcyB0byBiZSBidWls
dCBpbnNpZGUgYSBzaW5nbGUgb3B0aW9uIGFzIOKAnHN1YiBvcHRpb25z4oCdLjwvZGl2PjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Sm9lPC9kaXY+PC9ib2R5
PjwvaHRtbD4=
--===============5102071556342932680==--
