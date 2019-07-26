Content-Type: multipart/mixed; boundary="===============2950411631877840603=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/9] Implement outgoing MP_JOIN
Date: Thu, 25 Jul 2019 17:11:48 -0700
Message-ID: <761DA2E0-5575-4107-BD5A-D179731BEC12@apple.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1555

--===============2950411631877840603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Jul 17, 2019, at 3:12 PM, Peter Krystad <peter.krystad(a)linux.intel.c=
om> wrote:
> =

> This is several accumulated fixes that are required for MP_JOIN
> (secondary subflows) plus the outgoing code.
> =

> Both outgoing and incoming MP_JOIN now inter-operate
> with the multipath.org implementation although there is
> still a deadlock when incoming is fully established.
> Since the incoming direction did not work at all before
> this is an improvement. I have not yet tested running our
> implmentation against itself.
> =

> The final patch in the set is an "interim path manager", this
> is throw-away code that I include for testing purposes. For an
> incoming connection it is necessary for the server to advertise
> a secondary address

Just as an FYI:

if you are testing the upstreaming-MPTCP on the server-side and multipath-t=
cp.org <http://multipath-tcp.org/> on the client-side, you can configure on=
 the client the ndiffports path-manager. That makes the client establish su=
bflows even if there are not multiple IPs on the host, simply among the sam=
e IP-addresses by using different port-numbers.


That way you don't need to force the ADD_ADDR from the server.


Cheers,
Christoph


> and for my testing I have been hard-coding the IP
> address of my secondary interface when I build the kernel.
> Obviously not the final solution but we need to discuss what
> approach to use for the self tests. I also think we may not want
> to publish this patch on our net-next branch.
> =

> Peter Krystad (9):
>  Extend path manager interface
>  Fix locking in mptcp_finish_join.
>  Fix parsing MP_JOIN third ACK.
>  Re-factor and fixes for crypto_hmac_sha1()
>  Rename mptcp_attach_dss()
>  Fix return value if no DSS option is created.
>  Move setting request_ fields of subflow to MPTCP layer
>  mptcp: Add handling of outgoing MP_JOIN requests
>  mptcp: Implement interim path manager
> =

> include/net/mptcp.h  |  12 +--
> net/ipv4/tcp_input.c |   4 +-
> net/mptcp/crypto.c   |  23 +++---
> net/mptcp/options.c  |  77 ++++++++++++++++---
> net/mptcp/pm.c       | 171 +++++++++++++++++++++++++++++++++++++++++--
> net/mptcp/protocol.c |  29 ++++++--
> net/mptcp/protocol.h |  54 +++++++++++---
> net/mptcp/subflow.c  |  72 ++++++++++++++++--
> net/mptcp/token.c    |  82 ++++++++++++++++++---
> 9 files changed, 452 insertions(+), 72 deletions(-)
> =

> -- =

