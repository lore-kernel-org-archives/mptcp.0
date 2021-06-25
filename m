Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07B2FB2
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 23:48:03 +0000 (UTC)
IronPort-SDR: XJZ+bSTUphSW3RIiAgCMMjBpXRMlWF0U6CBd9DGJWn3s4uI790mNEXzYCnutEHB5sro7TwK9+s
 d1gNDlvgXOdA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="188138411"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="188138411"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 16:48:02 -0700
IronPort-SDR: lwuKk4SBiUsdh7J5XDBp0bvzmM9l30W+CE4nnSpwUsgXU+c09yjpH8biPrsdONGasbTVf9Zkz9
 5UW1U7VbhEnw==
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="418534868"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 16:47:58 -0700
Date: Fri, 25 Jun 2021 16:47:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 2/5] mptcp: MP_FAIL suboption
 receiving
In-Reply-To: <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
Message-ID: <99b4b4f7-3d7c-3636-11ca-0218ac5c456@linux.intel.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 24 Jun 2021, Geliang Tang wrote:

> This patch added handling for receiving MP_FAIL suboption.
>
> Add a new members mp_fail and fail_seq in struct mptcp_options_received.
> When MP_FAIL suboption is received, set mp_fail to 1 and save the sequence
> number to fail_seq.
>
> Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboption.
> In it, if there is no other established subflow, fallback to TCP.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c  | 16 ++++++++++++++++
> net/mptcp/pm.c       | 13 +++++++++++++
> net/mptcp/protocol.h | 16 ++++++++++++++++
> 3 files changed, 45 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eac23ceb9843..cd4d0521556d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -336,6 +336,16 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		mp_opt->reset_reason = *ptr;
> 		break;
>
> +	case MPTCPOPT_MP_FAIL:
> +		if (opsize != TCPOLEN_MPTCP_FAIL)
> +			break;
> +
> +		ptr += 2;
> +		mp_opt->mp_fail = 1;
> +		mp_opt->fail_seq = get_unaligned_be64(ptr);
> +		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
> +		break;
> +
> 	default:
> 		break;
> 	}
> @@ -364,6 +374,7 @@ void mptcp_get_options(const struct sock *sk,
> 	mp_opt->reset = 0;
> 	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
> 	mp_opt->deny_join_id0 = 0;
> +	mp_opt->mp_fail = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -1123,6 +1134,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 		mp_opt.mp_prio = 0;
> 	}
>
> +	if (mp_opt.mp_fail) {
> +		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +		mp_opt.mp_fail = 0;
> +	}
> +
> 	if (mp_opt.reset) {
> 		subflow->reset_seen = 1;
> 		subflow->reset_reason = mp_opt.reset_reason;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 639271e09604..d7792f6e38ba 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -247,6 +247,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
> }
>
> +void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> +	pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
> +
> +	if (!mptcp_has_another_subflow_established(sk)) {
> +		pr_fallback(msk);
> +		__mptcp_do_fallback(msk);
> +	}
> +}
> +

RFC 8684 also says the receiver of MP_FAIL should respond with MP_FAIL. 
That would also require some logic so only one MP_FAIL is sent in each 
direction.

I think there's some more fallback complexity too, see patch 3 reply.

-Mat


> /* path manager helpers */
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fd36c743c638..62fe09394624 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -139,6 +139,7 @@ struct mptcp_options_received {
> 		add_addr : 1,
> 		rm_addr : 1,
> 		mp_prio : 1,
> +		mp_fail : 1,
> 		echo : 1,
> 		csum_reqd : 1,
> 		backup : 1,
> @@ -160,6 +161,7 @@ struct mptcp_options_received {
> 	u64	ahmac;
> 	u8	reset_reason:4;
> 	u8	reset_transient:1;
> +	u64	fail_seq;
> };
>
> static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
> @@ -591,6 +593,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> }
>
> +static inline bool mptcp_has_another_subflow_established(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> +	mptcp_for_each_subflow(msk, tmp) {
> +		if (tmp->fully_established && tmp != subflow)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> @@ -703,6 +718,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 				 struct mptcp_addr_info *addr,
> 				 u8 bkup);
> +void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
