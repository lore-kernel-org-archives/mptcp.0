Content-Type: multipart/mixed; boundary="===============3251468665756811141=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Thu, 12 Dec 2019 17:19:10 -0800
Message-ID: <7E333AF6-9EBB-4809-B3B2-EE633A5A89C6@apple.com>
In-Reply-To: alpine.OSX.2.21.1912051635040.57359@pminglan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2920

--===============3251468665756811141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

for part 3:

=3D=3D=3D=3D=3D=3D=3D


Subject: [PATCH net-next 0/0] Multipath TCP part 3: MP_CAPABLE handshake

These patches depend on the "Multipath TCP part 2: Single subflow"
patch set sent earlier.

In this set we add the necessary code for the MP_CAPABLE exchange,
negotiating the MPTCP-version, keys and some flags. The handshake
has been specified such that it works reliably with servers using TCP SYN-c=
ookies
although the current implementation does not yet support SYN cookies.

<git tree references at github>

Thank your for your review. You can find us at mptcp(a)lists.01.org <mailto=
:mptcp(a)lists.01.org> and
https://is.gd/mptcp_upstream <https://is.gd/mptcp_upstream>.



=3D=3D=3D=3D=3D=3D



Please let me know if something should be changed.


Christoph




> On Dec 5, 2019, at 4:41 PM, Mat Martineau <mathew.j.martineau(a)linux.int=
el.com> wrote:
> =

> =

> Hello everyone -
> =

> As we discussed earlier today, here are draft cover letters for patch set=
 parts 1 & 2. Feedback appreciated!
> =

> =

> ------
> Part 1
> =

> Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites
> =

> The MPTCP upstreaming community has been collaborating on an
> upstreamable MPTCP implementation. David requested that we split this
> work in to multiple, smaller patch sets to build up MPTCP
> infrastructure. The scope of this first patch set is limited to
> prerequisite TCP core changes so we can get focused feedback in these
> areas.
> =

> In this patch set we introduce some MPTCP definitions, additional ULP
> and skb extension features, TCP option space checking, and a few
> exported symbols.
> =

> <git tree references at github>
> =

> Thank you for your review. You can find us at mptcp(a)lists.01.org and
> https://is.gd/mptcp_upstream
> =

> =

> ------
> Part 2
> =

> Subject: [PATCH net-next 0/0] Multipath TCP part 2: Single subflow
> =

> These patches depend on the "Multipath TCP part 1: Prerequisites" patch
> set sent earlier.
> =

> This set adds MPTCP connection establishment, writing & reading MPTCP
> options on data packets, a sysctl to allow MPTCP per-namespace, and self
> tests. This is sufficient to establish and maintain a connection with a
> MPTCP peer, but will not yet allow or initiate establishment of
> additional MPTCP subflows.
> =

> <git tree references at github>
> =

> Thank you for your review. You can find us at mptcp(a)lists.01.org and
> https://is.gd/mptcp_upstream
> =

> =

> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org


