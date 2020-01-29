Content-Type: multipart/mixed; boundary="===============3981584822805439309=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix incorrect IPV6 dependency check
Date: Wed, 29 Jan 2020 13:10:04 -0800
Message-ID: <alpine.OSX.2.21.2001291308450.9282@cmossx-mobl1.amr.corp.intel.com>
In-Reply-To: 20200129180117.545-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 3559

--===============3981584822805439309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2020, Geert Uytterhoeven wrote:

> If CONFIG_MPTCP=3Dy, CONFIG_MPTCP_IPV6=3Dn, and CONFIG_IPV6=3Dm:
>
>    net/mptcp/protocol.o: In function `__mptcp_tcp_fallback':
>    protocol.c:(.text+0x786): undefined reference to `inet6_stream_ops'
>
> Fix this by checking for CONFIG_MPTCP_IPV6 instead of CONFIG_IPV6, like
> is done in all other places in the mptcp code.
>
> Fixes: 8ab183deb26a3b79 ("mptcp: cope with later TCP fallback")
> Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
> ---

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


--
Mat Martineau
Intel
--===============3981584822805439309==--
