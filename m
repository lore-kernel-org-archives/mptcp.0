Content-Type: multipart/mixed; boundary="===============5967429456445575484=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: avoid 'tg
 push' 'up-to-date' error
Date: Fri, 31 May 2019 11:15:53 +0000
Message-ID: <gerrit.1559301351000.Ib142a511c240fba2df5f8ec2f0c9ed3f3c86dfa0@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1270

--===============5967429456445575484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456463

to review the following change.


Change subject: ci:upd-tg: avoid 'tg push' 'up-to-date' error
......................................................................

ci:upd-tg: avoid 'tg push' 'up-to-date' error

When syncing, if our TopGit tree has been updated by someone and there
is also a new update of the base, we will need to launch 'tg update'
twice: once to be sync with our repo, another one to propagate the
modification made in the base to the rest of the tree.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: Ib142a511c240fba2df5f8ec2f0c9ed3f3c86dfa0
---
M ci/update-tg-tree.sh
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/63/456463/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456463
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: Ib142a511c240fba2df5f8ec2f0c9ed3f3c86dfa0
Gerrit-Change-Number: 456463
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============5967429456445575484==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjQ2MyI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IGF2b2lkICYjMzk7dGcgcHVz
aCYjMzk7ICYjMzk7dXAtdG8tZGF0ZSYjMzk7IGVycm9yPGJyPjxicj5XaGVuIHN5bmNpbmcsIGlm
IG91ciBUb3BHaXQgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJ5IHNvbWVvbmUgYW5kIHRoZXJlPGJy
PmlzIGFsc28gYSBuZXcgdXBkYXRlIG9mIHRoZSBiYXNlLCB3ZSB3aWxsIG5lZWQgdG8gbGF1bmNo
ICYjMzk7dGcgdXBkYXRlJiMzOTs8YnI+dHdpY2U6IG9uY2UgdG8gYmUgc3luYyB3aXRoIG91ciBy
ZXBvLCBhbm90aGVyIG9uZSB0byBwcm9wYWdhdGUgdGhlPGJyPm1vZGlmaWNhdGlvbiBtYWRlIGlu
IHRoZSBiYXNlIHRvIHRoZSByZXN0IG9mIHRoZSB0cmVlLjxicj48YnI+U2lnbmVkLW9mZi1ieTog
TWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxicj5D
aGFuZ2UtSWQ6IEliMTQyYTUxMWMyNDBmYmEyZGY1ZjhlYzJmMGM5ZWQzZjNjODZkZmEwPGJyPi0t
LTxicj5NIGNpL3VwZGF0ZS10Zy10cmVlLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pPGJyPjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWls
eTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwg
c3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0IHJlZnMvY2hhbmdlcy82My80NTY0NjMvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhy
ZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0
LW5leHQvKy80NTY0NjMiPmNoYW5nZSA0NTY0NjM8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9y
IGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3
LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBp
dGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBp
dGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+
PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2Mv
bXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjQ2MyIvPjxtZXRhIGl0ZW1wcm9wPSJu
YW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlz
cGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEliMTQy
YTUxMWMyNDBmYmEyZGY1ZjhlYzJmMGM5ZWQzZjNjODZkZmEwIDwvZGl2Pgo8ZGl2IHN0eWxlPSJk
aXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLU51bWJlcjogNDU2NDYzIDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9
ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25lcjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGll
dS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LVJldmlld2VyOiBNYXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVA
bGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vy
cml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============5967429456445575484==--
