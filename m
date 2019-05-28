Content-Type: multipart/mixed; boundary="===============6473521847892948552=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:virtme: script to
 launch kselftests
Date: Tue, 28 May 2019 16:55:53 +0000
Message-ID: <gerrit.1559062547000.I98cd158c2580ffefa6023e66894124319e1be819@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1256

--===============6473521847892948552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456072

to review the following change.


Change subject: ci:virtme: script to launch kselftests
......................................................................

ci:virtme: script to launch kselftests

It uses Docker and VirtMe to start qEmu with a generated kernel and
start MPTCP kselftests.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I98cd158c2580ffefa6023e66894124319e1be819
---
A ci/Dockerfile.virtme.sh
A ci/virtme.sh
2 files changed, 121 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/72/456072/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456072
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I98cd158c2580ffefa6023e66894124319e1be819
Gerrit-Change-Number: 456072
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============6473521847892948552==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MiI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp2aXJ0bWU6IHNjcmlwdCB0byBsYXVuY2gg
a3NlbGZ0ZXN0czxicj48YnI+SXQgdXNlcyBEb2NrZXIgYW5kIFZpcnRNZSB0byBzdGFydCBxRW11
IHdpdGggYSBnZW5lcmF0ZWQga2VybmVsIGFuZDxicj5zdGFydCBNUFRDUCBrc2VsZnRlc3RzLjxi
cj48YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNA
dGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IEk5OGNkMTU4YzI1ODBmZmVmYTYwMjNlNjY4
OTQxMjQzMTllMWJlODE5PGJyPi0tLTxicj5BIGNpL0RvY2tlcmZpbGUudmlydG1lLnNoPGJyPkEg
Y2kvdmlydG1lLnNoPGJyPjIgZmlsZXMgY2hhbmdlZCwgMTIxIGluc2VydGlvbnMoKyksIDAgZGVs
ZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNl
LG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3
LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hh
bmdlcy83Mi80NTYwNzIvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8v
cmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NTYw
NzIiPmNoYW5nZSA0NTYwNzI8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGlu
ZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0
cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0
aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXBy
b3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRj
cC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MiIvPjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50
PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4g
R2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYg
c3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYg
c3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEk5OGNkMTU4YzI1ODBmZmVm
YTYwMjNlNjY4OTQxMjQzMTllMWJlODE5IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUi
PiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDU2MDcyIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5
Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9u
ZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVz
c2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVJl
dmlld2VyOiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwu
Y29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VU
eXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============6473521847892948552==--
