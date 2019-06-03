Content-Type: multipart/mixed; boundary="===============4682997635673471386=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:virtme: run tests
 with/without error detectors
Date: Mon, 03 Jun 2019 16:43:06 +0000
Message-ID: <gerrit.1559580181000.I5b4bacdfae3c17f04f2891f4d2601765cf96404f@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1278

--===============4682997635673471386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456654

to review the following change.


Change subject: ci:virtme: run tests with/without error detectors
......................................................................

ci:virtme: run tests with/without error detectors

Error detectors like KASAN and PROVE_LOCKING slow down the tests
execution. This might hide bugs. It is then better to run these tests
twice: with and without these extra kernel tools.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I5b4bacdfae3c17f04f2891f4d2601765cf96404f
---
M ci/virtme.sh
1 file changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/54/456654/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456654
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I5b4bacdfae3c17f04f2891f4d2601765cf96404f
Gerrit-Change-Number: 456654
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============4682997635673471386==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjY1NCI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp2aXJ0bWU6IHJ1biB0ZXN0cyB3aXRoL3dp
dGhvdXQgZXJyb3IgZGV0ZWN0b3JzPGJyPjxicj5FcnJvciBkZXRlY3RvcnMgbGlrZSBLQVNBTiBh
bmQgUFJPVkVfTE9DS0lORyBzbG93IGRvd24gdGhlIHRlc3RzPGJyPmV4ZWN1dGlvbi4gVGhpcyBt
aWdodCBoaWRlIGJ1Z3MuIEl0IGlzIHRoZW4gYmV0dGVyIHRvIHJ1biB0aGVzZSB0ZXN0czxicj50
d2ljZTogd2l0aCBhbmQgd2l0aG91dCB0aGVzZSBleHRyYSBrZXJuZWwgdG9vbHMuPGJyPjxicj5T
aWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJl
cy5uZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTViNGJhY2RmYWUzYzE3ZjA0ZjI4OTFmNGQyNjAxNzY1
Y2Y5NjQwNGY8YnI+LS0tPGJyPk0gY2kvdmlydG1lLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250
LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0
IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNw
X25ldC1uZXh0IHJlZnMvY2hhbmdlcy81NC80NTY2NTQvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0
IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0
Y3BfbmV0LW5leHQvKy80NTY2NTQiPmNoYW5nZSA0NTY2NTQ8L2E+LiBUbyB1bnN1YnNjcmliZSwg
b3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8v
cmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1z
Y29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1z
Y29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0Fj
dGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHVi
LmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjY1NCIvPjxtZXRhIGl0ZW1w
cm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHls
ZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0
LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNj
cmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6
IEk1YjRiYWNkZmFlM2MxN2YwNGYyODkxZjRkMjYwMTc2NWNmOTY0MDRmIDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDU2NjU0IDwvZGl2Pgo8
ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYg
c3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDtt
YXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxh
eTpub25lIj4gR2Vycml0LVJldmlld2VyOiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0
aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============4682997635673471386==--
