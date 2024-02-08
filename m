Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE61CD25
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358335; cv=none; b=OvZ+hPY+E9KYUxetLIppcTEfrPThSIXci5+ad7qYjwrW9YQadtvpBKykkii/Hslz0pQNwUceNqKMlfR96h1RqaWBvF0SLfQHOVJYH1Qr4H54jG95VGZpl89MEzrJBMrgG4UGdo/JbWjUYUIO0an7gj2A94W5TtABsLaQdWTkFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358335; c=relaxed/simple;
	bh=2ZpkjkHmMPmDyu3mPg0AEhhKJoST6o80V+Kb+tiQlI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NKqCK5PU8ox/J3riDqrn06KoBW0BqbMLekRVPDqyqBtSONdKEPKgGeSF2zVc080P7mSbrBbEVRRES3Vx8YDgoTPp+cjbHbR/VP+zub4hXG5YedhnSfVyW/yxwnyIafZa9ag1HVWYWsifozqW5ZCxbzvP79H0hW1l7udhC6uAyLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIf45gvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIf45gvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB3AC433F1;
	Thu,  8 Feb 2024 02:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707358334;
	bh=2ZpkjkHmMPmDyu3mPg0AEhhKJoST6o80V+Kb+tiQlI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KIf45gvI2cN3V9ZwyZXLGR1A9FcxTszTyo1OWfpiJYyaHn3s6ZlSr34CXNSKB9U+/
	 QXqLFwUa0HH/ZqKAyMaQ0JZFULrHd+JGabige2oCQMuW1cCLK9lIBjxKzNw1NFzYkF
	 Pbc3Oq8JZXvTha/kN4EAqmKJYjIr/GirScglv9jgl/e5tMYmpnX9rK6rsaSVy/Z6aW
	 O3zHk+vqcCy5QUnibZMo3NeH2c7ilI7xVWgq/CrK08Sc/+0h2KTGqfwv6mvZcdf3tb
	 Z4yAk1ku4m5u+7wGvpXuGk2uOjSUvKJkqvM5EA+MQP1n1qn7femRWMXPMjBpnnxGeF
	 tUy7vABdTb59A==
Date: Wed, 7 Feb 2024 18:12:13 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 6/7] mptcp: implement TCP_NOTSENT_LOWAT
 support.
In-Reply-To: <cfd580d15d1bbf7ba294f2f49266ae5ded02fec7.1705836321.git.pabeni@redhat.com>
Message-ID: <8fb6b093-3d47-cec2-74a8-e2ad8215a597@kernel.org>
References: <cover.1705836321.git.pabeni@redhat.com> <cfd580d15d1bbf7ba294f2f49266ae5ded02fec7.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jan 2024, Paolo Abeni wrote:

