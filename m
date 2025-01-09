Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD18191499
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444347; cv=none; b=Pj4iFL8NSocRUW4EgOFYGRiyq0qudavK9s/1VhSDsDq4ut1aROq0fdQwWOY2ZUf4Hh4JqzGZbkk1Du5hnpL/RrJUlZ53Pdie5oaE1/4Ra2E/e6UdbjJfQ8xu1UdTHoxHPG18d8QiPbm75hhnqmv7Y4CbH8hA43l4ggDIKgzgz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444347; c=relaxed/simple;
	bh=gjFc+KwmF1Kh9W/h4unYJ7xo1LNDe4ETKl+ToUOTJYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSbnb0SboAJ5Q0PR4viJ/sk5sNgNQ5rc94QQs+d1tzNdElqlWPjeIx7S7o/yAl9sNabHtXBGUnRl5r10K98EsHVVdRmWpy6Td2YphZgRxe4md+FZBR7Kqk0Kh/ax1KF6/xj2lgW8J6X6Rvnv7ygIOiQy6N/TO4jsDka0qFcKUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPl7/l2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPl7/l2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4C9C4CED2;
	Thu,  9 Jan 2025 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736444347;
	bh=gjFc+KwmF1Kh9W/h4unYJ7xo1LNDe4ETKl+ToUOTJYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZPl7/l2gfvqn5FGfodUqykERRnbNzio415FpbAxmV/w8sxahmy9kwHlbjJ8PmbjkQ
	 tyKexpMoQWL72b1JAsbC4hbtpDMdwAbIe7OBDCTCceYcrhQw/QmveERVMGgmRIYiPp
	 7vSpBd1hQJtOQ6sN7FB/NZCBFwyXFNxl78n+0z3j9N9rAC8tbSrd9iVs8OoL/hE2gp
	 oGWOjBIkLdOpz+MPt5dDPOs9Z33dyX8NSh6fGI/WnN2y1qt5qSAhYRfw7+ppcPA97P
	 kvnzfLZyNG1P+qgmjZO7IshAngpMVdT9yFtebhQ0WgyxUquvSUgakREkPPMU5tZL90
	 rmp0TqP0CDQxw==
Message-ID: <c509dab8-8438-422e-b6f8-2b7e956bf73f@kernel.org>
Date: Thu, 9 Jan 2025 18:39:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <tencent_28A52E260A59791DE3E6C44846805D812005@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_28A52E260A59791DE3E6C44846805D812005@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 09/01/2025 14:32, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch fixes an issue where an invalid address is announced
> as a signal, the 'add_addr_accepted' is incorrectly added twice.
> If reach the limits, even the invalid connection is removed from
> conn_list by mptcp_worker, the variable is not updated, so the
> available address can not be added.

Detail: I don't know if this is a fix for an issue (== fix for stable),
or something new. If it is a fix, it should be for stable, with a
'Fixes' tag. But I don't know if we want that in stable.

From what I understand, it can help a client when interacting with a
wrongly configured server. But it will not fix the server's behaviour.

> When 'ADD_ADDR' adds an invalid address in the LAN, it will trigger
> the 'tcp_done_with_error' at the TCP level due to 'icmp_unreach'.
> At this point, 'RETRANS_ADDR' will increment 'add_addr_accepted' again.

Do you mean that each time a SYN + MP_JOIN is retransmitted, and if it
was created upon the reception of an ADD_ADDR, the
msk->pm.add_addr_accepted counter is incremented? If yes, can you show
me via which path this is done please? I'm not sure to understand how we
can get this.

> This patch is also helpful for issue#498.

Can you give a bit more details about how the issue is being fixed here
please? e.g. what's happening after tcp_done_with_error()?

e.g. the subflow will be closed via (...). It is then possible to hook
there to check (...) and decrement the counter only if (...).

> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c | 25 +++++++++++++++++++++++++
>  net/mptcp/protocol.c   |  3 +++
>  net/mptcp/protocol.h   |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 618289aac0ab..63b5c1d6d87a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -958,6 +958,31 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
>  	spin_unlock_bh(&msk->pm.lock);
>  }
>  
> +void mptcp_pm_subflow_closed_external(struct mptcp_sock *msk,
> +				      struct mptcp_subflow_context *subflow)
> +{
> +	u8 remote_id = READ_ONCE(subflow->remote_id);
> +	s16 local_id = READ_ONCE(subflow->local_id);
> +	struct mptcp_subflow_context *iter;
> +
> +	if (!subflow->request_join || !remote_id)

It might be good to add a comment here above to clearly explain which
cases are included and/or excluded here. At least mentioning that you
are looking at the subflows that have been created upon the reception of
an ADD_ADDR, which means a requested MPJ to a remote ID > 0.

(also, please use 'remote_id > 0', that's clearer in this case, even if
it is the same)

> +		return;
> +
> +	mptcp_for_each_subflow(msk, iter) {
> +		u8 iter_rmtid = READ_ONCE(iter->remote_id);
> +		s16 iter_locid = READ_ONCE(iter->local_id);
> +
> +		if (remote_id == iter_rmtid && iter->request_join &&
> +		    local_id != iter_locid)
> +			return;

Then please add a comment here above as well: you are checking if there
are other subflows connected to the same remote ID.

Saying that, would it not be better to check that like that?

  mptcp_for_each_subflow(msk, iter) {
      if (subflow == iter)
          continue;

      /* other subflows created from the same announced ADD_ADDR? */
      if (iter->request_join && remote_id == READ_ONCE(iter->remote_id))
          return;
  }

  if (!WARN_ON_ONCE(msk->pm.add_addr_accepted == 0))
      return;

  /* only decr for the last subflow attached to the accepted ADD_ADDR */
  (...)

> +	}
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
> +		WRITE_ONCE(msk->pm.accept_addr, true);
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
>  static bool address_use_port(struct mptcp_pm_addr_entry *entry)
>  {
>  	return (entry->flags &
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 21bc3586c33e..93c832d7feed 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2569,6 +2569,9 @@ static void __mptcp_close_subflow(struct sock *sk)
>  			continue;
>  
>  		mptcp_close_ssk(sk, ssk, subflow);
> +
> +		if (mptcp_pm_is_kernel(msk))
> +			mptcp_pm_subflow_closed_external(msk, subflow);

Detail: usually, the core call generic PM functions (in pm.c), which
calls the proper PM, e.g.

  protocol.c
    → pm.c
      → pm_netlink.c
      → or pm_userspace.c

So:

  __mptcp_close_subflow()
    → mptcp_pm_subflow_closed_external()
      → if mptcp_pm_is_kernel(): mptcp_pm_nl_subflow_closed_external()

>  	}
>  
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b4c72a73594f..2923a8cafd91 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1148,6 +1148,8 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
> +void mptcp_pm_subflow_closed_external(struct mptcp_sock *msk,
> +				      struct mptcp_subflow_context *closed_subflow);
>  
>  /* called under PM lock */
>  static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

