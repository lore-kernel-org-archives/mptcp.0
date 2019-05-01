Content-Type: multipart/mixed; boundary="===============6209720684392064088=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: mptcp: selftests:
 switch to netns+veth based tests
Date: Wed, 01 May 2019 22:42:04 +0000
Message-ID: <gerrit.1556750522000.Ia0505b87be107298e00ea437139481a1a0f7c3c6@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1107

--===============6209720684392064088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/452799


Change subject: mptcp: selftests: switch to netns+veth based tests
......................................................................

mptcp: selftests: switch to netns+veth based tests

... so we can exercise PMTU and MSS handling.
MTU on lo is 64k, so we never had to deal with segmentation either.

This also avoids problems with timewait state in inet_ns,
all net namespaces are torn down before script exits.

This uncovers several bugs:
1. mptcp_init_sock() passes init_net instead of sock_net(sk), i.e.
   network namespaces are not supported
2. We corrupt tcp option space, I can see invalid tcp headers (too
   short) in tcpdump, and receiver process hangs without getting the
   data (poll timeout).
   Seems to be gone after adding

    if (size =3D=3D MAX_TCP_OPTION_SPACE)
          return size;

    BUG(size > MAX_TCP_OPTION_SPACE);

    in tcp_established_options() after writing mptcp options.
    SACK writing doesn't handle 'no option space left' case.
3. Several WARN_ON from networking core are triggered, e.g. due
   to mem accouting being off.  Maybe fixed already with pending
   locking fix in mptcp_recv.
4. "Replaced mapping before it was done" in dmesg.
5. receiver blocking in read(), while TCP socket is in CLOSE-WAIT.
   wait_woken+0xd6/0x170
   sk_wait_data+0x248/0x270
   mptcp_recvmsg+0x5c0/0xd50
6. kmemleak gets noisy, we probably leak a refcount somewhere (iirc
   Davide is already working on this).
7. crash on connect completion, probably same bug that Paolo reported
   already.

As the script did not yet turn up any problem when using only
tcp, it appears these are MPTCP related bugs rather than with script
or mptcp_connect.c .

