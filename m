Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132D72
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 21:26:42 +0000 (UTC)
IronPort-SDR: mFdesDdUm4U6EMkDEcMoZdv+hTbtCEpj+2eDLb3JbicicEkseH0zOgHQy2ks1qV+kVR2JxBowC
 +q/TxNVNNn6w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269921020"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="269921020"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:26:41 -0700
IronPort-SDR: 7mfCoQuXUaXd73Q3IfrHbIvbkX4WHyUf3/NjynzxcNGeG2eBeXjFbYJon7K3ffRqb0zzulsyJj
 Yg4kp6HfXMyA==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="442673642"
Received: from reschenk-mobl1.amr.corp.intel.com ([10.255.230.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:26:41 -0700
Date: Tue, 15 Jun 2021 14:26:41 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
In-Reply-To: <10bbc75802301770d24a9d74b7800f491e7b67f9.1623420606.git.pabeni@redhat.com>
Message-ID: <e9bfd7b4-4a9-5a6-1f7b-e25db9d19a@linux.intel.com>
References: <10bbc75802301770d24a9d74b7800f491e7b67f9.1623420606.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 11 Jun 2021, Paolo Abeni wrote:

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
> v1 -> v2:
> - access ssk icsk/tp state instead of msk (Mat)
> ---
> net/mptcp/protocol.c | 49 +++++++++++++++++++-------------------------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 21 insertions(+), 29 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0a220862f62d..1dc3a0cb653d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -455,36 +455,36 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> 	return ret;
> }
>
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
> +}
> +
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

The return value of mptcp_subflow_cleanup_rbuf() is ignored now, so that 
function can be changed to remove the 'ret' variable and return void.

> 	}
> -
> -	/* otherwise pick the first active subflow */
> -	mptcp_for_each_subflow(msk, subflow)
> -		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
> -			return;
> }
>
> static bool mptcp_check_data_fin(struct sock *sk)
> @@ -629,7 +629,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 			break;
> 		}
> 	} while (more_data_avail);
> -	WRITE_ONCE(msk->ack_hint, ssk);
>
> 	*bytes += moved;
> 	return done;
> @@ -1910,7 +1909,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		__mptcp_update_rmem(sk);
> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> 		mptcp_data_unlock(sk);
> -		tcp_cleanup_rbuf(ssk, moved);
>
> 		if (unlikely(ssk->sk_err))
> 			__mptcp_error_report(sk);
> @@ -1926,7 +1924,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		ret |= __mptcp_ofo_queue(msk);
> 		__mptcp_splice_receive_queue(sk);
> 		mptcp_data_unlock(sk);
> -		mptcp_cleanup_rbuf(msk);

Removing this call and the tcp_cleanup_rbuf() in the hunk above does mean 
there are fewer opportunites to cleanup/ack, but it looks like those were 
"extra" calls most of the time. With the location of the one call to 
mptcp_cleanup_rbuf() in mptcp_recvmsg() it shouldn't make much difference 
unless __mptcp_recvmsg_mskq() returns an error. Would it make sense to 
move the call to mptcp_cleanup_rbuf() to immediately follow 
__mptcp_recvmsg_mskq(), before checking for errors?


Thanks,
Mat

> 	}
> 	if (ret)
> 		mptcp_check_data_fin((struct sock *)msk);
> @@ -2175,9 +2172,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	if (ssk == msk->last_snd)
> 		msk->last_snd = NULL;
>
> -	if (ssk == msk->ack_hint)
> -		msk->ack_hint = NULL;
> -
> 	if (ssk == msk->first)
> 		msk->first = NULL;
>
> @@ -2392,7 +2386,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	msk->rmem_released = 0;
> 	msk->tx_pending_data = 0;
>
> -	msk->ack_hint = NULL;
> 	msk->first = NULL;
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 160c2ab09f19..9dea0734808e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -240,7 +240,6 @@ struct mptcp_sock {
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> 	spinlock_t	join_list_lock;
> -	struct sock	*ack_hint;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> -- 
> 2.26.3

--
Mat Martineau
Intel
