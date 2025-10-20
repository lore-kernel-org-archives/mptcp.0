Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B652253EB
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003171; cv=none; b=e1fJyLsYSCbUCJDTxAgB14Hhxk2tJdT2NtOnCnG8B6QE/yKBTcxQlleWSzHhzLIhTSJ3FGt9BGQB2J9Di65P+H0RPKPd4JNkQbzISSs3so4rhn87zFQMNZV32idfL5I4xbFn+9uRWr2ynwSnarDriXtB8BcImsQv9gmOS3vAfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003171; c=relaxed/simple;
	bh=pTKsVCr0Zp+S81eWfv3tvWeVswDxiRbuNm1zJ3+X9NU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zd9qkBy3aIa5wWWdVfEiW0hh3aFPQ/Ip6W5NPIHvAaUIQyecYzYr0t/wfH3+leQjeLGkf9s3yc1zwlW7IhYdkUrf7IzBJJcL/iA8AK832VXmGPPT1ZcPhl1m4aVdtCsibGKi+ViAJyo3qC9yRTLH7eI3ybsonLL0Jr91tk5PjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kweHjCNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kweHjCNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F8AC4CEFB;
	Mon, 20 Oct 2025 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761003170;
	bh=pTKsVCr0Zp+S81eWfv3tvWeVswDxiRbuNm1zJ3+X9NU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kweHjCNHD1Rj1tz04hyjGEx4YK2AcVcAra5Q4gOLD7p04AFmBo+s945fNZ7EwoZe2
	 8BOCJftQLzRq1gnpXzOC/7Th1i6CkVN3SLP730Uo2NIkmd8pdf8WagoFzkBhelDfRw
	 apEILGly+LgwqZvDbSbCFU0EjonnWxv+dxyROsvZ2MtaJ3FaF/9Cu/DX8A8JEpFQ7Q
	 jezasicE+Bb+7rFvfWuyN9iFYoZYpJyDZs1mkPfxMsHOfSMsrDFstxsHZXEer7ViqR
	 5ZuZUZxAqiwOoTd/h6etq2W+uE/6LgOZin5emGngi0SWzIhGdL42HL0/yw3tlL5fSC
	 YS/Wtvv862uTg==
Date: Mon, 20 Oct 2025 16:32:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-next 10/10] mptcp: leverage the backlog for RX
 packet processing
In-Reply-To: <1cb19d6e65591b81610cc0dd8ef5d0a38605b3f1.1759737859.git.pabeni@redhat.com>
Message-ID: <156d60d8-ee80-49fb-8b8e-d0be56f7a02a@kernel.org>
References: <cover.1759737859.git.pabeni@redhat.com> <1cb19d6e65591b81610cc0dd8ef5d0a38605b3f1.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mon, 6 Oct 2025, Paolo Abeni wrote:

> When the msk socket is owned or the msk receive buffer is full,
> move the incoming skbs in a msk level backlog list. This avoid
> traversing the joined subflows and acquiring the subflow level
> socket lock at reception time, improving the RX performances.
>
> when processing the backlog, use the fwd alloc memory borrowed from
> the incoming subflow. skbs exceeding the msk receive space are
> not dropped; instead they are kept into the backlog until the receive
> buffer is freed. Dropping packets already acked at the TCP level is
> explicitly discouraged by the RFC and would corrupt the data stream
> for fallback sockets.
>
> Special care is needed to avoid adding skbs to the backlog of a closed
> msk, and to avoid leaving dangling references into the backlog
> at subflow closing time.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v4 -> v5:
>  - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
>    some code duplication
>  - return soon in __mptcp_add_backlog() when dropping skbs due to
>    the msk closed. This avoid later UaF
> ---
> net/mptcp/protocol.c | 137 ++++++++++++++++++++++++-------------------
> net/mptcp/protocol.h |   2 +-
> 2 files changed, 79 insertions(+), 60 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d5d3da67d1ac..a97a92eccc502 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

...

> @@ -3509,23 +3519,29 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>
> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
> 				      BIT(MPTCP_RETRANSMIT) | \
> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
> -				      BIT(MPTCP_DEQUEUE))
> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>
> /* processes deferred events and flush wmem */
> static void mptcp_release_cb(struct sock *sk)
> 	__must_hold(&sk->sk_lock.slock)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 delta = 0;
>
> 	for (;;) {
> 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
> -		struct list_head join_list;
> +		LIST_HEAD(join_list);
> +		LIST_HEAD(skbs);
> +
> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
> +		msk->borrowed_mem = 0;
> +
> +		if (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
> +			list_splice_init(&msk->backlog_list, &skbs);
>
> -		if (!flags)
> +		if (!flags && list_empty(&skbs))
> 			break;
>
> -		INIT_LIST_HEAD(&join_list);
> 		list_splice_init(&msk->join_list, &join_list);
>
> 		/* the following actions acquire the subflow socket lock
> @@ -3544,7 +3560,8 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_push_pending(sk, 0);
> 		if (flags & BIT(MPTCP_RETRANSMIT))
> 			__mptcp_retrans(sk);
> -		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
> +		if (!list_empty(&skbs) &&
> +		    __mptcp_move_skbs(sk, &skbs, &delta)) {
> 			/* notify ack seq update */
> 			mptcp_cleanup_rbuf(msk, 0);
> 			sk->sk_data_ready(sk);
> @@ -3552,7 +3569,9 @@ static void mptcp_release_cb(struct sock *sk)
>
> 		cond_resched();
> 		spin_lock_bh(&sk->sk_lock.slock);
> +		list_splice(&skbs, &msk->backlog_list);
> 	}
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);

Hi Paolo -

Given the possible multiple calls to __mptcp_move_skbs() and that the 
spinlock is released/reacquired (and the cond_resched) in the middle, 
would it make sense to update msk->backlog_len for each iteration of the 
loop so __mptcp_space() and mptcp_space() don't under-report available 
space and mptcp_cleanup_rbuf() can make incremental progress?

I know we don't want to WRITE_ONCE() more than necessary, but it seems 
like there won't typically be more than one loop iteration. In the cases 
where it does repeat the loop that means data is arriving quickly and 
reporting mptcp_space accurately will be important.

- Mat


>
> 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
> 		__mptcp_clean_una_wakeup(sk);
