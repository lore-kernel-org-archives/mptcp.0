Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D02FAF
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 01:10:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203660263"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="203660263"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 18:10:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="531919799"
Received: from ntajaddo-mobl1.amr.corp.intel.com ([10.212.194.81])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 18:10:02 -0700
Date: Wed, 18 Aug 2021 18:10:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/4] mptcp: consolidate in_opt sub-options fields
 in a bitmask
In-Reply-To: <ac598d45ee47c89f56255cb6aa24e743b154f74d.1629133749.git.pabeni@redhat.com>
Message-ID: <298d5b5e-a478-4136-796-c0ecc8cb1d7d@linux.intel.com>
References: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com> <ac598d45ee47c89f56255cb6aa24e743b154f74d.1629133749.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 18 Aug 2021, Paolo Abeni wrote:

> This makes input options processing more consistent with
> output ones and will simplify the next patch.
>
> Also avoid clearing the suboption field after processing
> it, since it's not needed.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c  | 79 +++++++++++++++++++-------------------------
> net/mptcp/protocol.c |  4 +--
> net/mptcp/protocol.h | 20 +++++------
> net/mptcp/subflow.c  | 43 ++++++++++++++----------
> 4 files changed, 70 insertions(+), 76 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 500137f93c28..18ad028ed589 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -80,10 +80,12 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		 * In other words, the only way for checksums not to be used
> 		 * is if both hosts in their SYNs set A=0."
> 		 */
> -		mp_opt->csum_reqd = !!(flags & MPTCP_CAP_CHECKSUM_REQD);
> -		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
> +		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> +			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> +		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
> +			mp_opt->suboptions |= OPTION_MPTCP_DENYID0;
>
> -		mp_opt->mp_capable = 1;
> +		mp_opt->suboptions |= OPTIONS_MPTCP_MPC;
> 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
> 			mp_opt->sndr_key = get_unaligned_be64(ptr);
> 			ptr += 8;
> @@ -98,7 +100,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			 * equivalent to those in a DSS option and can be used
> 			 * interchangeably."
> 			 */
> -			mp_opt->dss = 1;
> +			mp_opt->suboptions |= OPTION_MPTCP_DSS;
> 			mp_opt->use_map = 1;
> 			mp_opt->mpc_map = 1;
> 			mp_opt->data_len = get_unaligned_be16(ptr);
> @@ -106,7 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		}
> 		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
> 			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
> -			mp_opt->csum_reqd = 1;
> +			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> 			ptr += 2;
> 		}
> 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
> @@ -115,7 +117,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		break;
>
> 	case MPTCPOPT_MP_JOIN:
> -		mp_opt->mp_join = 1;
> +		mp_opt->suboptions |= OPTIONS_MPTCP_MPJ;
> 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
> 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
> 			mp_opt->join_id = *ptr++;
> @@ -141,7 +143,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
> 			pr_debug("MP_JOIN hmac");
> 		} else {
> -			mp_opt->mp_join = 0;
> +			mp_opt->suboptions &= ~OPTIONS_MPTCP_MPJ;
> 		}
> 		break;
>
> @@ -189,8 +191,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
> 			break;
>
> -		mp_opt->dss = 1;
> -
> +		mp_opt->suboptions |= OPTION_MPTCP_DSS;
> 		if (mp_opt->use_ack) {
> 			if (mp_opt->ack64) {
> 				mp_opt->data_ack = get_unaligned_be64(ptr);
> @@ -219,14 +220,15 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			ptr += 2;
>
> 			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
> -				mp_opt->csum_reqd = 1;
> +				mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
> 				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
> 				ptr += 2;
> 			}
>
> 			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
> 				 mp_opt->data_seq, mp_opt->subflow_seq,
> -				 mp_opt->data_len, mp_opt->csum_reqd, mp_opt->csum);
> +				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
> +				 mp_opt->csum);
> 		}
>
> 		break;
> @@ -257,7 +259,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 				break;
> 		}
>
> -		mp_opt->add_addr = 1;
> +		mp_opt->suboptions = OPTION_MPTCP_ADD_ADDR;

The above "=" instead of "|=" is the only issue I noticed (the perils of 
manual bitfields!). Still running the tests to double check, but this 
seems like a good way to skip a lot of unnecessary branches.


Mat


