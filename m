Content-Type: multipart/mixed; boundary="===============7514211426705773044=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] mptcp: Make v1 changes for ADD_ADDR and
 RM_ADDR options
Date: Wed, 12 Feb 2020 15:58:00 -0800
Message-ID: <alpine.OSX.2.22.394.2002121530360.31766@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: 20200208013930.16640-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3639

--===============7514211426705773044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 7 Feb 2020, Peter Krystad wrote:

> Use union to minimize space used in struct mptcp_received_options.
> Remove family field and add hmac and port fields.
>
> squashto: Add ADD_ADDR handling
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> include/linux/tcp.h  |  22 +++---
> include/net/mptcp.h  |   2 +
> net/mptcp/options.c  | 180 ++++++++++++++++++++++++++++++++++---------
> net/mptcp/protocol.h |  17 ++--
> 4 files changed, 170 insertions(+), 51 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 0c75d7919f9a..42522be45cf7 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -86,9 +86,20 @@ struct mptcp_options_received {
> 	u64	data_seq;
> 	u32	subflow_seq;
> 	u16	data_len;
> +	struct in_addr	addr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct in6_addr	addr6;
> +#endif

The commit message says "Use union...", but it looks like this moved addr =

and addr6 out of a union. Could you clarify the intent here?

> +	u64	ahmac;
> +	u8	addr_id;
> +	u8	rm_id;
> 	u8	mp_capable : 1,
> 		mp_join : 1,
> 		dss : 1,
> +		add_addr : 1,
> +		add_addr6 : 1,
> +		rm_addr : 1,
> +		echo : 1,
> 		backup : 1;
> 	u8	join_id;
> 	u32	token;
> @@ -102,16 +113,6 @@ struct mptcp_options_received {
> 		ack64:1,
> 		mpc_map:1,
> 		__unused:2;
> -	u8	add_addr : 1,
> -		rm_addr : 1,
> -		family : 4;
> -	u8	addr_id;
> -	union {
> -		struct	in_addr	addr;
> -#if IS_ENABLED(CONFIG_IPV6)
> -		struct	in6_addr addr6;
> -#endif
> -	};
> };
> #endif
>
> @@ -148,6 +149,7 @@ static inline void tcp_clear_options(struct tcp_optio=
ns_received *rx_opt)
> 	rx_opt->mptcp.mp_capable =3D 0;
> 	rx_opt->mptcp.mp_join =3D 0;
> 	rx_opt->mptcp.add_addr =3D 0;
> +	rx_opt->mptcp.add_addr6 =3D 0;
> 	rx_opt->mptcp.rm_addr =3D 0;
> 	rx_opt->mptcp.dss =3D 0;
> #endif
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 7489f9267640..0e7c5471010b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -42,6 +42,8 @@ struct mptcp_out_options {
> #endif
> 	};
> 	u8 addr_id;
> +	u64 ahmac;
> +	u8 rm_id;
> 	u8 join_id;
> 	u8 backup;
> 	u32 nonce;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 97d2328fbb52..43f65847799d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -212,45 +212,56 @@ void mptcp_parse_option(const struct sk_buff *skb, =
const unsigned char *ptr,
> 		break;
>
> 	case MPTCPOPT_ADD_ADDR:
> -		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
> -		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
> -			break;
> -		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
> -		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
> -		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
> -			break;
> -
> -		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
> -		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
> -			break;
> +		mp_opt->echo =3D (*ptr++) & MPTCP_ADDR_ECHO;
> +		if (!mp_opt->echo) {
> +			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
> +			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
> +				mp_opt->add_addr =3D 1;
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
> -		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
> -			break;
> +			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
> +				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
> +				mp_opt->add_addr6 =3D 1;
> +#endif
> +			else
> +				break;
> +		} else {
> +			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
> +			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
> +				mp_opt->add_addr =3D 1;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
> +				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
> +				mp_opt->add_addr6 =3D 1;
> #endif
> +			else
> +				break;
> +		}
> +
> 		mp_opt->addr_id =3D *ptr++;
> -		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
> -			mp_opt->add_addr =3D 1;
> +		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
> +		if (mp_opt->add_addr =3D=3D 1) {
> 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
> -			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
> -				 mp_opt->addr.s_addr, mp_opt->addr_id);
> +			ptr +=3D 4;
> 		}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 		else {
> -			mp_opt->add_addr =3D 1;
> 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
> -			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
> +			ptr +=3D 16;
> 		}
> #endif
> +		if (!mp_opt->echo) {
> +			mp_opt->ahmac =3D get_unaligned_be64(ptr);
> +			ptr +=3D 8;
> +		}
> 		break;
>
> 	case MPTCPOPT_RM_ADDR:
> -		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR)
> +		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
> 			break;
>
> 		mp_opt->rm_addr =3D 1;
> -		mp_opt->addr_id =3D *ptr++;
> -		pr_debug("RM_ADDR: id=3D%d", mp_opt->addr_id);
> +		mp_opt->rm_id =3D *ptr++;
> +		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
> 		break;
>
> 	default:
> @@ -482,6 +493,38 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
> 	return true;
> }
>
> +static u64 add_addr_generate_hmac(u64 key1, u64 key2, u8 addr_id,
> +				  struct in_addr *addr)
> +{
> +	u8 hmac[MPTCPOPT_HMAC_LEN];
> +	u8 msg[7];
> +
> +	msg[0] =3D addr_id;
> +	memcpy(&msg[1], &addr->s_addr, 4);
> +	msg[5] =3D 0;
> +	msg[6] =3D 0;
> +
> +	mptcp_crypto_hmac_sha(key1, key2, msg, 7, (u32 *)hmac);
> +
> +	return get_unaligned_be64(hmac);
> +}
> +
> +static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
> +				   struct in6_addr *addr)
> +{
> +	u8 hmac[MPTCPOPT_HMAC_LEN];
> +	u8 msg[19];
> +
> +	msg[0] =3D addr_id;
> +	memcpy(&msg[1], &addr->s6_addr, 16);
> +	msg[17] =3D 0;
> +	msg[18] =3D 0;
> +
> +	mptcp_crypto_hmac_sha(key1, key2, msg, 19, (u32 *)hmac);

Why the cast to u32* here?


Thanks,

Mat


> +
> +	return get_unaligned_be64(hmac);
> +}
> +
> static bool mptcp_established_options_addr(struct sock *sk,
> 					   unsigned int *size,
> 					   unsigned int remaining,
> @@ -507,6 +550,11 @@ static bool mptcp_established_options_addr(struct so=
ck *sk,
> 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> 		opts->addr_id =3D id;
> 		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
> +		opts->ahmac =3D add_addr_generate_hmac(subflow->local_key,
> +						     subflow->remote_key,
> +						     opts->addr_id,
> +						     &opts->addr);
> +		pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac);
> 		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
> 	}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -516,6 +564,11 @@ static bool mptcp_established_options_addr(struct so=
ck *sk,
> 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
> 		opts->addr_id =3D id;
> 		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
> +		opts->ahmac =3D add_addr6_generate_hmac(subflow->local_key,
> +						      subflow->remote_key,
> +						      opts->addr_id,
> +						      &opts->addr6);
> +		pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac);
> 		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
> 	}
> #endif
> @@ -656,6 +709,36 @@ static void update_una(struct mptcp_sock *msk,
> 	}
> }
>
> +static bool add_addr_hmac_valid(struct mptcp_subflow_context *subflow,
> +				struct mptcp_options_received *mp_opt)
> +{
> +	u64 ahmac;
> +
> +	ahmac =3D add_addr_generate_hmac(subflow->remote_key, subflow->local_ke=
y,
> +				       mp_opt->addr_id, &mp_opt->addr);
> +
> +	pr_debug("subflow=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
> +		 subflow, (unsigned long long)ahmac,
> +		 (unsigned long long)mp_opt->ahmac);
> +
> +	return ahmac =3D=3D mp_opt->ahmac;
> +}
> +
> +static bool add_addr6_hmac_valid(struct mptcp_subflow_context *subflow,
> +				 struct mptcp_options_received *mp_opt)
> +{
> +	u64 ahmac;
> +
> +	ahmac =3D add_addr6_generate_hmac(subflow->remote_key, subflow->local_k=
ey,
> +					mp_opt->addr_id, &mp_opt->addr6);
> +
> +	pr_debug("subflow=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
> +		 subflow, (unsigned long long)ahmac,
> +		 (unsigned long long)mp_opt->ahmac);
> +
> +	return ahmac =3D=3D mp_opt->ahmac;
> +}
> +
> void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
> 			    struct tcp_options_received *opt_rx)
> {
> @@ -669,15 +752,20 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb,
> 		return;
>
> 	if (msk && mp_opt->add_addr) {
> -		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
> -			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
> +		pr_debug("subflow=3D%p, ahmac=3D%llu", subflow, mp_opt->ahmac);
> +		if (!mp_opt->echo && add_addr_hmac_valid(subflow, mp_opt))
> +			mptcp_pm_add_addr(msk, &mp_opt->addr,
> +					  mp_opt->addr_id);
> +		mp_opt->add_addr =3D 0;
> +	}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
> +	else if (msk && mp_opt->add_addr6) {
> +		if (!mp_opt->echo && add_addr6_hmac_valid(subflow, mp_opt))
> 			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
> 					   mp_opt->addr_id);
> -#endif
> -		mp_opt->add_addr =3D 0;
> +		mp_opt->add_addr6 =3D 0;
> 	}
> +#endif
>
> 	if (!mp_opt->dss)
> 		return;
> @@ -760,25 +848,47 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_=
out_options *opts)
>
> mp_capable_done:
> 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
> -				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
> +		if (opts->ahmac)
> +			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> +					      TCPOLEN_MPTCP_ADD_ADDR, 0,
> +					      opts->addr_id);
> +		else
> +			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> +					      TCPOLEN_MPTCP_ADD_ADDR_BASE,
> +					      MPTCP_ADDR_ECHO,
> +					      opts->addr_id);
> 		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
> 		ptr +=3D 1;
> +		if (opts->ahmac) {
> +			put_unaligned_be64(opts->ahmac, ptr);
> +			ptr +=3D 2;
> +		}
> 	}
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
> -		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -				      TCPOLEN_MPTCP_ADD_ADDR6,
> -				      MPTCP_ADDR_IPVERSION_6, opts->addr_id);
> +		if (opts->ahmac)
> +			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> +					      TCPOLEN_MPTCP_ADD_ADDR6, 0,
> +					      opts->addr_id);
> +		else
> +			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> +					      TCPOLEN_MPTCP_ADD_ADDR6_BASE,
> +					      MPTCP_ADDR_ECHO,
> +					      opts->addr_id);
> 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
> 		ptr +=3D 4;
> +		if (opts->ahmac) {
> +			put_unaligned_be64(opts->ahmac, ptr);
> +			ptr +=3D 2;
> +		}
> 	}
> #endif
>
> 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> -		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR, TCPOLEN_MPTCP_RM_ADDR,
> -				      0, opts->addr_id);
> +		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
> +				      TCPOLEN_MPTCP_RM_ADDR_BASE,
> +				      0, opts->rm_id);
> 	}
>
> 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e10b24ba1636..c6f9e56b59f2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -48,9 +48,16 @@
> #define TCPOLEN_MPTCP_DSS_MAP32		10
> #define TCPOLEN_MPTCP_DSS_MAP64		14
> #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
> -#define TCPOLEN_MPTCP_ADD_ADDR		8
> -#define TCPOLEN_MPTCP_ADD_ADDR6		20
> -#define TCPOLEN_MPTCP_RM_ADDR		4
> +#define TCPOLEN_MPTCP_ADD_ADDR		16
> +#define TCPOLEN_MPTCP_ADD_ADDR_PORT	18
> +#define TCPOLEN_MPTCP_ADD_ADDR_BASE	8
> +#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	10
> +#define TCPOLEN_MPTCP_ADD_ADDR6		28
> +#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	30
> +#define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
> +#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
> +#define TCPOLEN_MPTCP_PORT_LEN		2
> +#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
>
> /* MPTCP MP_JOIN flags */
> #define MPTCPOPT_BACKUP		BIT(0)
> @@ -73,9 +80,7 @@
> #define MPTCP_DSS_FLAG_MASK	(0x1F)
>
> /* MPTCP ADD_ADDR flags */
> -#define MPTCP_ADDR_FAMILY_MASK	(0x0F)
> -#define MPTCP_ADDR_IPVERSION_4	4
> -#define MPTCP_ADDR_IPVERSION_6	6
> +#define MPTCP_ADDR_ECHO		BIT(0)
>
> /* MPTCP socket flags */
> #define MPTCP_DATA_READY	BIT(0)
> -- =

> 2.17.2

--
Mat Martineau
Intel
--===============7514211426705773044==--
