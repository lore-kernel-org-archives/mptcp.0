Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9461A9F96
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275427; cv=none; b=miifoH9ERQdWFHPEgoJlKsBveTcsGA8PFrf7jL7LtJb5Y7cJxPcv9Gv1WhlBww3snKP4WTAJalIKPuDqRjbDWh8K2hVeXywXlQF/hch21GJpvZcB84SU/b5CMz0rgtWeSgNR585iHAAqMsrVxMc0c7Ofp7q/5CHBy0KP/68tCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275427; c=relaxed/simple;
	bh=ASdtZZIU99ATo1tibqRpkJDz2qwbFDRmPPnmxVVFb38=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8ENp4Y+LRnuBVBoKfgBjUmKnG8mguZ/HwOJJgoXYupyPrMMc+31oeHXogZGKPe/ZDH4bd9az59NEniakm1XrIgRcfO5l/aWY6aRVVYEKJXqDTdSm5JnUTt3V8g5I+WTtHn9aBTulqSbfLcGM8Rk/7f+Ed38T3zdWAU2ZsUe8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtEdjHfx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtEdjHfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A58C4CEF0;
	Fri, 19 Sep 2025 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275426;
	bh=ASdtZZIU99ATo1tibqRpkJDz2qwbFDRmPPnmxVVFb38=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LtEdjHfxaCdCEF95q+ueBshSGRGbZKgiv/Otk3M9NoGliVQjLUsnTc3yXeaOPuOTR
	 3cWNKGwQRwIansgEH7m5MlZsXbJhra8ecomP+MCeNmB2j11TwC1486vzbYX0t3LLbu
	 rUOIexJNwRJS6LK3IVKlX7FhvkkDJQV5Gh95fEUN3V94uiZeC6TBxvTgOe7lzE50VP
	 w7gBPjwNVffK9g/KeCErAZG6HAZ7FvYVplKfH9Fo+g16rRNKPEHh0zaUNrcqHddHOL
	 QLvtWcRTH6e1Gx8aoURaqLz2Mj4Xhw0Rzy6xlOZF/cEweISVqL2oy/BCEB20aF+yav
	 RaolHjrzI+tUg==
