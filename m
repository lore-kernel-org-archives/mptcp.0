Content-Type: multipart/mixed; boundary="===============8349602070144354859=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: default KUNIT_* fragments to
 KUNIT_ALL_TESTS
Date: Thu, 18 Jun 2020 20:45:36 -0700
Message-ID: <alpine.OSX.2.22.394.2006182045190.19717@adhawale-mobl.amr.corp.intel.com>
In-Reply-To: 20200616165105.3015572-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4741

--===============8349602070144354859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 16 Jun 2020, Matthieu Baerts wrote:

> This makes it easier to enable all KUnit fragments.
>
> Adding 'if !KUNIT_ALL_TESTS so individual tests can not be turned off.
> Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
> menuconfig.
>
> Similar to beaed42c427d ("kunit: default KUNIT_* fragments to KUNIT_ALL_T=
ESTS")
> and following ones.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>    to be squashed in "mptcp: move crypto test to KUNIT"
>
> net/mptcp/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index c701f27300ce..d7d5f9349366 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -21,9 +21,10 @@ config MPTCP_IPV6
> endif
>
> config MPTCP_KUNIT_TESTS
> -	tristate "This builds the MPTCP KUnit tests"
> +	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
> 	select MPTCP
> 	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> 	help
> 	  Currently covers the MPTCP crypto helpers.
> 	  Only useful for kernel devs running KUnit test harness and are not
> -- =

> 2.27.0.rc0

Looks good to me, thanks Matthieu.

--
Mat Martineau
Intel
--===============8349602070144354859==--
