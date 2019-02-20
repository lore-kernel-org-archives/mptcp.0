Content-Type: multipart/mixed; boundary="===============2134228281824788823=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: update the
 TopGit tree
Date: Wed, 20 Feb 2019 13:56:56 +0000
Message-ID: <gerrit.1550671010000.I5926aad6ff2d81d8add6047a849474c9d0c876fb@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1004

--===============2134228281824788823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445588

to review the following change.


Change subject: ci:upd-tg: update the TopGit tree
......................................................................

ci:upd-tg: update the TopGit tree

If the update and the validation are successful, the update are pushed
to the remote repo. If not, the changes are reverted and the script exit
with an error.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I5926aad6ff2d81d8add6047a849474c9d0c876fb
---
M ci/update-tg-tree.sh
1 file changed, 38 insertions(+), 2 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/88/445588/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445588
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I5926aad6ff2d81d8add6047a849474c9d0c876fb
Gerrit-Change-Number: 445588
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============2134228281824788823==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU4OCI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHVwZGF0ZSB0aGUgVG9wR2l0
IHRyZWU8YnI+PGJyPklmIHRoZSB1cGRhdGUgYW5kIHRoZSB2YWxpZGF0aW9uIGFyZSBzdWNjZXNz
ZnVsLCB0aGUgdXBkYXRlIGFyZSBwdXNoZWQ8YnI+dG8gdGhlIHJlbW90ZSByZXBvLiBJZiBub3Qs
IHRoZSBjaGFuZ2VzIGFyZSByZXZlcnRlZCBhbmQgdGhlIHNjcmlwdCBleGl0PGJyPndpdGggYW4g
ZXJyb3IuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1
LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTU5MjZhYWQ2ZmYyZDgxZDhh
ZGQ2MDQ3YTg0OTQ3NGM5ZDBjODc2ZmI8YnI+LS0tPGJyPk0gY2kvdXBkYXRlLXRnLXRyZWUuc2g8
YnI+MSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJyPjxi
cj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hp
dGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5pbzoy
OTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy84OC80NDU1ODgv
MTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1
Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDU1ODgiPmNoYW5nZSA0NDU1
ODg8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRlcnMs
IHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+c2V0
dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5vcmcv
RW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlwZT0i
aHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJlZj0i
aHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4
dC8rLzQ0NTU4OCIvPjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5nZSIv
PjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2plY3Q6
IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6
bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHNjcmlwdHMgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6
bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEk1OTI2YWFkNmZmMmQ4MWQ4YWRkNjA0N2E4NDk0NzRj
OWQwYzg3NmZiIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdl
LU51bWJlcjogNDQ1NTg4IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQt
UGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Pd25l
cjogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0OyA8
L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVJldmlld2VyOiBNYXQgTWFy
dGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4K
PGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2Ug
PC9kaXY+Cgo=

--===============2134228281824788823==--
