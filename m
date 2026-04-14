Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D73A8722
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154847; cv=none; b=b02atYqVhCc8aUpqp8aC5f72vzr86zBiZ55Nkr7Sv2ddgkxYPYZvHz5ivCguOp2uUgH1UviHqMozSpHCpdad7nlFLAZdT4S5YYIVuc/UfN2oyzosAhNCWryx+XhXJvn6si80KH5wLtvyBJLWQTdfjAN9x4RUVPDgUuAsbPf4XRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154847; c=relaxed/simple;
	bh=VfXDpj/qaaPTgTHrqIwCPXnI71Ntvm0oeuPe1eZbDPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UT3V+6tlxRB7cHcD+3Rddl0qUXtdEImsVLyQl681VR4W4zs/nSM/iaxH3Ex0v9JjwoVaSTwi6sc03ASb0er2YfWYvg4h5+x8tXLiXCE0Pa3wn9ZEuDWyySL/UorLClqnwZeY/C90y+68c9K/XQumbWi68nl+6UZNAPJOXBgtkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK4IcYQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK4IcYQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B5C19425
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776154847;
	bh=VfXDpj/qaaPTgTHrqIwCPXnI71Ntvm0oeuPe1eZbDPw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LK4IcYQeXY/bdogrBbmpmPS9AsE+wIHMw/e/SEq3AieID2xZWgFExXf+5y78CA3cg
	 ppzw7X2Tn1VN0lnjjCUUCAF8VVdtf1AFBcJtt+S/sLLUO2XYs9/ZERBf4zJdM75NsE
	 ZBCAocwYAbz2JEGx+pHayBYxMQAFSK60vMq3IbGHzGYn1lKKk0Zah8Q4q/Tcu0q3W9
	 4XUN3Cl9k987SoD/edwlEkFwnBNI7xspAiSbS3bE0sURDTtP/ov1KJy3Auub4S2nml
	 ryI5O8u+ZURcibZFO4bLzQMZziL0Ldc1Pe/7cZCVqIGvt1G62shxJNHIXlCvNKbpWl
	 dSpzAFG87mqPQ==
Message-ID: <756803ac-53f8-4eb2-b53c-2db4c2e1791d@kernel.org>
Date: Tue, 14 Apr 2026 10:20:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 05/19] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
 <20260413-mptcp-inc-limits-v3-5-dd36c9360432@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260413-mptcp-inc-limits-v3-5-dd36c9360432@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 13/04/2026 16:11, Matthieu Baerts (NGI0) wrote:
> When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
> and released at the end.
> 
> If at that moment, it was the last reference being held, the sk would
> not be freed. sock_put() should then be called instead of __sock_put().
> 
> But that's not enough: if it is the last reference, sock_put() will call
> sk_free(), which will end up calling sk_stop_timer_sync() on the same
> timer, and waiting indefinitely to finish. So it is needed to mark that
> the timer is done, and no need to call sk_stop_timer_sync().
> 
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v3: support calling sk_free() from the timer handler. Note: I'm not very
>     happy with this patch, it looks too big. Did I miss a simpler way?
> ---
>  net/mptcp/pm.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d3fcf441b208..adbebf46dcce 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -16,6 +16,7 @@ struct mptcp_pm_add_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
>  	u8			retrans_times;
> +	bool			timer_done;
>  	struct timer_list	add_timer;
>  	struct mptcp_sock	*sock;
>  	struct rcu_head		rcu;
> @@ -327,22 +328,22 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  							      add_timer);
>  	struct mptcp_sock *msk = entry->sock;
>  	struct sock *sk = (struct sock *)msk;
> -	unsigned int timeout;
> +	unsigned int timeout = 0;
>  
>  	pr_debug("msk=%p\n", msk);
>  
> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> -		goto exit;
> -
>  	bh_lock_sock(sk);
> +	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> +		goto out;
> +
>  	if (sock_owned_by_user(sk)) {
>  		/* Try again later. */
> -		sk_reset_timer(sk, timer, jiffies + HZ / 20);
> +		timeout = HZ / 20;
>  		goto out;
>  	}
>  
>  	if (mptcp_pm_should_add_signal_addr(msk)) {
> -		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
> +		timeout = TCP_RTO_MAX / 8;
>  		goto out;
>  	}
>  
> @@ -360,8 +361,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  	}
>  
>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> -		sk_reset_timer(sk, timer,
> -			       jiffies + (timeout << entry->retrans_times));
> +		timeout <<= entry->retrans_times;
> +	else
> +		timeout = 0;
>  
>  	spin_unlock_bh(&msk->pm.lock);
>  
> @@ -369,9 +371,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>  		mptcp_pm_subflow_established(msk);
>  
>  out:
> +	if (timeout)
> +		sk_reset_timer(sk, timer, jiffies + timeout);
> +	else
> +		/* if sock_put calls sk_free: avoid waiting for this timer */
> +		entry->timer_done = true;
>  	bh_unlock_sock(sk);
> -exit:
> -	__sock_put(sk);
> +	sock_put(sk);
>  }
>  
>  struct mptcp_pm_add_entry *
> @@ -431,12 +437,15 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  	add_entry->addr = *addr;
>  	add_entry->sock = msk;
>  	add_entry->retrans_times = 0;
> +	add_entry->timer_done = false;

As recommended by sashiko, this should be moved under the "reset_timer"
label just in case the sysctl value has been changed in between.

Also, I don't think we need to protect that with READ/WRITE_ONCE: this
variable is only useful when 'sock_put()' is called from the timer
handler, and it removes the last socket reference: when it is the last
consumer, alone, no concurrency then.

>  
>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>  reset_timer:
>  	timeout = mptcp_adjust_add_addr_timeout(msk);
>  	if (timeout)
>  		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
> +	else
> +		add_entry->timer_done = true;
>  
>  	return true;
>  }
> @@ -454,7 +463,8 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	list_for_each_entry_safe(entry, tmp, &free_list, list) {
> -		sk_stop_timer_sync(sk, &entry->add_timer);
> +		if (!entry->timer_done)
> +			sk_stop_timer_sync(sk, &entry->add_timer);
>  		kfree_rcu(entry, rcu);
>  	}
>  }
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

