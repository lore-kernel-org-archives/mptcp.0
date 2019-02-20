Content-Type: multipart/mixed; boundary="===============4035231307183046823=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: stop if no
 update from upstream
Date: Wed, 20 Feb 2019 13:57:00 +0000
Message-ID: <gerrit.1550671010000.Ic34ea0e8c9cff2c519eef8d4b439b0b459b0f119@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1007

--===============4035231307183046823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445591

to review the following change.


Change subject: ci:upd-tg: stop if no update from upstream
......................................................................

ci:upd-tg: stop if no update from upstream

Just not to do a validation for nothing.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: Ic34ea0e8c9cff2c519eef8d4b439b0b459b0f119
---
M ci/update-tg-tree.sh
1 file changed, 12 insertions(+), 1 deletion(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/91/445591/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445591
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: Ic34ea0e8c9cff2c519eef8d4b439b0b459b0f119
Gerrit-Change-Number: 445591
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============4035231307183046823==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU5MSI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHN0b3AgaWYgbm8gdXBkYXRl
IGZyb20gdXBzdHJlYW08YnI+PGJyPkp1c3Qgbm90IHRvIGRvIGEgdmFsaWRhdGlvbiBmb3Igbm90
aGluZy48YnI+PGJyPlNpZ25lZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUu
YmFlcnRzQHRlc3NhcmVzLm5ldCZndDs8YnI+Q2hhbmdlLUlkOiBJYzM0ZWEwZThjOWNmZjJjNTE5
ZWVmOGQ0YjQzOWIwYjQ1OWIwZjExOTxicj4tLS08YnI+TSBjaS91cGRhdGUtdGctdHJlZS5zaDxi
cj4xIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKTxicj48YnI+
PC9wcmU+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRl
LXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBwdWxsIHNzaDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0
MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCByZWZzL2NoYW5nZXMvOTEvNDQ1NTkxLzE8
L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIu
aW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ1NTkxIj5jaGFuZ2UgNDQ1NTkx
PC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9yIGZvciBoZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2
aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRp
bmdzPC9hPi48L3A+PGRpdiBpdGVtc2NvcGUgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0Vt
YWlsTWVzc2FnZSI+PGRpdiBpdGVtc2NvcGUgaXRlbXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0
dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rpb24iPjxsaW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0
dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQv
Ky80NDU1OTEiLz48bWV0YSBpdGVtcHJvcD0ibmFtZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48
L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBt
dWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5v
bmUiPiBHZXJyaXQtQnJhbmNoOiBzY3JpcHRzIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5v
bmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJYzM0ZWEwZThjOWNmZjJjNTE5ZWVmOGQ0YjQzOWIwYjQ1
OWIwZjExOSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1O
dW1iZXI6IDQ0NTU5MSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBh
dGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6
IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCZndDsgPC9k
aXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1SZXZpZXdlcjogTWF0IE1hcnRp
bmVhdSAmbHQ7bWF0aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbSZndDsgPC9kaXY+Cjxk
aXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1NZXNzYWdlVHlwZTogbmV3Y2hhbmdlIDwv
ZGl2PgoK

--===============4035231307183046823==--
