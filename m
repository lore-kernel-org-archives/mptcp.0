Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917991C3026
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748243; cv=none; b=uJ1wIGUCVR+ZK6Bs1WFXc7FLSLzhEU4rtdkTvpbwIZEoyj6+jQENrEfR/9mUUNn4ZoI+cVW58ngRez2LQ8vyBz5OkYLjMbq+dPehp6NZfCkGQlsfrpO2dLZWHV0X5AdZNxk3AcXvgZDInPSEjfhvmLCKiYGzbPO7Pce4hIm6j9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748243; c=relaxed/simple;
	bh=kwIRQJWqzyiyZueckGGyp6Ax2nQhldNqDdU7vsEiAuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYv44EqHtWKV8xwnu9uBKpj55FsyrTN6KeF6PBDm3LkOoj6LHCMscs+G19D0fMxiQMpI7E5KRM8z4nBgctSK5cGHDVCIqhkzOKO5sGNsj/Agid2Wds1o/zLBSDYVa3pd8kWGMC+Ah8Unn5UwZc/8SLdCJcbYYlWVxtIPYIQzLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIv2IZOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIv2IZOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E146C4CECE;
	Mon,  4 Nov 2024 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730748243;
	bh=kwIRQJWqzyiyZueckGGyp6Ax2nQhldNqDdU7vsEiAuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NIv2IZOMSBNwtplels7D7Uq3qQmlcZ5xSHYoSuNosFztWccnpgmBFGhkfckAN6rYC
	 CiwPO2E872UiPYnb6/UzFiI6zTV1q58RoLeeHJyVy6lD6+8cJAwJA/bffTT1ZDDS6y
	 zqyPQmtzGJdtzKMfHUyThP75oe9+QedNFLorQkcEV/+N3HX24Jk66MzTIt91mCw1oY
	 Azv2EyJcVvQZYisNIiT2ktgRfTOYtdyZcVUdoPGl+EimQVHw6xSb7McmJ2D69BMIng
	 WTmHSidzNy5+Ik7gCZZbt0+lIHi/2WPrB0eLdx/JSsJuIlWLaRk+DuwgGdx1gDf7QF
	 aYw94D8Z8aWhA==
Message-ID: <e3d9549e-b682-42f1-bd3d-9a5689a00982@kernel.org>
Date: Mon, 4 Nov 2024 20:24:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 27/36] mptcp: rename mptcp_pm_remove_addrs
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <39ecde504cf3652ce36d526a78c920ba94cd550b.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <39ecde504cf3652ce36d526a78c920ba94cd550b.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> mptcp_pm_remove_addrs() actually only deletes one address, which does
> not match its name. This patch renames it to mptcp_pm_remove_addr_entry()
> and changes the parameter "rm_list" to "entry".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c   | 24 ++++++++++--------------
>  net/mptcp/pm_userspace.c |  2 +-
>  net/mptcp/protocol.h     |  3 ++-
>  3 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 06f0c7df575e..852706e43f13 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1615,26 +1615,22 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  }
>  
>  /* Called from the userspace PM only */

(out of curiosity: after the modifications you did, could this helper
not be "easily" moved to pm_userspace.c?)

> -void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> +void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> +				struct mptcp_pm_addr_entry *entry)
>  {
>  	struct mptcp_rm_list alist = { .nr = 0 };
> -	struct mptcp_pm_addr_entry *entry;
>  	int anno_nr = 0;
>  
> -	list_for_each_entry(entry, rm_list, list) {
> -		if (alist.nr >= MPTCP_RM_IDS_MAX)
> -			break;
> -
> -		/* only delete if either announced or matching a subflow */
> -		if (remove_anno_list_by_saddr(msk, &entry->addr))
> -			anno_nr++;
> -		else if (!lookup_subflow_by_saddr(&msk->conn_list,
> -						  &entry->addr))
> -			continue;
> +	/* only delete if either announced or matching a subflow */
> +	if (remove_anno_list_by_saddr(msk, &entry->addr))
> +		anno_nr++;
> +	else if (!lookup_subflow_by_saddr(&msk->conn_list,
> +					  &entry->addr))

(maybe this can move to the previous line if it is under 80 chars?)

> +		goto out;
>  
> -		alist.ids[alist.nr++] = entry->addr.id;
> -	}
> +	alist.ids[alist.nr++] = entry->addr.id;
>  
> +out:
>  	if (alist.nr) {
>  		spin_lock_bh(&msk->pm.lock);
>  		msk->pm.add_addr_signaled -= anno_nr;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 3ad10d8062d9..21b2a3b02cfe 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -322,7 +322,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  	list_move(&match->list, &free_list);

Do you still need to do this move? Do you still need "free_list"? Can
you just remove the entry from the list?

>  	spin_unlock_bh(&msk->pm.lock);
>  
> -	mptcp_pm_remove_addrs(msk, &free_list);
> +	mptcp_pm_remove_addr_entry(msk, match);
>  
>  	release_sock(sk);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9dc01140af23..13cd97f9e0f7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1051,7 +1051,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  			   const struct mptcp_addr_info *addr,
>  			   bool echo);
>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
> -void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
> +void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> +				struct mptcp_pm_addr_entry *entry);
>  
>  void mptcp_free_local_addr_list(struct mptcp_sock *msk);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

