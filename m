Content-Type: multipart/mixed; boundary="===============1767801214906686396=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Part 2 - Cover Letter
Date: Thu, 16 Jan 2020 10:07:37 -0800
Message-ID: <AFDCA786-3364-46AA-9227-558148BD463A@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 3382

--===============1767801214906686396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

here is the proposed cover-letter for Part 2. I assume that it will be "v3"=
 as Mat already sent out the v2 before Christmas.

Please let me know what should be changed.

=3D=3D=3D=3D=3D=3D

Subject: [PATCH net-next v3 ...] Multipath TCP part 2: Single subflow

v2 -> v3: Added RFC8684-style handshake and some minor fixes
v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series

This set adds MPTCP connection establishment, writing & reading MPTCP
options on data packets, a sysctl to allow MPTCP per-namespace, and self
tests. This is sufficient to establish and maintain a connection with a
MPTCP peer, but will not yet allow or initiate establishment of
additional MPTCP subflows.

We also add the necessary code for the RFC8684-style handshake.
RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
version 1.

The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
deployments are currently based on RFC 6824, future deployments will be
migrating to MPTCP version 1. 3GPP's 5G standardization also solely supports
RFC 8684. Also, we believe that this initial submission of MPTCP will be
cleaner by solely supporting RFC 8684. If later on support for the old
MPTCP-version is required it can always be added in the future.

The major difference between RFC 8684 and RFC 6824 is that it has a better
support for servers using TCP SYN-cookies by reliably retransmitting the
MP_CAPABLE option.


Clone/fetch:
https://github.com/multipath-tcp/mptcp_net-next.git <https://github.com/mul=
tipath-tcp/mptcp_net-next.git> (tag: netdev-v3-part2)

Browse:
https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2 <https=
://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2>

Thank you for your review. You can find us at mptcp(a)lists.01.org <mailto:=
mptcp(a)lists.01.org> and
https://is.gd/mptcp_upstream <https://is.gd/mptcp_upstream>

=3D=3D=3D=3D=3D=3D

Cheers,
Christoph

