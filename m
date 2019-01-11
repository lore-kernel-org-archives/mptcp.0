Content-Type: multipart/mixed; boundary="===============1129186990172357687=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: sync
 net-next with upstream
Date: Fri, 11 Jan 2019 13:25:26 +0000
Message-ID: <gerrit.1547213126000.I60de106b77de4d8f06524edf051c2f83f936d578@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 974

--===============1129186990172357687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/440037


Change subject: ci:upd-tg: sync net-next with upstream
......................................................................

ci:upd-tg: sync net-next with upstream

Upstream is here Davem's net-next.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I60de106b77de4d8f06524edf051c2f83f936d578
---
M ci/update-tg-tree.sh
1 file changed, 32 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/37/440037/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/440037
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I60de106b77de4d8f06524edf051c2f83f936d578
Gerrit-Change-Number: 440037
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============1129186990172357687==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDAwMzciPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiBzeW5jIG5ldC1uZXh0IHdpdGggdXBzdHJlYW08
YnI+PGJyPlVwc3RyZWFtIGlzIGhlcmUgRGF2ZW0mIzM5O3MgbmV0LW5leHQuPGJyPjxicj5TaWdu
ZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5u
ZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTYwZGUxMDZiNzdkZTRkOGYwNjUyNGVkZjA1MWMyZjgzZjkz
NmQ1Nzg8YnI+LS0tPGJyPk0gY2kvdXBkYXRlLXRnLXRyZWUuc2g8YnI+MSBmaWxlIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxl
PSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFw
OyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNw
L21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy8zNy80NDAwMzcvMTwvcHJlPjxwPlRvIHZpZXcs
IHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10
Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDAwMzciPmNoYW5nZSA0NDAwMzc8L2E+LiBUbyB1bnN1YnNj
cmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0
dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2
IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2
IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcv
Vmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vy
cml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0MDAzNyIvPjxtZXRh
IGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRp
diBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0
Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFu
Y2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFu
Z2UtSWQ6IEk2MGRlMTA2Yjc3ZGU0ZDhmMDY1MjRlZGYwNTFjMmY4M2Y5MzZkNTc4IDwvZGl2Pgo8
ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDQwMDM3IDwv
ZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+
CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRz
ICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0i
ZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============1129186990172357687==--
