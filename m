Content-Type: multipart/mixed; boundary="===============2415410530537585084=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: for TG to
 use refs/top-bases
Date: Tue, 26 Feb 2019 16:01:52 +0000
Message-ID: <gerrit.1551196912000.I6bb61ee898228204eab8a1bc2072b58ba065d46c@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1013

--===============2415410530537585084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/446294


Change subject: ci:upd-tg: for TG to use refs/top-bases
......................................................................

ci:upd-tg: for TG to use refs/top-bases

From: https://github.com/mackyle/topgit#tg-migrate-bases

> Beginning with TopGit release 0.19.4, TopGit has the ability to store
> the top-bases refs in either the old ref/top-bases/... location or the
> new refs/heads/{top-bases}/... location. Starting with TopGit release
> 0.20.0, the default is the new location.

We force the 'old' location because Gerrit is configured for a use with
these refs and in the script, we also use refs/top-bases.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Change-Id: I6bb61ee898228204eab8a1bc2072b58ba065d46c
---
M ci/update-tg-tree.sh
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/94/446294/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446294
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I6bb61ee898228204eab8a1bc2072b58ba065d46c
Gerrit-Change-Number: 446294
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============2415410530537585084==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTQiPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiBmb3IgVEcgdG8gdXNlIHJlZnMvdG9wLWJhc2Vz
PGJyPjxicj5Gcm9tOiBodHRwczovL2dpdGh1Yi5jb20vbWFja3lsZS90b3BnaXQjdGctbWlncmF0
ZS1iYXNlczxicj48YnI+Jmd0OyBCZWdpbm5pbmcgd2l0aCBUb3BHaXQgcmVsZWFzZSAwLjE5LjQs
IFRvcEdpdCBoYXMgdGhlIGFiaWxpdHkgdG8gc3RvcmU8YnI+Jmd0OyB0aGUgdG9wLWJhc2VzIHJl
ZnMgaW4gZWl0aGVyIHRoZSBvbGQgcmVmL3RvcC1iYXNlcy8uLi4gbG9jYXRpb24gb3IgdGhlPGJy
PiZndDsgbmV3IHJlZnMvaGVhZHMve3RvcC1iYXNlc30vLi4uIGxvY2F0aW9uLiBTdGFydGluZyB3
aXRoIFRvcEdpdCByZWxlYXNlPGJyPiZndDsgMC4yMC4wLCB0aGUgZGVmYXVsdCBpcyB0aGUgbmV3
IGxvY2F0aW9uLjxicj48YnI+V2UgZm9yY2UgdGhlICYjMzk7b2xkJiMzOTsgbG9jYXRpb24gYmVj
YXVzZSBHZXJyaXQgaXMgY29uZmlndXJlZCBmb3IgYSB1c2Ugd2l0aDxicj50aGVzZSByZWZzIGFu
ZCBpbiB0aGUgc2NyaXB0LCB3ZSBhbHNvIHVzZSByZWZzL3RvcC1iYXNlcy48YnI+PGJyPlNpZ25l
ZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5l
dCZndDs8YnI+U3VnZ2VzdGVkLWJ5OiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5l
YXVAbGludXguaW50ZWwuY29tJmd0Ozxicj5DaGFuZ2UtSWQ6IEk2YmI2MWVlODk4MjI4MjA0ZWFi
OGExYmMyMDcyYjU4YmEwNjVkNDZjPGJyPi0tLTxicj5NIGNpL3VwZGF0ZS10Zy10cmVlLnNoPGJy
PjEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj48
L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQx
OC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy85NC80NDYyOTQvMTwv
cHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDYyOTQiPmNoYW5nZSA0NDYyOTQ8
L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZp
c2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGlu
Z3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1h
aWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0
cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0
cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8r
LzQ0NjI5NCIvPjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwv
ZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11
bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9u
ZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9u
ZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEk2YmI2MWVlODk4MjI4MjA0ZWFiOGExYmMyMDcyYjU4YmEw
NjVkNDZjIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51
bWJlcjogNDQ2Mjk0IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0
Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjog
TWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rp
dj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFu
Z2UgPC9kaXY+Cgo=

--===============2415410530537585084==--
