Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07863C129
	for <mptcp@lists.linux.dev>; Thu, 21 Sep 2023 23:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59A1C433C8;
	Thu, 21 Sep 2023 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695340555;
	bh=54wTqW021Lon02dT76XQeJUufW9lWg2dVpAhefjP6g4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WEQbA/edd1sahEPyDkfB9Y5RiYFE5P0k/0Xyq31aqVyshH4pbkBOsjfMepLd+K2VO
	 5yC/NWYxS9yKonUPl6XlxdEX5z95bE6qX3VyIcgjA5UxhPbF5tEy7lmmnFbtBZOJIZ
	 NN+rGgQeL7nxLF6oHkx6hHTZhVjXJkNe6pdZlG0n/xzDy55aPl1Mig5zXKsoW1rgB/
	 DyzsTWO1L6OnjteJjapQBxMyCuoWNSueuUuQYfxMKDHeKg0F/KyvSYWO+JkkIYPWQb
	 nU94PaNe+/xVWcDljFHatNWN+Y87O7EwElVAdqyDF0jssRqNf6d9RWv9bib+8cy7gp
	 c6aS9SlhHiTPA==
Date: Thu, 21 Sep 2023 16:55:48 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH mptcp-next v4 4/4] mptcp: refactor sndbuf auto-tuning.
In-Reply-To: <5c1ff76635a9a7453d7a315a739c83d71a44536b.1695200723.git.pabeni@redhat.com>
Message-ID: <df729ef3-9745-c59c-a1b2-c89d52809f99@kernel.org>
References: <cover.1695200723.git.pabeni@redhat.com> <5c1ff76635a9a7453d7a315a739c83d71a44536b.1695200723.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 Sep 2023, Paolo Abeni wrote:

> The MPTCP protocol account for the data enqueued on all the subflows
> to the main socket send buffer, while the send buffer auto-tuning
> algorithm set the main socket send buffer size as the max size among
> the subflows.
>
> That causes bad performances when at least one subflow is sndbuf
> limited, e.g. due to very high latency, as the MPTCP scheduler can't
> even fill such buffer.
>
> Change the send-buffer auto-tuning algorithm to compute the main socket
> send buffer size as the sum of all the subflows buffer size.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
>   drift on memory pressure/decrease
> ---
> net/mptcp/protocol.c | 18 +++++++++++++--
> net/mptcp/protocol.h | 54 ++++++++++++++++++++++++++++++++++++++++----
> net/mptcp/subflow.c  |  3 +--
> 3 files changed, 66 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f727a7ee662d..0a9d00e794d4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -891,6 +891,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
> 	mptcp_sockopt_sync_locked(msk, ssk);
> 	mptcp_subflow_joined(msk, ssk);
> 	mptcp_stop_tout_timer(sk);
> +	__mptcp_propagate_sndbuf(sk, ssk);
> 	return true;
> }
>
> @@ -1077,15 +1078,16 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	bool first = true;
>
> -	sk_stream_moderate_sndbuf(sk);
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> 		if (first)
> 			tcp_enter_memory_pressure(ssk);
> 		sk_stream_moderate_sndbuf(ssk);
> +
> 		first = false;
> 	}
> +	__mptcp_sync_sndbuf(sk);
> }
>
> /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
> @@ -2436,6 +2438,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		WRITE_ONCE(msk->first, NULL);
>
> out:
> +	__mptcp_sync_sndbuf(sk);
> 	if (need_push)
> 		__mptcp_push_pending(sk, 0);
>
> @@ -3214,7 +3217,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
> 	 * uses the correct data
> 	 */
> 	mptcp_copy_inaddrs(nsk, ssk);
> -	mptcp_propagate_sndbuf(nsk, ssk);
> +	__mptcp_propagate_sndbuf(nsk, ssk);
>
> 	mptcp_rcv_space_init(msk, ssk);
> 	bh_unlock_sock(nsk);
> @@ -3392,6 +3395,8 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_set_connected(sk);
> 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> 			__mptcp_error_report(sk);
> +		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
> +			__mptcp_sync_sndbuf(sk);
> 	}
>
> 	__mptcp_update_rmem(sk);
> @@ -3436,6 +3441,14 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
> 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> 		mptcp_data_unlock(sk);
> 	}
> +	if (status & BIT(MPTCP_DELEGATE_SNDBUF)) {
> +		mptcp_data_lock(sk);
> +		if (!sock_owned_by_user(sk))
> +			__mptcp_sync_sndbuf(sk);
> +		else
> +			__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
> +		mptcp_data_unlock(sk);
> +	}
> 	if (status & BIT(MPTCP_DELEGATE_ACK))
> 		schedule_3rdack_retransmission(ssk);
> }
> @@ -3520,6 +3533,7 @@ bool mptcp_finish_join(struct sock *ssk)
> 	/* active subflow, already present inside the conn_list */
> 	if (!list_empty(&subflow->node)) {
> 		mptcp_subflow_joined(msk, ssk);
> +		mptcp_propagate_sndbuf(parent, ssk);
> 		return true;
> 	}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7c7ad087d8ac..ab775e48c11d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -123,6 +123,7 @@
> #define MPTCP_RETRANSMIT	4
> #define MPTCP_FLUSH_JOIN_LIST	5
> #define MPTCP_CONNECTED		6
> +#define MPTCP_SYNC_SNDBUF	7
>
> struct mptcp_skb_cb {
> 	u64 map_seq;
> @@ -447,6 +448,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> #define MPTCP_DELEGATE_SCHEDULED	0
> #define MPTCP_DELEGATE_SEND		1
> #define MPTCP_DELEGATE_ACK		2
> +#define MPTCP_DELEGATE_SNDBUF		3
>
> #define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
> /* MPTCP subflow context */
> @@ -520,6 +522,9 @@ struct mptcp_subflow_context {
>
> 	u32	setsockopt_seq;
> 	u32	stale_rcv_tstamp;
> +	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
> +				     * protected by the msk socket lock
> +				     */
>
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> 	struct	sock *conn;	    /* parent mptcp_sock */
> @@ -768,13 +773,52 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
> 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
> }
>
> -static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
> +static inline void __mptcp_sync_sndbuf(struct sock *sk)
> {
> -	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
> -		return false;
> +	struct mptcp_subflow_context *subflow;
> +	int ssk_sndbuf, new_sndbuf;
> +
> +	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
> +		return;
> +
> +	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> +		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
> +
> +		subflow->cached_sndbuf = ssk_sndbuf;
> +		new_sndbuf += ssk_sndbuf;
> +	}
> +
> +	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
> +	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
> +}
> +
> +/* The called held both the msk socket and the subflow socket locks,
> + * possibly under BH
> + */
> +static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +
> +	if (READ_ONCE(ssk->sk_sndbuf) - subflow->cached_sndbuf)

