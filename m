Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769882D7DDF
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989518; cv=none; b=aPCAmSlMT95XxmhlkKYgXQsuf621mWMP2VVyWEAPcxpXtXxOYa8pbhnqDwcpMYaoBG4q1/1lKerJRCyTg8gN4onLdnB+Pj1g+4l0Old1RdsyDySqiBLeryIN9weoL+Ktbbe7ei9CenVddTK39gpwqJE7/9zX8M5Nw+6IZfROFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989518; c=relaxed/simple;
	bh=8kphyvr6wRRz+W4Fx6Y2yhN1xmU4NA6Ol+MXu823GXU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ER7Npxbug+qtWvjsc3ogp7pHC5Whb0p/HIwRXJWOBQyJVVR5NXXZSiuWZEceCdy+DPXO+qu9/NyGdADgA+R5P4bXZ9WHp4AcI/YxT4sabGZM+yeDZZLzCQeEpd4A0vT2TftYtFxqvjD04S5TDP1v0ESaw1PHt1K5VQzB6TO+JvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PofsO0yO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PofsO0yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C9DC113D0;
	Mon, 20 Oct 2025 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760989518;
	bh=8kphyvr6wRRz+W4Fx6Y2yhN1xmU4NA6Ol+MXu823GXU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PofsO0yOumfVtNeW/bGlqfeDQbwa7n0vUSnfl3ctnwVfz9MDllkNMC0OceYXzvunj
	 h+dDIHkhtEhuu03ixaC7D3xI2OiPkVBRvv6TST2O5FHTD9bUaQ5bjlTiX8XPMXNOV8
	 Y8894mFvBREH1PzudFkcRKyIDrHgDyVpQjI6OnpauQzE1DK3T8ln1QLuufS+uebzSZ
	 JwavkkiGkb2/pm9sDxHr4Wh7LAmphER8YIuGg079alFiGn9CPzfh2J/uvu5AuG40Lo
	 uNeNXnTlPTheTepsHcysgkmiTGy1454WeWeh1zeJKEQF/DZMF3AyOY/KglXl/xVtvM
	 yD90Gxs6poO5w==
Date: Mon, 20 Oct 2025 12:45:17 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-next 09/10] mptcp: introduce mptcp-level
 backlog
In-Reply-To: <16ead1024784cf5913a9c9ef69d7d15cb73512a3.1759737859.git.pabeni@redhat.com>
Message-ID: <a6e2b980-9e6a-3dcc-276d-b8d78f091e34@kernel.org>
References: <cover.1759737859.git.pabeni@redhat.com> <16ead1024784cf5913a9c9ef69d7d15cb73512a3.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Oct 2025, Paolo Abeni wrote:

> We are soon using it for incoming data processing.
> MPTCP can't leverage the sk_backlog, as the latter is processed
> before the release callback, and such callback for MPTCP releases
> and re-acquire the socket spinlock, breaking the sk_backlog processing
> assumption.
>
> Add a skb backlog list inside the mptcp sock struct, and implement
> basic helper to transfer packet to and purge such list.
>
> Packets in the backlog are not memory accounted, but still use the
> incoming subflow receive memory, to allow back-pressure.
>
> No packet is currently added to the backlog, so no functional changes
> intended here.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> v4 -> v5:
>  - split out of the next path, to make the latter smaller
>  - set a custom destructor for skbs in the backlog, this avoid
>    duplicate code, and fix a few places where the need ssk cleanup
>    was not performed.
>  - factor out the backlog purge in a new helper,
>    use spinlock protection, clear the backlog list and zero the
>    backlog len
>  - explicitly init the backlog_len at mptcp_init_sock() time
> ---
> net/mptcp/protocol.c | 70 +++++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h |  4 +++
> 2 files changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 05ee6bd26b7fa..2d5d3da67d1ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -337,6 +337,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
> 		mptcp_rcvbuf_grow(sk);
> }
>
> +static void mptcp_bl_free(struct sk_buff *skb)
> +{
> +	atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +}
> +
> static int mptcp_init_skb(struct sock *ssk,
> 			  struct sk_buff *skb, int offset, int copy_len)
> {
> @@ -360,7 +365,7 @@ static int mptcp_init_skb(struct sock *ssk,
> 	skb_dst_drop(skb);
>
> 	/* "borrow" the fwd memory from the subflow, instead of reclaiming it */
> -	skb->destructor = NULL;
> +	skb->destructor = mptcp_bl_free;
> 	borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
> 	borrowed &= ~(PAGE_SIZE - 1);
> 	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
> @@ -373,6 +378,13 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct sk_buff *tail;
>
> +	/* Avoid the indirect call overhead, we know destructor is
> +	 * mptcp_bl_free at this point.
> +	 */
> +	atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);

Hi Paolo -

Better (very slightly :) ) to make the direct call to mptcp_bl_free() 
then? The optimizer would inline it.

