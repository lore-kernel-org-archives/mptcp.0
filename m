Content-Type: multipart/mixed; boundary="===============5836071962397746612=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: new
 validation step
Date: Wed, 20 Feb 2019 13:56:53 +0000
Message-ID: <gerrit.1550671010000.Iab3b21466d59add12013f659fc0685a579bb9277@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1002

--===============5836071962397746612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445586

to review the following change.


Change subject: ci:upd-tg: new validation step
......................................................................

ci:upd-tg: new validation step

For the moment, only a basic compilation is done using x86_64 default
config.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: Iab3b21466d59add12013f659fc0685a579bb9277
---
M ci/update-tg-tree.sh
1 file changed, 23 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/86/445586/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445586
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: Iab3b21466d59add12013f659fc0685a579bb9277
Gerrit-Change-Number: 445586
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============5836071962397746612==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU4NiI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IG5ldyB2YWxpZGF0aW9uIHN0
ZXA8YnI+PGJyPkZvciB0aGUgbW9tZW50LCBvbmx5IGEgYmFzaWMgY29tcGlsYXRpb24gaXMgZG9u
ZSB1c2luZyB4ODZfNjQgZGVmYXVsdDxicj5jb25maWcuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBN
YXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7PGJyPkNo
YW5nZS1JZDogSWFiM2IyMTQ2NmQ1OWFkZDEyMDEzZjY1OWZjMDY4NWE1NzliYjkyNzc8YnI+LS0t
PGJyPk0gY2kvdXBkYXRlLXRnLXRyZWUuc2g8YnI+MSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWls
eTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwg
c3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0IHJlZnMvY2hhbmdlcy84Ni80NDU1ODYvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhy
ZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0
LW5leHQvKy80NDU1ODYiPmNoYW5nZSA0NDU1ODY8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9y
IGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3
LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBp
dGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBp
dGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+
PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2Mv
bXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU4NiIvPjxtZXRhIGl0ZW1wcm9wPSJu
YW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlz
cGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IElhYjNi
MjE0NjZkNTlhZGQxMjAxM2Y2NTlmYzA2ODVhNTc5YmI5Mjc3IDwvZGl2Pgo8ZGl2IHN0eWxlPSJk
aXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDQ1NTg2IDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9
ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGll
dS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LVJldmlld2VyOiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVA
bGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vy
cml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============5836071962397746612==--