Once above issues are fixed, this will be extended again to
set different/varying MTU in ns1 and ns4.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Change-Id: Ia0505b87be107298e00ea437139481a1a0f7c3c6
---
M tools/testing/selftests/net/mptcp/mptcp_connect.c
M tools/testing/selftests/net/mptcp/mptcp_connect.sh
2 files changed, 337 insertions(+), 176 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/99/452799/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/452799
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: Ia0505b87be107298e00ea437139481a1a0f7c3c6
Gerrit-Change-Number: 452799
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============6209720684392064088==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUyNzk5Ij5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPm1wdGNwOiBzZWxmdGVzdHM6IHN3aXRjaCB0byBuZXRucyt2ZXRoIGJh
c2VkIHRlc3RzPGJyPjxicj4uLi4gc28gd2UgY2FuIGV4ZXJjaXNlIFBNVFUgYW5kIE1TUyBoYW5k
bGluZy48YnI+TVRVIG9uIGxvIGlzIDY0aywgc28gd2UgbmV2ZXIgaGFkIHRvIGRlYWwgd2l0aCBz
ZWdtZW50YXRpb24gZWl0aGVyLjxicj48YnI+VGhpcyBhbHNvIGF2b2lkcyBwcm9ibGVtcyB3aXRo
IHRpbWV3YWl0IHN0YXRlIGluIGluZXRfbnMsPGJyPmFsbCBuZXQgbmFtZXNwYWNlcyBhcmUgdG9y
biBkb3duIGJlZm9yZSBzY3JpcHQgZXhpdHMuPGJyPjxicj5UaGlzIHVuY292ZXJzIHNldmVyYWwg
YnVnczo8YnI+MS4gbXB0Y3BfaW5pdF9zb2NrKCkgcGFzc2VzIGluaXRfbmV0IGluc3RlYWQgb2Yg
c29ja19uZXQoc2spLCBpLmUuPGJyPiAgIG5ldHdvcmsgbmFtZXNwYWNlcyBhcmUgbm90IHN1cHBv
cnRlZDxicj4yLiBXZSBjb3JydXB0IHRjcCBvcHRpb24gc3BhY2UsIEkgY2FuIHNlZSBpbnZhbGlk
IHRjcCBoZWFkZXJzICh0b288YnI+ICAgc2hvcnQpIGluIHRjcGR1bXAsIGFuZCByZWNlaXZlciBw
cm9jZXNzIGhhbmdzIHdpdGhvdXQgZ2V0dGluZyB0aGU8YnI+ICAgZGF0YSAocG9sbCB0aW1lb3V0
KS48YnI+ICAgU2VlbXMgdG8gYmUgZ29uZSBhZnRlciBhZGRpbmc8YnI+PGJyPiAgICBpZiAoc2l6
ZSA9PSBNQVhfVENQX09QVElPTl9TUEFDRSk8YnI+ICAgICAgICAgIHJldHVybiBzaXplOzxicj48
YnI+ICAgIEJVRyhzaXplICZndDsgTUFYX1RDUF9PUFRJT05fU1BBQ0UpOzxicj48YnI+ICAgIGlu
IHRjcF9lc3RhYmxpc2hlZF9vcHRpb25zKCkgYWZ0ZXIgd3JpdGluZyBtcHRjcCBvcHRpb25zLjxi
cj4gICAgU0FDSyB3cml0aW5nIGRvZXNuJiMzOTt0IGhhbmRsZSAmIzM5O25vIG9wdGlvbiBzcGFj
ZSBsZWZ0JiMzOTsgY2FzZS48YnI+My4gU2V2ZXJhbCBXQVJOX09OIGZyb20gbmV0d29ya2luZyBj
b3JlIGFyZSB0cmlnZ2VyZWQsIGUuZy4gZHVlPGJyPiAgIHRvIG1lbSBhY2NvdXRpbmcgYmVpbmcg
b2ZmLiAgTWF5YmUgZml4ZWQgYWxyZWFkeSB3aXRoIHBlbmRpbmc8YnI+ICAgbG9ja2luZyBmaXgg
aW4gbXB0Y3BfcmVjdi48YnI+NC4gJnF1b3Q7UmVwbGFjZWQgbWFwcGluZyBiZWZvcmUgaXQgd2Fz
IGRvbmUmcXVvdDsgaW4gZG1lc2cuPGJyPjUuIHJlY2VpdmVyIGJsb2NraW5nIGluIHJlYWQoKSwg
d2hpbGUgVENQIHNvY2tldCBpcyBpbiBDTE9TRS1XQUlULjxicj4gICB3YWl0X3dva2VuKzB4ZDYv
MHgxNzA8YnI+ICAgc2tfd2FpdF9kYXRhKzB4MjQ4LzB4MjcwPGJyPiAgIG1wdGNwX3JlY3Ztc2cr
MHg1YzAvMHhkNTA8YnI+Ni4ga21lbWxlYWsgZ2V0cyBub2lzeSwgd2UgcHJvYmFibHkgbGVhayBh
IHJlZmNvdW50IHNvbWV3aGVyZSAoaWlyYzxicj4gICBEYXZpZGUgaXMgYWxyZWFkeSB3b3JraW5n
IG9uIHRoaXMpLjxicj43LiBjcmFzaCBvbiBjb25uZWN0IGNvbXBsZXRpb24sIHByb2JhYmx5IHNh
bWUgYnVnIHRoYXQgUGFvbG8gcmVwb3J0ZWQ8YnI+ICAgYWxyZWFkeS48YnI+PGJyPkFzIHRoZSBz
Y3JpcHQgZGlkIG5vdCB5ZXQgdHVybiB1cCBhbnkgcHJvYmxlbSB3aGVuIHVzaW5nIG9ubHk8YnI+
dGNwLCBpdCBhcHBlYXJzIHRoZXNlIGFyZSBNUFRDUCByZWxhdGVkIGJ1Z3MgcmF0aGVyIHRoYW4g
d2l0aCBzY3JpcHQ8YnI+b3IgbXB0Y3BfY29ubmVjdC5jIC48YnI+PGJyPk9uY2UgYWJvdmUgaXNz
dWVzIGFyZSBmaXhlZCwgdGhpcyB3aWxsIGJlIGV4dGVuZGVkIGFnYWluIHRvPGJyPnNldCBkaWZm
ZXJlbnQvdmFyeWluZyBNVFUgaW4gbnMxIGFuZCBuczQuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBG
bG9yaWFuIFdlc3RwaGFsICZsdDtmd0BzdHJsZW4uZGUmZ3Q7PGJyPkNoYW5nZS1JZDogSWEwNTA1
Yjg3YmUxMDcyOThlMDBlYTQzNzEzOTQ4MWExYTBmN2MzYzY8YnI+LS0tPGJyPk0gdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3QuYzxicj5NIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LnNoPGJyPjIgZmlsZXMgY2hhbmdl
ZCwgMzM3IGluc2VydGlvbnMoKyksIDE3NiBkZWxldGlvbnMoLSk8YnI+PGJyPjwvcHJlPjxwcmUg
c3R5bGU9ImZvbnQtZmFtaWx5OiBtb25vc3BhY2UsbW9ub3NwYWNlOyB3aGl0ZS1zcGFjZTogcHJl
LXdyYXA7Ij5naXQgcHVsbCBzc2g6Ly9yZXZpZXcuZ2Vycml0aHViLmlvOjI5NDE4L211bHRpcGF0
aC10Y3AvbXB0Y3BfbmV0LW5leHQgcmVmcy9jaGFuZ2VzLzk5LzQ1Mjc5OS8xPC9wcmU+PHA+VG8g
dmlldywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL2MvbXVsdGlw
YXRoLXRjcC9tcHRjcF9uZXQtbmV4dC8rLzQ1Mjc5OSI+Y2hhbmdlIDQ1Mjc5OTwvYT4uIFRvIHVu
c3Vic2NyaWJlLCBvciBmb3IgaGVscCB3cml0aW5nIG1haWwgZmlsdGVycywgdmlzaXQgPGEgaHJl
Zj0iaHR0cHM6Ly9yZXZpZXcuZ2Vycml0aHViLmlvL3NldHRpbmdzIj5zZXR0aW5nczwvYT4uPC9w
PjxkaXYgaXRlbXNjb3BlIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1hLm9yZy9FbWFpbE1lc3NhZ2Ui
PjxkaXYgaXRlbXNjb3BlIGl0ZW1wcm9wPSJhY3Rpb24iIGl0ZW10eXBlPSJodHRwOi8vc2NoZW1h
Lm9yZy9WaWV3QWN0aW9uIj48bGluayBpdGVtcHJvcD0idXJsIiBocmVmPSJodHRwczovL3Jldmll
dy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDUyNzk5Ii8+
PG1ldGEgaXRlbXByb3A9Im5hbWUiIGNvbnRlbnQ9IlZpZXcgQ2hhbmdlIi8+PC9kaXY+PC9kaXY+
Cgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtUHJvamVjdDogbXVsdGlwYXRoLXRj
cC9tcHRjcF9uZXQtbmV4dCA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0
LUJyYW5jaDogdC91cHN0cmVhbSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vy
cml0LUNoYW5nZS1JZDogSWEwNTA1Yjg3YmUxMDcyOThlMDBlYTQzNzEzOTQ4MWExYTBmN2MzYzYg
PC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1DaGFuZ2UtTnVtYmVyOiA0
NTI3OTkgPC9kaXY+CjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZSI+IEdlcnJpdC1QYXRjaFNldDog
MSA8L2Rpdj4KPGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU93bmVyOiBNYXQgTWFy
dGluZWF1ICZsdDttYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tJmd0OyA8L2Rpdj4K
PGRpdiBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LU1lc3NhZ2VUeXBlOiBuZXdjaGFuZ2Ug
PC9kaXY+Cgo=

--===============6209720684392064088==--
