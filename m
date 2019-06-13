Content-Type: multipart/mixed; boundary="===============4493361434749283437=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] mptcpd 0.2a released
Date: Thu, 13 Jun 2019 14:11:06 -0700
Message-ID: <CAPyD+=AHPBgwp8hq23N8ow+zzd+tYOueOgy0CfJ1vGFmdNkHnQ@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 1365

--===============4493361434749283437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcpd 0.2a alpha release is now available on GitHub at:

    https://github.com/intel/mptcpd/releases/tag/v0.2a

This Multipath TCP Daemon alpha release replaces support for the
deprecated MPTCP generic netlink API with the one found in the
multipath-tcp.org kernel (0.95+), and has been verified to work with
that kernel.

Work is ongoing to leverage some of the features in the MPTCP generic
netlink API, such as availability of subflow network interface
indices, to help simplify path management plugin implementations.  See
the list of mptcpd issues for further details:

    https://github.com/intel/mptcpd/issues

--===============4493361434749283437==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+VGhlIG1wdGNwZCAwLjJhIGFscGhhIHJlbGVhc2UgaXMgbm93IGF2YWls
YWJsZSBvbiBHaXRIdWIgYXQ6PGJyPjxicj7CoCDCoCA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5j
b20vaW50ZWwvbXB0Y3BkL3JlbGVhc2VzL3RhZy92MC4yYSI+aHR0cHM6Ly9naXRodWIuY29tL2lu
dGVsL21wdGNwZC9yZWxlYXNlcy90YWcvdjAuMmE8L2E+PGJyPjxicj5UaGlzIE11bHRpcGF0aCBU
Q1AgRGFlbW9uIGFscGhhIHJlbGVhc2UgcmVwbGFjZXMgc3VwcG9ydCBmb3IgdGhlPGJyPmRlcHJl
Y2F0ZWQgTVBUQ1AgZ2VuZXJpYyBuZXRsaW5rIEFQSSB3aXRoIHRoZSBvbmUgZm91bmQgaW4gdGhl
PGJyPjxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZyI+bXVsdGlwYXRoLXRjcC5vcmc8
L2E+IGtlcm5lbCAoMC45NSspLCBhbmQgaGFzIGJlZW4gdmVyaWZpZWQgdG8gd29yayB3aXRoPGJy
PnRoYXQga2VybmVsLjxicj48YnI+V29yayBpcyBvbmdvaW5nIHRvIGxldmVyYWdlIHNvbWUgb2Yg
dGhlIGZlYXR1cmVzIGluIHRoZSBNUFRDUCBnZW5lcmljPGJyPm5ldGxpbmsgQVBJLCBzdWNoIGFz
IGF2YWlsYWJpbGl0eSBvZiBzdWJmbG93IG5ldHdvcmsgaW50ZXJmYWNlPGJyPmluZGljZXMsIHRv
IGhlbHAgc2ltcGxpZnkgcGF0aCBtYW5hZ2VtZW50IHBsdWdpbiBpbXBsZW1lbnRhdGlvbnMuwqAg
U2VlPGJyPnRoZSBsaXN0IG9mIG1wdGNwZCBpc3N1ZXMgZm9yIGZ1cnRoZXIgZGV0YWlsczo8YnI+
PGJyPsKgIMKgIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9tcHRjcGQvaXNzdWVz
Ij5odHRwczovL2dpdGh1Yi5jb20vaW50ZWwvbXB0Y3BkL2lzc3VlczwvYT48YnI+PGRpdj48YnI+
PC9kaXY+PC9kaXY+Cg==

--===============4493361434749283437==--