Message-ID: <139eaffc784289774aabd00885ae0dc3f7ade9d1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 03/12] mptcp: rcvbuf auto-tuning
 improvement
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 19 Sep 2025 17:50:21 +0800
In-Reply-To: <41db4ac9e54972274efd501dc110c5820def3412.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <41db4ac9e54972274efd501dc110c5820def3412.1758214563.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-09-18 at 19:14 +0200, Paolo Abeni wrote:
> Apply to the MPTCP auto-tuning the same improvements introduced for
> the
> TCP protocol by the merge commit 2da35e4b4df9 ("Merge branch
> 'tcp-receive-side-improvements'").
> 
> The main difference is that TCP subflow and the main MPTCP socket
> need
> to account separately for OoO: MPTCP does not care for TCP-level OoO
> and vice versa, as a consequence do not reflect MPTCP-level rcvbuf
> increase due to OoO packets at the subflow level.
> 
> This refeactor additionally allow dropping the msk receive buffer
> update
> at receive time, as the latter only intended to cope with subflow
> receive
> buffer increase due to OoO packets.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/559
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v1 -> v2:
>   - fix unused variable
>   - reword the commit message
> ---
>  net/mptcp/protocol.c | 92 ++++++++++++++++++++----------------------
> --
>  net/mptcp/protocol.h |  4 +-
>  2 files changed, 44 insertions(+), 52 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d95d24781509..162abafe3f320 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -179,6 +179,30 @@ static bool mptcp_ooo_try_coalesce(struct
> mptcp_sock *msk, struct sk_buff *to,
>  	return mptcp_try_coalesce((struct sock *)msk, to, from);
>  }
>  
> +static bool mptcp_rcvbuf_grow(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int rcvwin, rcvbuf;
> +
> +	if (!READ_ONCE(sock_net(sk)-
> >ipv4.sysctl_tcp_moderate_rcvbuf) ||
> +	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
> +		return false;
> +
> +	rcvwin = ((u64)msk->rcvq_space.space << 1);
> +
> +	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
> msk->ack_seq;
> +
> +	rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
> +		       READ_ONCE(sock_net(sk)-
> >ipv4.sysctl_tcp_rmem[2]));
> +
> +	if (rcvbuf > sk->sk_rcvbuf) {
> +		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  /* "inspired" by tcp_data_queue_ofo(), main differences:
>   * - use mptcp seqs
>   * - don't cope with sacks
> @@ -292,6 +316,9 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>  end:
>  	skb_condense(skb);
>  	skb_set_owner_r(skb, sk);
> +	/* do not grow rcvbuf for not-yet-accepted or orphaned
> sockets. */
> +	if (sk->sk_socket)
> +		mptcp_rcvbuf_grow(sk);
>  }
>  
>  static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock
> *ssk,
> @@ -784,18 +811,10 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  	return moved;
>  }
>  
> -static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
> -{
> -	if (unlikely(ssk->sk_rcvbuf > sk->sk_rcvbuf))
> -		WRITE_ONCE(sk->sk_rcvbuf, ssk->sk_rcvbuf);
> -}
> -
>  static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
> -	__mptcp_rcvbuf_update(sk, ssk);
> -
>  	/* Wake-up the reader only for in-sequence data */
>  	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
>  		sk->sk_data_ready(sk);
> @@ -2014,48 +2033,26 @@ static void mptcp_rcv_space_adjust(struct
> mptcp_sock *msk, int copied)
>  	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
>  		goto new_measure;
>  
> -	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)
> &&
> -	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> -		u64 rcvwin, grow;
> -		int rcvbuf;
> -
> -		rcvwin = ((u64)msk->rcvq_space.copied << 1) + 16 *
> advmss;
> -
> -		grow = rcvwin * (msk->rcvq_space.copied - msk-
> >rcvq_space.space);
> -
> -		do_div(grow, msk->rcvq_space.space);
> -		rcvwin += (grow << 1);
> -
> -		rcvbuf = min_t(u64, mptcp_space_from_win(sk,
> rcvwin),
> -			       READ_ONCE(sock_net(sk)-
> >ipv4.sysctl_tcp_rmem[2]));
> -
> -		if (rcvbuf > sk->sk_rcvbuf) {
> -			u32 window_clamp;
> -
> -			window_clamp = mptcp_win_from_space(sk,
> rcvbuf);
> -			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +	msk->rcvq_space.space = msk->rcvq_space.copied;
> +	if (mptcp_rcvbuf_grow(sk)) {
>  
> -			/* Make subflows follow along.  If we do not
> do this, we
> -			 * get drops at subflow level if skbs can't
> be moved to
> -			 * the mptcp rx queue fast enough (announced
> rcv_win can
> -			 * exceed ssk->sk_rcvbuf).
> -			 */
> -			mptcp_for_each_subflow(msk, subflow) {
> -				struct sock *ssk;
> -				bool slow;
> +		/* Make subflows follow along.  If we do not do
> this, we
> +		 * get drops at subflow level if skbs can't be moved
> to
> +		 * the mptcp rx queue fast enough (announced rcv_win
> can
> +		 * exceed ssk->sk_rcvbuf).
> +		 */
> +		mptcp_for_each_subflow(msk, subflow) {
> +			struct sock *ssk;
> +			bool slow;
>  
> -				ssk =
> mptcp_subflow_tcp_sock(subflow);
> -				slow = lock_sock_fast(ssk);
> -				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
> -				WRITE_ONCE(tcp_sk(ssk)-
> >window_clamp, window_clamp);
> -				if (tcp_can_send_ack(ssk))
> -					tcp_cleanup_rbuf(ssk, 1);
> -				unlock_sock_fast(ssk, slow);
> -			}
> +			ssk = mptcp_subflow_tcp_sock(subflow);
> +			slow = lock_sock_fast(ssk);
> +			tcp_sk(ssk)->rcvq_space.space = msk-
> >rcvq_space.copied;
> +			tcp_rcvbuf_grow(ssk);
> +			unlock_sock_fast(ssk, slow);
>  		}
>  	}
>  
> -	msk->rcvq_space.space = msk->rcvq_space.copied;
>  new_measure:
>  	msk->rcvq_space.copied = 0;
>  	msk->rcvq_space.time = mstamp;
> @@ -2084,11 +2081,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
>  	if (list_empty(&msk->conn_list))
>  		return false;
>  
> -	/* verify we can move any data from the subflow, eventually
> updating */
> -	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
> -		mptcp_for_each_subflow(msk, subflow)
> -			__mptcp_rcvbuf_update(sk, subflow-
> >tcp_sock);
> -
>  	subflow = list_first_entry(&msk->conn_list,
>  				   struct mptcp_subflow_context,
> node);
>  	for (;;) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9b5a248bad404..6ac58e92a1aa3 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -342,8 +342,8 @@ struct mptcp_sock {
>  	struct mptcp_pm_data	pm;
>  	struct mptcp_sched_ops	*sched;
>  	struct {
> -		u32	space;	/* bytes copied in last measurement
> window */
> -		u32	copied; /* bytes copied in this measurement
> window */
> +		int	space;	/* bytes copied in last measurement
> window */
> +		int	copied; /* bytes copied in this measurement
> window */
>  		u64	time;	/* start time of measurement window
> */
>  		u64	rtt_us; /* last maximum rtt of subflows */
>  	} rcvq_space;
