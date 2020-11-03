Content-Type: multipart/mixed; boundary="===============4023877658734889573=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 04/10] mptcp: use adding up
 size when get ADD_ADDR length
Date: Tue, 03 Nov 2020 18:23:36 +0100
Message-ID: <4b450240-03e5-624a-04fa-dcf42dd6afb6@tessares.net>
In-Reply-To: a5a8cec61a9f5d072f8d1f212ac5ab0702fbfc57.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6522

--===============4023877658734889573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 31/10/2020 16:24, Geliang Tang wrote:
> This patch uses adding up size to get the ADD_ADDR suboption length rather
> than returning the ADD_ADDR size constants.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>   net/mptcp/protocol.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f303c46bcc29..ad3fdec98fdc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -546,10 +546,14 @@ static inline bool mptcp_pm_should_rm_signal(struct=
 mptcp_sock *msk)
>   =

>   static inline unsigned int mptcp_add_addr_len(int family, bool echo)
>   {
> -	if (family =3D=3D AF_INET)
> -		return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
> -			    : TCPOLEN_MPTCP_ADD_ADDR;
> -	return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE : TCPOLEN_MPTCP_ADD_ADDR6;
> +	u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +
> +	if (family =3D=3D AF_INET6)
> +		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +	if (!echo)
> +		len +=3D 8; // Truncated HMAC

I don't think these comments with "//" are accepted. Instead, should we =

not declare a new constant, e.g. TCPOLEN_MPTCP_ADD_ADDR_HMAC?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4023877658734889573==--
