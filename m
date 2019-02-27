Content-Type: multipart/mixed; boundary="===============2685360788743057151=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: mptcp: add mptcp_poll
Date: Wed, 27 Feb 2019 23:31:44 +0000
Message-ID: <gerrit.1551310280000.Ibf354be7630ecd44d82ff44a9b692e4862120229@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1019

--===============2685360788743057151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/446472


Change subject: mptcp: add mptcp_poll
......................................................................

mptcp: add mptcp_poll

Can't use tcp_poll directly:

BUG: KASAN: slab-out-of-bounds in tcp_poll+0x17f/0x540
Read of size 4 at addr ffff88806ac5e50c by task mptcp_connect/2085
Call Trace:
 tcp_poll+0x17f/0x540
 sock_poll+0x152/0x180

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Change-Id: Ibf354be7630ecd44d82ff44a9b692e4862120229
---
M net/mptcp/protocol.c
1 file changed, 14 insertions(+), 1 deletion(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/72/446472/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446472
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: Ibf354be7630ecd44d82ff44a9b692e4862120229
Gerrit-Change-Number: 446472
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============2685360788743057151==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ2NDcyIj5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPm1wdGNwOiBhZGQgbXB0Y3BfcG9sbDxicj48YnI+Q2FuJiMzOTt0IHVz
ZSB0Y3BfcG9sbCBkaXJlY3RseTo8YnI+PGJyPkJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5k
cyBpbiB0Y3BfcG9sbCsweDE3Zi8weDU0MDxicj5SZWFkIG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4
ODgwNmFjNWU1MGMgYnkgdGFzayBtcHRjcF9jb25uZWN0LzIwODU8YnI+Q2FsbCBUcmFjZTo8YnI+
IHRjcF9wb2xsKzB4MTdmLzB4NTQwPGJyPiBzb2NrX3BvbGwrMHgxNTIvMHgxODA8YnI+PGJyPlNp
Z25lZC1vZmYtYnk6IEZsb3JpYW4gV2VzdHBoYWwgJmx0O2Z3QHN0cmxlbi5kZSZndDs8YnI+Q2hh
bmdlLUlkOiBJYmYzNTRiZTc2MzBlY2Q0NGQ4MmZmNDRhOWI2OTJlNDg2MjEyMDIyOTxicj4tLS08
YnI+TSBuZXQvbXB0Y3AvcHJvdG9jb2wuYzxicj4xIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6
IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBwdWxsIHNz
aDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4
dCByZWZzL2NoYW5nZXMvNzIvNDQ2NDcyLzE8L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8YSBocmVm
PSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0LysvNDQ2NDcyIj5jaGFuZ2UgNDQ2NDcyPC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9yIGZvciBo
ZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmlldy5n
ZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBpdGVtc2NvcGUgaXRl
bXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBpdGVtc2NvcGUgaXRl
bXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rpb24iPjxs
aW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9jL211
bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDY0NzIiLz48bWV0YSBpdGVtcHJvcD0ibmFt
ZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9ImRpc3Bs
YXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0IDwv
ZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNoOiB0L3Vwc3RyZWFt
IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJYmYz
NTRiZTc2MzBlY2Q0NGQ4MmZmNDRhOWI2OTJlNDg2MjEyMDIyOSA8L2Rpdj4KPGRpdiBzdHlsZT0i
ZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1OdW1iZXI6IDQ0NjQ3MiA8L2Rpdj4KPGRpdiBz
dHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6IE1hdCBNYXJ0aW5lYXUgJmx0O21hdGhldy5q
Lm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5
Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rpdj4KCg==

--===============2685360788743057151==--
