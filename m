Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADFC1CF8B
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745387; cv=none; b=V/JdhjfS4AlLSy6igAD0zsOFK0HaviUBBGWn+dQo4tHe3H6ft6/sYcX/7Bejpmn1JdNdUV45zb8+c57hb7u4z/v90JSBK/g3kWcl2rYUHTmB7aO4c6XZO0923E8tEgfEfwNb8eCDuDYtfrHIBKadYt3uOKTV0JY0wzH/xDNEQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745387; c=relaxed/simple;
	bh=oXnNzTRH5LFuT5hWQo2ErZcpEED4IWYNFEuBboAnqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0fTcJZe58r4mE1c7k5xzHSEAxFYHYulFiBku3uYUZdXIP91TDl5TU0Vg/TsVJPCOxUkVx9fPkp3nM5Y7HlKbNYiu6N8OfX7CSQMR3/G7IVi7muy0WIJkAOTTV/+KVDlmbvzVb5pVhAZgPaH3wJMowuEtKPuz/tT8qG8wSeAUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJC1UX19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJC1UX19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4FC4CECE;
	Mon,  4 Nov 2024 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730745387;
	bh=oXnNzTRH5LFuT5hWQo2ErZcpEED4IWYNFEuBboAnqYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SJC1UX19w1H9KsdBgTk1ICJZS7LNezIlc5Zhp7AObBbI7xx97yZxzDHfgcOHP0PqS
	 I3dJXGUnZ0lYKErcJtB8TDK6VZ8yIw1NkNe9B79H6PtnU7kZiVMI8gTEDWIfmY8k2R
	 iSlKmkTFdiIAmR2/3HXA9MpWMycdE7juZscc6zJLMClYmHRPhAamRkRT1pFX8ah9y6
	 IM2jPKUUgyki3ka3CcI7nM/KeuXGu2OcO4p8qObzoPbilz3GBUk3ig1EGAfBCUsze1
	 f6mgK/8M8um+IcllG5Jr73KFm56sb4hliMrKNWvdWRP7TGE4E2p9k2+Gjs05ybWdU2
	 9yBF69s+qPxhw==
Message-ID: <9f8bcf92-64c5-4020-be77-a2bc0fe1c83c@kernel.org>
Date: Mon, 4 Nov 2024 19:36:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 20/36] mptcp: add loc and rem for set_flags
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <0941887ad2ba9451d89c0409b40b945d57a4c56c.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0941887ad2ba9451d89c0409b40b945d57a4c56c.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch updates the interfaces set_flags to reduce repetitive code,
> adds two more parameters "loc" and "rem" for them. These addresses are
> parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
> to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_netlink.c   | 57 ++++++++++++++++++++++++----------------
>  net/mptcp/pm_userspace.c | 28 ++++++--------------
>  net/mptcp/protocol.h     |  4 ++-
>  3 files changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5fb1d5d8bf57..5cd5241da3c6 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -2045,10 +2045,10 @@ static int mptcp_nl_set_flags(struct net *net,
>  	return ret;
>  }
>  
> -static int mptcp_pm_nl_set_flags(struct genl_info *info)
> +static int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *loc,
> +				 struct mptcp_addr_info *rem,
> +				 struct genl_info *info)
>  {
> -	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
> -	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
>  			   MPTCP_PM_ADDR_FLAG_FULLMESH;
>  	struct net *net = genl_info_net(info);
> @@ -2056,59 +2056,72 @@ static int mptcp_pm_nl_set_flags(struct genl_info *info)
>  	struct pm_nl_pernet *pernet;
>  	u8 lookup_by_id = 0;
>  	u8 bkup = 0;
> -	int ret;
>  
>  	pernet = pm_nl_get_pernet(net);
>  
> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (addr.addr.family == AF_UNSPEC) {
> +	if (loc->addr.family == AF_UNSPEC) {
>  		lookup_by_id = 1;
> -		if (!addr.addr.id) {
> +		if (!loc->addr.id) {
>  			GENL_SET_ERR_MSG(info, "missing required inputs");
>  			return -EOPNOTSUPP;
>  		}
>  	}
>  
> -	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> +	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
>  
>  	spin_lock_bh(&pernet->lock);
> -	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
> -			       __lookup_addr(pernet, &addr.addr);
> +	entry = lookup_by_id ? __lookup_addr_by_id(pernet, loc->addr.id) :
> +			       __lookup_addr(pernet, &loc->addr);
>  	if (!entry) {
>  		spin_unlock_bh(&pernet->lock);
>  		GENL_SET_ERR_MSG(info, "address not found");
>  		return -EINVAL;
>  	}
> -	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
> +	if ((loc->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
>  	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>  		spin_unlock_bh(&pernet->lock);
>  		GENL_SET_ERR_MSG(info, "invalid addr flags");
>  		return -EINVAL;
>  	}
>  
> -	changed = (addr.flags ^ entry->flags) & mask;
> -	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
> -	addr = *entry;
> +	changed = (loc->flags ^ entry->flags) & mask;
> +	entry->flags = (entry->flags & ~mask) | (loc->flags & mask);
> +	*loc = *entry;
>  	spin_unlock_bh(&pernet->lock);
>  
> -	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
> +	mptcp_nl_set_flags(net, &loc->addr, bkup, changed);
>  	return 0;
>  }
>  
> -static int mptcp_pm_set_flags(struct genl_info *info)
> +static int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *loc,
> +			      struct mptcp_addr_info *rem,
> +			      struct genl_info *info)
>  {
>  	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -		return mptcp_userspace_pm_set_flags(info);
> -	return mptcp_pm_nl_set_flags(info);
> +		return mptcp_userspace_pm_set_flags(loc, rem, info);
> +	return mptcp_pm_nl_set_flags(loc, rem, info);
>  }
>  
>  int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return mptcp_pm_set_flags(info);
> +	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
> +	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> +	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];

(detail: maybe clearer to call it "attr_loc", similar to "attr_rem")

> +	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
> +	int ret;
> +
> +	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (attr_rem) {
> +		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return mptcp_pm_set_flags(&loc, &rem, info);

Nothing to change here, but linked to a previous comment for another
patch of this series: I think it would be clearer to move
mptcp_pm_nl_set_flags_doit() and similar (mptcp_pm_nl_get_addr_dumpit()
+ mptcp_pm_nl_get_addr_doit()) to pm.c: these helpers are generic,
implemented for each PM.

Similarly, we can move the content of their linked function
(mptcp_pm_set_flags(), mptcp_pm_dump_addr() and mptcp_pm_get_addr()) in
there. If this last step makes sense for the future changes of course,
but for the moment, these helpers are only used in one place, just next
to, and only 3 basic lines: 'if (X) return A; return B'.

>  }
>  
>  static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

