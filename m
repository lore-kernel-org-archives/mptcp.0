Content-Type: multipart/mixed; boundary="===============5894330702224084841=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:virtme: use expect
 to avoid 'sleep'
Date: Wed, 29 May 2019 13:24:47 +0000
Message-ID: <gerrit.1559136284000.Idded343f80cb432c0fc3bd91b07260a6d6abfaf0@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1265

--===============5894330702224084841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456218

to review the following change.


Change subject: ci:virtme: use expect to avoid 'sleep'
......................................................................

ci:virtme: use expect to avoid 'sleep'

This change will be mandatory when debug kernel config will be turned ON
as it will slowdown all the process, waiting with a fix time might be an
issue.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: Idded343f80cb432c0fc3bd91b07260a6d6abfaf0
---
M ci/Dockerfile.virtme.sh
M ci/virtme.sh
2 files changed, 36 insertions(+), 10 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/18/456218/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456218
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: Idded343f80cb432c0fc3bd91b07260a6d6abfaf0
Gerrit-Change-Number: 456218
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============5894330702224084841==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjIxOCI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp2aXJ0bWU6IHVzZSBleHBlY3QgdG8gYXZv
aWQgJiMzOTtzbGVlcCYjMzk7PGJyPjxicj5UaGlzIGNoYW5nZSB3aWxsIGJlIG1hbmRhdG9yeSB3
aGVuIGRlYnVnIGtlcm5lbCBjb25maWcgd2lsbCBiZSB0dXJuZWQgT048YnI+YXMgaXQgd2lsbCBz
bG93ZG93biBhbGwgdGhlIHByb2Nlc3MsIHdhaXRpbmcgd2l0aCBhIGZpeCB0aW1lIG1pZ2h0IGJl
IGFuPGJyPmlzc3VlLjxicj48YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZsdDtt
YXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IElkZGVkMzQzZjgw
Y2I0MzJjMGZjM2JkOTFiMDcyNjBhNmQ2YWJmYWYwPGJyPi0tLTxicj5NIGNpL0RvY2tlcmZpbGUu
dmlydG1lLnNoPGJyPk0gY2kvdmlydG1lLnNoPGJyPjIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZh
bWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1
bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25l
dC1uZXh0IHJlZnMvY2hhbmdlcy8xOC80NTYyMTgvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxh
IGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3Bf
bmV0LW5leHQvKy80NTYyMTgiPmNoYW5nZSA0NTYyMTg8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3Ig
Zm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2
aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29w
ZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29w
ZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlv
biI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlv
L2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjIxOCIvPjxtZXRhIGl0ZW1wcm9w
PSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0i
ZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5l
eHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlw
dHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IElk
ZGVkMzQzZjgwY2I0MzJjMGZjM2JkOTFiMDcyNjBhNmQ2YWJmYWYwIDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDU2MjE4IDwvZGl2Pgo8ZGl2
IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5
bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0
aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpu
b25lIj4gR2Vycml0LVJldmlld2VyOiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5l
YXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4g
R2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============5894330702224084841==--
