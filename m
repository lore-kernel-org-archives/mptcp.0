Content-Type: multipart/mixed; boundary="===============0221013786536171530=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix incorrect IPV6 dependency check
Date: Thu, 30 Jan 2020 09:56:19 +0100
Message-ID: <20200130.095619.1080558867331721556.davem@davemloft.net>
In-Reply-To: 20200129180117.545-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 3562

--===============0221013786536171530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geert Uytterhoeven <geert(a)linux-m68k.org>
Date: Wed, 29 Jan 2020 19:01:17 +0100

> If CONFIG_MPTCP=3Dy, CONFIG_MPTCP_IPV6=3Dn, and CONFIG_IPV6=3Dm:
> =

>     net/mptcp/protocol.o: In function `__mptcp_tcp_fallback':
>     protocol.c:(.text+0x786): undefined reference to `inet6_stream_ops'
> =

> Fix this by checking for CONFIG_MPTCP_IPV6 instead of CONFIG_IPV6, like
> is done in all other places in the mptcp code.
> =

> Fixes: 8ab183deb26a3b79 ("mptcp: cope with later TCP fallback")
> Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>

Applied.
--===============0221013786536171530==--
