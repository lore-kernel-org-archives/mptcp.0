Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660992;
	b=XVHHFva597tUXNQ5zQzYengWmTqa1FlkVuRJCNhhYnfKO8xlkTQK7SQGA981ZjqIMGiD
	 I3xjGqLWxa4qYKXr4BvcFq69Dj8QXTXuY+3sbnOnBm12CxEgoiLI2CI1Rk82im3/5afs1
	 E64zLwj7t7eXuZdPIW765H2L20jDBVwe5KeHh/lHKwnRU3vKkUgDnp4yDPfHsjZ0nZllH
	 kEbNpcbNLInTB042KoFiIY33EUneb/JQBIgJSKEecp6oy64GvkcT3+q+TP5r2cFZQ+wvB
	 12TMaCMh41LEbW/tikNLSGkzpotcARamz1geBwku27P7C/1NtXoqFjDWeTqIcrHCzlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660992;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=BO+9ehr6cUmT7ceRx3pGU32nyY2GwmNc/cfojEnv7kc=;
	b=0NK1sbm+RtIQ9Pa29webtj7O89IKWpehFYw/nAOWsy4A4M8ZjbC3MAbNPa1Id/LsJYkm
	 viQ0eErp2O5Re+FIsubxgnIsa/vsW/EabyKW6hlW3g6Nr0YunJ9jjoJxHOWVxvpWAADvM
	 J4yYjeVR7Non+dlYN4BpH8LvuL4f4gXOdVvuIkDfTmLVTFY723yXgZQPTXjcPkTfRm76T
	 HA8XA7d+5Q4t/zcoYWEe0t0u+HImEcrUeOFKWGCi/8HVCSrR9msSvhsksxYK6w3ZBMWa8
	 /bBxP0in3SqShhuSv8GjJ7APDIY+q3yjtBnSqbvq+Z1VMt6PgLDyjiSggO2+XU5aEbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3YdiZ1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7E606A31E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3YdiZ1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDBC1F000C0;
	Thu, 26 Nov 2026 02:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795660992;
	bh=BO+9ehr6cUmT7ceRx3pGU32nyY2GwmNc/cfojEnv7kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=F3YdiZ1Xpomu+SrgdS1J3q8A8KgomPavM+utPjXIFpzIhictUATZ2ejMosi5lsICm
	 3tYrfcI0OUzDI4giJTI9w/7cLLk7GYIH86CCsEpBADKHFC0Mb+qnQ8NZ/CbQbd64J/
	 +dhKGsrOe7i2LZPD6T20uBHGFQpp0If+xQ8zv2i+eavTUKEejtuIeBnz5nyz4Cs/7V
	 NbZeqSww2hXDhhi7Fu7eqT9f6AKz3JxvxiU5PNJIHEy7+i2gTp/s3RKhH0aKxpu26V
	 YuER2v+PnHKbWzjqTrq+z6jKy+HWuSS4IciwAcK77yOdO+g66tPM2pX8jycEkjiWUU
	 dIMQT/RT/Ix7w==
Date: Wed, 25 Nov 2026 18:43:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH mptcp-net v3 34/50] mptcp: don't charge the backlog twice
 at accept()
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-34-416c0920c73f@kernel.org>
Message-ID: <089c2aae-6368-14d4-ef3f-77021a35408e@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-34-416c0920c73f@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:

> From: Chris Mason <mason@kernel.org>
>
> accept() can permanently overcharge the memory cgroup of an MPTCP
> server, so the server can be OOM killed, if the new connection received
> data while its MPTCP socket was locked.
>
> The sockets of an MPTCP connection have no memory cgroup before
> accept(), which then charges the sk_forward_alloc and the sk_rmem_alloc
> of the MPTCP socket (msk) and of each subflow. mptcp_graft_subflows()
> also charges msk->backlog_unaccounted: the truesize of the skbs that
> __mptcp_add_backlog() queued while the socket lock of the msk was held
> and their subflow had no memory cgroup. But the first charge already
> covers each of these skbs that has not been freed, in the sk_rmem_alloc
> of its subflow or of the msk, so no later uncharge matches the extra
> charge.
>
> The fix used here is to remove msk->backlog_unaccounted, its charge in
> mptcp_graft_subflows() and the warning that tests it in
> mptcp_can_spool_backlog(). An RFC patch [1] removes the same lines, as
> part of another approach.
>
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch,
> on a kernel with the previous patch: 100,000 connections to an MPTCP
> server in a memory cgroup. Without this patch, about 63 MB stayed
> charged to this memory cgroup once all the connections were closed, and
> to its parent after its removal:
>
>  SNAP label=after-100000 rounds=100000 sockets_left_in_srv=0 tcp_mem_pages=0 [...] c_sock=63295488 [...]
>  [...]
>  SNAP label=c-removed rounds=100000 sockets_left_in_srv=0 tcp_mem_pages=0 c=removed [...] p_sock=63295488 [...]
>
> And about 12 MB with only 50 connections, each getting 20,000 duplicates
> of a byte before accept(), beside bare ACKs with RM_ADDR, which make the
> MPTCP worker take the socket lock:

