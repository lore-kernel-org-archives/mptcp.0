Content-Type: multipart/mixed; boundary="===============6904718530506374940=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net] mptcp: select CRYPTO
Date: Wed, 12 Feb 2020 11:31:12 -0800
Message-ID: <alpine.OSX.2.22.394.2002121126560.31766@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: 20200212170305.2683209-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3634

--===============6904718530506374940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2020, Matthieu Baerts wrote:

> Without this modification and if CRYPTO is not selected, we have this
> warning:
>
>  WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>    Depends on [n]: CRYPTO [=3Dn]
>    Selected by [y]:
>    - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]
>
> MPTCP selects CRYPTO_LIB_SHA256 which depends on CRYPTO. CRYPTO is now
> selected to avoid this issue.
>
> Fixes: 65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1))
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> net/mptcp/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index 49f6054e7f4e..a9ed3bf1d93f 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -4,6 +4,7 @@ config MPTCP
> 	depends on INET
> 	select SKB_EXTENSIONS
> 	select CRYPTO_LIB_SHA256
> +	select CRYPTO
> 	help
> 	  Multipath TCP (MPTCP) connections send and receive data over multiple
> 	  subflows in order to utilize multiple network paths. Each subflow
> -- =

> 2.25.0

Even though the config system prints that warning, it looks like sha256 is =

compiled and linked even without CONFIG_CRYPTO. Since we end up needing =

CONFIG_CRYPTO anyway for crypto_memneq, it's not bad to include it now, =

but it doesn't seem to be strictly necessary.

--
Mat Martineau
Intel
--===============6904718530506374940==--
