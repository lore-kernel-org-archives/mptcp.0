Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30892E413
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535221; cv=none; b=I6bxYWexdWMUx15GSiWNSTOVxsBQKg5t30K7Lns816OYvwQfwJ9p+qZ7Xhm6tRt6hQPMBT3i7uJTR1PWQoqbvXEas3hascQBhpmIYebk0yWOVQe7UCQy5gD8bool88/1CmWK92Ip7eVw8RXSfxZm7Ul2gl9fXd1Nrfp39E6GrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535221; c=relaxed/simple;
	bh=qCqgLAV+a8utLjegozP8S46KhPxIKkLcHQ9dDQTZOh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YDGp6BgkM6Cho85N1LY2pzHmjjUDsqTpGcyUPW9WBwMMclVBUv/J5xeWIfgOhjohFeSSPlKd3GXjHyFFHaBicPQIw4xUc0c1okik1NeKH2/WUM9JduLOBGgpRDAJ2xg0z18Vhy4joYG7rRfcfVQRk/4A6ogdiULw6s5PHLrqTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4DXk6Sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4DXk6Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD87C19424;
	Sat, 18 Apr 2026 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776535220;
	bh=qCqgLAV+a8utLjegozP8S46KhPxIKkLcHQ9dDQTZOh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K4DXk6SwhYUbvVYyvPBqSKGJuZKmX7xnCEP24OKzS6S+66tQhnGnPiDvF4hm59uqf
	 5uBivuU5K5NuUNPQeeC4+hDXIF5LLVLW0JK63+ruT4w/I6YFKqfY6MCNMsB4Su6vv1
	 8Kep/Q67D+gn8ZEQ0QgnUId69pfiwmCalaIX6azjYCXo9yK7Q1u2Ol2xtDQM29mQ1C
	 FYtJNtvGI8maouWpmGlRfTIIbPwh2HftGY3Z6KYnKcJKTeZU4a8VO/8rJs2FnPOd7r
	 nKjaSJ/ITziqPstie/pRBEJS+YR6wiaOvA/ZQDjAEnmB8lhmsojxlONOfUmNFozoxz
	 QmgXzkJDq8ojg==
Date: Sat, 18 Apr 2026 11:00:19 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 05/20] mptcp: pm: ADD_ADDR rtx: free sk if
 last
In-Reply-To: <20260415-mptcp-inc-limits-v5-5-e54c3bf80e4e@kernel.org>
Message-ID: <679eb0b7-304f-43b7-0f6b-5a9d6b7d382f@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-5-e54c3bf80e4e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:

> When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
> and released at the end.
>
> If at that moment, it was the last reference being held, the sk would
> not be freed. sock_put() should then be called instead of __sock_put().
>
> But that's not enough: if it is the last reference, sock_put() will call
> sk_free(), which will end up calling sk_stop_timer_sync() on the same
> timer, and waiting indefinitely to finish. So it is needed to mark that
> the timer is done at the end of the timer handler when it has not been
> rescheduled, not to call sk_stop_timer_sync() on "itself".
>
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v3: support calling sk_free() from the timer handler. Note: I'm not very
>    happy with this patch, it looks too big. Did I miss a simpler way?
> v4: init timer_done after 'reset_timer' label to handle cases where the
>    sysctl is changed in between.
> v5: only set timer_done to true in the timer handler, safer and easier.
> ---
> net/mptcp/pm.c | 30 +++++++++++++++++++-----------
> 1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d3fcf441b208..0ff35f49d451 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -16,6 +16,7 @@ struct mptcp_pm_add_entry {
> 	struct list_head	list;
> 	struct mptcp_addr_info	addr;
> 	u8			retrans_times;
> +	bool			timer_done;
> 	struct timer_list	add_timer;
> 	struct mptcp_sock	*sock;
> 	struct rcu_head		rcu;
> @@ -327,22 +328,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 							      add_timer);
> 	struct mptcp_sock *msk = entry->sock;
> 	struct sock *sk = (struct sock *)msk;
> -	unsigned int timeout;
> +	unsigned int timeout = 0;
>
> 	pr_debug("msk=%p\n", msk);
>
> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> -		goto exit;
> -
> 	bh_lock_sock(sk);
> +	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> +		goto out;
> +
> 	if (sock_owned_by_user(sk)) {
> 		/* Try again later. */
> -		sk_reset_timer(sk, timer, jiffies + HZ / 20);
> +		timeout = HZ / 20;
> 		goto out;
> 	}
>
> 	if (mptcp_pm_should_add_signal_addr(msk)) {
> -		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
> +		timeout = TCP_RTO_MAX / 8;
> 		goto out;
> 	}
>
> @@ -360,8 +361,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 	}
>
> 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> -		sk_reset_timer(sk, timer,
> -			       jiffies + (timeout << entry->retrans_times));
> +		timeout <<= entry->retrans_times;
> +	else
> +		timeout = 0;
>
> 	spin_unlock_bh(&msk->pm.lock);
>
> @@ -369,9 +371,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 		mptcp_pm_subflow_established(msk);
>
> out:
> +	if (timeout)
> +		sk_reset_timer(sk, timer, jiffies + timeout);
> +	else
> +		/* if sock_put calls sk_free: avoid waiting for this timer */
> +		entry->timer_done = true;
> 	bh_unlock_sock(sk);
> -exit:

This label was just added in the previous patch (which was quite small). I 
suggest squashing these two patches, but not a big problem to leave them 
separate.

- Mat

> -	__sock_put(sk);
> +	sock_put(sk);
> }
>
> struct mptcp_pm_add_entry *
> @@ -434,6 +440,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>
> 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> reset_timer:
> +	add_entry->timer_done = false;
> 	timeout = mptcp_adjust_add_addr_timeout(msk);
> 	if (timeout)
> 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
> @@ -454,7 +461,8 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> 	spin_unlock_bh(&msk->pm.lock);
>
> 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
> -		sk_stop_timer_sync(sk, &entry->add_timer);
> +		if (!entry->timer_done)
> +			sk_stop_timer_sync(sk, &entry->add_timer);
> 		kfree_rcu(entry, rcu);
> 	}
> }
>
> -- 
> 2.53.0
>
>
>
