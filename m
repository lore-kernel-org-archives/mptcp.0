Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B77083B
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866318; cv=none; b=qXGYh3kteiD55u+GIxxKWeygpAFSNqvofI3jOrhZCb1lFOBjYBwVrAn04ovYkPcMlepa2GHTuPtMUIhy1GKk+7uCydan7DcIHkqi0e2da2fth2B/tzCpXX1Qtc2yrVkypQ4w4VOpxf7Umi89Bx3m95BXUSgPaFzXPZvb3A8uVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866318; c=relaxed/simple;
	bh=6uRxB+sgNJ57pxxYoyjDW/IylnNbFXC8uzby8gHCkd4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJO0LhqEmk606XX4kpyxS5m0zWffL66487+KXvO3ZLUCp+0F7HpwMsupEYwICFKGpbAXip01bfrNLzXBC1KP0cFP+6vTgkh/pPFc7HGrKtkrOrq8ZALjyvjBU8uNBfaTuED0wygCNyGfG+kW5M70efMfCsyR4VlAsgaUR7tNWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvCc40/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvCc40/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022D7C4CEC3;
	Fri, 25 Oct 2024 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729866318;
	bh=6uRxB+sgNJ57pxxYoyjDW/IylnNbFXC8uzby8gHCkd4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YvCc40/B0TRoW7NVz8pgvvlH1e2pCsQe+9AOGuCyIsCOyOze9XWFO+TvHRfoqCATK
	 /DNKAmoCgeoSS43L/WIHOOnMdI5rrvFgvNJibE35vPMRk+3MHcYg+pGlSWaAdvIFW4
	 nq9SdJ2jL6cgkaoD8yAJaDMVJCWU9mIMKs3/BYdkmR1PVmHuwagY+g3Z+BstnsB3iE
	 kGxVOQZFma5iOHcf2zZcuJF4gqPKdFY6EJa8mtuOG+NnrozeOUi1GALUuVnqhaPKW4
	 MacF5o/m64Iy8xy2tXh9zOdT3T7TlBVcF58VRy22iWanpAhxin5TUjuNCofZfsG/Fr
	 rjPBMFPyJtDXg==
Message-ID: <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 25 Oct 2024 22:25:14 +0800
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
	 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0) wrote:
> In a few places -- to get an endpoint, dump all of them, and change
> their flags -- the list is iterated while holding the pernet->lock,
> but
> only to read the content of the list. In these cases, we can replace
> the
> spin locks, by RCU read ones, and use the _rcu variants to iterate
> over
> the entries list in a lockless way.
> 
> To make it clear, the lookup helpers using the _rcu variant are
> renamed
> with a _rcu suffix. The previous __lookup_addr() helper can then be
> removed, but __lookup_addr_by_id() is still needed.
> 
> While at it, the IDs bitmap is copied before iterating the list to
> dump
> the different addresses, to avoid any consistencies.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - This is not a fix, a small improvement for -next.
> ---
>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8b50e
> 6965731542871 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -520,12 +520,12 @@ __lookup_addr_by_id(struct pm_nl_pernet
> *pernet, unsigned int id)
>  }
>  
>  static struct mptcp_pm_addr_entry *
> -__lookup_addr(struct pm_nl_pernet *pernet, const struct
> mptcp_addr_info *info)
> +__lookup_addr_by_id_rcu(struct pm_nl_pernet *pernet, unsigned int
> id)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  
> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, info, entry-
> >addr.port))
> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list,
> list) {
> +		if (entry->addr.id == id)
>  			return entry;
>  	}
>  	return NULL;
> @@ -1836,8 +1836,8 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb,
> struct genl_info *info)
>  		goto fail;
>  	}
>  
> -	spin_lock_bh(&pernet->lock);
> -	entry = __lookup_addr_by_id(pernet, addr.addr.id);
> +	rcu_read_lock();
> +	entry = __lookup_addr_by_id_rcu(pernet, addr.addr.id);
>  	if (!entry) {
>  		GENL_SET_ERR_MSG(info, "address not found");
>  		ret = -EINVAL;
> @@ -1850,11 +1850,11 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb,
> struct genl_info *info)
>  
>  	genlmsg_end(msg, reply);
>  	ret = genlmsg_reply(msg, info);
> -	spin_unlock_bh(&pernet->lock);
> +	rcu_read_unlock();
>  	return ret;
>  
>  unlock_fail:
> -	spin_unlock_bh(&pernet->lock);
> +	rcu_read_unlock();
>  
>  fail:
>  	nlmsg_free(msg);
> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff
> *msg,
>  	struct net *net = sock_net(msg->sk);
>  	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
> +	unsigned long id_bitmap[4];
>  	int id = cb->args[0];
>  	void *hdr;
>  	int i;
>  
>  	pernet = pm_nl_get_pernet(net);
> +	bitmap_copy(id_bitmap, pernet->id_bitmap,
> MPTCP_PM_MAX_ADDR_ID + 1);

I think the id bitmap should only be copied when id is 0:

if (!id)
  bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);

Since this mptcp_pm_nl_dump_addr() may be called repeatedly when the
dump information is very long. We only copy it the first time it is
called, and subsequent calls cannot copy it again. WDYT?

Thanks,
-Geliang

>  
> -	spin_lock_bh(&pernet->lock);
> +	rcu_read_lock();
>  	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
> -		if (test_bit(i, pernet->id_bitmap)) {
> -			entry = __lookup_addr_by_id(pernet, i);
> +		if (test_bit(i, id_bitmap)) {
> +			entry = __lookup_addr_by_id_rcu(pernet, i);
>  			if (!entry)
>  				break;
>  
> @@ -1903,7 +1905,7 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  			genlmsg_end(msg, hdr);
>  		}
>  	}
> -	spin_unlock_bh(&pernet->lock);
> +	rcu_read_unlock();
>  
>  	cb->args[0] = id;
>  	return msg->len;
> @@ -2060,17 +2062,17 @@ int mptcp_pm_nl_set_flags(struct sk_buff
> *skb, struct genl_info *info)
>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
>  
> -	spin_lock_bh(&pernet->lock);
> -	entry = lookup_by_id ? __lookup_addr_by_id(pernet,
> addr.addr.id) :
> -			       __lookup_addr(pernet, &addr.addr);
> +	rcu_read_lock();
> +	entry = lookup_by_id ? __lookup_addr_by_id_rcu(pernet,
> addr.addr.id) :
> +			       __lookup_addr_rcu(pernet,
> &addr.addr);
>  	if (!entry) {
> -		spin_unlock_bh(&pernet->lock);
> +		rcu_read_unlock();
>  		GENL_SET_ERR_MSG(info, "address not found");
>  		return -EINVAL;
>  	}
>  	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
>  	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> -		spin_unlock_bh(&pernet->lock);
> +		rcu_read_unlock();
>  		GENL_SET_ERR_MSG(info, "invalid addr flags");
>  		return -EINVAL;
>  	}
> @@ -2078,7 +2080,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb,
> struct genl_info *info)
>  	changed = (addr.flags ^ entry->flags) & mask;
>  	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
>  	addr = *entry;
> -	spin_unlock_bh(&pernet->lock);
> +	rcu_read_unlock();
>  
>  	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
>  	return 0;
> 

