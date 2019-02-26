Content-Type: multipart/mixed; boundary="===============7601474942179328413=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: update
 kconfig with scripts/config
Date: Tue, 26 Feb 2019 16:01:53 +0000
Message-ID: <gerrit.1551196912000.I392af31cb71642007da087d83552a97274fc25d6@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1014

--===============7601474942179328413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/446295


Change subject: ci:upd-tg: update kconfig with scripts/config
......................................................................

ci:upd-tg: update kconfig with scripts/config

Cleaner than appending the .config file.

Also added a note why 'make olddefconfig' is not used.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I392af31cb71642007da087d83552a97274fc25d6
---
M ci/update-tg-tree.sh
1 file changed, 4 insertions(+), 3 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/95/446295/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446295
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I392af31cb71642007da087d83552a97274fc25d6
Gerrit-Change-Number: 446295
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============7601474942179328413==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTUiPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiB1cGRhdGUga2NvbmZpZyB3aXRoIHNjcmlwdHMv
Y29uZmlnPGJyPjxicj5DbGVhbmVyIHRoYW4gYXBwZW5kaW5nIHRoZSAuY29uZmlnIGZpbGUuPGJy
Pjxicj5BbHNvIGFkZGVkIGEgbm90ZSB3aHkgJiMzOTttYWtlIG9sZGRlZmNvbmZpZyYjMzk7IGlz
IG5vdCB1c2VkLjxicj48YnI+U2lnbmVkLW9mZi1ieTogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0
aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5DaGFuZ2UtSWQ6IEkzOTJhZjMxY2I3MTY0
MjAwN2RhMDg3ZDgzNTUyYTk3Mjc0ZmMyNWQ2PGJyPi0tLTxicj5NIGNpL3VwZGF0ZS10Zy10cmVl
LnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pPGJy
Pjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsg
d2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
bzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy85NS80NDYy
OTUvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJp
dGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTUiPmNoYW5nZSA0
NDYyOTU8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRl
cnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+
c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5v
cmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlw
ZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJl
Zj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQt
bmV4dC8rLzQ0NjI5NSIvPjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5n
ZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2pl
Y3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3Bs
YXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3Bs
YXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEkzOTJhZjMxY2I3MTY0MjAwN2RhMDg3ZDgzNTUy
YTk3Mjc0ZmMyNWQ2IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hh
bmdlLU51bWJlcjogNDQ2Mjk1IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJy
aXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1P
d25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0
OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBu
ZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============7601474942179328413==--
