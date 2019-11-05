Content-Type: multipart/mixed; boundary="===============6611169150709087079=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/6] IPv6 support
Date: Mon, 04 Nov 2019 16:52:15 -0800
Message-ID: <202dae18a2f0e594d468772c874107fac0ddccdd.camel@linux.intel.com>
In-Reply-To: 89ee912f38069b1a757de76b71fcf5f8a8eb6caa.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2387

--===============6611169150709087079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

On Thu, 2019-10-31 at 10:02 +0100, Paolo Abeni wrote:
> On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> > Implemented support for IPv6. selftests pass with ipv6=3Dtrue, =

> =

> Nice! =

> =

> > but they take twice as long to run...
> =

> Yep, that is expected, right? ;)

Right.

> =

> > With re-factoring the addition of IPv6 is very clean but I did not
> > split files yet as it will be hard to squash any changes after the
> > such a split.
> =

> We still need the Kconfig boilerplate, right? something alike:
>
> ---
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index f21190a4f7e9..3fa6d91f57ee 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -9,3 +9,8 @@ config MPTCP
>           uses the TCP protocol, and TCP options carry header
> information for
>           MPTCP.
>  =

> +config MPTCP_IPV6
> +       bool "IPv6 support form Multipath TCP"
> +       depends on MPTCP
> +       select IPV6
> +       default y
> ---
> =

> and than replace IS_ENABLED(IPV6) with CONFIG_MPTCP_IPV6.

Indeed we do, I will submit a patchset that does that will need to
be merged before the v2 IPv6 patchset (coming tomorrow).

> Additinal question: what happens if ipv6 is disabled at boot time
> (ipv6.disable=3D1 on the kernel command line)?

I believe the initialization in inet6_init() will not run and it will
not be possible to create a socket in the AF_INET6 domain.

Peter.

 =

> Thanks,
> =

> Paolo
>=20

--===============6611169150709087079==--
