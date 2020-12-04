Content-Type: multipart/mixed; boundary="===============1722628422544459684=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: use MPTCPOPT_HMAC_LEN
 macro
Date: Thu, 03 Dec 2020 17:59:07 -0800
Message-ID: <388dbbbe-bca8-9ef8-b33a-3737653e8dfb@linux.intel.com>
In-Reply-To: 1ab161c24f9027ce76b3483f025be8bbfa0c7667.1606899179.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7037

--===============1722628422544459684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Dec 2020, Geliang Tang wrote:

> Use the macro MPTCPOPT_HMAC_LEN instead of a constant in struct
> mptcp_options_received.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/protocol.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6933cdc2e605..4e922620ee56 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -122,7 +122,7 @@ struct mptcp_options_received {
> 	u32	token;
> 	u32	nonce;
> 	u64	thmac;
> -	u8	hmac[20];
> +	u8	hmac[MPTCPOPT_HMAC_LEN];
> 	u8	join_id;
> 	u8	use_map:1,
> 		dsn64:1,
> -- =

> 2.26.2

Looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============1722628422544459684==--
