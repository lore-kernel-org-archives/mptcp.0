Content-Type: multipart/mixed; boundary="===============2986511405854791963=="
MIME-Version: 1.0
From: Mat Martineau (GerritHub) <gerrit at gerrithub.io>
To: mptcp at lists.01.org
Subject: [MPTCP] Change in ...mptcp_net-next[t/upstream]: selftest: mptcp:
 explicitly check for any kind of tcp-like socket pairs
Date: Sat, 23 Mar 2019 00:08:00 +0000
Message-ID: <gerrit.1553299637000.I97e29ccff0dab592b31f8ce253c5c467654ab68c@review.gerrithub.io>
X-Status: 
X-Keywords:                  
X-UID: 1032

--===============2986511405854791963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau has uploaded this change for review. ( https://review.gerrith=
ub.io/c/multipath-tcp/mptcp_net-next/+/448886


Change subject: selftest: mptcp: explicitly check for any kind of tcp-like =
socket pairs
......................................................................

selftest: mptcp: explicitly check for any kind of tcp-like socket pairs

This expands a bit the existing tests checking for any {[mp]tcp,subflow}
<->{[mp]tcp,subflow} pairs.

Moving most of the logic to the shell script we can simplify a bit the
test program.

This change also cleans a bit the tests script output.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Change-Id: I97e29ccff0dab592b31f8ce253c5c467654ab68c
---
M tools/testing/selftests/net/mptcp/mptcp_connect.c
M tools/testing/selftests/net/mptcp/mptcp_connect.sh
2 files changed, 91 insertions(+), 80 deletions(-)



  git pull ssh://review.gerrithub.io:29418/multipath-tcp/mptcp_net-next ref=
s/changes/86/448886/1
-- =

To view, visit https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+=
/448886
To unsubscribe, or for help writing mail filters, visit https://review.gerr=
ithub.io/settings

Gerrit-Project: multipath-tcp/mptcp_net-next
Gerrit-Branch: t/upstream
Gerrit-Change-Id: I97e29ccff0dab592b31f8ce253c5c467654ab68c
Gerrit-Change-Number: 448886
Gerrit-PatchSet: 1
Gerrit-Owner: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Gerrit-MessageType: newchange

--===============2986511405854791963==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHA+TWF0IE1hcnRpbmVhdSBoYXMgdXBsb2FkZWQgdGhpcyBjaGFuZ2UgZm9yIDxzdHJvbmc+cmV2
aWV3PC9zdHJvbmc+LjwvcD48cD48YSBocmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8v
Yy9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LysvNDQ4ODg2Ij5WaWV3IENoYW5nZTwvYT48
L3A+PHByZSBzdHlsZT0iZm9udC1mYW1pbHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNw
YWNlOiBwcmUtd3JhcDsiPnNlbGZ0ZXN0OiBtcHRjcDogZXhwbGljaXRseSBjaGVjayBmb3IgYW55
IGtpbmQgb2YgdGNwLWxpa2Ugc29ja2V0IHBhaXJzPGJyPjxicj5UaGlzIGV4cGFuZHMgYSBiaXQg
dGhlIGV4aXN0aW5nIHRlc3RzIGNoZWNraW5nIGZvciBhbnkge1ttcF10Y3Asc3ViZmxvd308YnI+
Jmx0Oy0mZ3Q7e1ttcF10Y3Asc3ViZmxvd30gcGFpcnMuPGJyPjxicj5Nb3ZpbmcgbW9zdCBvZiB0
aGUgbG9naWMgdG8gdGhlIHNoZWxsIHNjcmlwdCB3ZSBjYW4gc2ltcGxpZnkgYSBiaXQgdGhlPGJy
PnRlc3QgcHJvZ3JhbS48YnI+PGJyPlRoaXMgY2hhbmdlIGFsc28gY2xlYW5zIGEgYml0IHRoZSB0
ZXN0cyBzY3JpcHQgb3V0cHV0Ljxicj48YnI+U2lnbmVkLW9mZi1ieTogUGFvbG8gQWJlbmkgJmx0
O3BhYmVuaUByZWRoYXQuY29tJmd0Ozxicj5DaGFuZ2UtSWQ6IEk5N2UyOWNjZmYwZGFiNTkyYjMx
ZjhjZTI1M2M1YzQ2NzY1NGFiNjhjPGJyPi0tLTxicj5NIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LmM8YnI+TSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9u
ZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5zaDxicj4yIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlv
bnMoKyksIDgwIGRlbGV0aW9ucygtKTxicj48YnI+PC9wcmU+PHByZSBzdHlsZT0iZm9udC1mYW1p
bHk6IG1vbm9zcGFjZSxtb25vc3BhY2U7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPmdpdCBwdWxs
IHNzaDovL3Jldmlldy5nZXJyaXRodWIuaW86Mjk0MTgvbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQt
bmV4dCByZWZzL2NoYW5nZXMvODYvNDQ4ODg2LzE8L3ByZT48cD5UbyB2aWV3LCB2aXNpdCA8YSBo
cmVmPSJodHRwczovL3Jldmlldy5nZXJyaXRodWIuaW8vYy9tdWx0aXBhdGgtdGNwL21wdGNwX25l
dC1uZXh0LysvNDQ4ODg2Ij5jaGFuZ2UgNDQ4ODg2PC9hPi4gVG8gdW5zdWJzY3JpYmUsIG9yIGZv
ciBoZWxwIHdyaXRpbmcgbWFpbCBmaWx0ZXJzLCB2aXNpdCA8YSBocmVmPSJodHRwczovL3Jldmll
dy5nZXJyaXRodWIuaW8vc2V0dGluZ3MiPnNldHRpbmdzPC9hPi48L3A+PGRpdiBpdGVtc2NvcGUg
aXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL0VtYWlsTWVzc2FnZSI+PGRpdiBpdGVtc2NvcGUg
aXRlbXByb3A9ImFjdGlvbiIgaXRlbXR5cGU9Imh0dHA6Ly9zY2hlbWEub3JnL1ZpZXdBY3Rpb24i
PjxsaW5rIGl0ZW1wcm9wPSJ1cmwiIGhyZWY9Imh0dHBzOi8vcmV2aWV3LmdlcnJpdGh1Yi5pby9j
L211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvKy80NDg4ODYiLz48bWV0YSBpdGVtcHJvcD0i
bmFtZSIgY29udGVudD0iVmlldyBDaGFuZ2UiLz48L2Rpdj48L2Rpdj4KCjxkaXYgc3R5bGU9ImRp
c3BsYXk6bm9uZSI+IEdlcnJpdC1Qcm9qZWN0OiBtdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0
IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQnJhbmNoOiB0L3Vwc3Ry
ZWFtIDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtQ2hhbmdlLUlkOiBJ
OTdlMjljY2ZmMGRhYjU5MmIzMWY4Y2UyNTNjNWM0Njc2NTRhYjY4YyA8L2Rpdj4KPGRpdiBzdHls
ZT0iZGlzcGxheTpub25lIj4gR2Vycml0LUNoYW5nZS1OdW1iZXI6IDQ0ODg4NiA8L2Rpdj4KPGRp
diBzdHlsZT0iZGlzcGxheTpub25lIj4gR2Vycml0LVBhdGNoU2V0OiAxIDwvZGl2Pgo8ZGl2IHN0
eWxlPSJkaXNwbGF5Om5vbmUiPiBHZXJyaXQtT3duZXI6IE1hdCBNYXJ0aW5lYXUgJmx0O21hdGhl
dy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20mZ3Q7IDwvZGl2Pgo8ZGl2IHN0eWxlPSJkaXNw
bGF5Om5vbmUiPiBHZXJyaXQtTWVzc2FnZVR5cGU6IG5ld2NoYW5nZSA8L2Rpdj4KCg==

--===============2986511405854791963==--