> 		mp_opt->addr.id = *ptr++;
> 		mp_opt->addr.port = 0;
> 		if (mp_opt->addr.family == AF_INET) {
> @@ -297,7 +299,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>
> 		ptr++;
>
> -		mp_opt->rm_addr = 1;
> +		mp_opt->suboptions |= OPTION_MPTCP_RM_ADDR;
> 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
> 		for (i = 0; i < mp_opt->rm_list.nr; i++)
> 			mp_opt->rm_list.ids[i] = *ptr++;
> @@ -308,7 +310,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		if (opsize != TCPOLEN_MPTCP_PRIO)
> 			break;
>
> -		mp_opt->mp_prio = 1;
> +		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
> 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
> 		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
> 		break;
> @@ -320,7 +322,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		ptr += 2;
> 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
> 		ptr += 8;
> -		mp_opt->fastclose = 1;
> +		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
> 		break;
>
> 	case MPTCPOPT_RST:
> @@ -329,7 +331,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>
> 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
> 			break;
> -		mp_opt->reset = 1;
> +
> +		mp_opt->suboptions |= OPTION_MPTCP_RST;
> 		flags = *ptr++;
> 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
> 		mp_opt->reset_reason = *ptr;
> @@ -340,7 +343,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			break;
>
> 		ptr += 2;
> -		mp_opt->mp_fail = 1;
> +		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
> 		mp_opt->fail_seq = get_unaligned_be64(ptr);
> 		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
> 		break;
> @@ -359,15 +362,7 @@ void mptcp_get_options(const struct sock *sk,
> 	int length;
>
> 	/* initialize option status */
> -	mp_opt->mp_capable = 0;
> -	mp_opt->mp_join = 0;
> -	mp_opt->add_addr = 0;
> -	mp_opt->fastclose = 0;
> -	mp_opt->rm_addr = 0;
> -	mp_opt->dss = 0;
> -	mp_opt->mp_prio = 0;
> -	mp_opt->reset = 0;
> -	mp_opt->mp_fail = 0;
> +	mp_opt->suboptions = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -921,7 +916,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		 */
> 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
> 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
> -		    subflow->mp_join && mp_opt->mp_join &&
> +		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
> 		    READ_ONCE(msk->pm.server_side))
> 			tcp_send_ack(ssk);
> 		goto fully_established;
> @@ -938,7 +933,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		return subflow->mp_capable;
> 	}
>
> -	if (mp_opt->dss && mp_opt->use_ack) {
> +	if ((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) {
> 		/* subflows are fully established as soon as we get any
> 		 * additional ack.
> 		 */
> @@ -947,7 +942,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		goto fully_established;
> 	}
>
> -	if (mp_opt->add_addr) {
> +	if (mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) {
> 		WRITE_ONCE(msk->fully_established, true);
> 		return true;
> 	}
> @@ -956,7 +951,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 	 * then fallback to TCP. Fallback scenarios requires a reset for
> 	 * MP_JOIN subflows.
> 	 */
> -	if (!mp_opt->mp_capable) {
> +	if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
> 		if (subflow->mp_join)
> 			goto reset;
> 		subflow->mp_capable = 0;
> @@ -965,7 +960,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 		return false;
> 	}
>
> -	if (mp_opt->deny_join_id0)
> +	if (mp_opt->suboptions & OPTION_MPTCP_DENYID0)
> 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
>
> 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
> @@ -1120,13 +1115,13 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> 		return sk->sk_state != TCP_CLOSE;
>
> -	if (mp_opt.fastclose &&
> +	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> 	    msk->local_key == mp_opt.rcvr_key) {
> 		WRITE_ONCE(msk->rcv_fastclose, true);
> 		mptcp_schedule_work((struct sock *)msk);
> 	}
>
> -	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
> +	if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
> 		if (!mp_opt.echo) {
> 			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> @@ -1138,34 +1133,28 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>
> 		if (mp_opt.addr.port)
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> -
> -		mp_opt.add_addr = 0;
> 	}
>
> -	if (mp_opt.rm_addr) {
> +	if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
> 		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> -		mp_opt.rm_addr = 0;
> -	}
>
> -	if (mp_opt.mp_prio) {
> +	if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
> 		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> -		mp_opt.mp_prio = 0;
> 	}
>
> -	if (mp_opt.mp_fail) {
> +	if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
> 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> -		mp_opt.mp_fail = 0;
> 	}
>
> -	if (mp_opt.reset) {
> +	if (mp_opt.suboptions & OPTION_MPTCP_RST) {
> 		subflow->reset_seen = 1;
> 		subflow->reset_reason = mp_opt.reset_reason;
> 		subflow->reset_transient = mp_opt.reset_transient;
> 	}
>
> -	if (!mp_opt.dss)
> +	if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
> 		return true;
>
> 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
> @@ -1214,7 +1203,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 		}
> 		mpext->data_len = mp_opt.data_len;
> 		mpext->use_map = 1;
> -		mpext->csum_reqd = mp_opt.csum_reqd;
> +		mpext->csum_reqd = !!(mp_opt.suboptions & OPTION_MPTCP_CSUMREQD);
>
> 		if (mpext->csum_reqd)
> 			mpext->csum = mp_opt.csum;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8eb2626503d7..b5f8ad634571 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2836,7 +2836,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->token = subflow_req->token;
> 	msk->subflow = NULL;
> 	WRITE_ONCE(msk->fully_established, false);
> -	if (mp_opt->csum_reqd)
> +	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
> 		WRITE_ONCE(msk->csum_enabled, true);
>
> 	msk->write_seq = subflow_req->idsn + 1;
> @@ -2845,7 +2845,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
>
> -	if (mp_opt->mp_capable) {
> +	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
> 		msk->can_ack = true;
> 		msk->remote_key = mp_opt->sndr_key;
> 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 624a72e7ea17..9934bea21cb9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -29,6 +29,14 @@
> #define OPTION_MPTCP_DSS	BIT(11)
> #define OPTION_MPTCP_FAIL	BIT(12)
>
> +#define OPTION_MPTCP_CSUMREQD	BIT(13)
> +#define OPTION_MPTCP_DENYID0	BIT(14)
> +
> +#define OPTIONS_MPTCP_MPC	(OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK | \
> +				 OPTION_MPTCP_MPC_ACK)
> +#define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
> +				 OPTION_MPTCP_MPJ_SYNACK)
> +
> /* MPTCP option subtypes */
> #define MPTCPOPT_MP_CAPABLE	0
> #define MPTCPOPT_MP_JOIN	1
> @@ -132,15 +140,7 @@ struct mptcp_options_received {
> 	u32	subflow_seq;
> 	u16	data_len;
> 	__sum16	csum;
> -	u16	mp_capable : 1,
> -		mp_join : 1,
> -		fastclose : 1,
> -		reset : 1,
> -		dss : 1,
> -		add_addr : 1,
> -		rm_addr : 1,
> -		mp_prio : 1,
> -		mp_fail : 1;
> +	u16	suboptions;
> 	u32	token;
> 	u32	nonce;
> 	u16	use_map:1,
> @@ -152,9 +152,7 @@ struct mptcp_options_received {
> 		reset_reason:4,
> 		reset_transient:1,
> 		echo:1,
> -		csum_reqd:1,
> 		backup:1,
> -		deny_join_id0:1,
> 		__unused:1;
> 	u8	join_id;
> 	u64	thmac;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 54b7ffc21861..670bed9fcf2e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -141,6 +141,7 @@ static int subflow_check_req(struct request_sock *req,
> 	struct mptcp_subflow_context *listener = mptcp_subflow_ctx(sk_listener);
> 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> 	struct mptcp_options_received mp_opt;
> +	bool opt_mp_capable, opt_mp_join;
>
> 	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
>
> @@ -154,16 +155,18 @@ static int subflow_check_req(struct request_sock *req,
>
> 	mptcp_get_options(sk_listener, skb, &mp_opt);
>
> -	if (mp_opt.mp_capable) {
> +	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
> +	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
> +	if (opt_mp_capable) {
> 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
>
> -		if (mp_opt.mp_join)
> +		if (opt_mp_join)
> 			return 0;
> -	} else if (mp_opt.mp_join) {
> +	} else if (opt_mp_join) {
> 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
> 	}
>
> -	if (mp_opt.mp_capable && listener->request_mptcp) {
> +	if (opt_mp_capable && listener->request_mptcp) {
> 		int err, retries = MPTCP_TOKEN_MAX_RETRIES;
>
> 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
> @@ -194,7 +197,7 @@ static int subflow_check_req(struct request_sock *req,
> 		else
> 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
>
> -	} else if (mp_opt.mp_join && listener->request_mptcp) {
> +	} else if (opt_mp_join && listener->request_mptcp) {
> 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
> 		subflow_req->mp_join = 1;
> 		subflow_req->backup = mp_opt.backup;
> @@ -243,15 +246,18 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 	struct mptcp_subflow_context *listener = mptcp_subflow_ctx(sk_listener);
> 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> 	struct mptcp_options_received mp_opt;
> +	bool opt_mp_capable, opt_mp_join;
> 	int err;
>
> 	subflow_init_req(req, sk_listener);
> 	mptcp_get_options(sk_listener, skb, &mp_opt);
>
> -	if (mp_opt.mp_capable && mp_opt.mp_join)
> +	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
> +	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
> +	if (opt_mp_capable && opt_mp_join)
> 		return -EINVAL;
>
> -	if (mp_opt.mp_capable && listener->request_mptcp) {
> +	if (opt_mp_capable && listener->request_mptcp) {
> 		if (mp_opt.sndr_key == 0)
> 			return -EINVAL;
>
> @@ -262,7 +268,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>
> 		subflow_req->mp_capable = 1;
> 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq - 1;
> -	} else if (mp_opt.mp_join && listener->request_mptcp) {
> +	} else if (opt_mp_join && listener->request_mptcp) {
> 		if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
> 			return -EINVAL;
>
> @@ -394,7 +400,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
>
> -
> 	/* be sure no special action on any packet other than syn-ack */
> 	if (subflow->conn_finished)
> 		return;
> @@ -407,7 +412,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> 	mptcp_get_options(sk, skb, &mp_opt);
> 	if (subflow->request_mptcp) {
> -		if (!mp_opt.mp_capable) {
> +		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
> 			MPTCP_INC_STATS(sock_net(sk),
> 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
> 			mptcp_do_fallback(sk);
> @@ -415,9 +420,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 			goto fallback;
> 		}
>
> -		if (mp_opt.csum_reqd)
> +		if (mp_opt.suboptions & OPTION_MPTCP_CSUMREQD)
> 			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
> -		if (mp_opt.deny_join_id0)
> +		if (mp_opt.suboptions & OPTION_MPTCP_DENYID0)
> 			WRITE_ONCE(mptcp_sk(parent)->pm.remote_deny_join_id0, true);
> 		subflow->mp_capable = 1;
> 		subflow->can_ack = 1;
> @@ -430,7 +435,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 	} else if (subflow->request_join) {
> 		u8 hmac[SHA256_DIGEST_SIZE];
>
> -		if (!mp_opt.mp_join) {
> +		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ)) {
> 			subflow->reset_reason = MPTCP_RST_EMPTCP;
> 			goto do_reset;
> 		}
> @@ -636,10 +641,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>
> 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
>
> -	/* After child creation we must look for 'mp_capable' even when options
> +	/* After child creation we must look for MPC even when options
> 	 * are not parsed
> 	 */
> -	mp_opt.mp_capable = 0;
> +	mp_opt.suboptions = 0;
>
> 	/* hopefully temporary handling for MP_JOIN+syncookie */
> 	subflow_req = mptcp_subflow_rsk(req);
> @@ -659,7 +664,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 		 * options.
> 		 */
> 		mptcp_get_options(sk, skb, &mp_opt);
> -		if (!mp_opt.mp_capable) {
> +		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
> 			fallback = true;
> 			goto create_child;
> 		}
> @@ -668,8 +673,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 		if (!new_msk)
> 			fallback = true;
> 	} else if (subflow_req->mp_join) {
> +		bool opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
> +
> 		mptcp_get_options(sk, skb, &mp_opt);
> -		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
> +		if (!opt_mp_join || !subflow_hmac_valid(req, &mp_opt) ||
> 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
> 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
> 			fallback = true;
> @@ -726,7 +733,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 			/* with OoO packets we can reach here without ingress
> 			 * mpc option
> 			 */
> -			if (mp_opt.mp_capable)
> +			if (mp_opt.suboptions & OPTIONS_MPTCP_MPC)
> 				mptcp_subflow_fully_established(ctx, &mp_opt);
> 		} else if (ctx->mp_join) {
> 			struct mptcp_sock *owner;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