What does "20,000 duplicates of a byte" mean? Just that each connection 
received 20kbytes before accept? If the test case happens to use the same 
byte value for every data byte in the payload, that's superfluous 
information.

Other than that, the patch LGTM.

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
>  SNAP label=after-50 rounds=50 sockets_left_in_srv=0 tcp_mem_pages=256 [...] c_sock=12881920 [...]
>
> Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
> Link: https://lore.kernel.org/all/20260924080219.1036588-4-caixinchen1@huawei.com/ [1]
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ No comment change: the commit message explains why the backlog is
>  covered. Commit message: refer to the RFC [1] removing the same lines
>  + how the issue was found, and its symptoms. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 35 +----------------------------------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 1 insertion(+), 35 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 504fe4a9954f..c9ef23276399 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -802,12 +802,6 @@ static void __mptcp_add_backlog(struct sock *sk,
>
> account:
> 	WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
> -
> -	/* Possibly not accept()ed yet, keep track of memory not CG
> -	 * accounted, mptcp_graft_subflows() will handle it.
> -	 */
> -	if (!mem_cgroup_from_sk(ssk))
> -		msk->backlog_unaccounted += delta;
> }
>
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> @@ -2456,12 +2450,6 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -	/* After CG initialization, subflows should never add skb before
> -	 * gaining the CG themself.
> -	 */
> -	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
> -			       mem_cgroup_from_sk(sk));
> -
> 	if (list_empty(&msk->backlog_list))
> 		return false;
>
> @@ -4691,8 +4679,7 @@ static void mptcp_graft_subflows(struct sock *sk)
> 		/* Subflows joining after __inet_accept() will get the
> 		 * mem CG properly initialized at mptcp_finish_join() time,
> 		 * but subflows pending in join_list need explicit
> -		 * initialization before flushing `backlog_unaccounted`
> -		 * or MPTCP can later unexpectedly observe unaccounted memory.
> +		 * initialization by the loop below.
> 		 */
> 		mptcp_data_lock(sk);
> 		list_splice_init(&msk->join_list, &join_list);
> @@ -4724,26 +4711,6 @@ static void mptcp_graft_subflows(struct sock *sk)
> unlock:
> 		release_sock(ssk);
> 	}
> -
> -	if (mem_cgroup_sk_enabled(sk)) {
> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> -		int amt;
> -
> -		/* Account the backlog memory; prior accept() is aware of
> -		 * fwd and rmem only.
> -		 */
> -		mptcp_data_lock(sk);
> -		amt = sk_mem_pages(sk->sk_forward_alloc +
> -				   msk->backlog_unaccounted +
> -				   atomic_read(&sk->sk_rmem_alloc)) -
> -		      sk_mem_pages(sk->sk_forward_alloc +
> -				   atomic_read(&sk->sk_rmem_alloc));
> -		msk->backlog_unaccounted = 0;
> -		mptcp_data_unlock(sk);
> -
> -		if (amt)
> -			mem_cgroup_sk_charge(sk, amt, gfp);
> -	}
> }
>
> static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d0ae782c9ade..9a9dbab672af 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -394,7 +394,6 @@ struct mptcp_sock {
>
> 	struct list_head backlog_list;	/* protected by the data lock */
> 	u32		backlog_len;
> -	u32		backlog_unaccounted;
> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
>
> -- 
> 2.55.0
>
>
>
