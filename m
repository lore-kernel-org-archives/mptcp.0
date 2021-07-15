Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BF168
	for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 01:46:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190138748"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190138748"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:46:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="494839196"
Received: from ywu57-mobl2.amr.corp.intel.com ([10.212.215.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:46:48 -0700
Date: Wed, 14 Jul 2021 18:46:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v4 mptcp-next 3/5] mptcp: send out MP_FAIL when
 data checksum fail
In-Reply-To: <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com>
Message-ID: <c1cab5c9-2ef2-7fe4-a75f-9b458a2a9a7@linux.intel.com>
References: <cover.1626258797.git.geliangtang@gmail.com> <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com> <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com>
 <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 14 Jul 2021, Geliang Tang wrote:

> When a bad checksum is detected, set the send_mp_fail flag to send out
> the MP_FAIL option.
>
> Add a new function mptcp_has_another_subflow() to check whether there's
> only a single subflow.
>
> When multiple subflows are in use, close the affected subflow with a RST
> that includes an MP_FAIL option and discard the data with the bad
> checksum.
>
> Set the sk_state of the subsocket to TCP_CLOSE, then the flag
> MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
> and the subflow will be closed.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.h | 13 +++++++++++++
> net/mptcp/subflow.c  | 15 +++++++++++++++
> 2 files changed, 28 insertions(+)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 20f8faf0543b..260920d26935 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -601,6 +601,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> }
>
> +static inline bool mptcp_has_another_subflow(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
> +	mptcp_for_each_subflow(msk, tmp) {
> +		if (tmp != subflow)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 966f777d35ce..11a719fad718 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -908,6 +908,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> +		subflow->send_mp_fail = 1;
> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> @@ -1155,6 +1156,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> fallback:
> 	/* RFC 8684 section 3.7. */
> +	if (subflow->send_mp_fail) {
> +		if (mptcp_has_another_subflow(ssk)) {
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
> +			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> +				sk_eat_skb(ssk, skb);
> +			WRITE_ONCE(subflow->data_avail, 0);
> +			return true;
> +		}
> +	}
> +

The above handles the multiple-subflow case...

> 	if (subflow->mp_join || subflow->fully_established) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers

...and since the infinite-mapping code and other single-subflow logic will 
be in a later patch set, should the single-subflow case be temporarily 
handled here by sending MP_TCPRST instead of MP_FAIL?

--
Mat Martineau
Intel
