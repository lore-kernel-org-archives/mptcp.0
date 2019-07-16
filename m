Content-Type: multipart/mixed; boundary="===============8302645078476331163=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] about self-tests failures
Date: Tue, 16 Jul 2019 18:38:13 +0200
Message-ID: <E1CBF9A0-BAB8-4618-B70D-F2A7D0BD168A@apple.com>
In-Reply-To: 590f30b41103f8b1096afafe7865966a215a6506.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1498

--===============8302645078476331163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

> On Jul 16, 2019, at 3:21 PM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> =EF=BB=BFHi all,
> =

> I spent some time debugging the self-test failures, and I think I got
> the root cause.
> =

> The tests fails when, due to netem, the 3 way handshake final ack
> packet is dropped.
> =

> When that happen, the sender never emit the MP_CAPABLE option in later
> retrasmission (has the '!subflow->fourth_ack' condition in
> mptcp_established_options_mp() is always false).
> =

> As a result, on the server side, subflow_syn_recv_sock() always returns
> NULL - the session keys check fails - the connection is never
> established, and the server's select() never returns

I can=E2=80=99t check the code right now, but is there a specific reason wh=
y this doesn=E2=80=99t work on the server side? IMO, there is no need for a=
 session key check upon reception of the third ACK.

> I'm trying to address the issue forcing MP_CAPABLE option in
> retransmitted 3 way handshake ack packets, but I'm facing several
> issues, as the TCP stack tries hard to avoid retransmitting 'pure ack',
> preferring the following data packet, instead.
> =

> We can't attach the MP_CAPABLE opt to the next data segment, or such
> segment will lack the require DSS - unless we place both DSS and
> MP_CAPABLE in the same pkt.
> =

> @Christoph: can you please describe how this issue (3way hs ack drop)
> is handled from the mptcp.org implementation?

I think we have to separate between RFC6824 and RFC6824bis:

RFC6824:

As you saw, the MP_CAPABLE is sent in the third ACK which is unreliable. In=
 the mptcp.org implementation the server-side request-sock remembers the ke=
y it saw in the SYN segment. Thus, the information in the third ACK is redu=
ndant and so the server side still works even if the third ACK is lost. It =
simply knows that the client actually did ask for MPTCP in the SYN and thus=
 the state can be created.
I think it is important that the server remembers the MPTCP key in the SYN =
as part of the request-sock. And the server should not rely on the third AC=
K to contain the MP_CAPABLE.

You can see here: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.95/n=
et/mptcp/mptcp_ctrl.c#L2097 where we only check for MPTCP in the request-so=
ck.

There is one caveat to that: when SYN-cookies are used on the server, there=
 is no request-sock upon SYN reception and thus the server needs the third =
ACK to enable MPTCP. This means that if the third ACK is lost, we end up wi=
th regular TCP.

To handle this scenario we changed the handshake in RFC6824bis.

In RFC6824bis, the client transmits the keying information reliably togethe=
r with the first flight of data. That way, even servers with SYN cookies en=
abled can allow loss of the third ACK.


Christoph =



> Thanks,
> =

> Paolo

