Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3476FBE
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101239; cv=none; b=WHZZWDgFUwKiUBkSjm/fSe4dyi2wH9iZIoed6rZSaKchdZ/Tj9BpeghBiAEZqST0yKcoQ4j+3RwOzd5yi1HdqUT+m1BEQSDDObrRQHyVMtLCp2fRoLihDSK+ipESri25N2xD3Y24X2+iRtukh0vf8FTKjiRm8Yf4qCinxdXBy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101239; c=relaxed/simple;
	bh=6sq+UkUyK4glpHWnQn0s0wrRhhLLV7lEdqGYZFFy/8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElyHPFbC26ELAPhCBiJ2fTQ/jwKqSdzh/OP723EKkxn5gQ2l5d5EVJTScvP64l9CbSyZ6/0eac4ePrWsXibcngWU8TWqPFHwhtMH5tp32BWU/MGHGuRxW2h5j14c/Z27DffyyWMpsvtCgTwXVubcr95vfNELbclHQ9KRmXqsDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcTy2ZNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcTy2ZNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74423C116B1;
	Tue, 16 Jul 2024 03:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101238;
	bh=6sq+UkUyK4glpHWnQn0s0wrRhhLLV7lEdqGYZFFy/8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IcTy2ZNZadjP3h7G5jg7xCPRjrOeskLvf/F6kqmEEKb2D9LV+6kS1YTC7ALoZjMvk
	 2xdcpXUXfTBrsc86lB1zEnmbBO+QGgJGz5hkutSogBJnL3sXznFRxsl59dDBZ56EM4
	 fOq/bQ0QWT+GKxnDvkkVRJxbg11WpjKvq2KWPhd3GW3stdp5fpjTNLfIsl2lC4pMj8
	 /W4YVd0oxvAC+r8kRggMZTVWLL4ZCOxrq0DNyRodpIH8wC8eNodOrisl8RYkIkiGGl
	 u5b18JmL11gI3z3qlxBd25oICZfqIPghGLKF/If7OySVM8nFSRZWjExf96cmUhMw+U
	 g1P+EshkK3gpA==
Message-ID: <04f90c53bf7842c80b501e5e60e2f04872ddc88e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 14/17] mptcp: pm: remove
 mptcp_pm_remove_subflow()
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 16 Jul 2024 11:40:32 +0800
In-Reply-To: <20240715-mptcp-pm-avail-v2-14-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
	 <20240715-mptcp-pm-avail-v2-14-fc5153bd1f6e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
> This helper is confusing. It is in pm.c, but it is specific to the
> in-kernel PM and it cannot be used by the userspace one. Also, it
> simply
> calls one in-kernel specific function with the PM lock, while the
> similar mptcp_pm_remove_addr() helper requires the PM lock.
> 
> What's left is the pr_debug(), which is not that useful, because a
> similar one is present in the only function called by this helper:
> 
>   mptcp_pm_nl_rm_subflow_received()
> 
> After these modifications, this helper can now be marked as 'static'.
> 
> Note that it is not really a bug, but it will help backporting the
> following commits.
> 
> Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm.c         | 10 ----------
>  net/mptcp/pm_netlink.c | 16 +++++++++++-----
>  net/mptcp/protocol.h   |  3 ---
>  3 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 55406720c607..1f1b2617d0f5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -60,16 +60,6 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk,
> const struct mptcp_rm_list *rm_
>  	return 0;
>  }
>  
> -int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct
> mptcp_rm_list *rm_list)
> -{
> -	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
> -	spin_unlock_bh(&msk->pm.lock);
> -	return 0;
> -}
> -
>  /* path manager event handlers */
>  
>  void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct
> sock *ssk, int server_side)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 44092246259c..96336a87973f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -858,8 +858,8 @@ static void mptcp_pm_nl_rm_addr_received(struct
> mptcp_sock *msk)
>  	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx,
> MPTCP_MIB_RMADDR);
>  }
>  
> -void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
> -				     const struct mptcp_rm_list
> *rm_list)
> +static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
> +					    const struct
> mptcp_rm_list *rm_list)
>  {
>  	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list,
> MPTCP_MIB_RMSUBFLOW);
>  }
> @@ -1454,8 +1454,11 @@ static int
> mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>  		remove_subflow = lookup_subflow_by_saddr(&msk-
> >conn_list, addr);
>  		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow
> &&
>  					  !(entry->flags &
> MPTCP_PM_ADDR_FLAG_IMPLICIT));
> +

I think no need to add a new line here.

>  		if (remove_subflow) {
> -			mptcp_pm_remove_subflow(msk, &list);
> +			spin_lock_bh(&msk->pm.lock);
> +			mptcp_pm_nl_rm_subflow_received(msk, &list);
> +			spin_unlock_bh(&msk->pm.lock);

The subsequent code holds msk->pm.lock too, both of them can be placed
in the same block holding msk->pm.lock once.

>  		} else if (entry->flags &
> MPTCP_PM_ADDR_FLAG_SUBFLOW) {
>  			/* If the subflow has been used, but now
> closed */
>  			spin_lock_bh(&msk->pm.lock);
> @@ -1608,8 +1611,11 @@ static void
> mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
>  		spin_unlock_bh(&msk->pm.lock);
>  	}
>  
> -	if (slist.nr)
> -		mptcp_pm_remove_subflow(msk, &slist);
> +	if (slist.nr) {
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_pm_nl_rm_subflow_received(msk, &slist);
> +		spin_unlock_bh(&msk->pm.lock);
> +	}

The same here. Holding msk->pm.lock once.

WDYT?

>  
>  	/* Reset counters: maybe some subflows have been removed
> before */
>  	spin_lock_bh(&msk->pm.lock);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19d60b6d5b45..f2eb5273d752 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1030,7 +1030,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock
> *msk,
>  			   const struct mptcp_addr_info *addr,
>  			   bool echo);
>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct
> mptcp_rm_list *rm_list);
> -int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct
> mptcp_rm_list *rm_list);
>  void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head
> *rm_list);
>  
>  void mptcp_free_local_addr_list(struct mptcp_sock *msk);
> @@ -1134,8 +1133,6 @@ static inline u8 subflow_get_local_id(const
> struct mptcp_subflow_context *subflo
>  
>  void __init mptcp_pm_nl_init(void);
>  void mptcp_pm_nl_work(struct mptcp_sock *msk);
> -void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
> -				     const struct mptcp_rm_list
> *rm_list);
>  unsigned int mptcp_pm_get_add_addr_signal_max(const struct
> mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct
> mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock
> *msk);
> 

