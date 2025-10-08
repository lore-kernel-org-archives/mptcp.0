Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791714A60C
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759892972; cv=none; b=cvS2GYP5O8VzzFOX4fmDprunqprSDajOEzuUt4yA7U6/gBTREhpfba0Dl0iy+QI80eJhtNrhBuNshFbRrEZ0NWz5ZsIIfCwCGHL3Q4W+ak3vuMGl+yJI9PX3blYlJ+ksMsGKd20gTtyEW3YC4mXkjSAenGo6eeBivqZ07FksBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759892972; c=relaxed/simple;
	bh=7P4f1FmANpn9Un9STwWmuojQcJ38NPZNsq4YzJOmr5I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFJ/9CDDE8t7oo16LwF4d5iSS6ovM6W2U3EqpDy7Nakrp7CWlw20BmbH78ELAP3+oixHlWqFnLe+JWFGbb/xrvU2LUGMnSxcijDYbxHyK8kfu94wbtqkVhkwqGRf2pgFMHY3SQli5aujMoHv8sYjkBCOTeEEQ2p48AwwaaVDS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWF/sEl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWF/sEl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC65C4CEF1;
	Wed,  8 Oct 2025 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759892971;
	bh=7P4f1FmANpn9Un9STwWmuojQcJ38NPZNsq4YzJOmr5I=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=eWF/sEl0lJouWtDgWFS2K9fXy5V44tUHEUqQI6f5LSwAOZlDUP2AivaYF6y+g0l4e
	 IfaxVF4AS1krr12GkO2CxVa2FFIklgISdvrOBOTDE+YjyzMxUhB9lUAYebCsiHkiw/
	 QvGNVBdLWhB4KavXatvVXBupQWK0goXy2CoKVL8ufBj1E+uDe4K4yLYOydlblcjw5P
	 Awtg+hBv1lr6lELaMfq4ke2bHao7wDMWaoIZ/rmy5zUR9lWjOBUfAa1/+8Y2eGOxjj
	 kg0cpXaLsiE7XtkomQLrdyLbUI913tUwiK+fvnWCB2lg45Ei581KIOjPYEgvAh/jQ9
	 MX4Lo+hnqB5fA==
Message-ID: <8d1a5a81a52c26ea19d6e10e9137b22875b58d7b.camel@kernel.org>
Subject: Re: [PATCH v5 mptcp-next 09/10] mptcp: introduce mptcp-level backlog
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Wed, 08 Oct 2025 11:09:29 +0800
In-Reply-To: <16ead1024784cf5913a9c9ef69d7d15cb73512a3.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
	 <16ead1024784cf5913a9c9ef69d7d15cb73512a3.1759737859.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Mon, 2025-10-06 at 10:12 +0200, Paolo Abeni wrote:
