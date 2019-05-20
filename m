Content-Type: multipart/mixed; boundary="===============8725761921846354197=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: tag export
 branch with date
Date: Mon, 20 May 2019 08:37:13 +0000
Message-ID: <gerrit.1558341430000.I172661673bb515687c07471289a857f80e06b0c1@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1198

--===============8725761921846354197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/455063

to review the following change.


Change subject: ci:upd-tg: tag export branch with date
......................................................................

ci:upd-tg: tag export branch with date

We might have references to commits from this 'export' branch. But this
branch is regularly rebuilt. Git GC would them remove these old
references.

Adding a tag force Github (and other clones) to keep these references.
All these tags will be like this:

    export/<date>

Note that if working from 'export' is an issue for you because it forces
you to use 'git rebase --onto', you can also work on top of 'for-review'
branch: the code will be the same, the git history will not be rewritten
for this branch.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Change-Id: I172661673bb515687c07471289a857f80e06b0c1
---
M ci/update-tg-tree.sh
1 file changed, 8 insertions(+), 1 deletion(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/63/455063/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/455063
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I172661673bb515687c07471289a857f80e06b0c1
Gerrit-Change-Number: 455063
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============8725761921846354197==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NTA2MyI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHRhZyBleHBvcnQgYnJhbmNo
IHdpdGggZGF0ZTxicj48YnI+V2UgbWlnaHQgaGF2ZSByZWZlcmVuY2VzIHRvIGNvbW1pdHMgZnJv
bSB0aGlzICYjMzk7ZXhwb3J0JiMzOTsgYnJhbmNoLiBCdXQgdGhpczxicj5icmFuY2ggaXMgcmVn
dWxhcmx5IHJlYnVpbHQuIEdpdCBHQyB3b3VsZCB0aGVtIHJlbW92ZSB0aGVzZSBvbGQ8YnI+cmVm
ZXJlbmNlcy48YnI+PGJyPkFkZGluZyBhIHRhZyBmb3JjZSBHaXRodWIgKGFuZCBvdGhlciBjbG9u
ZXMpIHRvIGtlZXAgdGhlc2UgcmVmZXJlbmNlcy48YnI+QWxsIHRoZXNlIHRhZ3Mgd2lsbCBiZSBs
aWtlIHRoaXM6PGJyPjxicj4gICAgZXhwb3J0LyZsdDtkYXRlJmd0Ozxicj48YnI+Tm90ZSB0aGF0
IGlmIHdvcmtpbmcgZnJvbSAmIzM5O2V4cG9ydCYjMzk7IGlzIGFuIGlzc3VlIGZvciB5b3UgYmVj
YXVzZSBpdCBmb3JjZXM8YnI+eW91IHRvIHVzZSAmIzM5O2dpdCByZWJhc2UgLS1vbnRvJiMzOTss
IHlvdSBjYW4gYWxzbyB3b3JrIG9uIHRvcCBvZiAmIzM5O2Zvci1yZXZpZXcmIzM5Ozxicj5icmFu
Y2g6IHRoZSBjb2RlIHdpbGwgYmUgdGhlIHNhbWUsIHRoZSBnaXQgaGlzdG9yeSB3aWxsIG5vdCBi
ZSByZXdyaXR0ZW48YnI+Zm9yIHRoaXMgYnJhbmNoLjxicj48YnI+U2lnbmVkLW9mZi1ieTogTWF0
dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5TdWdn
ZXN0ZWQtYnk6IE1hdCBNYXJ0aW5lYXUgJmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRl
bC5jb20mZ3Q7PGJyPkNoYW5nZS1JZDogSTE3MjY2MTY3M2JiNTE1Njg3YzA3NDcxMjg5YTg1N2Y4
MGUwNmIwYzE8YnI+LS0tPGJyPk0gY2kvdXBkYXRlLXRnLXRyZWUuc2g8YnI+MSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKTxicj48YnI+PC9wcmU+PHByZSBzdHls
ZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3Jh
cDsiPmdpdCBwdWxsIHNzaDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRj
cC9tcHRjcF9uZXQtbmV4dCByZWZzL2NoYW5nZXMvNjMvNDU1MDYzLzE8L3ByZT48cD5UbyB2aWV3
LCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgt
dGNwL21wdGNwX25ldC1uZXh0LysvNDU1MDYzIj5jaGFuZ2UgNDU1MDYzPC9hPi4gVG8gdW5zdWJz
Y3JpYmUsIG9yIGZvciBoZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJo
dHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRp
diBpdGVtc2NvcGUgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRp
diBpdGVtc2NvcGUgaXRlbXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3Jn
L1ZpZXdBY3Rpb24iPjxsaW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3Lmdl
cnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NTUwNjMiLz48bWV0
YSBpdGVtcHJvcD0ibmFtZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxk
aXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21w
dGNwX25ldC1uZXh0IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJh
bmNoOiBzY3JpcHRzIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hh
bmdlLUlkOiBJMTcyNjYxNjczYmI1MTU2ODdjMDc0NzEyODlhODU3ZjgwZTA2YjBjMSA8L2Rpdj4K
PGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1OdW1iZXI6IDQ1NTA2MyA8
L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2
Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6IE1hdHRoaWV1IEJhZXJ0
cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCZndDsgPC9kaXY+CjxkaXYgc3R5bGU9
ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1SZXZpZXdlcjogTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3
LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbSZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3Bs
YXk6bm9uZSI+IEdlcnJpdC1NZXNzYWdlVHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============8725761921846354197==--
