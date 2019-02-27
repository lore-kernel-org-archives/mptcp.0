Content-Type: multipart/mixed; boundary="===============0059984749800012037=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: mptcp: add and use
 mptcp_subflow_hold
Date: Wed, 27 Feb 2019 23:31:45 +0000
Message-ID: <gerrit.1551310280000.I568fb486b0003cf2a05933f36413d3270013050a@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1018

--===============0059984749800012037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/446473


Change subject: mptcp: add and use mptcp_subflow_hold
......................................................................

mptcp: add and use mptcp_subflow_hold

subflow sockets already have lifetime managed by RCU, so we can
switch to atomic_inc_not_zero and skip/pretend we did not find
such socket in the mptcp subflow list.

This is required to get rid of synchronize_rcu() from mptcp_close().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Change-Id: I568fb486b0003cf2a05933f36413d3270013050a
---
M net/mptcp/protocol.c
1 file changed, 67 insertions(+), 38 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/73/446473/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446473
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: I568fb486b0003cf2a05933f36413d3270013050a
Gerrit-Change-Number: 446473
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============0059984749800012037==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ2NDczIj5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPm1wdGNwOiBhZGQgYW5kIHVzZSBtcHRjcF9zdWJmbG93X2hvbGQ8YnI+
PGJyPnN1YmZsb3cgc29ja2V0cyBhbHJlYWR5IGhhdmUgbGlmZXRpbWUgbWFuYWdlZCBieSBSQ1Us
IHNvIHdlIGNhbjxicj5zd2l0Y2ggdG8gYXRvbWljX2luY19ub3RfemVybyBhbmQgc2tpcC9wcmV0
ZW5kIHdlIGRpZCBub3QgZmluZDxicj5zdWNoIHNvY2tldCBpbiB0aGUgbXB0Y3Agc3ViZmxvdyBs
aXN0Ljxicj48YnI+VGhpcyBpcyByZXF1aXJlZCB0byBnZXQgcmlkIG9mIHN5bmNocm9uaXplX3Jj
dSgpIGZyb20gbXB0Y3BfY2xvc2UoKS48YnI+PGJyPlNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gV2Vz
dHBoYWwgJmx0O2Z3QHN0cmxlbi5kZSZndDs8YnI+Q2hhbmdlLUlkOiBJNTY4ZmI0ODZiMDAwM2Nm
MmEwNTkzM2YzNjQxM2QzMjcwMDEzMDUwYTxicj4tLS08YnI+TSBuZXQvbXB0Y3AvcHJvdG9jb2wu
Yzxicj4xIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pPGJy
Pjxicj48L3ByZT48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFjZTsg
d2hpdGUtc3BhY2U6IHByZS13cmFwOyI+Z2l0IHB1bGwgc3NoOi8vcmV2aWV3LmdlcnJpdGh1Yi5p
bzoyOTQxOC9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IHJlZnMvY2hhbmdlcy83My80NDY0
NzMvMTwvcHJlPjxwPlRvIHZpZXcsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJp
dGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDY0NzMiPmNoYW5nZSA0
NDY0NzM8L2E+LiBUbyB1bnN1YnNjcmliZSwgb3IgZm9yIGhlbHAgd3JpdGluZyBtYWlsIGZpbHRl
cnMsIHZpc2l0IDxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9zZXR0aW5ncyI+
c2V0dGluZ3M8L2E+LjwvcD48ZGl2IGl0ZW1zY29wZSBpdGVtdHlwZT0iaHR0cDovL3NjaGVtYS5v
cmcvRW1haWxNZXNzYWdlIj48ZGl2IGl0ZW1zY29wZSBpdGVtcHJvcD0iYWN0aW9uIiBpdGVtdHlw
ZT0iaHR0cDovL3NjaGVtYS5vcmcvVmlld0FjdGlvbiI+PGxpbmsgaXRlbXByb3A9InVybCIgaHJl
Zj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQt
bmV4dC8rLzQ0NjQ3MyIvPjxtZXRhIGl0ZW1wcm9wPSJuYW1lIiBjb250ZW50PSJWaWV3IENoYW5n
ZSIvPjwvZGl2PjwvZGl2PgoKPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVByb2pl
Y3Q6IG11bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3Bs
YXk6bm9uZSI+IEdlcnJpdC1CcmFuY2g6IHQvdXBzdHJlYW0gPC9kaXY+CjxkaXYgc3R5bGU9ImRp
c3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtSWQ6IEk1NjhmYjQ4NmIwMDAzY2YyYTA1OTMzZjM2
NDEzZDMyNzAwMTMwNTBhIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQt
Q2hhbmdlLU51bWJlcjogNDQ2NDczIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBH
ZXJyaXQtUGF0Y2hTZXQ6IDEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1Pd25lcjogTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3LmoubWFydGluZWF1QGxpbnV4LmludGVs
LmNvbSZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1NZXNzYWdl
VHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============0059984749800012037==--
