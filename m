Content-Type: multipart/mixed; boundary="===============8950264368917506621=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: reset the TG
 changes in case of error
Date: Wed, 20 Feb 2019 13:56:54 +0000
Message-ID: <gerrit.1550671010000.I3d6c197a0032be1e1455c71379053a4f9389dbe5@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1003

--===============8950264368917506621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445587

to review the following change.


Change subject: ci:upd-tg: reset the TG changes in case of error
......................................................................

ci:upd-tg: reset the TG changes in case of error

It will be interesting to do that in case of error during the validation
or when updating the tree.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I3d6c197a0032be1e1455c71379053a4f9389dbe5
---
M ci/update-tg-tree.sh
1 file changed, 28 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/87/445587/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445587
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I3d6c197a0032be1e1455c71379053a4f9389dbe5
Gerrit-Change-Number: 445587
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============8950264368917506621==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU4NyI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHJlc2V0IHRoZSBURyBjaGFu
Z2VzIGluIGNhc2Ugb2YgZXJyb3I8YnI+PGJyPkl0IHdpbGwgYmUgaW50ZXJlc3RpbmcgdG8gZG8g
dGhhdCBpbiBjYXNlIG9mIGVycm9yIGR1cmluZyB0aGUgdmFsaWRhdGlvbjxicj5vciB3aGVuIHVw
ZGF0aW5nIHRoZSB0cmVlLjxicj48YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZs
dDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IEkzZDZjMTk3
YTAwMzJiZTFlMTQ1NWM3MTM3OTA1M2E0ZjkzODlkYmU1PGJyPi0tLTxicj5NIGNpL3VwZGF0ZS10
Zy10cmVlLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25v
c3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBwdWxsIHNzaDovL3Jldmlldy5nZXJy
aXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCByZWZzL2NoYW5nZXMv
ODcvNDQ1NTg3LzE8L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmll
dy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ1NTg3Ij5j
aGFuZ2UgNDQ1NTg3PC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9yIGZvciBoZWxwIHdyaXRpbmcgbWFp
bCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vc2V0
dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBpdGVtc2NvcGUgaXRlbXR5cGU9Imh0dHA6Ly9z
Y2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBpdGVtc2NvcGUgaXRlbXByb3A9ImFjdGlvbiIg
aXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rpb24iPjxsaW5rIGl0ZW1wcm9wPSJ1
cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0
Y3BfbmV0LW5leHQvKy80NDU1ODciLz48bWV0YSBpdGVtcHJvcD0ibmFtZSIgY29udGVudD0iVmll
dyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNoOiBzY3JpcHRzIDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJM2Q2YzE5N2EwMDMyYmUxZTE0NTVj
NzEzNzkwNTNhNGY5Mzg5ZGJlNSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vy
cml0LUNoYW5nZS1OdW1iZXI6IDQ0NTU4NyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBH
ZXJyaXQtT3duZXI6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVz
Lm5ldCZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1SZXZpZXdl
cjogTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVsLmNvbSZn
dDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1NZXNzYWdlVHlwZTog
bmV3Y2hhbmdlIDwvZGl2PgoK

--===============8950264368917506621==--