> 2.17.2
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2950411631877840603==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gSnVsIDE3LCAyMDE5
LCBhdCAzOjEyIFBNLCBQZXRlciBLcnlzdGFkICZsdDs8YSBocmVmPSJtYWlsdG86cGV0ZXIua3J5
c3RhZEBsaW51eC5pbnRlbC5jb20iIGNsYXNzPSIiPnBldGVyLmtyeXN0YWRAbGludXguaW50ZWwu
Y29tPC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5nZS1uZXds
aW5lIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+VGhpcyBpcyBzZXZlcmFsIGFjY3VtdWxh
dGVkIGZpeGVzIHRoYXQgYXJlIHJlcXVpcmVkIGZvciBNUF9KT0lOPGJyIGNsYXNzPSIiPihzZWNv
bmRhcnkgc3ViZmxvd3MpIHBsdXMgdGhlIG91dGdvaW5nIGNvZGUuPGJyIGNsYXNzPSIiPjxiciBj
bGFzcz0iIj5Cb3RoIG91dGdvaW5nIGFuZCBpbmNvbWluZyBNUF9KT0lOIG5vdyBpbnRlci1vcGVy
YXRlPGJyIGNsYXNzPSIiPndpdGggdGhlIDxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgub3JnIiBj
bGFzcz0iIj5tdWx0aXBhdGgub3JnPC9hPiBpbXBsZW1lbnRhdGlvbiBhbHRob3VnaCB0aGVyZSBp
czxiciBjbGFzcz0iIj5zdGlsbCBhIGRlYWRsb2NrIHdoZW4gaW5jb21pbmcgaXMgZnVsbHkgZXN0
YWJsaXNoZWQuPGJyIGNsYXNzPSIiPlNpbmNlIHRoZSBpbmNvbWluZyBkaXJlY3Rpb24gZGlkIG5v
dCB3b3JrIGF0IGFsbCBiZWZvcmU8YnIgY2xhc3M9IiI+dGhpcyBpcyBhbiBpbXByb3ZlbWVudC4g
SSBoYXZlIG5vdCB5ZXQgdGVzdGVkIHJ1bm5pbmcgb3VyPGJyIGNsYXNzPSIiPmltcGxtZW50YXRp
b24gYWdhaW5zdCBpdHNlbGYuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGUgZmluYWwgcGF0
Y2ggaW4gdGhlIHNldCBpcyBhbiAiaW50ZXJpbSBwYXRoIG1hbmFnZXIiLCB0aGlzPGJyIGNsYXNz
PSIiPmlzIHRocm93LWF3YXkgY29kZSB0aGF0IEkgaW5jbHVkZSBmb3IgdGVzdGluZyBwdXJwb3Nl
cy4gRm9yIGFuPGJyIGNsYXNzPSIiPmluY29taW5nIGNvbm5lY3Rpb24gaXQgaXMgbmVjZXNzYXJ5
IGZvciB0aGUgc2VydmVyIHRvIGFkdmVydGlzZTxiciBjbGFzcz0iIj5hIHNlY29uZGFyeSBhZGRy
ZXNzPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+
SnVzdCBhcyBhbiBGWUk6PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5pZiB5b3Ug
YXJlIHRlc3RpbmcgdGhlIHVwc3RyZWFtaW5nLU1QVENQIG9uIHRoZSBzZXJ2ZXItc2lkZSBhbmQg
PGEgaHJlZj0iaHR0cDovL211bHRpcGF0aC10Y3Aub3JnIiBjbGFzcz0iIj5tdWx0aXBhdGgtdGNw
Lm9yZzwvYT4mbmJzcDtvbiB0aGUgY2xpZW50LXNpZGUsIHlvdSBjYW4gY29uZmlndXJlIG9uIHRo
ZSBjbGllbnQgdGhlIG5kaWZmcG9ydHMgcGF0aC1tYW5hZ2VyLiBUaGF0IG1ha2VzIHRoZSBjbGll
bnQgZXN0YWJsaXNoIHN1YmZsb3dzIGV2ZW4gaWYgdGhlcmUgYXJlIG5vdCBtdWx0aXBsZSBJUHMg
b24gdGhlIGhvc3QsIHNpbXBseSBhbW9uZyB0aGUgc2FtZSBJUC1hZGRyZXNzZXMgYnkgdXNpbmcg
ZGlmZmVyZW50IHBvcnQtbnVtYmVycy48L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2
PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2PlRoYXQgd2F5IHlvdSBkb24ndCBuZWVkIHRvIGZvcmNl
IHRoZSBBRERfQUREUiBmcm9tIHRoZSBzZXJ2ZXIuPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5DaHJpc3Rv
cGg8L2Rpdj48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUg
dHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPiBhbmQgZm9y
IG15IHRlc3RpbmcgSSBoYXZlIGJlZW4gaGFyZC1jb2RpbmcgdGhlIElQPGJyIGNsYXNzPSIiPmFk
ZHJlc3Mgb2YgbXkgc2Vjb25kYXJ5IGludGVyZmFjZSB3aGVuIEkgYnVpbGQgdGhlIGtlcm5lbC48
YnIgY2xhc3M9IiI+T2J2aW91c2x5IG5vdCB0aGUgZmluYWwgc29sdXRpb24gYnV0IHdlIG5lZWQg
dG8gZGlzY3VzcyB3aGF0PGJyIGNsYXNzPSIiPmFwcHJvYWNoIHRvIHVzZSBmb3IgdGhlIHNlbGYg
dGVzdHMuIEkgYWxzbyB0aGluayB3ZSBtYXkgbm90IHdhbnQ8YnIgY2xhc3M9IiI+dG8gcHVibGlz
aCB0aGlzIHBhdGNoIG9uIG91ciBuZXQtbmV4dCBicmFuY2guPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj5QZXRlciBLcnlzdGFkICg5KTo8YnIgY2xhc3M9IiI+ICZuYnNwO0V4dGVuZCBwYXRoIG1h
bmFnZXIgaW50ZXJmYWNlPGJyIGNsYXNzPSIiPiAmbmJzcDtGaXggbG9ja2luZyBpbiBtcHRjcF9m
aW5pc2hfam9pbi48YnIgY2xhc3M9IiI+ICZuYnNwO0ZpeCBwYXJzaW5nIE1QX0pPSU4gdGhpcmQg
QUNLLjxiciBjbGFzcz0iIj4gJm5ic3A7UmUtZmFjdG9yIGFuZCBmaXhlcyBmb3IgY3J5cHRvX2ht
YWNfc2hhMSgpPGJyIGNsYXNzPSIiPiAmbmJzcDtSZW5hbWUgbXB0Y3BfYXR0YWNoX2RzcygpPGJy
IGNsYXNzPSIiPiAmbmJzcDtGaXggcmV0dXJuIHZhbHVlIGlmIG5vIERTUyBvcHRpb24gaXMgY3Jl
YXRlZC48YnIgY2xhc3M9IiI+ICZuYnNwO01vdmUgc2V0dGluZyByZXF1ZXN0XyBmaWVsZHMgb2Yg
c3ViZmxvdyB0byBNUFRDUCBsYXllcjxiciBjbGFzcz0iIj4gJm5ic3A7bXB0Y3A6IEFkZCBoYW5k
bGluZyBvZiBvdXRnb2luZyBNUF9KT0lOIHJlcXVlc3RzPGJyIGNsYXNzPSIiPiAmbmJzcDttcHRj
cDogSW1wbGVtZW50IGludGVyaW0gcGF0aCBtYW5hZ2VyPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij4gaW5jbHVkZS9uZXQvbXB0Y3AuaCAmbmJzcDt8ICZuYnNwOzEyICstLTxiciBjbGFzcz0iIj4g
bmV0L2lwdjQvdGNwX2lucHV0LmMgfCAmbmJzcDsmbmJzcDs0ICstPGJyIGNsYXNzPSIiPiBuZXQv
bXB0Y3AvY3J5cHRvLmMgJm5ic3A7Jm5ic3A7fCAmbmJzcDsyMyArKystLS08YnIgY2xhc3M9IiI+
IG5ldC9tcHRjcC9vcHRpb25zLmMgJm5ic3A7fCAmbmJzcDs3NyArKysrKysrKysrKysrKysrLS0t
PGJyIGNsYXNzPSIiPiBuZXQvbXB0Y3AvcG0uYyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDt8IDE3MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
PGJyIGNsYXNzPSIiPiBuZXQvbXB0Y3AvcHJvdG9jb2wuYyB8ICZuYnNwOzI5ICsrKysrKy0tPGJy
IGNsYXNzPSIiPiBuZXQvbXB0Y3AvcHJvdG9jb2wuaCB8ICZuYnNwOzU0ICsrKysrKysrKysrLS0t
PGJyIGNsYXNzPSIiPiBuZXQvbXB0Y3Avc3ViZmxvdy5jICZuYnNwO3wgJm5ic3A7NzIgKysrKysr
KysrKysrKysrKy0tPGJyIGNsYXNzPSIiPiBuZXQvbXB0Y3AvdG9rZW4uYyAmbmJzcDsmbmJzcDsm
bmJzcDt8ICZuYnNwOzgyICsrKysrKysrKysrKysrKysrKy0tLTxiciBjbGFzcz0iIj4gOSBmaWxl
cyBjaGFuZ2VkLCA0NTIgaW5zZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pPGJyIGNsYXNzPSIi
PjxiciBjbGFzcz0iIj4tLSA8YnIgY2xhc3M9IiI+Mi4xNy4yPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxiciBj
bGFzcz0iIj5tcHRjcCBtYWlsaW5nIGxpc3Q8YnIgY2xhc3M9IiI+PGEgaHJlZj0ibWFpbHRvOm1w
dGNwQGxpc3RzLjAxLm9yZyIgY2xhc3M9IiI+bXB0Y3BAbGlzdHMuMDEub3JnPC9hPjxiciBjbGFz
cz0iIj5odHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL21wdGNwPGJyIGNsYXNz
PSIiPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnIgY2xhc3M9IiI+PC9ib2R5Pjwv
aHRtbD4=
--===============2950411631877840603==--
