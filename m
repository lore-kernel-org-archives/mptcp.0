Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95370
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 23:20:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209367525"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="209367525"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:20:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="648098333"
Received: from wilesamy-mobl.amr.corp.intel.com ([10.212.141.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:20:25 -0700
Date: Wed, 7 Jul 2021 16:20:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/8] mptcp: send out MP_FAIL when
 data checksum fail
In-Reply-To: <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
Message-ID: <ce51fdd8-f261-a17-ce9e-362b8712cc55@linux.intel.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Geliang Tang wrote:

> When a bad checksum is detected, send out the MP_FAIL option.
>
> When multiple subflows are in use, close the affected subflow with a RST
> that includes an MP_FAIL option.
>
> When a single subfow is in use, send back an MP_FAIL option on the
> subflow-level ACK. And the receiver of this MP_FAIL respond with an
> MP_FAIL in the reverse direction.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm.c       | 10 ++++++++++
> net/mptcp/protocol.h | 14 ++++++++++++++
> net/mptcp/subflow.c  | 18 ++++++++++++++++++
> 3 files changed, 42 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d4c19420194a..c34c9c0b2fa5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -250,8 +250,18 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>
> 	pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
> +
> +	if (!msk->pm.subflows) {

The pm.lock isn't held so it's not safe to access pm.subflows

I don't think it's sufficient to read pm.subflows with the lock or add 
READ_ONCE/WRITE_ONCE, since that would still allow race conditions with 
the msk. To handle fallback when receiving MP_FAIL I think the 
sock_owned_by_user() checks and delegated callback (similar to 
mptcp_subflow_process_delegated()) may be needed.

> +		if (!subflow->mp_fail_need_echo) {
> +			subflow->send_mp_fail = 1;
> +			subflow->fail_seq = fail_seq;

Echoing the fail_seq back doesn't seem correct, from the RFC it seems like 
this side should send a sequence number for the opposite data direction? 
Do you agree?

> +		} else {
> +			subflow->mp_fail_need_echo = 0;
> +		}
> +	}
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8e050575a2d9..7a49454c77a6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -422,6 +422,7 @@ struct mptcp_subflow_context {
> 		backup : 1,
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> +		mp_fail_need_echo : 1,

I think mp_fail_expect_echo would be a more accurate name.

> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1;	    /* ctx can be free at ulp release time */
> @@ -594,6 +595,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
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

Why check tmp->fully_established here?


- Mat


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
> index 0b5d4a3eadcd..46302208c474 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -913,6 +913,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> +		subflow->send_mp_fail = 1;
> +		subflow->fail_seq = subflow->map_seq;
> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> @@ -1160,6 +1162,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> fallback:
> 	/* RFC 8684 section 3.7. */
> +	if (subflow->send_mp_fail) {
> +		if (mptcp_has_another_subflow_established(ssk)) {
> +			mptcp_subflow_reset(ssk);
> +			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> +				sk_eat_skb(ssk, skb);
> +			WRITE_ONCE(subflow->data_avail, 0);
> +			return true;
> +		}
> +
> +		if (!msk->pm.subflows) {
> +			subflow->mp_fail_need_echo = 1;
> +			WRITE_ONCE(subflow->data_avail, 0);
> +			return true;
> +		}
> +	}
> +
> 	if (subflow->mp_join || subflow->fully_established) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
