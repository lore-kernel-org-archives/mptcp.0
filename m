Content-Type: multipart/mixed; boundary="===============6545095291160143993=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: allow to
 force a sync
Date: Tue, 26 Feb 2019 16:01:54 +0000
Message-ID: <gerrit.1551196912000.I2d881336e7abaab068871a990491740c69dc828a@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1015

--===============6545095291160143993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/446296


Change subject: ci:upd-tg: allow to force a sync
......................................................................

ci:upd-tg: allow to force a sync

Only for debugging purpose, not to stop if there is no net-next update.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I2d881336e7abaab068871a990491740c69dc828a
---
M ci/Dockerfile.update-tg-tree.sh
M ci/update-tg-tree.sh
2 files changed, 3 insertions(+), 1 deletion(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/96/446296/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446296
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I2d881336e7abaab068871a990491740c69dc828a
Gerrit-Change-Number: 446296
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============6545095291160143993==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTYiPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiBhbGxvdyB0byBmb3JjZSBhIHN5bmM8YnI+PGJy
Pk9ubHkgZm9yIGRlYnVnZ2luZyBwdXJwb3NlLCBub3QgdG8gc3RvcCBpZiB0aGVyZSBpcyBubyBu
ZXQtbmV4dCB1cGRhdGUuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0
O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTJkODgxMzM2
ZTdhYmFhYjA2ODg3MWE5OTA0OTE3NDBjNjlkYzgyOGE8YnI+LS0tPGJyPk0gY2kvRG9ja2VyZmls
ZS51cGRhdGUtdGctdHJlZS5zaDxicj5NIGNpL3VwZGF0ZS10Zy10cmVlLnNoPGJyPjIgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPGJyPjxicj48L3ByZT48cHJl
IHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHBy
ZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBh
dGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy85Ni80NDYyOTYvMTwvcHJlPjxwPlRv
IHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRp
cGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTYiPmNoYW5nZSA0NDYyOTY8L2E+LiBUbyB1
bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhy
ZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+Ljwv
cD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdl
Ij48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVt
YS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZp
ZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NjI5NiIv
PjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2
PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10
Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1CcmFuY2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1DaGFuZ2UtSWQ6IEkyZDg4MTMzNmU3YWJhYWIwNjg4NzFhOTkwNDkxNzQwYzY5ZGM4MjhhIDwv
ZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDQ2
Mjk2IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUg
QmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBz
dHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+
Cgo=

--===============6545095291160143993==--
