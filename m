Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFBB2561B
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772045; cv=none; b=FcVjcWoRKmN+wEmhfJ0cCUjSSny+/SJKJIhXDUToZ+aAPcxJWap/3L/Hv08Pl4U+vRpO2SZ1scfxj//0wVy8vFZeU3aQnf4+44FpyB9IVZCyC7MSLEnrmmy4GOUpArdnBmIvn1b8t4WpjzqnRfLYXbLOKqxtJncPeQBkmVHESIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772045; c=relaxed/simple;
	bh=O6Yxm7dR7filIiG6Bi251JS7OtOEgDnXfv7ZTCnE0DY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bfI7Ryts5ZSYd2/Re8H4KQS2MtJIjCtVtd7tPfZbF2zNJyTLvs6hqWcGG3KeJnXa36KL7JeVbnQ6q7KZmmz3ZyEZkNweK+DRDSmOZcljcuQz+HdZ9p9R9B+j4xrcuQHfCr+pyRSLXVwMb0SIUNpGhxWzIZI34u2Clc6nGUwEi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azonsvu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azonsvu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3EBC4AF0A;
	Tue, 23 Jul 2024 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721772044;
	bh=O6Yxm7dR7filIiG6Bi251JS7OtOEgDnXfv7ZTCnE0DY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Azonsvu0OiwLXobOUdrBflbhQ+CKVYP0iTaqd89KbeJoIeXnkaU6Mhy9VosRA1xw3
	 y5Srm3Re6Dkk2O+bGEh/V7xjQtI4TDvlRing1kxlKPoY0fRGLh06h4PT/V/UXuujkS
	 dZ7IsQPhyHAcqCHRuFMQcz+WGQwqCSSEOcsTNmHP1TTA6moz0ArkxuAwuV9nEhPbae
	 3niS0DAN4LPxinFAspuP8z4NfVNIIoeLk5zyJmFTw7FyS/iN8TnZN5OsW4ku/8pFBd
	 MR3fBxDjwqEXlF24W5WoNYsRbJMa86v1hl9VOVt7nGHIbivGC2rGigF4OpElumcFHL
	 /VzFwO+5TjGAg==
Date: Tue, 23 Jul 2024 15:00:43 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v4 12/23] mptcp: pm: re-using ID of unused
 flushed subflows
In-Reply-To: <20240722-mptcp-pm-avail-v4-12-15bfd73de384@kernel.org>
Message-ID: <50ed5ca5-13f0-360f-379f-539b2ed3939a@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org> <20240722-mptcp-pm-avail-v4-12-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jul 2024, Matthieu Baerts (NGI0) wrote:

> If no subflows are attached to the 'subflow' endpoints that are being
> flushed, the corresponding addr IDs will not be marked as available
> again.
>
> Mark all ID as being available when flushing all the 'subflow'
> endpoints, and reset local_addr_used counter to cover these cases.
>
> While at it, renamed the helpers linked to the flushing operations to
> make it clear that the intention is to flush all created subflows, and
> remove all announced addresses, not just a "random" selection.

Hi Matthieu -

Considering that this series is getting quite large for -net, a separate 
net-next patch looks preferable to me.

- Mat



>
> Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_netlink.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index bdbf27fe89e0..4045e5cc6298 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1586,8 +1586,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> 	}
> }
>
> -static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
> -					       struct list_head *rm_list)
> +static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
> +					      struct list_head *rm_list)
> {
> 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
> 	struct mptcp_pm_addr_entry *entry;
> @@ -1608,12 +1608,19 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
> 		mptcp_pm_remove_addr(msk, &alist);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> +
> 	if (slist.nr)
> 		mptcp_pm_remove_subflow(msk, &slist);
> +
> +	/* Reset counters: maybe some subflows have been removed before */
> +	spin_lock_bh(&msk->pm.lock);
> +	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	msk->pm.local_addr_used = 0;
> +	spin_unlock_bh(&msk->pm.lock);
> }
>
> -static void mptcp_nl_remove_addrs_list(struct net *net,
> -				       struct list_head *rm_list)
> +static void mptcp_nl_flush_addrs_list(struct net *net,
> +				      struct list_head *rm_list)
> {
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> @@ -1626,7 +1633,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
>
> 		if (!mptcp_pm_is_userspace(msk)) {
> 			lock_sock(sk);
> -			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
> +			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
> 			release_sock(sk);
> 		}
>
> @@ -1667,7 +1674,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
> 	pernet->next_id = 1;
> 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 	spin_unlock_bh(&pernet->lock);
> -	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
> +	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
> 	synchronize_rcu();
> 	__flush_addrs(&free_list);
> 	return 0;
>
> -- 
> 2.45.2
>
>
>
