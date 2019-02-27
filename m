Content-Type: multipart/mixed; boundary="===============8578881144319094399=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: mptcp: add basic
 kselftest program
Date: Wed, 27 Feb 2019 23:31:46 +0000
Message-ID: <gerrit.1551310280000.I31f585fceef36b26bbd937140e8f0b2c51d222f0@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1020

--===============8578881144319094399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/446474


Change subject: mptcp: add basic kselftest program
......................................................................

mptcp: add basic kselftest program

create mptcp connection between two processes, xmit data back and
forth.  Data is read from stdin and written (after traversing mtcp
connection twice) to stdout.

Wrapper script tests that data has passed un-altered.

Will run automatically on "make kselftest".

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Change-Id: I31f585fceef36b26bbd937140e8f0b2c51d222f0
---
M tools/testing/selftests/Makefile
A tools/testing/selftests/net/mptcp/Makefile
A tools/testing/selftests/net/mptcp/config
A tools/testing/selftests/net/mptcp/mptcp_connect.c
A tools/testing/selftests/net/mptcp/mptcp_connect.sh
5 files changed, 445 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/74/446474/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446474
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: I31f585fceef36b26bbd937140e8f0b2c51d222f0
Gerrit-Change-Number: 446474
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============8578881144319094399==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ2NDc0Ij5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPm1wdGNwOiBhZGQgYmFzaWMga3NlbGZ0ZXN0IHByb2dyYW08YnI+PGJy
PmNyZWF0ZSBtcHRjcCBjb25uZWN0aW9uIGJldHdlZW4gdHdvIHByb2Nlc3NlcywgeG1pdCBkYXRh
IGJhY2sgYW5kPGJyPmZvcnRoLiAgRGF0YSBpcyByZWFkIGZyb20gc3RkaW4gYW5kIHdyaXR0ZW4g
KGFmdGVyIHRyYXZlcnNpbmcgbXRjcDxicj5jb25uZWN0aW9uIHR3aWNlKSB0byBzdGRvdXQuPGJy
Pjxicj5XcmFwcGVyIHNjcmlwdCB0ZXN0cyB0aGF0IGRhdGEgaGFzIHBhc3NlZCB1bi1hbHRlcmVk
Ljxicj48YnI+V2lsbCBydW4gYXV0b21hdGljYWxseSBvbiAmcXVvdDttYWtlIGtzZWxmdGVzdCZx
dW90Oy48YnI+PGJyPlNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gV2VzdHBoYWwgJmx0O2Z3QHN0cmxl
bi5kZSZndDs8YnI+Q2hhbmdlLUlkOiBJMzFmNTg1ZmNlZWYzNmIyNmJiZDkzNzE0MGU4ZjBiMmM1
MWQyMjJmMDxicj4tLS08YnI+TSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9NYWtlZmlsZTxicj5B
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9NYWtlZmlsZTxicj5BIHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9jb25maWc8YnI+QSB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5jPGJyPkEgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3Quc2g8YnI+NSBmaWxlcyBjaGFuZ2VkLCA0NDUgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJlPjxwcmUgc3R5bGU9ImZvbnQt
ZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5naXQg
cHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211bHRpcGF0aC10Y3AvbXB0Y3Bf
bmV0LW5leHQgcmVmcy9jaGFuZ2VzLzc0LzQ0NjQ3NC8xPC9wcmU+PHA+VG8gdmlldywgdmlzaXQg
PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRj
cF9uZXQtbmV4dC8rLzQ0NjQ3NCI+Y2hhbmdlIDQ0NjQ3NDwvYT4uIFRvIHVuc3Vic2NyaWJlLCBv
ciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9y
ZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwvYT4uPC9wPjxkaXYgaXRlbXNj
b3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1lc3NhZ2UiPjxkaXYgaXRlbXNj
b3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9WaWV3QWN0
aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIu
aW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ2NDc0Ii8+PG1ldGEgaXRlbXBy
b3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+PC9kaXY+Cgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQt
bmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUJyYW5jaDogdC91
cHN0cmVhbSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1J
ZDogSTMxZjU4NWZjZWVmMzZiMjZiYmQ5MzcxNDBlOGYwYjJjNTFkMjIyZjAgPC9kaXY+CjxkaXYg
c3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVyOiA0NDY0NzQgPC9kaXY+
CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNldDogMSA8L2Rpdj4KPGRp
diBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXQgTWFydGluZWF1ICZsdDtt
YXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4KPGRpdiBzdHlsZT0i
ZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2UgPC9kaXY+Cgo=

--===============8578881144319094399==--
