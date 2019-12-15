Content-Type: multipart/mixed; boundary="===============2845798619302133442=="
MIME-Version: 1.0
From: V Anil Kumar <anil at csir4pi.in>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] MPTCP implementation feedback for
 RFC6824bis
Date: Sun, 15 Dec 2019 19:50:27 +0530
Message-ID: <fa91c3e72444.5df68e83@nic.in>
In-Reply-To: A534F828-E876-454F-B734-1B5AC32FB027@strayalpha.com
X-Status: 
X-Keywords:                  
X-UID: 3071

--===============2845798619302133442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On 12/14/19 10:48 PM, Joe Touch  <touch(a)strayalpha.com> wrote: =

> =

> =

> =

> =

> =

> =

> =

> =

> =

> =

> > =

> > On Dec 14, 2019, at 5:39 AM, V Anil Kumar <anil(a)csir4pi.in> wrote:
> > =

> > =

> > =

> > =

> > > =

> > > The implementation needs to enforce a strict priority of DSS over SAC=
K and ADD_ADDR.
> > > =

> > =

> > TCP options have evolved over a period of time, and I do not think as s=
uch any document/guidelines exist on enforcing priority for one over the ot=
her, though it turns out be an interesting topic. Also, more TCP options co=
uld come up in future for implementing new features. So, it is likely that =
implementations would follow different strategy when it come to option prio=
rity. =

> > =

> > =

> =

> =

> =

> FYI, this has come up as an issue before.
> =

> =

> =

> =

> TCP options are individual and accepted in isolation. They are easily con=
firmed only during SYN exchange; anything after that requires a stateful, r=
eliable transmission mechanism for coordination.
> =

> =

> =

> =

> There is no way to retrofit any ordering constraints, or prioritization. =
If you need that sort of feature, it needs to be built inside a single opti=
on as =E2=80=9Csub options=E2=80=9D.
> =

> =

> =

> =

>  =

> =


Thank you for sharing this information.
I agree with this. =

Anil

> =

> =

> =

> =

> =

> Joe
> =

> =

>  =

>=20

