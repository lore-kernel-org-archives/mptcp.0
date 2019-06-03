Content-Type: multipart/mixed; boundary="===============3250810448261750275=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:virtme: refactoring
 to split in functions
Date: Mon, 03 Jun 2019 16:43:04 +0000
Message-ID: <gerrit.1559580181000.I44f69261471b9ee28cdbab509399756513da8690@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1277

--===============3250810448261750275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456653

to review the following change.


Change subject: ci:virtme: refactoring to split in functions
......................................................................

ci:virtme: refactoring to split in functions

That helps to understand the script by using functions with clear names.

But it is mainly to prepare the following commit that will run the tests
twice with different kernel configs.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I44f69261471b9ee28cdbab509399756513da8690
---
M ci/virtme.sh
1 file changed, 92 insertions(+), 34 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/53/456653/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456653
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I44f69261471b9ee28cdbab509399756513da8690
Gerrit-Change-Number: 456653
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============3250810448261750275==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjY1MyI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp2aXJ0bWU6IHJlZmFjdG9yaW5nIHRvIHNw
bGl0IGluIGZ1bmN0aW9uczxicj48YnI+VGhhdCBoZWxwcyB0byB1bmRlcnN0YW5kIHRoZSBzY3Jp
cHQgYnkgdXNpbmcgZnVuY3Rpb25zIHdpdGggY2xlYXIgbmFtZXMuPGJyPjxicj5CdXQgaXQgaXMg
bWFpbmx5IHRvIHByZXBhcmUgdGhlIGZvbGxvd2luZyBjb21taXQgdGhhdCB3aWxsIHJ1biB0aGUg
dGVzdHM8YnI+dHdpY2Ugd2l0aCBkaWZmZXJlbnQga2VybmVsIGNvbmZpZ3MuPGJyPjxicj5TaWdu
ZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5u
ZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTQ0ZjY5MjYxNDcxYjllZTI4Y2RiYWI1MDkzOTk3NTY1MTNk
YTg2OTA8YnI+LS0tPGJyPk0gY2kvdmlydG1lLnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCA5MiBpbnNl
cnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJlPjxwcmUgc3R5bGU9ImZvbnQt
ZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5naXQg
cHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211bHRpcGF0aC10Y3AvbXB0Y3Bf
bmV0LW5leHQgcmVmcy9jaGFuZ2VzLzUzLzQ1NjY1My8xPC9wcmU+PHA+VG8gdmlldywgdmlzaXQg
PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRj
cF9uZXQtbmV4dC8rLzQ1NjY1MyI+Y2hhbmdlIDQ1NjY1MzwvYT4uIFRvIHVuc3Vic2NyaWJlLCBv
ciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9y
ZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwvYT4uPC9wPjxkaXYgaXRlbXNj
b3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1lc3NhZ2UiPjxkaXYgaXRlbXNj
b3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9WaWV3QWN0
aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIu
aW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDU2NjUzIi8+PG1ldGEgaXRlbXBy
b3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+PC9kaXY+Cgo8ZGl2IHN0eWxl
PSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQt
bmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUJyYW5jaDogc2Ny
aXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1JZDog
STQ0ZjY5MjYxNDcxYjllZTI4Y2RiYWI1MDkzOTk3NTY1MTNkYTg2OTAgPC9kaXY+CjxkaXYgc3R5
bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVyOiA0NTY2NTMgPC9kaXY+Cjxk
aXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNldDogMSA8L2Rpdj4KPGRpdiBz
dHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXR0aGlldSBCYWVydHMgJmx0O21h
dHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5
Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1hdCBNYXJ0aW5lYXUgJmx0O21hdGhldy5qLm1hcnRp
bmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUi
PiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rpdj4KCg==

--===============3250810448261750275==--
