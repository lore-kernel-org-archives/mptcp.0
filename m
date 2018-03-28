Content-Type: multipart/mixed; boundary="===============2729532009996514372=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Tue, 27 Mar 2018 18:53:46 -0700
Message-ID: <634b848f-cc34-43c7-93ee-1906b9534f6a@oracle.com>
In-Reply-To: CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 434

--===============2729532009996514372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/27/2018 05:04 AM, Lorenzo Colitti wrote:
> On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com =

> <mailto:cpaasch(a)apple.com>> wrote:
>
>     It also would allow us to expose subflows as file-descriptors to the
>     user-space. That way the user-space can do setsockopt,
>     getsockopt,... on the
>     subflows. An idea that came up in the past when we were thinking
>     on how to
>     expose an MPTCP API that allows apps to control certain things on the
>     subflows.
>
>
> +1 to this since it will allow client platforms to use setsockopt to, =

> for example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, =

> or with SO_MARK as used by Android).
May I ask why it can not be done=C2=A0 -- Only flow id should be needed. Pl=
us =

for policy enforcement the meta socket would have to be consulted. I am =

new to Linux but based on what I have read SO_BINDTODEVICE does not =

guarantee much for Tx if the routing says otherwise, quick check of =

ip_queue_xmit() shows it first consults the routing table. I understand =

policy routing can be used to steer the packets. Perhaps my =

understanding is incorrect.

IMHO this whole idea of exposing individual flows to the application =

seems to go against the basic design of MPTCP. I am not sure what the =

use case is as TCP is streams based and MPTCP will spread out data on =

multiple flows. I am not a involved in the cellular space so I don' =

know, feel free to enlighten me.

Shoaib

