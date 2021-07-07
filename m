Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37E70
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 23:07:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="207581022"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="207581022"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:07:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="648094543"
Received: from wilesamy-mobl.amr.corp.intel.com ([10.212.141.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:07:41 -0700
Date: Wed, 7 Jul 2021 16:07:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/8] mptcp: MP_FAIL suboption
 sending
In-Reply-To: <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
Message-ID: <aa163c9-156d-fd2f-5ce9-dca1cec3c770@linux.intel.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Geliang Tang wrote:

> This patch added the MP_FAIL suboption sending support.
>
> Add a new flag named send_mp_fail in struct mptcp_subflow_context. If
> this flag is set, send out MP_FAIL suboption.
>
> Add a new member fail_seq in struct mptcp_out_options to save the data
> sequence number to put into the MP_FAIL suboption.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> include/net/mptcp.h  |  1 +
> net/mptcp/options.c  | 54 ++++++++++++++++++++++++++++++++++++++++++--
> net/mptcp/protocol.h |  4 ++++
> 3 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index cb580b06152f..f48d3b5a3fd4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -72,6 +72,7 @@ struct mptcp_out_options {
> 	u32 nonce;
> 	u64 thmac;
> 	u32 token;
> +	u64 fail_seq;
> 	u8 hmac[20];
> 	struct mptcp_ext ext_copy;
> #endif
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b5850afea343..b78defe1aed9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -771,6 +771,28 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
> 	opts->reset_reason = subflow->reset_reason;
> }
>
> +static bool mptcp_established_options_mp_fail(struct sock *sk,
> +					      unsigned int *size,
> +					      unsigned int remaining,
> +					      struct mptcp_out_options *opts)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> +	if (!subflow->send_mp_fail)
> +		return false;
> +
> +	if (remaining < TCPOLEN_MPTCP_FAIL)
> +		return false;
> +
> +	*size = TCPOLEN_MPTCP_FAIL;
> +	opts->suboptions |= OPTION_MPTCP_FAIL;
> +	opts->fail_seq = subflow->fail_seq;
> +
> +	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
> +
> +	return true;
> +}
> +
> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts)
> @@ -787,15 +809,29 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 		return false;
>
> 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> -		mptcp_established_options_rst(sk, skb, size, remaining, opts);
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts);
> +		*size += opt_size;
> +		remaining -= opt_size;

If there isn't enough space for MP_TCPRST, opt_size can still have the 
value set by mptcp_established_options_mp_fail() and the previous two 
lines would add or subtract incorrectly. mptcp_established_options_rst() 
could return bool to make the size adjustments conditional like the new 
mp_fail lines above.

- Mat


> 		return true;
> 	}
>
> 	snd_data_fin = mptcp_data_fin_enabled(msk);
> 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
> 		ret = true;
> -	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts))
> +	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
> 		ret = true;
> +		if (opts->ext_copy.use_ack) {
> +			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +				*size += opt_size;
> +				remaining -= opt_size;
> +				ret = true;
> +			}
> +		}
> +	}
>
> 	/* we reserved enough space for the above options, and exceeding the
> 	 * TCP option space would be fatal
> @@ -1334,6 +1370,20 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 				      opts->backup, TCPOPT_NOP);
> 	}
>
> +	if (OPTION_MPTCP_FAIL & opts->suboptions) {
> +		const struct sock *ssk = (const struct sock *)tp;
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		subflow->send_mp_fail = 0;
> +
> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> +				      TCPOLEN_MPTCP_FAIL,
> +				      0, 0);
> +		put_unaligned_be64(opts->fail_seq, ptr);
> +		ptr += 2;
> +	}
> +
> 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> 		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> 				      TCPOLEN_MPTCP_MPJ_SYN,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 426ed80fe72f..007af5e4ba3d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -26,6 +26,7 @@
> #define OPTION_MPTCP_FASTCLOSE	BIT(8)
> #define OPTION_MPTCP_PRIO	BIT(9)
> #define OPTION_MPTCP_RST	BIT(10)
> +#define OPTION_MPTCP_FAIL	BIT(11)
>
> /* MPTCP option subtypes */
> #define MPTCPOPT_MP_CAPABLE	0
> @@ -67,6 +68,7 @@
> #define TCPOLEN_MPTCP_PRIO_ALIGN	4
> #define TCPOLEN_MPTCP_FASTCLOSE		12
> #define TCPOLEN_MPTCP_RST		4
> +#define TCPOLEN_MPTCP_FAIL		12
>
> #define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
>
> @@ -417,6 +419,7 @@ struct mptcp_subflow_context {
> 		mpc_map : 1,
> 		backup : 1,
> 		send_mp_prio : 1,
> +		send_mp_fail : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1;	    /* ctx can be free at ulp release time */
> @@ -431,6 +434,7 @@ struct mptcp_subflow_context {
> 	u8	reset_seen:1;
> 	u8	reset_transient:1;
> 	u8	reset_reason:4;
> +	u64	fail_seq;
>
> 	long	delegated_status;
> 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
