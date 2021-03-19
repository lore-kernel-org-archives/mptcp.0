Content-Type: multipart/mixed; boundary="===============6279274596858154932=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 2/7] mptcp: use
 mptcp_addr_info in mptcp_out_options
Date: Thu, 18 Mar 2021 21:13:42 -0700
Message-ID: <8dcc4db-5312-a27e-d779-347b67fbeac@linux.intel.com>
In-Reply-To: 48a821dc73542f7d4729015eb4c10ad95370dfb1.1615966219.git.geliangtang@gmail.com
X-Keywords:                  
X-UID: 2

--===============6279274596858154932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Mar 2021, Geliang Tang wrote:

> This patch moved the mptcp_addr_info struct from protocol.h to mptcp.h,
> added a new struct mptcp_addr_info member addr in struct mptcp_out_option=
s,
> and dropped the original addr, addr6, addr_id and port fields in it. Then
> we can use opts->addr to get the adding address from PM directly using
> mptcp_pm_add_addr_signal.
>
> Since the port number became as a big-endian order now, use ntohs to
> convert it before printing it out.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/net/mptcp.h  | 21 +++++++++++++--------
> net/mptcp/options.c  | 42 ++++++++++++++++++------------------------
> net/mptcp/protocol.h | 12 ------------
> 3 files changed, 31 insertions(+), 44 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 16fe34d139c3..80d98a7db3c6 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -41,20 +41,25 @@ struct mptcp_rm_list {
> 	u8 nr;
> };
>
> +struct mptcp_addr_info {
> +	u8			id;
> +	sa_family_t		family : 4;

It's unusual to use a bitfield size specifier with a special type like =

sa_family_t. This patch moves the mptcp_addr_info struct from protocol.h =

to mptcp.h, and the deleted struct below does not have the " : 4" for the =

family. Was this intentional?

While AF_INET and AF_INET6 do fit in 4 bits, and AF_MAX is only 45, I =

think this code should either use a bitfield to represent IPv4/v6, or use =

a whole sa_family_t. Maybe this is why MPTCP_ADDR_IPVERSION_? values were =

defined.

Mat


> +	__be16			port;
> +	union {
> +		struct in_addr	addr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +		struct in6_addr	addr6;
> +#endif
> +	};
> +};
> +
> struct mptcp_out_options {
> #if IS_ENABLED(CONFIG_MPTCP)
> 	u16 suboptions;
> 	u64 sndr_key;
> 	u64 rcvr_key;
> -	union {
> -		struct in_addr addr;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		struct in6_addr addr6;
> -#endif
> -	};
> -	u8 addr_id;
> -	u16 port;
> 	u64 ahmac;
> +	struct mptcp_addr_info addr;
> 	struct mptcp_rm_list rm_list;
> 	u8 join_id;
> 	u8 backup;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4b7119eb2c31..7e01f44ed885 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -626,7 +626,6 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
> 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> 	bool drop_other_suboptions =3D false;
> 	unsigned int opt_size =3D *size;
> -	struct mptcp_addr_info saddr;
> 	bool echo;
> 	bool port;
> 	int len;
> @@ -643,45 +642,40 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
> 	}
>
> 	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo, &port)))
> +	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &por=
t)))
> 		return false;
>
> -	len =3D mptcp_add_addr_len(saddr.family, echo, port);
> +	len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> 	if (remaining < len)
> 		return false;
>
> 	*size =3D len;
> 	if (drop_other_suboptions)
> 		*size -=3D opt_size;
> -	opts->addr_id =3D saddr.id;
> -	if (port)
> -		opts->port =3D ntohs(saddr.port);
> -	if (saddr.family =3D=3D AF_INET) {
> +	if (opts->addr.family =3D=3D AF_INET) {
> 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -		opts->addr =3D saddr.addr;
> 		if (!echo) {
> 			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> 							     msk->remote_key,
> -							     opts->addr_id,
> -							     &opts->addr,
> -							     opts->port);
> +							     opts->addr.id,
> +							     &opts->addr.addr,
> +							     opts->addr.port);
> 		}
> 	}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	else if (saddr.family =3D=3D AF_INET6) {
> +	else if (opts->addr.family =3D=3D AF_INET6) {
> 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
> -		opts->addr6 =3D saddr.addr6;
> 		if (!echo) {
> 			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
> 							      msk->remote_key,
> -							      opts->addr_id,
> -							      &opts->addr6,
> -							      opts->port);
> +							      opts->addr.id,
> +							      &opts->addr.addr6,
> +							      opts->addr.port);
> 		}
> 	}
> #endif
> 	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -		 opts->addr_id, opts->ahmac, echo, opts->port);
> +		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>
> 	return true;
> }
> @@ -1217,7 +1211,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
> 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> #endif
>
> -		if (opts->port)
> +		if (opts->addr.port)
> 			len +=3D TCPOLEN_MPTCP_PORT_LEN;
>
> 		if (opts->ahmac) {
> @@ -1226,19 +1220,19 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
> 		}
>
> 		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -				      len, echo, opts->addr_id);
> +				      len, echo, opts->addr.id);
> 		if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -			memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
> +			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
> 			ptr +=3D 1;
> 		}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 		else if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
> -			memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
> +			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
> 			ptr +=3D 4;
> 		}
> #endif
>
> -		if (!opts->port) {
> +		if (!opts->addr.port) {
> 			if (opts->ahmac) {
> 				put_unaligned_be64(opts->ahmac, ptr);
> 				ptr +=3D 2;
> @@ -1247,7 +1241,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
> 			if (opts->ahmac) {
> 				u8 *bptr =3D (u8 *)ptr;
>
> -				put_unaligned_be16(opts->port, bptr);
> +				put_unaligned_be16(opts->addr.port, bptr);
> 				bptr +=3D 2;
> 				put_unaligned_be64(opts->ahmac, bptr);
> 				bptr +=3D 8;
> @@ -1256,7 +1250,7 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
>
> 				ptr +=3D 3;
> 			} else {
> -				put_unaligned_be32(opts->port << 16 |
> +				put_unaligned_be32(opts->addr.port << 16 |
> 						   TCPOPT_NOP << 8 |
> 						   TCPOPT_NOP, ptr);
> 				ptr +=3D 1;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9005ccc2bc7d..b993e372c4ad 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -169,18 +169,6 @@ static inline __be32 mptcp_option(u8 subopt, u8 len,=
 u8 nib, u8 field)
> 		     ((nib & 0xF) << 8) | field);
> }
>
> -struct mptcp_addr_info {
> -	sa_family_t		family;
> -	__be16			port;
> -	u8			id;
> -	union {
> -		struct in_addr addr;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		struct in6_addr addr6;
> -#endif
> -	};
> -};
> -
> enum mptcp_pm_status {
> 	MPTCP_PM_ADD_ADDR_RECEIVED,
> 	MPTCP_PM_ADD_ADDR_SEND_ACK,
> -- =

> 2.30.2

--
Mat Martineau
Intel
--===============6279274596858154932==--

