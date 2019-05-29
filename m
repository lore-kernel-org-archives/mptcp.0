Content-Type: multipart/mixed; boundary="===============6127413528516543187=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:virtme: turn on
 KASAN and PROVE_LOCKING
Date: Wed, 29 May 2019 13:24:48 +0000
Message-ID: <gerrit.1559136284000.I54868cc70c8ab994fea5f6926866913c133b108d@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1264

--===============6127413528516543187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456219

to review the following change.


Change subject: ci:virtme: turn on KASAN and PROVE_LOCKING
......................................................................

ci:virtme: turn on KASAN and PROVE_LOCKING

To debug memory and locking issues. There is a tradeoff in speed, but it
could alert us to problems the selftests alone don't catch.

Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I54868cc70c8ab994fea5f6926866913c133b108d
---
M ci/virtme.sh
1 file changed, 12 insertions(+), 5 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/19/456219/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456219
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I54868cc70c8ab994fea5f6926866913c133b108d
Gerrit-Change-Number: 456219
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============6127413528516543187==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjIxOSI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp2aXJ0bWU6IHR1cm4gb24gS0FTQU4gYW5k
IFBST1ZFX0xPQ0tJTkc8YnI+PGJyPlRvIGRlYnVnIG1lbW9yeSBhbmQgbG9ja2luZyBpc3N1ZXMu
IFRoZXJlIGlzIGEgdHJhZGVvZmYgaW4gc3BlZWQsIGJ1dCBpdDxicj5jb3VsZCBhbGVydCB1cyB0
byBwcm9ibGVtcyB0aGUgc2VsZnRlc3RzIGFsb25lIGRvbiYjMzk7dCBjYXRjaC48YnI+PGJyPlN1
Z2dlc3RlZC1ieTogTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3LmoubWFydGluZWF1QGxpbnV4Lmlu
dGVsLmNvbSZndDs8YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGll
dS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IEk1NDg2OGNjNzBjOGFiOTk0
ZmVhNWY2OTI2ODY2OTEzYzEzM2IxMDhkPGJyPi0tLTxicj5NIGNpL3ZpcnRtZS5zaDxicj4xIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJl
PjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFj
ZTogcHJlLXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211
bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzE5LzQ1NjIxOS8xPC9wcmU+
PHA+VG8gdmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2Mv
bXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjIxOSI+Y2hhbmdlIDQ1NjIxOTwvYT4u
IFRvIHVuc3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQg
PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwv
YT4uPC9wPjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1l
c3NhZ2UiPjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8v
c2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczov
L3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDU2
MjE5Ii8+PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+
PC9kaXY+Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4g
R2Vycml0LUJyYW5jaDogc2NyaXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4g
R2Vycml0LUNoYW5nZS1JZDogSTU0ODY4Y2M3MGM4YWI5OTRmZWE1ZjY5MjY4NjY5MTNjMTMzYjEw
OGQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVy
OiA0NTYyMTkgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNl
dDogMSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXR0
aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7IDwvZGl2Pgo8
ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1hdCBNYXJ0aW5lYXUg
Jmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rpdj4K
Cg==

--===============6127413528516543187==--
