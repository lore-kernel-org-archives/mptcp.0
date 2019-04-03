Content-Type: multipart/mixed; boundary="===============9100941040628464529=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: mptcp: Associate
 MPTCP context with TCP socket
Date: Wed, 03 Apr 2019 23:21:49 +0000
Message-ID: <gerrit.1554333664000.Ibdee5d8a80f23f3dda1dcaadc8a961320027e2ba@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1041

--===============9100941040628464529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Peter Krystad,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/450099

to review the following change.


Change subject: mptcp: Associate MPTCP context with TCP socket
......................................................................

mptcp: Associate MPTCP context with TCP socket

Use ULP to associate a subflow_context structure with each TCP
subflow socket.

Change-Id: Ibdee5d8a80f23f3dda1dcaadc8a961320027e2ba
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
M include/linux/tcp.h
M include/net/mptcp.h
M net/mptcp/Makefile
M net/mptcp/protocol.c
A net/mptcp/subflow.c
5 files changed, 198 insertions(+), 17 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/99/450099/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/450099
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: Ibdee5d8a80f23f3dda1dcaadc8a961320027e2ba
Gerrit-Change-Number: 450099
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-Reviewer: Peter Krystad <peter.krystad(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============9100941040628464529==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSB3b3VsZCBsaWtlIFBldGVyIEtyeXN0YWQgdG8gPHN0cm9uZz5yZXZp
ZXc8L3N0cm9uZz4gdGhpcyBjaGFuZ2UuPC9wPjxwPjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3Lmdl
cnJpdGh1Yi5pby9jL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NTAwOTkiPlZpZXcg
Q2hhbmdlPC9hPjwvcD48cHJlIHN0eWxlPSJmb250LWZhbWlseTogbW9ub3NwYWNlLG1vbm9zcGFj
ZTsgd2hpdGUtc3BhY2U6IHByZS13cmFwOyI+bXB0Y3A6IEFzc29jaWF0ZSBNUFRDUCBjb250ZXh0
IHdpdGggVENQIHNvY2tldDxicj48YnI+VXNlIFVMUCB0byBhc3NvY2lhdGUgYSBzdWJmbG93X2Nv
bnRleHQgc3RydWN0dXJlIHdpdGggZWFjaCBUQ1A8YnI+c3ViZmxvdyBzb2NrZXQuPGJyPjxicj5D
aGFuZ2UtSWQ6IEliZGVlNWQ4YTgwZjIzZjNkZGExZGNhYWRjOGE5NjEzMjAwMjdlMmJhPGJyPlNp
Z25lZC1vZmYtYnk6IFBldGVyIEtyeXN0YWQgJmx0O3BldGVyLmtyeXN0YWRAbGludXguaW50ZWwu
Y29tJmd0Ozxicj4tLS08YnI+TSBpbmNsdWRlL2xpbnV4L3RjcC5oPGJyPk0gaW5jbHVkZS9uZXQv
bXB0Y3AuaDxicj5NIG5ldC9tcHRjcC9NYWtlZmlsZTxicj5NIG5ldC9tcHRjcC9wcm90b2NvbC5j
PGJyPkEgbmV0L21wdGNwL3N1YmZsb3cuYzxicj41IGZpbGVzIGNoYW5nZWQsIDE5OCBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJlPjxwcmUgc3R5bGU9ImZvbnQtZmFt
aWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5naXQgcHVs
bCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0
LW5leHQgcmVmcy9jaGFuZ2VzLzk5LzQ1MDA5OS8xPC9wcmU+PHA+VG8gdmlldywgdmlzaXQgPGEg
aHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9u
ZXQtbmV4dC8rLzQ1MDA5OSI+Y2hhbmdlIDQ1MDA5OTwvYT4uIFRvIHVuc3Vic2NyaWJlLCBvciBm
b3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZp
ZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwvYT4uPC9wPjxkaXYgaXRlbXNjb3Bl
IGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1lc3NhZ2UiPjxkaXYgaXRlbXNjb3Bl
IGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9WaWV3QWN0aW9u
Ij48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUwMDk5Ii8+PG1ldGEgaXRlbXByb3A9
Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+PC9kaXY+Cgo8ZGl2IHN0eWxlPSJk
aXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4
dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUJyYW5jaDogdC91cHN0
cmVhbSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1JZDog
SWJkZWU1ZDhhODBmMjNmM2RkYTFkY2FhZGM4YTk2MTMyMDAyN2UyYmEgPC9kaXY+CjxkaXYgc3R5
bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVyOiA0NTAwOTkgPC9kaXY+Cjxk
aXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNldDogMSA8L2Rpdj4KPGRpdiBz
dHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXQgTWFydGluZWF1ICZsdDttYXRo
ZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlz
cGxheTpub25lIj4gR2Vycml0LVJldmlld2VyOiBQZXRlciBLcnlzdGFkICZsdDtwZXRlci5rcnlz
dGFkQGxpbnV4LmludGVsLmNvbSZndDsgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+
IEdlcnJpdC1NZXNzYWdlVHlwZTogbmV3Y2hhbmdlIDwvZGl2PgoK

--===============9100941040628464529==--
