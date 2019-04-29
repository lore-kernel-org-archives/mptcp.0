Content-Type: multipart/mixed; boundary="===============5644731271439166543=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: tcp,
 ulp: Add clone operation to tcp_ulp_ops
Date: Mon, 29 Apr 2019 23:12:47 +0000
Message-ID: <gerrit.1556579518000.I380ce1411ccbaff50cb22b809e5b2ec5877fa1d2@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1100

--===============5644731271439166543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/452480


Change subject: tcp, ulp: Add clone operation to tcp_ulp_ops
......................................................................

tcp, ulp: Add clone operation to tcp_ulp_ops

If ULP is used on a listening socket, icsk_ulp_ops and icsk_ulp_data are
copied when the listener is cloned. Sometimes the clone is immediately
deleted, which will invoke the release op on the clone and likely
corrupt the listening socket's icsk_ulp_data.

The clone operation is invoked immediately after the clone is copied and
gives the ULP type an opportunity to set up the clone socket and its
icsk_ulp_data.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Change-Id: I380ce1411ccbaff50cb22b809e5b2ec5877fa1d2
---
M include/net/tcp.h
M net/ipv4/inet_connection_sock.c
M net/ipv4/tcp_ulp.c
3 files changed, 19 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/80/452480/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/452480
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: I380ce1411ccbaff50cb22b809e5b2ec5877fa1d2
Gerrit-Change-Number: 452480
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============5644731271439166543==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUyNDgwIj5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPnRjcCwgdWxwOiBBZGQgY2xvbmUgb3BlcmF0aW9uIHRvIHRjcF91bHBf
b3BzPGJyPjxicj5JZiBVTFAgaXMgdXNlZCBvbiBhIGxpc3RlbmluZyBzb2NrZXQsIGljc2tfdWxw
X29wcyBhbmQgaWNza191bHBfZGF0YSBhcmU8YnI+Y29waWVkIHdoZW4gdGhlIGxpc3RlbmVyIGlz
IGNsb25lZC4gU29tZXRpbWVzIHRoZSBjbG9uZSBpcyBpbW1lZGlhdGVseTxicj5kZWxldGVkLCB3
aGljaCB3aWxsIGludm9rZSB0aGUgcmVsZWFzZSBvcCBvbiB0aGUgY2xvbmUgYW5kIGxpa2VseTxi
cj5jb3JydXB0IHRoZSBsaXN0ZW5pbmcgc29ja2V0JiMzOTtzIGljc2tfdWxwX2RhdGEuPGJyPjxi
cj5UaGUgY2xvbmUgb3BlcmF0aW9uIGlzIGludm9rZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGNs
b25lIGlzIGNvcGllZCBhbmQ8YnI+Z2l2ZXMgdGhlIFVMUCB0eXBlIGFuIG9wcG9ydHVuaXR5IHRv
IHNldCB1cCB0aGUgY2xvbmUgc29ja2V0IGFuZCBpdHM8YnI+aWNza191bHBfZGF0YS48YnI+PGJy
PlNpZ25lZC1vZmYtYnk6IE1hdCBNYXJ0aW5lYXUgJmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51
eC5pbnRlbC5jb20mZ3Q7PGJyPkNoYW5nZS1JZDogSTM4MGNlMTQxMWNjYmFmZjUwY2IyMmI4MDll
NWIyZWM1ODc3ZmExZDI8YnI+LS0tPGJyPk0gaW5jbHVkZS9uZXQvdGNwLmg8YnI+TSBuZXQvaXB2
NC9pbmV0X2Nvbm5lY3Rpb25fc29jay5jPGJyPk0gbmV0L2lwdjQvdGNwX3VscC5jPGJyPjMgZmls
ZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJl
PjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFj
ZTogcHJlLXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211
bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzgwLzQ1MjQ4MC8xPC9wcmU+
PHA+VG8gdmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2Mv
bXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1MjQ4MCI+Y2hhbmdlIDQ1MjQ4MDwvYT4u
IFRvIHVuc3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQg
PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwv
YT4uPC9wPjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1l
c3NhZ2UiPjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8v
c2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczov
L3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUy
NDgwIi8+PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+
PC9kaXY+Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4g
R2Vycml0LUJyYW5jaDogdC91cHN0cmVhbSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LUNoYW5nZS1JZDogSTM4MGNlMTQxMWNjYmFmZjUwY2IyMmI4MDllNWIyZWM1ODc3
ZmExZDIgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVt
YmVyOiA0NTI0ODAgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRj
aFNldDogMSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBN
YXQgTWFydGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8
L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdj
aGFuZ2UgPC9kaXY+Cgo=

--===============5644731271439166543==--
