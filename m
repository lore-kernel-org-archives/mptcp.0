Content-Type: multipart/mixed; boundary="===============9028521173330358627=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: stop in case
 of error
Date: Tue, 28 May 2019 16:55:52 +0000
Message-ID: <gerrit.1559062547000.I7086ff65cba9d1b6f98817aa51d18d1c0d6c54c7@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1255

--===============9028521173330358627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456071

to review the following change.


Change subject: ci:upd-tg: stop in case of error
......................................................................

ci:upd-tg: stop in case of error

by forcing 'set -e'.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I7086ff65cba9d1b6f98817aa51d18d1c0d6c54c7
---
M ci/Dockerfile.update-tg-tree.sh
1 file changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/71/456071/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456071
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I7086ff65cba9d1b6f98817aa51d18d1c0d6c54c7
Gerrit-Change-Number: 456071
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============9028521173330358627==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MSI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHN0b3AgaW4gY2FzZSBvZiBl
cnJvcjxicj48YnI+YnkgZm9yY2luZyAmIzM5O3NldCAtZSYjMzk7Ljxicj48YnI+U2lnbmVkLW9m
Zi1ieTogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0
Ozxicj5DaGFuZ2UtSWQ6IEk3MDg2ZmY2NWNiYTlkMWI2Zjk4ODE3YWE1MWQxOGQxYzBkNmM1NGM3
PGJyPi0tLTxicj5NIGNpL0RvY2tlcmZpbGUudXBkYXRlLXRnLXRyZWUuc2g8YnI+MSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJlPjxwcmUg
c3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFjZTogcHJl
LXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211bHRpcGF0
aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzcxLzQ1NjA3MS8xPC9wcmU+PHA+VG8g
dmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MSI+Y2hhbmdlIDQ1NjA3MTwvYT4uIFRvIHVu
c3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQgPGEgaHJl
Zj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwvYT4uPC9w
PjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1lc3NhZ2Ui
PjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1h
Lm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL3Jldmll
dy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDU2MDcxIi8+
PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+PC9kaXY+
Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlwYXRoLXRj
cC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0
LUJyYW5jaDogc2NyaXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0
LUNoYW5nZS1JZDogSTcwODZmZjY1Y2JhOWQxYjZmOTg4MTdhYTUxZDE4ZDFjMGQ2YzU0YzcgPC9k
aXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVyOiA0NTYw
NzEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNldDogMSA8
L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXR0aGlldSBC
YWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7IDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1hdCBNYXJ0aW5lYXUgJmx0O21h
dGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJk
aXNwbGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rpdj4KCg==

--===============9028521173330358627==--
