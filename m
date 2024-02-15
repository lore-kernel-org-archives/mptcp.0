Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EB8833
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036300; cv=none; b=Oc/wo/nb1z2H+vIsKNiTbiOExg+8pVKavsv7e08/zrewp64xNw7rlrqncmH+jeN7OSPwQQaC7KDEzkssnCoSpwSgvrEPrKpSWJZ8gX+gxS8xMwParJG4Z7M+b0ipXrdpT5p7KrmO6GkfTACspz155OrQta1M3yGbDJvl4qHH4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036300; c=relaxed/simple;
	bh=B2ueSxXUDQeFi9hgPQn2uSInHRN2Aq7CF+ZJHixZAy4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EIFnCIDs7rHOuqRoa8V9PTVg77k7VfENrwTtwklhS8bZqjGZETKAPjxJHCXgh1BN5/XboBRSt3LrqtwEz8A0TW+K/nigmG2f1N16HAS9qmFzTbHTR/uJiflcPaRiP2mk1Dc7kJOe/ukAvi8Wm9+8PmFZuf/eVeak6osy93H031k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+OKIyVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+OKIyVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9488C433C7;
	Thu, 15 Feb 2024 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036299;
	bh=B2ueSxXUDQeFi9hgPQn2uSInHRN2Aq7CF+ZJHixZAy4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=G+OKIyVu8oMtyWXtyEdXvtChgw25Gay7QW2v2w4IranN5fZxjNoCX0EOrl2a/xQPO
	 g26OY/4OOIoreUwsJdG66NxeGN9B1An2M1mQVgkAWycoYXlD06tXEY2Bg8QV7P5ryj
	 MdbZGp1O71Bz7gXGlTT7AqrfUEMn15LiJyFumktYUfFgNVQPZNgXQB3tvvQVOwy92g
	 RqWQqWsDChCwXrsLo59h1TEoVbTuBZJS0ib9ouckN4Hpgw33ATJT1NfSgpOF1njPkJ
	 o2vsMJLoXr/AyW/62CKoplrFTDd33OazxJ9suRIwFlt1yIVp+CJacvkgSHlsbpWEk/
	 yL50Ar8kVJ+Ig==
Date: Thu, 15 Feb 2024 14:31:39 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-next v2 6/7] mptcp: implement TCP_NOTSENT_LOWAT
 support.
In-Reply-To: <aafd3d3f4e4f827ebff1235697afcc08182e964f.1707739536.git.pabeni@redhat.com>
Message-ID: <5617e62d-de89-3723-2809-994abe622910@kernel.org>
References: <cover.1707739536.git.pabeni@redhat.com> <aafd3d3f4e4f827ebff1235697afcc08182e964f.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 12 Feb 2024, Paolo Abeni wrote:

> Add support for such socket option storing the user-space provided
> value in a new msk field, and using such data to implement the
> _mptcp_stream_memory_free() helper, similar to the TCP one.
>
> To avoid adding more indirect calls in the fast path, open-code
> a variant of sk_stream_memory_free() in mptcp_sendmsg() and add
> direct calls to the mptcp stream memory free helper where possible.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 48 +++++++++++++++++++++++++++++++++++++++-----
> net/mptcp/protocol.h | 28 +++++++++++++++++++++++++-
> net/mptcp/sockopt.c  | 12 +++++++++++
> 3 files changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index def01e030121..cc5680c4c5b3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1762,6 +1762,39 @@ static int do_copy_data_nocache(struct sock *sk, int copy,
> 	return 0;
> }
>
> +static bool mptcp_stream_memory_free(const struct sock *sk, int wake)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 notsent_bytes = READ_ONCE(msk->write_seq) -
> +			    READ_ONCE(msk->snd_nxt);
> +
> +	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);

Hi Paolo -

This is identical to __mptcp_stream_memory_free() (other than 'inline' and 
combining notsent_bytes assignment w/ declaration). Prefer to avoid the 
code duplication!


- Mat


> +}
> +
> +/* open-code sk_stream_memory_free() plus sent limit computation to
> + * avoid indirect calls in fast-path.
> + * Called under the msk socket lock, so we can avoid a bunch of ONCE
> + * annotations.
> + */
> +static u32 mptcp_send_limit(const struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 limit, not_sent;
> +
> +	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
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
> @@ -1806,6 +1839,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
> @@ -1813,9 +1852,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		dfrag = mptcp_pending_tail(sk);
> 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
> 		if (!dfrag_collapsed) {
> -			if (!sk_stream_memory_free(sk))
> -				goto wait_for_memory;
> -
> 			if (!mptcp_page_frag_refill(sk, pfrag))
> 				goto wait_for_memory;
>
> @@ -1830,6 +1866,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		offset = dfrag->offset + dfrag->data_len;
> 		psize = pfrag->size - offset;
> 		psize = min_t(size_t, psize, msg_data_left(msg));
> +		psize = min_t(size_t, psize, copy_limit);
> 		total_ts = psize + frag_truesize;
>
> 		if (!sk_wmem_schedule(sk, total_ts))
> @@ -3711,6 +3748,7 @@ static struct proto mptcp_prot = {
> 	.unhash		= mptcp_unhash,
> 	.get_port	= mptcp_get_port,
> 	.forward_alloc_get	= mptcp_forward_alloc_get,
> +	.stream_memory_free	= mptcp_stream_memory_free,
> 	.sockets_allocated	= &mptcp_sockets_allocated,
>
> 	.memory_allocated	= &tcp_memory_allocated,
> @@ -3884,12 +3922,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
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
> index 0aa77c03643d..62b84cc6f35e 100644
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
