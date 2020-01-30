Content-Type: multipart/mixed; boundary="===============8005620563196096040=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix undefined mptcp_handle_ipv6_mapped for
 modular IPV6
Date: Thu, 30 Jan 2020 10:56:23 +0100
Message-ID: <20200130.105623.2251053622156610557.davem@davemloft.net>
In-Reply-To: 20200130094526.22483-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 3565

--===============8005620563196096040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geert Uytterhoeven <geert(a)linux-m68k.org>
Date: Thu, 30 Jan 2020 10:45:26 +0100

> If CONFIG_MPTCP=3Dy, CONFIG_MPTCP_IPV6=3Dn, and CONFIG_IPV6=3Dm:
> =

>     ERROR: "mptcp_handle_ipv6_mapped" [net/ipv6/ipv6.ko] undefined!
> =

> This does not happen if CONFIG_MPTCP_IPV6=3Dy, as CONFIG_MPTCP_IPV6
> selects CONFIG_IPV6, and thus forces CONFIG_IPV6 builtin.
> =

> As exporting a symbol for an empty function would be a bit wasteful, fix
> this by providing a dummy version of mptcp_handle_ipv6_mapped() for the
> CONFIG_MPTCP_IPV6=3Dn case.
> =

> Rename mptcp_handle_ipv6_mapped() to mptcpv6_handle_mapped(), to make it
> clear this is a pure-IPV6 function, just like mptcpv6_init().
> =

> Fixes: cec37a6e41aae7bf ("mptcp: Handle MP_CAPABLE options for outgoing c=
onnections")
> Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>

Looks good, applied, thank you.
--===============8005620563196096040==--