--===============2845798619302133442==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgSm9lLDxiciAvPjxiciAvPjxzcGFuPk9uIDEyLzE0LzE5IDEwOjQ4IFBNLCA8YiBjbGFzcz0i
bmFtZSI+Sm9lIFRvdWNoIDwvYj4gJmx0O3RvdWNoQHN0cmF5YWxwaGEuY29tJmd0OyB3cm90ZTo8
L3NwYW4+PGJsb2NrcXVvdGUgY2l0ZT0ibWlkOkE1MzRGODI4LUU4NzYtNDU0Ri1CNzM0LTFCNUFD
MzJGQjAyN0BzdHJheWFscGhhLmNvbSIgY2xhc3M9Iml3Y1F1b3RlIiBzdHlsZT0iYm9yZGVyLWxl
ZnQ6IDFweCBzb2xpZCAjMDBGOyBwYWRkaW5nLWxlZnQ6IDEzcHg7IG1hcmdpbi1sZWZ0OiAwOyIg
dHlwZT0iY2l0ZSI+PGRpdiBjbGFzcz0ibWltZXR5cGUtdGV4dC1odG1sIj48c3Bhbj48cD48bWV0
YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiIGh0dHAtZXF1aXY9IkNvbnRlbnQt
VHlwZSIgLz48dGFibGU+PHRib2R5Pjx0cj48dGQgY2xhc3M9IiIgc3R5bGU9IndvcmQtd3JhcDog
YnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBhZnRlci13
aGl0ZS1zcGFjZTsiPjxwPjxiciBjbGFzcz0iIiAvPjwvcD48ZGl2PjxiciBjbGFzcz0iIiAvPjxi
bG9ja3F1b3RlIGNsYXNzPSIiIHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9IiI+T24gRGVjIDE0LCAy
MDE5LCBhdCA1OjM5IEFNLCBWIEFuaWwgS3VtYXIgJmx0OzxhIGNsYXNzPSIiIGhyZWY9Im1haWx0
bzphbmlsQGNzaXI0cGkuaW4iPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjwvZGl2Pjxi
ciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSIgLz48ZGl2IGNsYXNzPSIiPjxkaXYg
Y2xhc3M9IlNpbmdsZXRvbiI+PGJsb2NrcXVvdGUgY2l0ZT0ibWlkOjIwMTkxMjEzMTgyNDA5LkdC
OTQzMEBNYWNCb29rLVByby02NC5sb2NhbCIgY2xhc3M9Iml3Y1F1b3RlIiBzdHlsZT0iZm9udC1m
YW1pbHk6IEhlbHZldGljYTsgZm9udC1zaXplOiAxMnB4OyBmb250LXN0eWxlOiBub3JtYWw7IGZv
bnQtdmFyaWFudC1jYXBzOiBub3JtYWw7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGxldHRlci1zcGFj
aW5nOiBub3JtYWw7IG9ycGhhbnM6IGF1dG87IHRleHQtYWxpZ246IHN0YXJ0OyB0ZXh0LWluZGVu
dDogMHB4OyB0ZXh0LXRyYW5zZm9ybTogbm9uZTsgd2hpdGUtc3BhY2U6IG5vcm1hbDsgd2lkb3dz
OiBhdXRvOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXNpemUtYWRqdXN0OiBhdXRv
OyAtd2Via2l0LXRleHQtc3Ryb2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsg
Ym9yZGVyLWxlZnQtd2lkdGg6IDFweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXIt
bGVmdC1jb2xvcjogcmdiKDAsIDAsIDI1NSk7IHBhZGRpbmctbGVmdDogMTNweDsgbWFyZ2luLWxl
ZnQ6IDBweDsiIHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0eXBlLXRleHQtcGxhaW4iPlRo
ZSBpbXBsZW1lbnRhdGlvbiBuZWVkcyB0byBlbmZvcmNlIGEgc3RyaWN0IHByaW9yaXR5IG9mIERT
UyBvdmVyIFNBQ0sgYW5kIEFERF9BRERSLjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2IGNsYXNzPSIi
IHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTogSGVsdmV0aWNh
OyBmb250LXNpemU6IDEycHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJpYW50LWNhcHM6
IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5vcm1hbDsgdGV4
dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3JtOiBub25lOyB3
aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10ZXh0LXN0cm9r
ZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7Ij5UQ1Agb3B0aW9ucyBoYXZlIGV2
b2x2ZWQgb3ZlciBhIHBlcmlvZCBvZiB0aW1lLCBhbmQgSSBkbyBub3QgdGhpbmsgYXMgc3VjaCBh
bnkgZG9jdW1lbnQvZ3VpZGVsaW5lcyBleGlzdCBvbiCgZW5mb3JjaW5nIHByaW9yaXR5IGZvciBv
bmUgb3ZlciB0aGUgb3RoZXIsIHRob3VnaCBpdCB0dXJucyBvdXQgYmUgYW4gaW50ZXJlc3Rpbmcg
dG9waWMuIKBBbHNvLCBtb3JlIFRDUCBvcHRpb25zIGNvdWxkIGNvbWUgdXAgaW4gZnV0dXJlIGZv
ciBpbXBsZW1lbnRpbmcgoG5ldyBmZWF0dXJlcy4goFNvLCBpdCBpcyBsaWtlbHkgdGhhdCBpbXBs
ZW1lbnRhdGlvbnMgd291bGQgZm9sbG93IGRpZmZlcmVudCBzdHJhdGVneSB3aGVuIGl0IGNvbWUg
dG8gb3B0aW9uIHByaW9yaXR5LqA8L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+
PGJyIGNsYXNzPSIiIC8+PGRpdiBjbGFzcz0iIj5GWUksIHRoaXMgaGFzIGNvbWUgdXAgYXMgYW4g
aXNzdWUgYmVmb3JlLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiIC8+PC9kaXY+PGRp
diBjbGFzcz0iIj5UQ1Agb3B0aW9ucyBhcmUgaW5kaXZpZHVhbCBhbmQgYWNjZXB0ZWQgaW4gaXNv
bGF0aW9uLiBUaGV5IGFyZSBlYXNpbHkgY29uZmlybWVkIG9ubHkgZHVyaW5nIFNZTiBleGNoYW5n
ZTsgYW55dGhpbmcgYWZ0ZXIgdGhhdCByZXF1aXJlcyBhIHN0YXRlZnVsLCByZWxpYWJsZSB0cmFu
c21pc3Npb24gbWVjaGFuaXNtIGZvciBjb29yZGluYXRpb24uPC9kaXY+PGRpdiBjbGFzcz0iIj48
YnIgY2xhc3M9IiIgLz48L2Rpdj48ZGl2IGNsYXNzPSIiPlRoZXJlIGlzIG5vIHdheSB0byByZXRy
b2ZpdCBhbnkgb3JkZXJpbmcgY29uc3RyYWludHMsIG9yIHByaW9yaXRpemF0aW9uLiBJZiB5b3Ug
bmVlZCB0aGF0IHNvcnQgb2YgZmVhdHVyZSwgaXQgbmVlZHMgdG8gYmUgYnVpbHQgaW5zaWRlIGEg
c2luZ2xlIG9wdGlvbiBhcyCTc3ViIG9wdGlvbnOULjwvZGl2PjxkaXY+PGJyIC8+PC9kaXY+PC90
ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L3A+PC9zcGFuPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2
PlRoYW5rIHlvdSBmb3Igc2hhcmluZyB0aGlzIGluZm9ybWF0aW9uLjwvZGl2PjxkaXY+SSBhZ3Jl
ZSB3aXRoIHRoaXMuoDwvZGl2PjxkaXY+QW5pbDwvZGl2PjxibG9ja3F1b3RlIGNpdGU9Im1pZDpB
NTM0RjgyOC1FODc2LTQ1NEYtQjczNC0xQjVBQzMyRkIwMjdAc3RyYXlhbHBoYS5jb20iIGNsYXNz
PSJpd2NRdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgIzAwRjsgcGFkZGluZy1s
ZWZ0OiAxM3B4OyBtYXJnaW4tbGVmdDogMDsiIHR5cGU9ImNpdGUiPjxkaXYgY2xhc3M9Im1pbWV0
eXBlLXRleHQtaHRtbCI+PHNwYW4+PHA+PHRhYmxlPjx0Ym9keT48dHI+PHRkIGNsYXNzPSIiIHN0
eWxlPSJ3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGlu
ZS1icmVhazogYWZ0ZXItd2hpdGUtc3BhY2U7Ij48ZGl2IGNsYXNzPSIiPkpvZTwvZGl2PjwvdGQ+
PC90cj48L3Rib2R5PjwvdGFibGU+PC9wPjwvc3Bhbj48L2Rpdj48L2Jsb2NrcXVvdGU+Cg==

--===============2845798619302133442==--
