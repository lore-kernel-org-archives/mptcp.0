Content-Type: multipart/mixed; boundary="===============5602467379578327675=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: add mptcp reset option support
Date: Wed, 24 Feb 2021 16:39:11 -0800
Message-ID: <3f998c-5ccb-99b3-11df-59d11fb0f52e@linux.intel.com>
In-Reply-To: 20210224140338.978-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7948

--===============5602467379578327675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Feb 2021, Florian Westphal wrote:

> The MPTCP reset option allows to carry a mptcp-specific error code that
> provides more information on the nature of a connection reset.
>
> Reset option data received gets stored in the subflow context so it can
> be sent to userspace via the 'subflow closed' netlink event.
>
> When a subflow is closed, the desired error code that should be sent to
> the peer is also placed in the subflow context structure.
>
> If a reset is sent before subflow establishment could complete, e.g. on
> HMAC failure during an MP_JOIN operation, the mptcp skb extension is
> used to store the reset information.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> Changes since v1:
>  - send reset event if mp_reset had reason code 0 too
>  - avoid 3x repeat of skb_ext_add/memset/assignment
>  - place reason codes in uapi header
>

In testing this I found that wireshark doesn't know about the MPTCP_RST =

option subtype yet!

I think v2 is ready for the export branch. Thanks, Florian.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


Mat


