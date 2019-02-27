Content-Type: multipart/mixed; boundary="===============8684267095803431419=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: update
 'for-review' branch
Date: Wed, 27 Feb 2019 17:31:35 +0000
Message-ID: <gerrit.1551288695000.Ieaedba4c703e6c374015afef876ad53d7cb561d9@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1017

--===============8684267095803431419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts has uploaded this change for review. ( https://review.gerri=
thub.io/c/multipath-tcp/mptcp_net-next/+/446449


Change subject: ci:upd-tg: update 'for-review' branch
......................................................................

ci:upd-tg: update 'for-review' branch

If you use TopGit internally to manage your different commits you want
to integrate on top of other MPTCP changes (on top of t/upstream or
export), you can now base your tree on top of 'for-review' branch (you
can also use it as target for 'git-review' or keep 't/upstream', that
will be the same from a Gerrit point of view): this new branch
'for-review' is like 't/upstream' (top of the tree) but without TopGit
files: Gerrit will see when changes are integrated in the tree (not like
'export') because Change-Id are preserved and mark changes as merged
automatically when it is in the tree. Also with this new branch, you
don't have any .top* files on this branch.

In other words, use this branch as base and target for new changes.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: Ieaedba4c703e6c374015afef876ad53d7cb561d9
---
M ci/update-tg-tree.sh
1 file changed, 22 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/49/446449/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446449
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: Ieaedba4c703e6c374015afef876ad53d7cb561d9
Gerrit-Change-Number: 446449
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-MessageType: newchange

--===============8684267095803431419==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIGhhcyB1cGxvYWRlZCB0aGlzIGNoYW5nZSBmb3IgPHN0cm9uZz5y
ZXZpZXc8L3N0cm9uZz4uPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDY0NDkiPlZpZXcgQ2hhbmdlPC9h
PjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsgd2hpdGUt
c3BhY2U6IHByZS13cmFwOyI+Y2k6dXBkLXRnOiB1cGRhdGUgJiMzOTtmb3ItcmV2aWV3JiMzOTsg
YnJhbmNoPGJyPjxicj5JZiB5b3UgdXNlIFRvcEdpdCBpbnRlcm5hbGx5IHRvIG1hbmFnZSB5b3Vy
IGRpZmZlcmVudCBjb21taXRzIHlvdSB3YW50PGJyPnRvIGludGVncmF0ZSBvbiB0b3Agb2Ygb3Ro
ZXIgTVBUQ1AgY2hhbmdlcyAob24gdG9wIG9mIHQvdXBzdHJlYW0gb3I8YnI+ZXhwb3J0KSwgeW91
IGNhbiBub3cgYmFzZSB5b3VyIHRyZWUgb24gdG9wIG9mICYjMzk7Zm9yLXJldmlldyYjMzk7IGJy
YW5jaCAoeW91PGJyPmNhbiBhbHNvIHVzZSBpdCBhcyB0YXJnZXQgZm9yICYjMzk7Z2l0LXJldmll
dyYjMzk7IG9yIGtlZXAgJiMzOTt0L3Vwc3RyZWFtJiMzOTssIHRoYXQ8YnI+d2lsbCBiZSB0aGUg
c2FtZSBmcm9tIGEgR2Vycml0IHBvaW50IG9mIHZpZXcpOiB0aGlzIG5ldyBicmFuY2g8YnI+JiMz
OTtmb3ItcmV2aWV3JiMzOTsgaXMgbGlrZSAmIzM5O3QvdXBzdHJlYW0mIzM5OyAodG9wIG9mIHRo
ZSB0cmVlKSBidXQgd2l0aG91dCBUb3BHaXQ8YnI+ZmlsZXM6IEdlcnJpdCB3aWxsIHNlZSB3aGVu
IGNoYW5nZXMgYXJlIGludGVncmF0ZWQgaW4gdGhlIHRyZWUgKG5vdCBsaWtlPGJyPiYjMzk7ZXhw
b3J0JiMzOTspIGJlY2F1c2UgQ2hhbmdlLUlkIGFyZSBwcmVzZXJ2ZWQgYW5kIG1hcmsgY2hhbmdl
cyBhcyBtZXJnZWQ8YnI+YXV0b21hdGljYWxseSB3aGVuIGl0IGlzIGluIHRoZSB0cmVlLiBBbHNv
IHdpdGggdGhpcyBuZXcgYnJhbmNoLCB5b3U8YnI+ZG9uJiMzOTt0IGhhdmUgYW55IC50b3AqIGZp
bGVzIG9uIHRoaXMgYnJhbmNoLjxicj48YnI+SW4gb3RoZXIgd29yZHMsIHVzZSB0aGlzIGJyYW5j
aCBhcyBiYXNlIGFuZCB0YXJnZXQgZm9yIG5ldyBjaGFuZ2VzLjxicj48YnI+U2lnbmVkLW9mZi1i
eTogTWF0dGhpZXUgQmFlcnRzICZsdDttYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Jmd0Ozxi
cj5DaGFuZ2UtSWQ6IEllYWVkYmE0YzcwM2U2YzM3NDAxNWFmZWY4NzZhZDUzZDdjYjU2MWQ5PGJy
Pi0tLTxicj5NIGNpL3VwZGF0ZS10Zy10cmVlLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCAwIGRlbGV0aW9ucygtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0iZm9udC1m
YW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBw
dWxsIHNzaDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9u
ZXQtbmV4dCByZWZzL2NoYW5nZXMvNDkvNDQ2NDQ5LzE8L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8
YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNw
X25ldC1uZXh0LysvNDQ2NDQ5Ij5jaGFuZ2UgNDQ2NDQ5PC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9y
IGZvciBoZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jl
dmlldy5nZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBpdGVtc2Nv
cGUgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBpdGVtc2Nv
cGUgaXRlbXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rp
b24iPjxsaW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
by9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDY0NDkiLz48bWV0YSBpdGVtcHJv
cD0ibmFtZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9
ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNoOiBzY3Jp
cHRzIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJ
ZWFlZGJhNGM3MDNlNmMzNzQwMTVhZmVmODc2YWQ1M2Q3Y2I1NjFkOSA8L2Rpdj4KPGRpdiBzdHls
ZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1OdW1iZXI6IDQ0NjQ0OSA8L2Rpdj4KPGRp
diBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0
dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6
bm9uZSI+IEdlcnJpdC1NZXNzYWdlVHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============8684267095803431419==--
