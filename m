Content-Type: multipart/mixed; boundary="===============6279134766054626140=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: manually
 update 'export' branch on Github
Date: Mon, 04 Mar 2019 13:29:58 +0000
Message-ID: <gerrit.1551706198000.I09cc703b16d5f30f9e34ff4db70e90f38172fed6@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1024

--===============6279134766054626140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/446921

to review the following change.


Change subject: ci:upd-tg: manually update 'export' branch on Github
......................................................................

ci:upd-tg: manually update 'export' branch on Github

Because we rewrite the history, Gerrithub stops the sync with Github for
this branch. We then do a manual update (CI has rights to do that).

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I09cc703b16d5f30f9e34ff4db70e90f38172fed6
---
M ci/update-tg-tree.sh
1 file changed, 7 insertions(+), 0 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/21/446921/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/446921
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I09cc703b16d5f30f9e34ff4db70e90f38172fed6
Gerrit-Change-Number: 446921
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============6279134766054626140==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NjkyMSI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IG1hbnVhbGx5IHVwZGF0ZSAm
IzM5O2V4cG9ydCYjMzk7IGJyYW5jaCBvbiBHaXRodWI8YnI+PGJyPkJlY2F1c2Ugd2UgcmV3cml0
ZSB0aGUgaGlzdG9yeSwgR2Vycml0aHViIHN0b3BzIHRoZSBzeW5jIHdpdGggR2l0aHViIGZvcjxi
cj50aGlzIGJyYW5jaC4gV2UgdGhlbiBkbyBhIG1hbnVhbCB1cGRhdGUgKENJIGhhcyByaWdodHMg
dG8gZG8gdGhhdCkuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBNYXR0aGlldSBCYWVydHMgJmx0O21h
dHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7PGJyPkNoYW5nZS1JZDogSTA5Y2M3MDNiMTZk
NWYzMGY5ZTM0ZmY0ZGI3MGU5MGYzODE3MmZlZDY8YnI+LS0tPGJyPk0gY2kvdXBkYXRlLXRnLXRy
ZWUuc2g8YnI+MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8
YnI+PGJyPjwvcHJlPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNl
OyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHVi
LmlvOjI5NDE4L211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzIxLzQ0
NjkyMS8xPC9wcmU+PHA+VG8gdmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vy
cml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NjkyMSI+Y2hhbmdl
IDQ0NjkyMTwvYT4uIFRvIHVuc3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmls
dGVycywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdz
Ij5zZXR0aW5nczwvYT4uPC9wPjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1h
Lm9yZy9FbWFpbE1lc3NhZ2UiPjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10
eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBo
cmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25l
dC1uZXh0LysvNDQ2OTIxIi8+PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hh
bmdlIi8+PC9kaXY+PC9kaXY+Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJv
amVjdDogbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlz
cGxheTpub25lIj4gR2Vycml0LUJyYW5jaDogc2NyaXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlz
cGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1JZDogSTA5Y2M3MDNiMTZkNWYzMGY5ZTM0ZmY0ZGI3
MGU5MGYzODE3MmZlZDYgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1D
aGFuZ2UtTnVtYmVyOiA0NDY5MjEgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdl
cnJpdC1QYXRjaFNldDogMSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0
LU93bmVyOiBNYXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQm
Z3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1h
dCBNYXJ0aW5lYXUgJmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwv
ZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2No
YW5nZSA8L2Rpdj4KCg==

--===============6279134766054626140==--