> include/net/mptcp.h        | 18 ++++++++--
> include/uapi/linux/mptcp.h | 11 +++++++
> net/ipv4/tcp_ipv4.c        | 21 ++++++++++--
> net/ipv6/tcp_ipv6.c        | 14 +++++++-
> net/mptcp/options.c        | 67 +++++++++++++++++++++++++++++++++++---
> net/mptcp/pm_netlink.c     | 12 +++++++
> net/mptcp/protocol.c       | 12 +++++--
> net/mptcp/protocol.h       | 14 +++++++-
> net/mptcp/subflow.c        | 30 ++++++++++++++---
> 9 files changed, 180 insertions(+), 19 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index cea69c801595..16fe34d139c3 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -30,8 +30,8 @@ struct mptcp_ext {
> 			ack64:1,
> 			mpc_map:1,
> 			frozen:1,
> -			__unused:1;
> -	/* one byte hole */
> +			reset_transient:1;
> +	u8		reset_reason:4;
> };
>
> #define MPTCP_RM_IDS_MAX	8
> @@ -58,6 +58,8 @@ struct mptcp_out_options {
> 	struct mptcp_rm_list rm_list;
> 	u8 join_id;
> 	u8 backup;
> +	u8 reset_reason:4;
> +	u8 reset_transient:1;
> 	u32 nonce;
> 	u64 thmac;
> 	u32 token;
> @@ -156,6 +158,16 @@ void mptcp_seq_show(struct seq_file *seq);
> int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 				  const struct sock *sk_listener,
> 				  struct sk_buff *skb);
> +
> +__be32 mptcp_get_reset_option(const struct sk_buff *skb);
> +
> +static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
> +{
> +	if (skb_ext_exist(skb, SKB_EXT_MPTCP))
> +		return mptcp_get_reset_option(skb);
> +
> +	return htonl(0u);
> +}
> #else
>
> static inline void mptcp_init(void)
> @@ -236,6 +248,8 @@ static inline int mptcp_subflow_init_cookie_req(struc=
t request_sock *req,
> {
> 	return 0; /* TCP fallback */
> }
> +
> +static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { re=
turn htonl(0u); }
> #endif /* CONFIG_MPTCP */
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index e1172c1ffdfd..8eb3c0844bff 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -174,10 +174,21 @@ enum mptcp_event_attr {
> 	MPTCP_ATTR_FLAGS,	/* u16 */
> 	MPTCP_ATTR_TIMEOUT,	/* u32 */
> 	MPTCP_ATTR_IF_IDX,	/* s32 */
> +	MPTCP_ATTR_RESET_REASON,/* u32 */
> +	MPTCP_ATTR_RESET_FLAGS, /* u32 */
>
> 	__MPTCP_ATTR_AFTER_LAST
> };
>
> #define MPTCP_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
>
> +/* MPTCP Reset reason codes, rfc8684 */
> +#define MPTCP_RST_EUNSPEC	0
> +#define MPTCP_RST_EMPTCP	1
> +#define MPTCP_RST_ERESOURCE	2
> +#define MPTCP_RST_EPROHIBIT	3
> +#define MPTCP_RST_EWQ2BIG	4
> +#define MPTCP_RST_EBADPERF	5
> +#define MPTCP_RST_EMIDDLEBOX	6
> +
> #endif /* _UAPI_MPTCP_H */
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index daad4f99db32..e092c5a9dd1c 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -655,14 +655,18 @@ EXPORT_SYMBOL(tcp_v4_send_check);
>  *	Exception: precedence violation. We do not implement it in any case.
>  */
>
> +#ifdef CONFIG_TCP_MD5SIG
> +#define OPTION_BYTES TCPOLEN_MD5SIG_ALIGNED
> +#else
> +#define OPTION_BYTES sizeof(__be32)
> +#endif
> +
> static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
> {
> 	const struct tcphdr *th =3D tcp_hdr(skb);
> 	struct {
> 		struct tcphdr th;
> -#ifdef CONFIG_TCP_MD5SIG
> -		__be32 opt[(TCPOLEN_MD5SIG_ALIGNED >> 2)];
> -#endif
> +		__be32 opt[OPTION_BYTES / sizeof(__be32)];
> 	} rep;
> 	struct ip_reply_arg arg;
> #ifdef CONFIG_TCP_MD5SIG
> @@ -770,6 +774,17 @@ static void tcp_v4_send_reset(const struct sock *sk,=
 struct sk_buff *skb)
> 				     ip_hdr(skb)->daddr, &rep.th);
> 	}
> #endif
> +	/* Can't co-exist with TCPMD5, hence check rep.opt[0] */
> +	if (rep.opt[0] =3D=3D 0) {
> +		__be32 mrst =3D mptcp_reset_option(skb);
> +
> +		if (mrst) {
> +			rep.opt[0] =3D mrst;
> +			arg.iov[0].iov_len +=3D sizeof(mrst);
> +			rep.th.doff =3D arg.iov[0].iov_len / 4;
> +		}
> +	}
> +
> 	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> 				      ip_hdr(skb)->saddr, /* XXX */
> 				      arg.iov[0].iov_len, IPPROTO_TCP, 0);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index bd44ded7e50c..a18d304fe1c9 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -879,8 +879,8 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
> 	struct net *net =3D sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
> 	struct sock *ctl_sk =3D net->ipv6.tcp_sk;
> 	unsigned int tot_len =3D sizeof(struct tcphdr);
> +	__be32 mrst =3D 0, *topt;
> 	struct dst_entry *dst;
> -	__be32 *topt;
> 	__u32 mark =3D 0;
>
> 	if (tsecr)
> @@ -890,6 +890,15 @@ static void tcp_v6_send_response(const struct sock *=
sk, struct sk_buff *skb, u32
> 		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> #endif
>
> +#ifdef CONFIG_MPTCP
> +	if (rst && !key) {
> +		mrst =3D mptcp_reset_option(skb);
> +
> +		if (mrst)
> +			tot_len +=3D sizeof(__be32);
> +	}
> +#endif
> +
> 	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> 			 GFP_ATOMIC);
> 	if (!buff)
> @@ -920,6 +929,9 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
> 		*topt++ =3D htonl(tsecr);
> 	}
>
> +	if (mrst)
> +		*topt++ =3D mrst;
> +
> #ifdef CONFIG_TCP_MD5SIG
> 	if (key) {
> 		*topt++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c6a0d71e59d7..f95643d820fe 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -305,6 +305,18 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
> 		mp_opt->fastclose =3D 1;
> 		break;
>
> +	case MPTCPOPT_RST:
> +		if (opsize !=3D TCPOLEN_MPTCP_RST)
> +			break;
> +
> +		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> +			break;
> +		mp_opt->reset =3D 1;
> +		flags =3D *ptr++;
> +		mp_opt->reset_transient =3D flags & MPTCP_RST_TRANSIENT;
> +		mp_opt->reset_reason =3D *ptr;
> +		break;
> +
> 	default:
> 		break;
> 	}
> @@ -327,6 +339,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> 	mp_opt->rm_addr =3D 0;
> 	mp_opt->dss =3D 0;
> 	mp_opt->mp_prio =3D 0;
> +	mp_opt->reset =3D 0;
>
> 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr =3D (const unsigned char *)(th + 1);
> @@ -724,6 +737,22 @@ static bool mptcp_established_options_mp_prio(struct=
 sock *sk,
> 	return true;
> }
>
> +static noinline void mptcp_established_options_rst(struct sock *sk, stru=
ct sk_buff *skb,
> +						   unsigned int *size,
> +						   unsigned int remaining,
> +						   struct mptcp_out_options *opts)
> +{
> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +
> +	if (remaining < TCPOLEN_MPTCP_RST)
> +		return;
> +
> +	*size =3D TCPOLEN_MPTCP_RST;
> +	opts->suboptions |=3D OPTION_MPTCP_RST;
> +	opts->reset_transient =3D subflow->reset_transient;
> +	opts->reset_reason =3D subflow->reset_reason;
> +}
> +
> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts)
> @@ -739,11 +768,10 @@ bool mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
> 	if (unlikely(__mptcp_check_fallback(msk)))
> 		return false;
>
> -	/* prevent adding of any MPTCP related options on reset packet
> -	 * until we support MP_TCPRST/MP_FASTCLOSE
> -	 */
> -	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> -		return false;
> +	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> +		mptcp_established_options_rst(sk, skb, size, remaining, opts);
> +		return true;
> +	}
>
> 	snd_data_fin =3D mptcp_data_fin_enabled(msk);
> 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remai=
ning, opts))
> @@ -1058,6 +1086,12 @@ void mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb)
> 		mp_opt.mp_prio =3D 0;
> 	}
>
> +	if (mp_opt.reset) {
> +		subflow->reset_seen =3D 1;
> +		subflow->reset_reason =3D mp_opt.reset_reason;
> +		subflow->reset_transient =3D mp_opt.reset_transient;
> +	}
> +
> 	if (!mp_opt.dss)
> 		return;
>
> @@ -1285,6 +1319,12 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
> 		ptr +=3D 5;
> 	}
>
> +	if (OPTION_MPTCP_RST & opts->suboptions)
> +		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
> +				      TCPOLEN_MPTCP_RST,
> +				      opts->reset_transient,
> +				      opts->reset_reason);
> +
> 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
> 		struct mptcp_ext *mpext =3D &opts->ext_copy;
> 		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> @@ -1336,3 +1376,20 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
> 	if (tp)
> 		mptcp_set_rwin(tp);
> }
> +
> +__be32 mptcp_get_reset_option(const struct sk_buff *skb)
> +{
> +	const struct mptcp_ext *ext =3D mptcp_get_ext(skb);
> +	u8 flags, reason;
> +
> +	if (ext) {
> +		flags =3D ext->reset_transient;
> +		reason =3D ext->reset_reason;
> +
> +		return mptcp_option(MPTCPOPT_RST, TCPOLEN_MPTCP_RST,
> +				    flags, reason);
> +	}
> +
> +	return htonl(0u);
> +}
> +EXPORT_SYMBOL_GPL(mptcp_get_reset_option);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 55fdcb1b5281..3b99ae822318 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1648,9 +1648,21 @@ static int mptcp_event_sub_closed(struct sk_buff *=
skb,
> 				  const struct mptcp_sock *msk,
> 				  const struct sock *ssk)
> {
> +	const struct mptcp_subflow_context *sf;
> +
> 	if (mptcp_event_put_token_and_ssk(skb, msk, ssk))
> 		return -EMSGSIZE;
>
> +	sf =3D mptcp_subflow_ctx(ssk);
> +	if (!sf->reset_seen)
> +		return 0;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_RESET_REASON, sf->reset_reason))
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_RESET_FLAGS, sf->reset_transient))
> +		return -EMSGSIZE;
> +
> 	return 0;
> }
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2859ad2c6990..e2388da9b320 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3090,14 +3090,18 @@ bool mptcp_finish_join(struct sock *ssk)
> 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
>
> 	/* mptcp socket already closing? */
> -	if (!mptcp_is_fully_established(parent))
> +	if (!mptcp_is_fully_established(parent)) {
> +		subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 		return false;
> +	}
>
> 	if (!msk->pm.server_side)
> 		goto out;
>
> -	if (!mptcp_pm_allow_new_subflow(msk))
> +	if (!mptcp_pm_allow_new_subflow(msk)) {
> +		subflow->reset_reason =3D MPTCP_RST_EPROHIBIT;
> 		return false;
> +	}
>
> 	/* active connections are already on conn_list, and we can't acquire
> 	 * msk lock here.
> @@ -3111,8 +3115,10 @@ bool mptcp_finish_join(struct sock *ssk)
> 		sock_hold(ssk);
> 	}
> 	spin_unlock_bh(&msk->join_list_lock);
> -	if (!ret)
> +	if (!ret) {
> +		subflow->reset_reason =3D MPTCP_RST_EPROHIBIT;
> 		return false;
> +	}
>
> 	/* attach to msk socket only after we are sure he will deal with us
> 	 * at close time
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6af3e259fa05..285f44e35835 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -26,6 +26,7 @@
> #define OPTION_MPTCP_RM_ADDR	BIT(8)
> #define OPTION_MPTCP_FASTCLOSE	BIT(9)
> #define OPTION_MPTCP_PRIO	BIT(10)
> +#define OPTION_MPTCP_RST	BIT(11)
>
> /* MPTCP option subtypes */
> #define MPTCPOPT_MP_CAPABLE	0
> @@ -36,6 +37,7 @@
> #define MPTCPOPT_MP_PRIO	5
> #define MPTCPOPT_MP_FAIL	6
> #define MPTCPOPT_MP_FASTCLOSE	7
> +#define MPTCPOPT_RST		8
>
> /* MPTCP suboption lengths */
> #define TCPOLEN_MPTCP_MPC_SYN		4
> @@ -64,6 +66,7 @@
> #define TCPOLEN_MPTCP_PRIO		3
> #define TCPOLEN_MPTCP_PRIO_ALIGN	4
> #define TCPOLEN_MPTCP_FASTCLOSE		12
> +#define TCPOLEN_MPTCP_RST		4
>
> /* MPTCP MP_JOIN flags */
> #define MPTCPOPT_BACKUP		BIT(0)
> @@ -93,6 +96,9 @@
> /* MPTCP MP_PRIO flags */
> #define MPTCP_PRIO_BKUP		BIT(0)
>
> +/* MPTCP TCPRST flags */
> +#define MPTCP_RST_TRANSIENT	BIT(0)
> +
> /* MPTCP socket flags */
> #define MPTCP_DATA_READY	0
> #define MPTCP_NOSPACE		1
> @@ -122,6 +128,7 @@ struct mptcp_options_received {
> 	u16	mp_capable : 1,
> 		mp_join : 1,
> 		fastclose : 1,
> +		reset : 1,
> 		dss : 1,
> 		add_addr : 1,
> 		rm_addr : 1,
> @@ -151,6 +158,8 @@ struct mptcp_options_received {
> 	};
> 	u64	ahmac;
> 	u16	port;
> +	u8	reset_reason:4;
> +	u8	reset_transient:1;
> };
>
> static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> @@ -421,6 +430,9 @@ struct mptcp_subflow_context {
> 	u8	hmac[MPTCPOPT_HMAC_LEN];
> 	u8	local_id;
> 	u8	remote_id;
> +	u8	reset_seen:1;
> +	u8	reset_transient:1;
> +	u8	reset_reason:4;
>
> 	long	delegated_status;
> 	struct	list_head delegated_node;   /* link into delegated_action, protec=
ted by local BH */
> @@ -737,7 +749,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct =
mptcp_sock *msk);
> unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
>
> -static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> +static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
> {
> 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
> }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d022893a5765..6af443a18bac 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -115,6 +115,16 @@ static bool subflow_use_different_sport(struct mptcp=
_sock *msk, const struct soc
> 	return inet_sk(sk)->inet_sport !=3D inet_sk((struct sock *)msk)->inet_sp=
ort;
> }
>
> +static void subflow_add_reset_reason(struct sk_buff *skb, u8 reason)
> +{
> +	struct mptcp_ext *mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +	if (mpext) {
> +		memset(mpext, 0, sizeof(*mpext));
> +		mpext->reset_reason =3D reason;
> +	}
> +}
> +
> /* Init mptcp request socket.
>  *
>  * Returns an error code if a JOIN has failed and a TCP reset
> @@ -190,8 +200,10 @@ static int subflow_check_req(struct request_sock *re=
q,
> 		subflow_req->msk =3D subflow_token_join_request(req);
>
> 		/* Can't fall back to TCP in this case. */
> -		if (!subflow_req->msk)
> +		if (!subflow_req->msk) {
> +			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
> 			return -EPERM;
> +		}
>
> 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
> 			pr_debug("syn inet_sport=3D%d %d",
> @@ -400,8 +412,10 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
> 	} else if (subflow->request_join) {
> 		u8 hmac[SHA256_DIGEST_SIZE];
>
> -		if (!mp_opt.mp_join)
> +		if (!mp_opt.mp_join) {
> +			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 			goto do_reset;
> +		}
>
> 		subflow->thmac =3D mp_opt.thmac;
> 		subflow->remote_nonce =3D mp_opt.nonce;
> @@ -410,6 +424,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>
> 		if (!subflow_thmac_valid(subflow)) {
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
> +			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 			goto do_reset;
> 		}
>
> @@ -438,6 +453,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
> 	return;
>
> do_reset:
> +	subflow->reset_transient =3D 0;
> 	mptcp_subflow_reset(sk);
> }
>
> @@ -649,8 +665,10 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> 		 * to reset the context to non MPTCP status.
> 		 */
> 		if (!ctx || fallback) {
> -			if (fallback_is_fatal)
> +			if (fallback_is_fatal) {
> +				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
> 				goto dispose_child;
> +			}
>
> 			subflow_drop_ctx(child);
> 			goto out;
> @@ -685,8 +703,10 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> 			struct mptcp_sock *owner;
>
> 			owner =3D subflow_req->msk;
> -			if (!owner)
> +			if (!owner) {
> +				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> 				goto dispose_child;
> +			}
>
> 			/* move the msk reference ownership to the subflow */
> 			subflow_req->msk =3D NULL;
> @@ -1051,6 +1071,8 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
> 	smp_wmb();
> 	ssk->sk_error_report(ssk);
> 	tcp_set_state(ssk, TCP_CLOSE);
> +	subflow->reset_transient =3D 0;
> +	subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 	tcp_send_active_reset(ssk, GFP_ATOMIC);
> 	subflow->data_avail =3D 0;
> 	return false;
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============5602467379578327675==--