--===============1767801214906686396==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8sPGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdiBjbGFzcz0iIj5oZXJlIGlzIHRoZSBwcm9wb3NlZCBjb3Zlci1sZXR0ZXIgZm9yIFBh
cnQgMi4gSSBhc3N1bWUgdGhhdCBpdCB3aWxsIGJlICJ2MyIgYXMgTWF0IGFscmVhZHkgc2VudCBv
dXQgdGhlIHYyIGJlZm9yZSBDaHJpc3RtYXMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5QbGVhc2UgbGV0IG1lIGtub3cgd2hhdCBzaG91bGQgYmUg
Y2hhbmdlZC48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNz
PSIiPj09PT09PTwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xh
c3M9IiI+U3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHYzIC4uLl0mbmJzcDtNdWx0aXBhdGggVENQ
IHBhcnQgMjogU2luZ2xlIHN1YmZsb3c8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48
L2Rpdj48ZGl2IGNsYXNzPSIiPnYyIC0mZ3Q7IHYzOiBBZGRlZCBSRkM4Njg0LXN0eWxlIGhhbmRz
aGFrZSBhbmQgc29tZSBtaW5vciBmaXhlczxiciBjbGFzcz0iIj52MSAtJmd0OyB2MjogUmViYXNl
ZCBvbiBsYXRlc3QgIk11bHRpcGF0aCBUQ1A6IFByZXJlcXVpc2l0ZXMiIHYzIHNlcmllczxiciBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+VGhpcyBzZXQgYWRkcyBNUFRDUCBjb25uZWN0aW9uIGVzdGFi
bGlzaG1lbnQsIHdyaXRpbmcgJmFtcDsgcmVhZGluZyBNUFRDUDxiciBjbGFzcz0iIj5vcHRpb25z
IG9uIGRhdGEgcGFja2V0cywgYSBzeXNjdGwgdG8gYWxsb3cgTVBUQ1AgcGVyLW5hbWVzcGFjZSwg
YW5kIHNlbGY8YnIgY2xhc3M9IiI+dGVzdHMuIFRoaXMgaXMgc3VmZmljaWVudCB0byBlc3RhYmxp
c2ggYW5kIG1haW50YWluIGEgY29ubmVjdGlvbiB3aXRoIGE8YnIgY2xhc3M9IiI+TVBUQ1AgcGVl
ciwgYnV0IHdpbGwgbm90IHlldCBhbGxvdyBvciBpbml0aWF0ZSBlc3RhYmxpc2htZW50IG9mPGJy
IGNsYXNzPSIiPmFkZGl0aW9uYWwgTVBUQ1Agc3ViZmxvd3MuPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj5XZSBhbHNvIGFkZCB0aGUgbmVjZXNzYXJ5IGNvZGUgZm9yIHRoZSBSRkM4Njg0LXN0eWxl
IGhhbmRzaGFrZS48YnIgY2xhc3M9IiI+UkZDODY4NCBvYnNvbGV0ZXMgdGhlIGV4cGVyaW1lbnRh
bCBSRkM2ODI0IGFuZCBtYWtlcyBNUFRDUCBtb3ZlLW9uIHRvPGJyIGNsYXNzPSIiPnZlcnNpb24g
MS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPlRoZSBNUFRDUCBwYXRjaHNldCBleGNsdXNpdmVs
eSBzdXBwb3J0cyBSRkMgODY4NC4gQWx0aG91Z2ggYWxsIE1QVENQPGJyIGNsYXNzPSIiPmRlcGxv
eW1lbnRzIGFyZSBjdXJyZW50bHkgYmFzZWQgb24gUkZDIDY4MjQsIGZ1dHVyZSBkZXBsb3ltZW50
cyB3aWxsIGJlPGJyIGNsYXNzPSIiPm1pZ3JhdGluZyB0byBNUFRDUCB2ZXJzaW9uIDEuIDNHUFAn
cyA1RyBzdGFuZGFyZGl6YXRpb24gYWxzbyBzb2xlbHkgc3VwcG9ydHM8YnIgY2xhc3M9IiI+UkZD
IDg2ODQuIEFsc28sIHdlIGJlbGlldmUgdGhhdCB0aGlzIGluaXRpYWwgc3VibWlzc2lvbiBvZiBN
UFRDUCB3aWxsIGJlPGJyIGNsYXNzPSIiPmNsZWFuZXIgYnkgc29sZWx5IHN1cHBvcnRpbmcgUkZD
IDg2ODQuIElmIGxhdGVyIG9uIHN1cHBvcnQgZm9yIHRoZSBvbGQ8YnIgY2xhc3M9IiI+TVBUQ1At
dmVyc2lvbiBpcyByZXF1aXJlZCBpdCBjYW4gYWx3YXlzIGJlIGFkZGVkIGluIHRoZSBmdXR1cmUu
PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGUgbWFqb3IgZGlmZmVyZW5jZSBiZXR3ZWVuIFJG
QyA4Njg0IGFuZCBSRkMgNjgyNCBpcyB0aGF0IGl0IGhhcyBhIGJldHRlcjxiciBjbGFzcz0iIj5z
dXBwb3J0IGZvciBzZXJ2ZXJzIHVzaW5nIFRDUCBTWU4tY29va2llcyBieSByZWxpYWJseSByZXRy
YW5zbWl0dGluZyB0aGU8YnIgY2xhc3M9IiI+TVBfQ0FQQUJMRSBvcHRpb24uPGJyIGNsYXNzPSIi
PjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+Q2xvbmUvZmV0Y2g6PGJyIGNsYXNzPSIiPjxhIGhy
ZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LmdpdCIg
Y2xhc3M9IiI+aHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQu
Z2l0PC9hPiZuYnNwOyh0YWc6IG5ldGRldi12My1wYXJ0Mik8YnIgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPkJyb3dzZTo8YnIgY2xhc3M9IiI+PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL211bHRp
cGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvdHJlZS9uZXRkZXYtdjMtcGFydDIiIGNsYXNzPSIiPmh0
dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0L3RyZWUvbmV0ZGV2
LXYzLXBhcnQyPC9hPjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhhbmsgeW91IGZvciB5b3Vy
IHJldmlldy4gWW91IGNhbiBmaW5kIHVzIGF0Jm5ic3A7PGEgaHJlZj0ibWFpbHRvOm1wdGNwQGxp
c3RzLjAxLm9yZyIgY2xhc3M9IiI+bXB0Y3BAbGlzdHMuMDEub3JnPC9hPiZuYnNwO2FuZDxiciBj
bGFzcz0iIj48YSBocmVmPSJodHRwczovL2lzLmdkL21wdGNwX3Vwc3RyZWFtIiBjbGFzcz0iIj5o
dHRwczovL2lzLmdkL21wdGNwX3Vwc3RyZWFtPC9hPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PT09PT09PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIg
Y2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5DaGVlcnMsPC9kaXY+PGRpdiBjbGFzcz0iIj5D
aHJpc3RvcGg8L2Rpdj48L2JvZHk+PC9odG1sPg==
--===============1767801214906686396==--