> We are soon using it for incoming data processing.
> MPTCP can't leverage the sk_backlog, as the latter is processed
> before the release callback, and such callback for MPTCP releases
> and re-acquire the socket spinlock, breaking the sk_backlog
> processing
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
>   - split out of the next path, to make the latter smaller
>   - set a custom destructor for skbs in the backlog, this avoid
>     duplicate code, and fix a few places where the need ssk cleanup
>     was not performed.
>   - factor out the backlog purge in a new helper,
>     use spinlock protection, clear the backlog list and zero the
>     backlog len
>   - explicitly init the backlog_len at mptcp_init_sock() time
> ---
>  net/mptcp/protocol.c | 70 +++++++++++++++++++++++++++++++++++++++++-
> --
>  net/mptcp/protocol.h |  4 +++
>  2 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 05ee6bd26b7fa..2d5d3da67d1ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -337,6 +337,11 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>   mptcp_rcvbuf_grow(sk);
>  }
>  
> +static void mptcp_bl_free(struct sk_buff *skb)
> +{
> + atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +}
> +
>  static int mptcp_init_skb(struct sock *ssk,
>     struct sk_buff *skb, int offset, int copy_len)
>  {
> @@ -360,7 +365,7 @@ static int mptcp_init_skb(struct sock *ssk,
>   skb_dst_drop(skb);
>  
>   /* "borrow" the fwd memory from the subflow, instead of reclaiming
> it */
> - skb->destructor = NULL;
> + skb->destructor = mptcp_bl_free;
>   borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
>   borrowed &= ~(PAGE_SIZE - 1);
>   sk_forward_alloc_add(ssk, skb->truesize - borrowed);
> @@ -373,6 +378,13 @@ static bool __mptcp_move_skb(struct sock *sk,
> struct sk_buff *skb)
>   struct mptcp_sock *msk = mptcp_sk(sk);
>   struct sk_buff *tail;
>  
> + /* Avoid the indirect call overhead, we know destructor is
> + * mptcp_bl_free at this point.
> + */
> + atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> + skb->sk = NULL;
> + skb->destructor = NULL;
> +
>   /* try to fetch required memory from subflow */
>   if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
>   MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> @@ -654,6 +666,35 @@ static void mptcp_dss_corruption(struct
> mptcp_sock *msk, struct sock *ssk)
>   }
>  }
>  
> +static void __mptcp_add_backlog(struct sock *sk, struct sk_buff
> *skb)
> +{
> + struct mptcp_sock *msk = mptcp_sk(sk);
> + struct sk_buff *tail = NULL;
> + bool fragstolen;
> + int delta;
> +
> + if (unlikely(sk->sk_state == TCP_CLOSE)) {
> + kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> + return;
> + }
> +
> + /* Try to coalesce with the last skb in our backlog */
> + if (!list_empty(&msk->backlog_list))
> + tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
> +
> + if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)-
> >end_seq &&
> +     skb->sk == tail->sk &&
> +     __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
> + skb->truesize -= delta;
> + kfree_skb_partial(skb, fragstolen);
> + WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
> + return;
> + }
> +
> + list_add_tail(&skb->list, &msk->backlog_list);
> + WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
> +}
> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>      struct sock *ssk)
>  {
> @@ -701,10 +742,12 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>   int bmem;
>  
>   bmem = mptcp_init_skb(ssk, skb, offset, len);
> - skb->sk = NULL;
>   sk_forward_alloc_add(sk, bmem);
> - atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
> - ret = __mptcp_move_skb(sk, skb) || ret;
> +
> + if (true)

nit: How about adding the own_msk parameter to
__mptcp_move_skbs_from_subflow() in this patch? This would allow us to
avoid using 'if (true)' here by using 'if (own_msk)'.

Thanks,
-Geliang

> + ret |= __mptcp_move_skb(sk, skb);
> + else
> + __mptcp_add_backlog(sk, skb);
>   seq += len;
>  
>   if (unlikely(map_remaining < len)) {
> @@ -2753,12 +2796,28 @@ static void mptcp_mp_fail_no_response(struct
> mptcp_sock *msk)
>   unlock_sock_fast(ssk, slow);
>  }
>  
> +static void mptcp_backlog_purge(struct sock *sk)
> +{
> + struct mptcp_sock *msk = mptcp_sk(sk);
> + struct sk_buff *tmp, *skb;
> + LIST_HEAD(backlog);
> +
> + mptcp_data_lock(sk);
> + list_splice_init(&msk->backlog_list, &backlog);
> + msk->backlog_len = 0;
> + mptcp_data_unlock(sk);
> +
> + list_for_each_entry_safe(skb, tmp, &backlog, list)
> + kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +}
> +
>  static void mptcp_do_fastclose(struct sock *sk)
>  {
>   struct mptcp_subflow_context *subflow, *tmp;
>   struct mptcp_sock *msk = mptcp_sk(sk);
>  
>   mptcp_set_state(sk, TCP_CLOSE);
> + mptcp_backlog_purge(sk);
>   mptcp_for_each_subflow_safe(msk, subflow, tmp)
>   __mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
>     subflow, MPTCP_CF_FASTCLOSE);
> @@ -2816,11 +2875,13 @@ static void __mptcp_init_sock(struct sock
> *sk)
>   INIT_LIST_HEAD(&msk->conn_list);
>   INIT_LIST_HEAD(&msk->join_list);
>   INIT_LIST_HEAD(&msk->rtx_queue);
> + INIT_LIST_HEAD(&msk->backlog_list);
>   INIT_WORK(&msk->work, mptcp_worker);
>   msk->out_of_order_queue = RB_ROOT;
>   msk->first_pending = NULL;
>   msk->timer_ival = TCP_RTO_MIN;
>   msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> + msk->backlog_len = 0;
>  
>   WRITE_ONCE(msk->first, NULL);
>   inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> @@ -3197,6 +3258,7 @@ static void mptcp_destroy_common(struct
> mptcp_sock *msk, unsigned int flags)
>   struct sock *sk = (struct sock *)msk;
>  
>   __mptcp_clear_xmit(sk);
> + mptcp_backlog_purge(sk);
>  
>   /* join list will be eventually flushed (with rst) at sock lock
> release time */
>   mptcp_for_each_subflow_safe(msk, subflow, tmp)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 46d8432c72ee7..a21c4955f4cfb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -358,6 +358,9 @@ struct mptcp_sock {
>   * allow_infinite_fallback and
>   * allow_join
>   */
> +
> + struct list_head backlog_list; /*protected by the data lock */
> + u32 backlog_len;
>  };
>  
>  #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -408,6 +411,7 @@ static inline int mptcp_space_from_win(const
> struct sock *sk, int win)
>  static inline int __mptcp_space(const struct sock *sk)
>  {
>   return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> +     READ_ONCE(mptcp_sk(sk)->backlog_len) -
>       sk_rmem_alloc_get(sk));
>  }
>  

