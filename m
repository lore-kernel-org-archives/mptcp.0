Content-Type: multipart/mixed; boundary="===============3917499670292129611=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_HMAC_TEST should depend on MPTCP
Date: Thu, 30 Jan 2020 09:56:29 +0100
Message-ID: <20200130.095629.1691702887527418741.davem@davemloft.net>
In-Reply-To: 20200129180224.700-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 3563

--===============3917499670292129611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geert Uytterhoeven <geert(a)linux-m68k.org>
Date: Wed, 29 Jan 2020 19:02:24 +0100

> As the MPTCP HMAC test is integrated into the MPTCP code, it can be
> built only when MPTCP is enabled.  Hence when MPTCP is disabled, asking
> the user if the test code should be enabled is futile.
> =

> Wrap the whole block of MPTCP-specific config options inside a check for
> MPTCP.  While at it, drop the "default n" for MPTCP_HMAC_TEST, as that
> is the default anyway.
> =

> Fixes: 65492c5a6ab5df50 ("mptcp: move from sha1 (v0) to sha256 (v1)")
> Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>

Applied.
--===============3917499670292129611==--
