Content-Type: multipart/mixed; boundary="===============3680263866514142915=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_HMAC_TEST should depend on MPTCP
Date: Wed, 29 Jan 2020 13:08:04 -0800
Message-ID: <alpine.OSX.2.21.2001291246140.9282@cmossx-mobl1.amr.corp.intel.com>
In-Reply-To: 20200129180224.700-1-geert@linux-m68k.org
X-Status: 
X-Keywords:                  
X-UID: 3558

--===============3680263866514142915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 29 Jan 2020, Geert Uytterhoeven wrote:

> As the MPTCP HMAC test is integrated into the MPTCP code, it can be
> built only when MPTCP is enabled.  Hence when MPTCP is disabled, asking
> the user if the test code should be enabled is futile.
>
> Wrap the whole block of MPTCP-specific config options inside a check for
> MPTCP.  While at it, drop the "default n" for MPTCP_HMAC_TEST, as that
> is the default anyway.
>
> Fixes: 65492c5a6ab5df50 ("mptcp: move from sha1 (v0) to sha256 (v1)")
> Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
> ---

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3680263866514142915==--
