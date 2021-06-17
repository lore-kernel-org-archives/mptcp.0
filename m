Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360672
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 00:13:13 +0000 (UTC)
IronPort-SDR: ke2fkHA4z2xY6FFSB7evTp7ao40/SsdFPqRQUH01aEot8LwKBzW48gv9v15qPvrn3NqAfPVmgk
 ZHut+jH4xrnA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="291910080"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291910080"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:13:12 -0700
IronPort-SDR: lwlUv0T8xwwTRPJo+56GJOc8O3KagBP53J2UtIfd7pk4la+lnj/kIVK1nihnDina2gUS8giKkd
 3H58MS60xNvg==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450819814"
Received: from ndalili-mobl.amr.corp.intel.com ([10.209.105.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 17:13:12 -0700
Date: Wed, 16 Jun 2021 17:13:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
In-Reply-To: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
Message-ID: <a5dfa3f-d52c-70e1-260-141ca530@linux.intel.com>
References: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, Paolo Abeni wrote:

> The current cleanup rbuf tries a bit too hard to avoid acquiring
> the subflow socket lock. We may end-up delaying the needed ack,
> or skip acking a blocked subflow.
>
> Address the above extending the conditions used to trigger the cleanup
> to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> on all the active subflows.
>
> Note that we can't replicate the exact tests implemented in
> tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> ping-pong mode.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - mptcp_subflow_cleanup_rbuf() returns void

Thanks for the v3, this looks ready to apply.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> v1 -> v2:
> - access ssk icsk/tp state instead of msk (Mat)
> ---
> net/mptcp/protocol.c | 56 ++++++++++++++++++--------------------------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 23 insertions(+), 34 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0a220862f62d..05c8382aafef 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -442,49 +442,46 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
> 	}
> }
>
> -static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> +static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> {
> 	bool slow;
> -	int ret;
>
> 	slow = lock_sock_fast(ssk);
> -	ret = tcp_can_send_ack(ssk);
> -	if (ret)
> +	if (tcp_can_send_ack(ssk))
> 		tcp_cleanup_rbuf(ssk, 1);
> 	unlock_sock_fast(ssk, slow);
> -	return ret;
> +}
> +
> +static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
> +{
> +	const struct inet_connection_sock *icsk = inet_csk(ssk);
> +	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> +	const struct tcp_sock *tp = tcp_sk(ssk);
> +
> +	return (ack_pending & ICSK_ACK_SCHED) &&
> +		((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
> +		  READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
> +		 (rx_empty && ack_pending &
> +			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
> }
>
> static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
> {
> -	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
> 	int old_space = READ_ONCE(msk->old_wspace);
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> -	bool cleanup;
> +	int space =  __mptcp_space(sk);
> +	bool cleanup, rx_empty;
>
> -	/* this is a simple superset of what tcp_cleanup_rbuf() implements
> -	 * so that we don't have to acquire the ssk socket lock most of the time
> -	 * to do actually nothing
> -	 */
> -	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
> -	if (!cleanup)
> -		return;
> +	cleanup = (space > 0) && (space >= (old_space << 1));
> +	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
>
> -	/* if the hinted ssk is still active, try to use it */
> -	if (likely(ack_hint)) {
> -		mptcp_for_each_subflow(msk, subflow) {
> -			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> -			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
> -				return;
> -		}
> +		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
> +			mptcp_subflow_cleanup_rbuf(ssk);
> 	}
> -
> -	/* otherwise pick the first active subflow */
> -	mptcp_for_each_subflow(msk, subflow)
> -		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
> -			return;
> }
>
> static bool mptcp_check_data_fin(struct sock *sk)
> @@ -629,7 +626,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 			break;
> 		}
> 	} while (more_data_avail);
> -	WRITE_ONCE(msk->ack_hint, ssk);
>
> 	*bytes += moved;
> 	return done;
> @@ -1910,7 +1906,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		__mptcp_update_rmem(sk);
> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> 		mptcp_data_unlock(sk);
> -		tcp_cleanup_rbuf(ssk, moved);
>
> 		if (unlikely(ssk->sk_err))
> 			__mptcp_error_report(sk);
> @@ -1926,7 +1921,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		ret |= __mptcp_ofo_queue(msk);
> 		__mptcp_splice_receive_queue(sk);
> 		mptcp_data_unlock(sk);
> -		mptcp_cleanup_rbuf(msk);
> 	}
> 	if (ret)
> 		mptcp_check_data_fin((struct sock *)msk);
> @@ -2175,9 +2169,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	if (ssk == msk->last_snd)
> 		msk->last_snd = NULL;
>
> -	if (ssk == msk->ack_hint)
> -		msk->ack_hint = NULL;
> -
> 	if (ssk == msk->first)
> 		msk->first = NULL;
>
> @@ -2392,7 +2383,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	msk->rmem_released = 0;
> 	msk->tx_pending_data = 0;
>
> -	msk->ack_hint = NULL;
> 	msk->first = NULL;
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 41f2957bf50c..2480db50cbd2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -243,7 +243,6 @@ struct mptcp_sock {
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> 	spinlock_t	join_list_lock;
> -	struct sock	*ack_hint;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