> Add support for such socket option storing the user-space provided
> value in a new msk field, and using such data to implement the
> _mptcp_stream_memory_free() helper, similar to the TCP one.
>
> To avoid adding more indirect calls in the fast path, instead of
> hooking the new helper via the sk_stream_memory_free sock cb,
> add the directly calls where needed.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++-----
> net/mptcp/protocol.h | 28 +++++++++++++++++++++++++++-
> net/mptcp/sockopt.c  | 12 ++++++++++++
> 3 files changed, 67 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3599205fdceb..53d6c5544900 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1761,6 +1761,25 @@ static int do_copy_data_nocache(struct sock *sk, int copy,
> 	return 0;
> }
>
> +static u32 mptcp_send_limit(const struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 limit, not_sent;
> +
> +	if (!sk_stream_memory_free(sk))
> +		return 0;
> +
> +	limit = mptcp_notsent_lowat(sk);
> +	if (limit == UINT_MAX)
> +		return UINT_MAX;
> +
> +	not_sent = msk->write_seq - msk->snd_nxt;
> +	if (not_sent >= limit)
> +		return 0;
> +
> +	return limit - not_sent;
> +}
> +
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1805,6 +1824,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		struct mptcp_data_frag *dfrag;
> 		bool dfrag_collapsed;
> 		size_t psize, offset;
> +		u32 copy_limit;
> +
> +		/* ensure fitting the notsent_lowat() constraint */
> +		copy_limit = mptcp_send_limit(sk);
> +		if (!copy_limit)
> +			goto wait_for_memory;
>
> 		/* reuse tail pfrag, if possible, or carve a new one from the
> 		 * page allocator
> @@ -1812,9 +1837,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		dfrag = mptcp_pending_tail(sk);
> 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
> 		if (!dfrag_collapsed) {
> -			if (!sk_stream_memory_free(sk))
> -				goto wait_for_memory;
> -
> 			if (!mptcp_page_frag_refill(sk, pfrag))
> 				goto wait_for_memory;
>
> @@ -1829,6 +1851,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		offset = dfrag->offset + dfrag->data_len;
> 		psize = pfrag->size - offset;
> 		psize = min_t(size_t, psize, msg_data_left(msg));
> +		psize = min_t(size_t, psize, copy_limit);


Hi Paolo -

Any concern that this will cause us to start sending short packets if 
mptcp_send_limit() starts returning small (nonzero) values?

If copy_limit is small on the first iteration of this loop, it looks like 
a small segment will be created. When that gets acked, a small amount 
becomes available and then we create another small segment (repeat...).

On the first pass (or on the 'wait_for_memory' path) should something like 
__mptcp_stream_is_writeable(sk, 1) be used to make sure a reasonable chunk 
of buffer is available before proceeding?

Or is that the approach to this feature that got too complicated? :)


- Mat


> 		total_ts = psize + frag_truesize;
>
> 		if (!sk_wmem_schedule(sk, total_ts))
> @@ -3886,12 +3909,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
> {
> 	struct sock *sk = (struct sock *)msk;
>
> -	if (sk_stream_is_writeable(sk))
> +	if (__mptcp_stream_is_writeable(sk, 1))
> 		return EPOLLOUT | EPOLLWRNORM;
>
> 	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> 	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
> -	if (sk_stream_is_writeable(sk))
> +	if (__mptcp_stream_is_writeable(sk, 1))
> 		return EPOLLOUT | EPOLLWRNORM;
>
> 	return 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3069d5c072b0..4a32d3d11fb6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -307,6 +307,7 @@ struct mptcp_sock {
> 			in_accept_queue:1,
> 			free_first:1,
> 			rcvspace_init:1;
> +	u32		notsent_lowat;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> @@ -796,11 +797,36 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
> 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
> }
>
> +static inline u32 mptcp_notsent_lowat(const struct sock *sk)
> +{
> +	struct net *net = sock_net(sk);
> +	u32 val;
> +
> +	val = READ_ONCE(mptcp_sk(sk)->notsent_lowat);
> +	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
> +}
> +
> +static inline bool __mptcp_stream_memory_free(const struct sock *sk, int wake)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 notsent_bytes;
> +
> +	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
> +	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
> +}
> +
> +static inline bool __mptcp_stream_is_writeable(const struct sock *sk, int wake)
> +{
> +	return __mptcp_stream_memory_free(sk, wake) &&
> +	       __sk_stream_is_writeable(sk, wake);
> +}
> +
> static inline void mptcp_write_space(struct sock *sk)
> {
> 	/* pairs with memory barrier in mptcp_poll */
> 	smp_mb();
> -	sk_stream_write_space(sk);
> +	if (__mptcp_stream_memory_free(sk, 1))
> +		sk_stream_write_space(sk);
> }
>
> static inline void __mptcp_sync_sndbuf(struct sock *sk)
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index ac37f6c5e2ed..1b38dac70719 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -812,6 +812,16 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return 0;
> 	case TCP_ULP:
> 		return -EOPNOTSUPP;
> +	case TCP_NOTSENT_LOWAT:
> +		ret = mptcp_get_int_option(msk, optval, optlen, &val);
> +		if (ret)
> +			return ret;
> +
> +		lock_sock(sk);
> +		WRITE_ONCE(msk->notsent_lowat, val);
> +		mptcp_write_space(sk);
> +		release_sock(sk);
> +		return 0;
> 	case TCP_CONGESTION:
> 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
> 	case TCP_CORK:
> @@ -1345,6 +1355,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
> 	case TCP_NODELAY:
> 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
> +	case TCP_NOTSENT_LOWAT:
> +		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
> 	}
> 	return -EOPNOTSUPP;
> }
> -- 
> 2.43.0
>
>
>