--===============3251468665756811141==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IZWxsbyw8L2Rpdj48ZGl2IGNsYXNz
PSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPmZvciBwYXJ0IDM6PC9kaXY+PGRp
diBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj49PT09PT09PC9kaXY+
PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5TdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgMC8wXSBNdWx0
aXBhdGggVENQIHBhcnQgMzogTVBfQ0FQQUJMRSBoYW5kc2hha2U8L2Rpdj48ZGl2IGNsYXNzPSIi
PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPlRoZXNlIHBhdGNoZXMgZGVwZW5kIG9u
IHRoZSAiTXVsdGlwYXRoIFRDUCBwYXJ0IDI6IFNpbmdsZSBzdWJmbG93IjwvZGl2PjxkaXYgY2xh
c3M9IiI+cGF0Y2ggc2V0IHNlbnQgZWFybGllci48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkluIHRoaXMgc2V0IHdlIGFkZCB0aGUgbmVjZXNzYXJ5
IGNvZGUgZm9yIHRoZSBNUF9DQVBBQkxFIGV4Y2hhbmdlLDwvZGl2PjxkaXYgY2xhc3M9IiI+bmVn
b3RpYXRpbmcgdGhlIE1QVENQLXZlcnNpb24sIGtleXMgYW5kIHNvbWUgZmxhZ3MuIFRoZSBoYW5k
c2hha2U8L2Rpdj48ZGl2IGNsYXNzPSIiPmhhcyBiZWVuIHNwZWNpZmllZCBzdWNoIHRoYXQgaXQg
d29ya3MgcmVsaWFibHkgd2l0aCBzZXJ2ZXJzIHVzaW5nIFRDUCBTWU4tY29va2llczwvZGl2Pjxk
aXYgY2xhc3M9IiI+YWx0aG91Z2ggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lcyBub3Qg
eWV0IHN1cHBvcnQgU1lOIGNvb2tpZXMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
PC9kaXY+PGRpdiBjbGFzcz0iIj4mbHQ7Z2l0IHRyZWUgcmVmZXJlbmNlcyBhdCBnaXRodWImZ3Q7
PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5UaGFu
ayB5b3VyIGZvciB5b3VyIHJldmlldy4gWW91IGNhbiBmaW5kIHVzIGF0IDxhIGhyZWY9Im1haWx0
bzptcHRjcEBsaXN0cy4wMS5vcmciIGNsYXNzPSIiPm1wdGNwQGxpc3RzLjAxLm9yZzwvYT4mbmJz
cDthbmQ8L2Rpdj48ZGl2IGNsYXNzPSIiPjxhIGhyZWY9Imh0dHBzOi8vaXMuZ2QvbXB0Y3BfdXBz
dHJlYW0iIGNsYXNzPSIiPmh0dHBzOi8vaXMuZ2QvbXB0Y3BfdXBzdHJlYW08L2E+LjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj49PT09PT08L2Rpdj48ZGl2PjxiciBjbGFz
cz0iIj48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2PlBsZWFzZSBsZXQgbWUga25vdyBpZiBzb21ldGhpbmcgc2hvdWxkIGJlIGNoYW5nZWQu
PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRp
dj5DaHJpc3RvcGg8L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPk9uIERlYyA1LCAyMDE5LCBh
dCA0OjQxIFBNLCBNYXQgTWFydGluZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWF0aGV3LmoubWFy
dGluZWF1QGxpbnV4LmludGVsLmNvbSIgY2xhc3M9IiI+bWF0aGV3LmoubWFydGluZWF1QGxpbnV4
LmludGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFu
Z2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj5IZWxs
byBldmVyeW9uZSAtPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5BcyB3ZSBkaXNjdXNzZWQgZWFy
bGllciB0b2RheSwgaGVyZSBhcmUgZHJhZnQgY292ZXIgbGV0dGVycyBmb3IgcGF0Y2ggc2V0IHBh
cnRzIDEgJmFtcDsgMi4gRmVlZGJhY2sgYXBwcmVjaWF0ZWQhPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+LS0tLS0tPGJyIGNsYXNzPSIiPlBhcnQgMTxiciBjbGFzcz0iIj48
YnIgY2xhc3M9IiI+U3ViamVjdDogW1BBVENIIG5ldC1uZXh0IDAvMF0gTXVsdGlwYXRoIFRDUCBw
YXJ0IDE6IFByZXJlcXVpc2l0ZXM8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPlRoZSBNUFRDUCB1
cHN0cmVhbWluZyBjb21tdW5pdHkgaGFzIGJlZW4gY29sbGFib3JhdGluZyBvbiBhbjxiciBjbGFz
cz0iIj51cHN0cmVhbWFibGUgTVBUQ1AgaW1wbGVtZW50YXRpb24uIERhdmlkIHJlcXVlc3RlZCB0
aGF0IHdlIHNwbGl0IHRoaXM8YnIgY2xhc3M9IiI+d29yayBpbiB0byBtdWx0aXBsZSwgc21hbGxl
ciBwYXRjaCBzZXRzIHRvIGJ1aWxkIHVwIE1QVENQPGJyIGNsYXNzPSIiPmluZnJhc3RydWN0dXJl
LiBUaGUgc2NvcGUgb2YgdGhpcyBmaXJzdCBwYXRjaCBzZXQgaXMgbGltaXRlZCB0bzxiciBjbGFz
cz0iIj5wcmVyZXF1aXNpdGUgVENQIGNvcmUgY2hhbmdlcyBzbyB3ZSBjYW4gZ2V0IGZvY3VzZWQg
ZmVlZGJhY2sgaW4gdGhlc2U8YnIgY2xhc3M9IiI+YXJlYXMuPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj5JbiB0aGlzIHBhdGNoIHNldCB3ZSBpbnRyb2R1Y2Ugc29tZSBNUFRDUCBkZWZpbml0aW9u
cywgYWRkaXRpb25hbCBVTFA8YnIgY2xhc3M9IiI+YW5kIHNrYiBleHRlbnNpb24gZmVhdHVyZXMs
IFRDUCBvcHRpb24gc3BhY2UgY2hlY2tpbmcsIGFuZCBhIGZldzxiciBjbGFzcz0iIj5leHBvcnRl
ZCBzeW1ib2xzLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+Jmx0O2dpdCB0cmVlIHJlZmVyZW5j
ZXMgYXQgZ2l0aHViJmd0OzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhhbmsgeW91IGZvciB5
b3VyIHJldmlldy4gWW91IGNhbiBmaW5kIHVzIGF0IDxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0
cy4wMS5vcmciIGNsYXNzPSIiPm1wdGNwQGxpc3RzLjAxLm9yZzwvYT4gYW5kPGJyIGNsYXNzPSIi
PjxhIGhyZWY9Imh0dHBzOi8vaXMuZ2QvbXB0Y3BfdXBzdHJlYW0iIGNsYXNzPSIiPmh0dHBzOi8v
aXMuZ2QvbXB0Y3BfdXBzdHJlYW08L2E+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+LS0tLS0tPGJyIGNsYXNzPSIiPlBhcnQgMjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
U3ViamVjdDogW1BBVENIIG5ldC1uZXh0IDAvMF0gTXVsdGlwYXRoIFRDUCBwYXJ0IDI6IFNpbmds
ZSBzdWJmbG93PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGVzZSBwYXRjaGVzIGRlcGVuZCBv
biB0aGUgIk11bHRpcGF0aCBUQ1AgcGFydCAxOiBQcmVyZXF1aXNpdGVzIiBwYXRjaDxiciBjbGFz
cz0iIj5zZXQgc2VudCBlYXJsaWVyLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhpcyBzZXQg
YWRkcyBNUFRDUCBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQsIHdyaXRpbmcgJmFtcDsgcmVhZGlu
ZyBNUFRDUDxiciBjbGFzcz0iIj5vcHRpb25zIG9uIGRhdGEgcGFja2V0cywgYSBzeXNjdGwgdG8g
YWxsb3cgTVBUQ1AgcGVyLW5hbWVzcGFjZSwgYW5kIHNlbGY8YnIgY2xhc3M9IiI+dGVzdHMuIFRo
aXMgaXMgc3VmZmljaWVudCB0byBlc3RhYmxpc2ggYW5kIG1haW50YWluIGEgY29ubmVjdGlvbiB3
aXRoIGE8YnIgY2xhc3M9IiI+TVBUQ1AgcGVlciwgYnV0IHdpbGwgbm90IHlldCBhbGxvdyBvciBp
bml0aWF0ZSBlc3RhYmxpc2htZW50IG9mPGJyIGNsYXNzPSIiPmFkZGl0aW9uYWwgTVBUQ1Agc3Vi
Zmxvd3MuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4mbHQ7Z2l0IHRyZWUgcmVmZXJlbmNlcyBh
dCBnaXRodWImZ3Q7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGFuayB5b3UgZm9yIHlvdXIg
cmV2aWV3LiBZb3UgY2FuIGZpbmQgdXMgYXQgbXB0Y3BAbGlzdHMuMDEub3JnIGFuZDxiciBjbGFz
cz0iIj5odHRwczovL2lzLmdkL21wdGNwX3Vwc3RyZWFtPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+LS08YnIgY2xhc3M9IiI+TWF0IE1hcnRpbmVhdTxiciBjbGFzcz0iIj5J
bnRlbDxiciBjbGFzcz0iIj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXzxiciBjbGFzcz0iIj5tcHRjcCBtYWlsaW5nIGxpc3QgLS0gbXB0Y3BAbGlzdHMuMDEu
b3JnPGJyIGNsYXNzPSIiPlRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbXB0Y3AtbGVh
dmVAbGlzdHMuMDEub3JnPGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rp
dj48YnIgY2xhc3M9IiI+PC9kaXY+PC9ib2R5PjwvaHRtbD4=
--===============3251468665756811141==--
