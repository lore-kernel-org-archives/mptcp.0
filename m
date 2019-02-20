Content-Type: multipart/mixed; boundary="===============1062987455208054948=="
MIME-Version: 1.0
From: Matthieu Baerts (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[scripts]: ci:upd-tg: ease
 integration with a docker
Date: Wed, 20 Feb 2019 13:56:58 +0000
Message-ID: <gerrit.1550671010000.I69f47c74868a6d24f003d45bb6288db46e23e63e@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1006

--===============1062987455208054948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat Martineau,

I'd like you to do a code review. Please visit

    https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/445590

to review the following change.


Change subject: ci:upd-tg: ease integration with a docker
......................................................................

ci:upd-tg: ease integration with a docker

In this docker, we will have all dependences needed to run this script,
topgit included. That reduces the size of the script and ease the
integration of the script.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Change-Id: I69f47c74868a6d24f003d45bb6288db46e23e63e
---
A ci/Dockerfile.update-tg-tree.sh
M ci/update-tg-tree.sh
2 files changed, 55 insertions(+), 48 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/90/445590/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/445590
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: scripts
Gerrit-Change-Id: I69f47c74868a6d24f003d45bb6288db46e23e63e
Gerrit-Change-Number: 445590
Gerrit-PatchSet: 1
Gerrit-Owner: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Gerrit-Reviewer: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============1062987455208054948==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0dGhpZXUgQmFlcnRzIHdvdWxkIGxpa2UgTWF0IE1hcnRpbmVhdSB0byA8c3Ryb25nPnJl
dmlldzwvc3Ryb25nPiB0aGlzIGNoYW5nZS48L3A+PHA+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcu
Z2Vycml0aHViLmlvL2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU5MCI+Vmll
dyBDaGFuZ2U8L2E+PC9wPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3Nw
YWNlOyB3aGl0ZS1zcGFjZTogcHJlLXdyYXA7Ij5jaTp1cGQtdGc6IGVhc2UgaW50ZWdyYXRpb24g
d2l0aCBhIGRvY2tlcjxicj48YnI+SW4gdGhpcyBkb2NrZXIsIHdlIHdpbGwgaGF2ZSBhbGwgZGVw
ZW5kZW5jZXMgbmVlZGVkIHRvIHJ1biB0aGlzIHNjcmlwdCw8YnI+dG9wZ2l0IGluY2x1ZGVkLiBU
aGF0IHJlZHVjZXMgdGhlIHNpemUgb2YgdGhlIHNjcmlwdCBhbmQgZWFzZSB0aGU8YnI+aW50ZWdy
YXRpb24gb2YgdGhlIHNjcmlwdC48YnI+PGJyPlNpZ25lZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0
cyAmbHQ7bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCZndDs8YnI+Q2hhbmdlLUlkOiBJNjlm
NDdjNzQ4NjhhNmQyNGYwMDNkNDViYjYyODhkYjQ2ZTIzZTYzZTxicj4tLS08YnI+QSBjaS9Eb2Nr
ZXJmaWxlLnVwZGF0ZS10Zy10cmVlLnNoPGJyPk0gY2kvdXBkYXRlLXRnLXRyZWUuc2g8YnI+MiBm
aWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSk8YnI+PGJyPjwv
cHJlPjxwcmUgc3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1z
cGFjZTogcHJlLXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4
L211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzkwLzQ0NTU5MC8xPC9w
cmU+PHA+VG8gdmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlv
L2MvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ0NTU5MCI+Y2hhbmdlIDQ0NTU5MDwv
YT4uIFRvIHVuc3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlz
aXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5n
czwvYT4uPC9wPjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFp
bE1lc3NhZ2UiPjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRw
Oi8vc2NoZW1hLm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRw
czovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0Lysv
NDQ1NTkwIi8+PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9k
aXY+PC9kaXY+Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVs
dGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LUJyYW5jaDogc2NyaXB0cyA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25l
Ij4gR2Vycml0LUNoYW5nZS1JZDogSTY5ZjQ3Yzc0ODY4YTZkMjRmMDAzZDQ1YmI2Mjg4ZGI0NmUy
M2U2M2UgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVt
YmVyOiA0NDU1OTAgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRj
aFNldDogMSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBN
YXR0aGlldSBCYWVydHMgJmx0O21hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQmZ3Q7IDwvZGl2
Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUmV2aWV3ZXI6IE1hdCBNYXJ0aW5l
YXUgJmx0O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2
IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rp
dj4KCg==

--===============1062987455208054948==--
