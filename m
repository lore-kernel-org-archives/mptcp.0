Content-Type: multipart/mixed; boundary="===============6807244174091697889=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: support
 unconventional home dir
Date: Tue, 28 May 2019 16:55:50 +0000
Message-ID: <gerrit.1559062547000.I09d34ff2170f3f606f4b2048ed839a748be539f5@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1254

--===============6807244174091697889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/456070

to review the following change.


Change subject: ci:upd-tg: support unconventional home dir
......................................................................

ci:upd-tg: support unconventional home dir

Create the parent dir just in case it is from somewhere else, not the
traditional /home.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I09d34ff2170f3f606f4b2048ed839a748be539f5
---
M ci/Dockerfile.update-tg-tree.sh
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/70/456070/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/456070
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I09d34ff2170f3f606f4b2048ed839a748be539f5
Gerrit-Change-Number: 456070
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============6807244174091697889==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MCI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IHN1cHBvcnQgdW5jb252ZW50
aW9uYWwgaG9tZSBkaXI8YnI+PGJyPkNyZWF0ZSB0aGUgcGFyZW50IGRpciBqdXN0IGluIGNhc2Ug
aXQgaXMgZnJvbSBzb21ld2hlcmUgZWxzZSwgbm90IHRoZTxicj50cmFkaXRpb25hbCAvaG9tZS48
YnI+PGJyPlNpZ25lZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0cyAmbHQ7bWF0dGhpZXUuYmFlcnRz
QHRlc3NhcmVzLm5ldCZndDs8YnI+Q2hhbmdlLUlkOiBJMDlkMzRmZjIxNzBmM2Y2MDZmNGIyMDQ4
ZWQ4MzlhNzQ4YmU1MzlmNTxicj4tLS08YnI+TSBjaS9Eb2NrZXJmaWxlLnVwZGF0ZS10Zy10cmVl
LnNoPGJyPjEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSk8YnI+
PGJyPjwvcHJlPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3
aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlv
OjI5NDE4L211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzcwLzQ1NjA3
MC8xPC9wcmU+PHA+VG8gdmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0
aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1NjA3MCI+Y2hhbmdlIDQ1
NjA3MDwvYT4uIFRvIHVuc3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVy
cywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5z
ZXR0aW5nczwvYT4uPC9wPjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9y
Zy9FbWFpbE1lc3NhZ2UiPjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBl
PSJodHRwOi8vc2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVm
PSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0LysvNDU2MDcwIi8+PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdl
Ii8+PC9kaXY+PC9kaXY+Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVj
dDogbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxh
eTpub25lIj4gR2Vycml0LUJyYW5jaDogc2NyaXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxh
eTpub25lIj4gR2Vycml0LUNoYW5nZS1JZDogSTA5ZDM0ZmYyMTcwZjNmNjA2ZjRiMjA0OGVkODM5
YTc0OGJlNTM5ZjUgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFu
Z2UtTnVtYmVyOiA0NTYwNzAgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJp
dC1QYXRjaFNldDogMSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93
bmVyOiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7
IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1hdCBN
YXJ0aW5lYXUgJmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2
Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5n
ZSA8L2Rpdj4KCg==

--===============6807244174091697889==--