--===============8302645078476331163==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iIHJvbGU9InRleHRi
b3giIGFyaWEtbGFiZWw9Ik1lc3NhZ2UgQm9keSI+PGRpdiBkaXI9Imx0ciI+PHNwYW4+SGVsbG8s
PC9zcGFuPjxicj48c3Bhbj48L3NwYW4+PGJyPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxzcGFu
Pk9uIEp1bCAxNiwgMjAxOSwgYXQgMzoyMSBQTSwgUGFvbG8gQWJlbmkgJmx0O3BhYmVuaUByZWRo
YXQuY29tJmd0OyB3cm90ZTo8L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBl
PSJjaXRlIj48c3Bhbj48L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj48c3Bhbj7vu79IaSBhbGwsPC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUg
dHlwZT0iY2l0ZSI+PHNwYW4+PC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+PHNwYW4+SSBzcGVudCBzb21lIHRpbWUgZGVidWdnaW5nIHRoZSBzZWxmLXRlc3Qg
ZmFpbHVyZXMsIGFuZCBJIHRoaW5rIEkgZ290PC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+dGhlIHJvb3QgY2F1c2UuPC9zcGFuPjxicj48L2Jsb2Nr
cXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+PC9zcGFuPjxicj48L2Jsb2NrcXVv
dGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+VGhlIHRlc3RzIGZhaWxzIHdoZW4sIGR1
ZSB0byBuZXRlbSwgdGhlIDMgd2F5IGhhbmRzaGFrZSBmaW5hbCBhY2s8L3NwYW4+PGJyPjwvYmxv
Y2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj5wYWNrZXQgaXMgZHJvcHBlZC48
L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj48L3Nw
YW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj5XaGVuIHRo
YXQgaGFwcGVuLCB0aGUgc2VuZGVyIG5ldmVyIGVtaXQgdGhlIE1QX0NBUEFCTEUgb3B0aW9uIGlu
IGxhdGVyPC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNw
YW4+cmV0cmFzbWlzc2lvbiAoaGFzIHRoZSAnIXN1YmZsb3ctJmd0O2ZvdXJ0aF9hY2snIGNvbmRp
dGlvbiBpbjwvc3Bhbj48YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxz
cGFuPm1wdGNwX2VzdGFibGlzaGVkX29wdGlvbnNfbXAoKSBpcyBhbHdheXMgZmFsc2UpLjwvc3Bh
bj48YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxzcGFuPjwvc3Bhbj48
YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxzcGFuPkFzIGEgcmVzdWx0
LCBvbiB0aGUgc2VydmVyIHNpZGUsIHN1YmZsb3dfc3luX3JlY3Zfc29jaygpIGFsd2F5cyByZXR1
cm5zPC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+
TlVMTCAtIHRoZSBzZXNzaW9uIGtleXMgY2hlY2sgZmFpbHMgLSB0aGUgY29ubmVjdGlvbiBpcyBu
ZXZlcjwvc3Bhbj48YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPjxzcGFu
PmVzdGFibGlzaGVkLCBhbmQgdGhlIHNlcnZlcidzIHNlbGVjdCgpIG5ldmVyIHJldHVybnM8L3Nw
YW4+PC9ibG9ja3F1b3RlPjxkaXYgZGlyPSJsdHIiPjxicj48L2Rpdj48ZGl2IGRpcj0ibHRyIj5J
IGNhbuKAmXQgY2hlY2sgdGhlIGNvZGUgcmlnaHQgbm93LCBidXQgaXMgdGhlcmUgYSBzcGVjaWZp
YyByZWFzb24gd2h5IHRoaXMgZG9lc27igJl0IHdvcmsgb24gdGhlIHNlcnZlciBzaWRlPyBJTU8s
IHRoZXJlIGlzIG5vIG5lZWQgZm9yIGEgc2Vzc2lvbiBrZXkgY2hlY2sgdXBvbiByZWNlcHRpb24g
b2YgdGhlIHRoaXJkIEFDSy48L2Rpdj48YnI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+
SSdtIHRyeWluZyB0byBhZGRyZXNzIHRoZSBpc3N1ZSBmb3JjaW5nIE1QX0NBUEFCTEUgb3B0aW9u
IGluPC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+
cmV0cmFuc21pdHRlZCAzIHdheSBoYW5kc2hha2UgYWNrIHBhY2tldHMsIGJ1dCBJJ20gZmFjaW5n
IHNldmVyYWw8L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48
c3Bhbj5pc3N1ZXMsIGFzIHRoZSBUQ1Agc3RhY2sgdHJpZXMgaGFyZCB0byBhdm9pZCByZXRyYW5z
bWl0dGluZyAncHVyZSBhY2snLDwvc3Bhbj48YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiPjxzcGFuPnByZWZlcnJpbmcgdGhlIGZvbGxvd2luZyBkYXRhIHBhY2tldCwgaW5z
dGVhZC48L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bh
bj48L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj5X
ZSBjYW4ndCBhdHRhY2ggdGhlIE1QX0NBUEFCTEUgb3B0IHRvIHRoZSBuZXh0IGRhdGEgc2VnbWVu
dCwgb3Igc3VjaDwvc3Bhbj48YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUi
PjxzcGFuPnNlZ21lbnQgd2lsbCBsYWNrIHRoZSByZXF1aXJlIERTUyAtIHVubGVzcyB3ZSBwbGFj
ZSBib3RoIERTUyBhbmQ8L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJj
aXRlIj48c3Bhbj5NUF9DQVBBQkxFIGluIHRoZSBzYW1lIHBrdC48L3NwYW4+PGJyPjwvYmxvY2tx
dW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj48L3NwYW4+PGJyPjwvYmxvY2txdW90
ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj5AQ2hyaXN0b3BoOiBjYW4geW91IHBsZWFz
ZSBkZXNjcmliZSBob3cgdGhpcyBpc3N1ZSAoM3dheSBocyBhY2sgZHJvcCk8L3NwYW4+PGJyPjwv
YmxvY2txdW90ZT48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48c3Bhbj5pcyBoYW5kbGVkIGZyb20g
dGhlIG1wdGNwLm9yZyBpbXBsZW1lbnRhdGlvbj88L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48c3Bh
bj48L3NwYW4+PGJyPjxzcGFuPkkgdGhpbmsgd2UgaGF2ZSB0byBzZXBhcmF0ZSBiZXR3ZWVuIFJG
QzY4MjQgYW5kIFJGQzY4MjRiaXM6PC9zcGFuPjxicj48c3Bhbj48L3NwYW4+PGJyPjxzcGFuPlJG
QzY4MjQ6PC9zcGFuPjxicj48c3Bhbj48L3NwYW4+PGJyPjxzcGFuPkFzIHlvdSBzYXcsIHRoZSBN
UF9DQVBBQkxFIGlzIHNlbnQgaW4gdGhlIHRoaXJkIEFDSyB3aGljaCBpcyB1bnJlbGlhYmxlLiBJ
biB0aGUgbXB0Y3Aub3JnIGltcGxlbWVudGF0aW9uIHRoZSBzZXJ2ZXItc2lkZSByZXF1ZXN0LXNv
Y2sgcmVtZW1iZXJzIHRoZSBrZXkgaXQgc2F3IGluIHRoZSBTWU4gc2VnbWVudC4gVGh1cywgdGhl
IGluZm9ybWF0aW9uIGluIHRoZSB0aGlyZCBBQ0sgaXMgcmVkdW5kYW50IGFuZCBzbyB0aGUgc2Vy
dmVyIHNpZGUgc3RpbGwgd29ya3MgZXZlbiBpZiB0aGUgdGhpcmQgQUNLIGlzIGxvc3QuIEl0IHNp
bXBseSBrbm93cyB0aGF0IHRoZSBjbGllbnQgYWN0dWFsbHkgZGlkIGFzayBmb3IgTVBUQ1AgaW4g
dGhlIFNZTiBhbmQgdGh1cyB0aGUgc3RhdGUgY2FuIGJlIGNyZWF0ZWQuPC9zcGFuPjxicj48c3Bh
bj5JIHRoaW5rIGl0IGlzIGltcG9ydGFudCB0aGF0IHRoZSBzZXJ2ZXIgcmVtZW1iZXJzIHRoZSBN
UFRDUCBrZXkgaW4gdGhlIFNZTiBhcyBwYXJ0IG9mIHRoZSByZXF1ZXN0LXNvY2suIEFuZCB0aGUg
c2VydmVyIHNob3VsZCBub3QgcmVseSBvbiB0aGUgdGhpcmQgQUNLIHRvIGNvbnRhaW4gdGhlIE1Q
X0NBUEFCTEUuPC9zcGFuPjwvZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48L2Rpdj48ZGl2IGRpcj0i
bHRyIj5Zb3UgY2FuIHNlZSBoZXJlOiZuYnNwOzxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9t
dWx0aXBhdGgtdGNwL21wdGNwL2Jsb2IvbXB0Y3BfdjAuOTUvbmV0L21wdGNwL21wdGNwX2N0cmwu
YyNMMjA5NyI+aHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3AvYmxvYi9tcHRj
cF92MC45NS9uZXQvbXB0Y3AvbXB0Y3BfY3RybC5jI0wyMDk3PC9hPiZuYnNwO3doZXJlIHdlIG9u
bHkgY2hlY2sgZm9yIE1QVENQIGluIHRoZSByZXF1ZXN0LXNvY2suPGJyPjxzcGFuPjwvc3Bhbj48
YnI+PHNwYW4+VGhlcmUgaXMgb25lIGNhdmVhdCB0byB0aGF0OiB3aGVuIFNZTi1jb29raWVzIGFy
ZSB1c2VkIG9uIHRoZSBzZXJ2ZXIsIHRoZXJlIGlzIG5vIHJlcXVlc3Qtc29jayB1cG9uIFNZTiBy
ZWNlcHRpb24gYW5kIHRodXMgdGhlIHNlcnZlciBuZWVkcyB0aGUgdGhpcmQgQUNLIHRvIGVuYWJs
ZSBNUFRDUC4gVGhpcyBtZWFucyB0aGF0IGlmIHRoZSB0aGlyZCBBQ0sgaXMgbG9zdCwgd2UgZW5k
IHVwIHdpdGggcmVndWxhciBUQ1AuPC9zcGFuPjxicj48c3Bhbj48L3NwYW4+PGJyPjxzcGFuPlRv
IGhhbmRsZSB0aGlzIHNjZW5hcmlvIHdlIGNoYW5nZWQgdGhlIGhhbmRzaGFrZSBpbiBSRkM2ODI0
YmlzLjwvc3Bhbj48YnI+PHNwYW4+PC9zcGFuPjxicj48c3Bhbj5JbiBSRkM2ODI0YmlzLCB0aGUg
Y2xpZW50IHRyYW5zbWl0cyB0aGUga2V5aW5nIGluZm9ybWF0aW9uIHJlbGlhYmx5IHRvZ2V0aGVy
IHdpdGggdGhlIGZpcnN0IGZsaWdodCBvZiBkYXRhLiBUaGF0IHdheSwgZXZlbiBzZXJ2ZXJzIHdp
dGggU1lOIGNvb2tpZXMgZW5hYmxlZCBjYW4gYWxsb3cgbG9zcyBvZiB0aGUgdGhpcmQgQUNLLjwv
c3Bhbj48YnI+PHNwYW4+PC9zcGFuPjxicj48c3Bhbj48L3NwYW4+PGJyPjxzcGFuPkNocmlzdG9w
aCA8L3NwYW4+PGJyPjxzcGFuPjwvc3Bhbj48YnI+PHNwYW4+PC9zcGFuPjxicj48YmxvY2txdW90
ZSB0eXBlPSJjaXRlIj48c3Bhbj5UaGFua3MsPC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+PHNwYW4+PC9zcGFuPjxicj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+PHNwYW4+UGFvbG88L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIj48c3Bhbj48L3NwYW4+PGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Jv
ZHk+PC9odG1sPg==
--===============8302645078476331163==--
