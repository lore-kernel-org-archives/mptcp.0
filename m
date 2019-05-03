Content-Type: multipart/mixed; boundary="===============7385481732589698737=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: also check
 without CONFIG_MPTCP
Date: Fri, 03 May 2019 14:43:58 +0000
Message-ID: <gerrit.1556894636000.I0fe952c535f84c807a8ee9b665a638b0ee874c9b@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1113

--===============7385481732589698737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/452987


Change subject: ci:upd-tg: also check without CONFIG_MPTCP
......................................................................

ci:upd-tg: also check without CONFIG_MPTCP

We should continue to be able to compile without CONFIG_MPTCP.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I0fe952c535f84c807a8ee9b665a638b0ee874c9b
---
M ci/update-tg-tree.sh
1 file changed, 14 insertions(+), 3 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/87/452987/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/452987
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I0fe952c535f84c807a8ee9b665a638b0ee874c9b
Gerrit-Change-Number: 452987
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============7385481732589698737==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NTI5ODciPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiBhbHNvIGNoZWNrIHdpdGhvdXQgQ09ORklHX01Q
VENQPGJyPjxicj5XZSBzaG91bGQgY29udGludWUgdG8gYmUgYWJsZSB0byBjb21waWxlIHdpdGhv
dXQgQ09ORklHX01QVENQLjxicj48YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZs
dDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IEkwZmU5NTJj
NTM1Zjg0YzgwN2E4ZWU5YjY2NWE2MzhiMGVlODc0YzliPGJyPi0tLTxicj5NIGNpL3VwZGF0ZS10
Zy10cmVlLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25v
c3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBwdWxsIHNzaDovL3Jldmlldy5nZXJy
aXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCByZWZzL2NoYW5nZXMv
ODcvNDUyOTg3LzE8L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmll
dy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUyOTg3Ij5j
aGFuZ2UgNDUyOTg3PC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9yIGZvciBoZWxwIHdyaXRpbmcgbWFp
bCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vc2V0
dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBpdGVtc2NvcGUgaXRlbXR5cGU9Imh0dHA6Ly9z
Y2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBpdGVtc2NvcGUgaXRlbXByb3A9ImFjdGlvbiIg
aXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rpb24iPjxsaW5rIGl0ZW1wcm9wPSJ1
cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0
Y3BfbmV0LW5leHQvKy80NTI5ODciLz48bWV0YSBpdGVtcHJvcD0ibmFtZSIgY29udGVudD0iVmll
dyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNoOiBzY3JpcHRzIDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJMGZlOTUyYzUzNWY4NGM4MDdhOGVl
OWI2NjVhNjM4YjBlZTg3NGM5YiA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vy
cml0LUNoYW5nZS1OdW1iZXI6IDQ1Mjk4NyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBH
ZXJyaXQtT3duZXI6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVz
Lm5ldCZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1NZXNzYWdl
VHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============7385481732589698737==--