Hi Paolo -

How about

      if (READ_ONCE(ssk->sk_sndbuf) != subflow->cached_sndbuf)

instead?

Mat


> +		__mptcp_sync_sndbuf(sk);
> +}
> +
> +/* the caller held only the subflow socket lock, either in process or
> + * BH context. Additionally this can be called under the msk data lock,
> + * so we can't acquire such lock here: let the delegate action acquires
> + * the needed locks in suitable order.
> + */
> +static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +
> +	if (likely(READ_ONCE(ssk->sk_sndbuf) == subflow->cached_sndbuf))
> +		return;
>
> -	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
> -	return true;
> +	local_bh_disable();
> +	mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
> +	local_bh_enable();
> }
>
> static inline void mptcp_write_space(struct sock *sk)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6102e74121c3..0eae952064b1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
>
> void __mptcp_set_connected(struct sock *sk)
> {
> +	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
> 	if (sk->sk_state == TCP_SYN_SENT) {
> 		inet_sk_state_store(sk, TCP_ESTABLISHED);
> 		sk->sk_state_change(sk);
> @@ -472,7 +473,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 		return;
>
> 	msk = mptcp_sk(parent);
> -	mptcp_propagate_sndbuf(parent, sk);
> 	subflow->rel_write_seq = 1;
> 	subflow->conn_finished = 1;
> 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
> @@ -1728,7 +1728,6 @@ static void subflow_state_change(struct sock *sk)
>
> 	msk = mptcp_sk(parent);
> 	if (subflow_simultaneous_connect(sk)) {
> -		mptcp_propagate_sndbuf(parent, sk);
> 		mptcp_do_fallback(sk);
> 		mptcp_rcv_space_init(msk, sk);
> 		pr_fallback(msk);
> -- 
> 2.41.0
>
>
>