>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2729532009996514372==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwMy8yNy8yMDE4IDA1OjA0IEFNLCBM
b3JlbnpvIENvbGl0dGkKICAgICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIgpjaXRlPSJtaWQ6Q0FLRDFZcjJzQkNkVU80OGNwPXJaUTZzNHYxM3l0cFBk
OW9QVCtVPWlZcmRYdGJhNUhBQG1haWwuZ21haWwuY29tIj4KICAgICAgPGRpdiBkaXI9Imx0ciI+
CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPgogICAgICAgICAgPGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPk9uIFR1ZSwgTWFyIDI3LCAyMDE4IGF0IDExOjE4IEFNLAogICAgICAgICAg
ICBDaHJpc3RvcGggUGFhc2NoIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEKICAgICAgICAgICAgICAg
IGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiCiAgICAgICAg
ICAgICAgICBtb3otZG8tbm90LXNlbmQ9InRydWUiPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDs8
L3NwYW4+CiAgICAgICAgICAgIHdyb3RlOjxicj4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwCiAgICAgICAgICAgICAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5JdCBhbHNvCiAgICAg
ICAgICAgICAgd291bGQgYWxsb3cgdXMgdG8gZXhwb3NlIHN1YmZsb3dzIGFzIGZpbGUtZGVzY3Jp
cHRvcnMgdG8KICAgICAgICAgICAgICB0aGU8YnI+CiAgICAgICAgICAgICAgdXNlci1zcGFjZS4g
VGhhdCB3YXkgdGhlIHVzZXItc3BhY2UgY2FuIGRvIHNldHNvY2tvcHQsCiAgICAgICAgICAgICAg
Z2V0c29ja29wdCwuLi4gb24gdGhlPGJyPgogICAgICAgICAgICAgIHN1YmZsb3dzLiBBbiBpZGVh
IHRoYXQgY2FtZSB1cCBpbiB0aGUgcGFzdCB3aGVuIHdlIHdlcmUKICAgICAgICAgICAgICB0aGlu
a2luZyBvbiBob3cgdG88YnI+CiAgICAgICAgICAgICAgZXhwb3NlIGFuIE1QVENQIEFQSSB0aGF0
IGFsbG93cyBhcHBzIHRvIGNvbnRyb2wgY2VydGFpbgogICAgICAgICAgICAgIHRoaW5ncyBvbiB0
aGU8YnI+CiAgICAgICAgICAgICAgc3ViZmxvd3MuPGJyPgogICAgICAgICAgICA8L2Jsb2NrcXVv
dGU+CiAgICAgICAgICAgIDxkaXY+PGJyPgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAg
PGRpdj4rMSB0byB0aGlzIHNpbmNlIGl0IHdpbGwgYWxsb3cgY2xpZW50IHBsYXRmb3JtcyB0byB1
c2UKICAgICAgICAgICAgICBzZXRzb2Nrb3B0IHRvLCBmb3IgZXhhbXBsZSwgYmluZCBzdWJmbG93
cyB0byBpbnRlcmZhY2VzCiAgICAgICAgICAgICAgKGUuZy4sIHdpdGggU09fQklORFRPREVWSUNF
LCBvciB3aXRoIFNPX01BUksgYXMgdXNlZCBieQogICAgICAgICAgICAgIEFuZHJvaWQpLjwvZGl2
PgogICAgICAgICAgPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvZGl2PgogICAgPC9ibG9j
a3F1b3RlPgogICAgTWF5IEkgYXNrIHdoeSBpdCBjYW4gbm90IGJlIGRvbmXCoCAtLSBPbmx5IGZs
b3cgaWQgc2hvdWxkIGJlIG5lZWRlZC4KICAgIFBsdXMgZm9yIHBvbGljeSBlbmZvcmNlbWVudCB0
aGUgbWV0YSBzb2NrZXQgd291bGQgaGF2ZSB0byBiZQogICAgY29uc3VsdGVkLiBJIGFtIG5ldyB0
byBMaW51eCBidXQgYmFzZWQgb24gd2hhdCBJIGhhdmUgcmVhZAogICAgU09fQklORFRPREVWSUNF
IGRvZXMgbm90IGd1YXJhbnRlZSBtdWNoIGZvciBUeCBpZiB0aGUgcm91dGluZyBzYXlzCiAgICBv
dGhlcndpc2UsIHF1aWNrIGNoZWNrIG9mIGlwX3F1ZXVlX3htaXQoKSBzaG93cyBpdCBmaXJzdCBj
b25zdWx0cwogICAgdGhlIHJvdXRpbmcgdGFibGUuIEkgdW5kZXJzdGFuZCBwb2xpY3kgcm91dGlu
ZyBjYW4gYmUgdXNlZCB0byBzdGVlcgogICAgdGhlIHBhY2tldHMuIFBlcmhhcHMgbXkgdW5kZXJz
dGFuZGluZyBpcyBpbmNvcnJlY3QuIDxicj4KICAgIDxicj4KICAgIElNSE8gdGhpcyB3aG9sZSBp
ZGVhIG9mIGV4cG9zaW5nIGluZGl2aWR1YWwgZmxvd3MgdG8gdGhlIGFwcGxpY2F0aW9uCiAgICBz
ZWVtcyB0byBnbyBhZ2FpbnN0IHRoZSBiYXNpYyBkZXNpZ24gb2YgTVBUQ1AuIEkgYW0gbm90IHN1
cmUgd2hhdAogICAgdGhlIHVzZSBjYXNlIGlzIGFzIFRDUCBpcyBzdHJlYW1zIGJhc2VkIGFuZCBN
UFRDUCB3aWxsIHNwcmVhZCBvdXQKICAgIGRhdGEgb24gbXVsdGlwbGUgZmxvd3MuIEkgYW0gbm90
IGEgaW52b2x2ZWQgaW4gdGhlIGNlbGx1bGFyIHNwYWNlIHNvCiAgICBJIGRvbicga25vdywgZmVl
bCBmcmVlIHRvIGVubGlnaHRlbiBtZS48YnI+CiAgICA8YnI+CiAgICBTaG9haWI8YnI+CiAgICA8
YnI+CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgpjaXRlPSJtaWQ6Q0FLRDFZcjJzQkNkVU80
OGNwPXJaUTZzNHYxM3l0cFBkOW9QVCtVPWlZcmRYdGJhNUhBQG1haWwuZ21haWwuY29tIj48YnI+
CiAgICAgIDxmaWVsZHNldCBjbGFzcz0ibWltZUF0dGFjaG1lbnRIZWFkZXIiPjwvZmllbGRzZXQ+
CiAgICAgIDxicj4KICAgICAgPHByZSB3cmFwPSIiPl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCm1wdGNwIG1haWxpbmcgbGlzdAo8YSBjbGFzcz0ibW96LXR4
dC1saW5rLWFiYnJldmlhdGVkIiBocmVmPSJtYWlsdG86bXB0Y3BAbGlzdHMuMDEub3JnIj5tcHRj
cEBsaXN0cy4wMS5vcmc8L2E+CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiIGhyZWY9
Imh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3AiPmh0dHBzOi8vbGlz
dHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3A8L2E+CjwvcHJlPgogICAgPC9ibG9ja3F1
b3RlPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============2729532009996514372==--
