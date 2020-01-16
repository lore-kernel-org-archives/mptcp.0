Content-Type: multipart/mixed; boundary="===============8347614394106312819=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Part 2 - Cover Letter
Date: Thu, 16 Jan 2020 14:47:37 -0800
Message-ID: <FDE750BB-804A-428B-B31A-9B5539276D3A@apple.com>
In-Reply-To: AFDCA786-3364-46AA-9227-558148BD463A@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3385

--===============8347614394106312819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Jan 16, 2020, at 10:07 AM, Christoph Paasch <cpaasch(a)apple.com> wrot=
e:
> =

> Hello,
> =

> here is the proposed cover-letter for Part 2. I assume that it will be "v=
3" as Mat already sent out the v2 before Christmas.
> =

> Please let me know what should be changed.
> =

> =3D=3D=3D=3D=3D=3D
> =

> Subject: [PATCH net-next v3 ...] Multipath TCP part 2: Single subflow
> =

> v2 -> v3: Added RFC8684-style handshake and some minor fixes
> v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
> =

> This set adds MPTCP connection establishment, writing & reading MPTCP
> options on data packets, a sysctl to allow MPTCP per-namespace, and self
> tests. This is sufficient to establish and maintain a connection with a
> MPTCP peer, but will not yet allow or initiate establishment of
> additional MPTCP subflows.
> =

> We also add the necessary code for the RFC8684-style handshake.
> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> version 1.
> =

> The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> deployments are currently based on RFC 6824, future deployments will be
> migrating to MPTCP version 1. 3GPP's 5G standardization also solely suppo=
rts
> RFC 8684. Also, we believe that this initial submission of MPTCP will be
> cleaner by solely supporting RFC 8684. If later on support for the old
> MPTCP-version is required it can always be added in the future.
> =

> The major difference between RFC 8684 and RFC 6824 is that it has a better
> support for servers using TCP SYN-cookies by reliably retransmitting the
> MP_CAPABLE option.

I forgot the Twitter reference! Matth, any good ideas for a joke? :-)


Christoph

> =

> =

> Clone/fetch:
> https://github.com/multipath-tcp/mptcp_net-next.git <https://github.com/m=
ultipath-tcp/mptcp_net-next.git> (tag: netdev-v3-part2)
> =

> Browse:
> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2 <htt=
ps://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v3-part2>
> =

> Thank you for your review. You can find us at mptcp(a)lists.01.org <mailt=
o:mptcp(a)lists.01.org> and
> https://is.gd/mptcp_upstream <https://is.gd/mptcp_upstream>
> =

> =3D=3D=3D=3D=3D=3D
> =

> Cheers,
> Christoph


