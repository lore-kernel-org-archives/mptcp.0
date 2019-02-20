Content-Type: multipart/mixed; boundary="===============5460511248134384870=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: publish
 exported TopGit tree
Date: Wed, 20 Feb 2019 13:56:57 +0000
Message-ID: <gerrit.1550671010000.I6d236847a84e552958398f0f3f591dc45f77dd45@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1005

--===============5460511248134384870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445589

to review the following change.


Change subject: ci:upd-tg: publish exported TopGit tree
......................................................................

ci:upd-tg: publish exported TopGit tree

The tree is exported to a new branch and published. This branch will be
overriden if it exists before but that's normal, we will always rebase
our changes on top of last net-next branch.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I6d236847a84e552958398f0f3f591dc45f77dd45
---
M ci/update-tg-tree.sh
1 file changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/89/445589/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445589
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I6d236847a84e552958398f0f3f591dc45f77dd45
Gerrit-Change-Number: 445589
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============5460511248134384870==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU4OSI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHB1Ymxpc2ggZXhwb3J0ZWQg
VG9wR2l0IHRyZWU8YnI+PGJyPlRoZSB0cmVlIGlzIGV4cG9ydGVkIHRvIGEgbmV3IGJyYW5jaCBh
bmQgcHVibGlzaGVkLiBUaGlzIGJyYW5jaCB3aWxsIGJlPGJyPm92ZXJyaWRlbiBpZiBpdCBleGlz
dHMgYmVmb3JlIGJ1dCB0aGF0JiMzOTtzIG5vcm1hbCwgd2Ugd2lsbCBhbHdheXMgcmViYXNlPGJy
Pm91ciBjaGFuZ2VzIG9uIHRvcCBvZiBsYXN0IG5ldC1uZXh0IGJyYW5jaC48YnI+PGJyPlNpZ25l
ZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5l
dCZndDs8YnI+Q2hhbmdlLUlkOiBJNmQyMzY4NDdhODRlNTUyOTU4Mzk4ZjBmM2Y1OTFkYzQ1Zjc3
ZGQ0NTxicj4tLS08YnI+TSBjaS91cGRhdGUtdGctdHJlZS5zaDxicj4xIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0i
Zm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsi
PmdpdCBwdWxsIHNzaDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9t
cHRjcF9uZXQtbmV4dCByZWZzL2NoYW5nZXMvODkvNDQ1NTg5LzE8L3ByZT48cD5UbyB2aWV3LCB2
aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNw
L21wdGNwX25ldC1uZXh0LysvNDQ1NTg5Ij5jaGFuZ2UgNDQ1NTg5PC9hPi4gVG8gdW5zdWJzY3Jp
YmUsIG9yIGZvciBoZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRw
czovL3Jldmlldy5nZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBp
dGVtc2NvcGUgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBp
dGVtc2NvcGUgaXRlbXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1Zp
ZXdBY3Rpb24iPjxsaW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJp
dGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDU1ODkiLz48bWV0YSBp
dGVtcHJvcD0ibmFtZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYg
c3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNw
X25ldC1uZXh0IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNo
OiBzY3JpcHRzIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdl
LUlkOiBJNmQyMzY4NDdhODRlNTUyOTU4Mzk4ZjBmM2Y1OTFkYzQ1Zjc3ZGQ0NSA8L2Rpdj4KPGRp
diBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1OdW1iZXI6IDQ0NTU4OSA8L2Rp
dj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8
ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6IE1hdHRoaWV1IEJhZXJ0cyAm
bHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRp
c3BsYXk6bm9uZSI+IEdlcnJpdC1SZXZpZXdlcjogTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3Lmou
bWFydGluZWF1QGxpbnV4LmludGVsLmNvbSZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6
bm9uZSI+IEdlcnJpdC1NZXNzYWdlVHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============5460511248134384870==--