> +	skb->sk = NULL;
> +	skb->destructor = NULL;
> +
> 	/* try to fetch required memory from subflow */
> 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> @@ -654,6 +666,35 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
> 	}
> }
>
> +static void __mptcp_add_backlog(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *tail = NULL;
> +	bool fragstolen;
> +	int delta;
> +
> +	if (unlikely(sk->sk_state == TCP_CLOSE)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +		return;
> +	}
> +
> +	/* Try to coalesce with the last skb in our backlog */
> +	if (!list_empty(&msk->backlog_list))
> +		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
> +
> +	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
> +	    skb->sk == tail->sk &&
> +	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
> +		skb->truesize -= delta;
> +		kfree_skb_partial(skb, fragstolen);
> +		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
> +		return;
> +	}
> +
> +	list_add_tail(&skb->list, &msk->backlog_list);
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
> +}
> +
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 					   struct sock *ssk)
> {
> @@ -701,10 +742,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 			int bmem;
>
> 			bmem = mptcp_init_skb(ssk, skb, offset, len);
> -			skb->sk = NULL;
> 			sk_forward_alloc_add(sk, bmem);
> -			atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
> -			ret = __mptcp_move_skb(sk, skb) || ret;
> +
> +			if (true)
> +				ret |= __mptcp_move_skb(sk, skb);
> +			else
> +				__mptcp_add_backlog(sk, skb);
> 			seq += len;
>
> 			if (unlikely(map_remaining < len)) {
> @@ -2753,12 +2796,28 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> 	unlock_sock_fast(ssk, slow);
> }
>
> +static void mptcp_backlog_purge(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *tmp, *skb;
> +	LIST_HEAD(backlog);
> +
> +	mptcp_data_lock(sk);
> +	list_splice_init(&msk->backlog_list, &backlog);
> +	msk->backlog_len = 0;
> +	mptcp_data_unlock(sk);
> +
> +	list_for_each_entry_safe(skb, tmp, &backlog, list)
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +}
> +
> static void mptcp_do_fastclose(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow, *tmp;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> 	mptcp_set_state(sk, TCP_CLOSE);
> +	mptcp_backlog_purge(sk);

Should mptcp_backlog_purge() also be called in mptcp_check_fastclose()?

- Mat


> 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
> 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
> 				  subflow, MPTCP_CF_FASTCLOSE);
> @@ -2816,11 +2875,13 @@ static void __mptcp_init_sock(struct sock *sk)
> 	INIT_LIST_HEAD(&msk->conn_list);
> 	INIT_LIST_HEAD(&msk->join_list);
> 	INIT_LIST_HEAD(&msk->rtx_queue);
> +	INIT_LIST_HEAD(&msk->backlog_list);
> 	INIT_WORK(&msk->work, mptcp_worker);
> 	msk->out_of_order_queue = RB_ROOT;
> 	msk->first_pending = NULL;
> 	msk->timer_ival = TCP_RTO_MIN;
> 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> +	msk->backlog_len = 0;
>
> 	WRITE_ONCE(msk->first, NULL);
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> @@ -3197,6 +3258,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	struct sock *sk = (struct sock *)msk;
>
> 	__mptcp_clear_xmit(sk);
> +	mptcp_backlog_purge(sk);
>
> 	/* join list will be eventually flushed (with rst) at sock lock release time */
> 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 46d8432c72ee7..a21c4955f4cfb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -358,6 +358,9 @@ struct mptcp_sock {
> 					 * allow_infinite_fallback and
> 					 * allow_join
> 					 */
> +
> +	struct list_head backlog_list;	/*protected by the data lock */
> +	u32		backlog_len;
> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -408,6 +411,7 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
> static inline int __mptcp_space(const struct sock *sk)
> {
> 	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> +				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
> 				    sk_rmem_alloc_get(sk));
> }
>
> -- 
> 2.51.0
>
>
>