--===============8347614394106312819==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gSmFuIDE2LCAyMDIw
LCBhdCAxMDowNyBBTSwgQ2hyaXN0b3BoIFBhYXNjaCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNwYWFz
Y2hAYXBwbGUuY29tIiBjbGFzcz0iIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7IHdyb3RlOjwv
ZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0iIj48
bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNl
dD11cy1hc2NpaSIgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAt
d2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIg
Y2xhc3M9IiI+SGVsbG8sPGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFz
cz0iIj5oZXJlIGlzIHRoZSBwcm9wb3NlZCBjb3Zlci1sZXR0ZXIgZm9yIFBhcnQgMi4gSSBhc3N1
bWUgdGhhdCBpdCB3aWxsIGJlICJ2MyIgYXMgTWF0IGFscmVhZHkgc2VudCBvdXQgdGhlIHYyIGJl
Zm9yZSBDaHJpc3RtYXMuPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRp
diBjbGFzcz0iIj5QbGVhc2UgbGV0IG1lIGtub3cgd2hhdCBzaG91bGQgYmUgY2hhbmdlZC48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPj09PT09PTwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+U3ViamVj
dDogW1BBVENIIG5ldC1uZXh0IHYzIC4uLl0mbmJzcDtNdWx0aXBhdGggVENQIHBhcnQgMjogU2lu
Z2xlIHN1YmZsb3c8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNs
YXNzPSIiPnYyIC0mZ3Q7IHYzOiBBZGRlZCBSRkM4Njg0LXN0eWxlIGhhbmRzaGFrZSBhbmQgc29t
ZSBtaW5vciBmaXhlczxiciBjbGFzcz0iIj52MSAtJmd0OyB2MjogUmViYXNlZCBvbiBsYXRlc3Qg
Ik11bHRpcGF0aCBUQ1A6IFByZXJlcXVpc2l0ZXMiIHYzIHNlcmllczxiciBjbGFzcz0iIj48YnIg
Y2xhc3M9IiI+VGhpcyBzZXQgYWRkcyBNUFRDUCBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQsIHdy
aXRpbmcgJmFtcDsgcmVhZGluZyBNUFRDUDxiciBjbGFzcz0iIj5vcHRpb25zIG9uIGRhdGEgcGFj
a2V0cywgYSBzeXNjdGwgdG8gYWxsb3cgTVBUQ1AgcGVyLW5hbWVzcGFjZSwgYW5kIHNlbGY8YnIg
Y2xhc3M9IiI+dGVzdHMuIFRoaXMgaXMgc3VmZmljaWVudCB0byBlc3RhYmxpc2ggYW5kIG1haW50
YWluIGEgY29ubmVjdGlvbiB3aXRoIGE8YnIgY2xhc3M9IiI+TVBUQ1AgcGVlciwgYnV0IHdpbGwg
bm90IHlldCBhbGxvdyBvciBpbml0aWF0ZSBlc3RhYmxpc2htZW50IG9mPGJyIGNsYXNzPSIiPmFk
ZGl0aW9uYWwgTVBUQ1Agc3ViZmxvd3MuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5XZSBhbHNv
IGFkZCB0aGUgbmVjZXNzYXJ5IGNvZGUgZm9yIHRoZSBSRkM4Njg0LXN0eWxlIGhhbmRzaGFrZS48
YnIgY2xhc3M9IiI+UkZDODY4NCBvYnNvbGV0ZXMgdGhlIGV4cGVyaW1lbnRhbCBSRkM2ODI0IGFu
ZCBtYWtlcyBNUFRDUCBtb3ZlLW9uIHRvPGJyIGNsYXNzPSIiPnZlcnNpb24gMS48YnIgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPlRoZSBNUFRDUCBwYXRjaHNldCBleGNsdXNpdmVseSBzdXBwb3J0cyBS
RkMgODY4NC4gQWx0aG91Z2ggYWxsIE1QVENQPGJyIGNsYXNzPSIiPmRlcGxveW1lbnRzIGFyZSBj
dXJyZW50bHkgYmFzZWQgb24gUkZDIDY4MjQsIGZ1dHVyZSBkZXBsb3ltZW50cyB3aWxsIGJlPGJy
IGNsYXNzPSIiPm1pZ3JhdGluZyB0byBNUFRDUCB2ZXJzaW9uIDEuIDNHUFAncyA1RyBzdGFuZGFy
ZGl6YXRpb24gYWxzbyBzb2xlbHkgc3VwcG9ydHM8YnIgY2xhc3M9IiI+UkZDIDg2ODQuIEFsc28s
IHdlIGJlbGlldmUgdGhhdCB0aGlzIGluaXRpYWwgc3VibWlzc2lvbiBvZiBNUFRDUCB3aWxsIGJl
PGJyIGNsYXNzPSIiPmNsZWFuZXIgYnkgc29sZWx5IHN1cHBvcnRpbmcgUkZDIDg2ODQuIElmIGxh
dGVyIG9uIHN1cHBvcnQgZm9yIHRoZSBvbGQ8YnIgY2xhc3M9IiI+TVBUQ1AtdmVyc2lvbiBpcyBy
ZXF1aXJlZCBpdCBjYW4gYWx3YXlzIGJlIGFkZGVkIGluIHRoZSBmdXR1cmUuPGJyIGNsYXNzPSIi
PjxiciBjbGFzcz0iIj5UaGUgbWFqb3IgZGlmZmVyZW5jZSBiZXR3ZWVuIFJGQyA4Njg0IGFuZCBS
RkMgNjgyNCBpcyB0aGF0IGl0IGhhcyBhIGJldHRlcjxiciBjbGFzcz0iIj5zdXBwb3J0IGZvciBz
ZXJ2ZXJzIHVzaW5nIFRDUCBTWU4tY29va2llcyBieSByZWxpYWJseSByZXRyYW5zbWl0dGluZyB0
aGU8YnIgY2xhc3M9IiI+TVBfQ0FQQUJMRSBvcHRpb24uPGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2
PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PkkgZm9yZ290
IHRoZSBUd2l0dGVyIHJlZmVyZW5jZSEgTWF0dGgsIGFueSBnb29kIGlkZWFzIGZvciBhIGpva2U/
IDotKTwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2
PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUi
IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3Jk
OyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNl
OyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPkNsb25l
L2ZldGNoOjxiciBjbGFzcz0iIj48YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbXVsdGlwYXRo
LXRjcC9tcHRjcF9uZXQtbmV4dC5naXQiIGNsYXNzPSIiPmh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0
aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0LmdpdDwvYT4mbmJzcDsodGFnOiBuZXRkZXYtdjMtcGFy
dDIpPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5Ccm93c2U6PGJyIGNsYXNzPSIiPjxhIGhyZWY9
Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0L3RyZWUvbmV0
ZGV2LXYzLXBhcnQyIiBjbGFzcz0iIj5odHRwczovL2dpdGh1Yi5jb20vbXVsdGlwYXRoLXRjcC9t
cHRjcF9uZXQtbmV4dC90cmVlL25ldGRldi12My1wYXJ0MjwvYT48YnIgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPlRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuIFlvdSBjYW4gZmluZCB1cyBhdCZuYnNw
OzxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5vcmciIGNsYXNzPSIiPm1wdGNwQGxpc3Rz
LjAxLm9yZzwvYT4mbmJzcDthbmQ8YnIgY2xhc3M9IiI+PGEgaHJlZj0iaHR0cHM6Ly9pcy5nZC9t
cHRjcF91cHN0cmVhbSIgY2xhc3M9IiI+aHR0cHM6Ly9pcy5nZC9tcHRjcF91cHN0cmVhbTwvYT48
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPj09PT09
PTwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hl
ZXJzLDwvZGl2PjxkaXYgY2xhc3M9IiI+Q2hyaXN0b3BoPC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9j
a3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIj48L2JvZHk+PC9odG1sPg==
--===============8347614394106312819==--
