Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42F7A13A
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071004; cv=none; b=mplbjnVd5wxwyDt3x8RDYyW8Df5wFkxldUEfWQ2uruyK5uPack7YGpKx7pf28fNjEW2/NHmKGVjUiicqW6OnClNEhkPxtOb8/d3QLlKWWj1dzpdao0J/rIhg74ec0XdSJHjvUfk3e34RgpmjQLrsZIYSe+MQv+7yfyGJ2ofvano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071004; c=relaxed/simple;
	bh=kgS/hA2Z4lIFwbRA4pYvl25bnmuzOhMpA4rk82xOCXU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayO2sZsAfM8vubayEoKGxZ79c807HRm7y5uVGjpKOeE2VgDrk1L89vNNVDWxcblrgzUqcpeXFr2nF9seAnMuZ+6+TsD+bmvjzz6q/z54rIV5A03clLjtC9iIv4BA43I5OCpQCGbK5OZOZuU4zEqD0aSMJOFeTtMBVXjuv1JTEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW64qIPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW64qIPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE81C116D0;
	Thu, 26 Feb 2026 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772071003;
	bh=kgS/hA2Z4lIFwbRA4pYvl25bnmuzOhMpA4rk82xOCXU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=aW64qIPAuUQUoPBDI/tvaCzzARPsJSY3uzRbstF2k5nMnlJ3Vg4jp0mCq0aLCiFBT
	 TF6aVCk9siJerALlTI4mSgilTJ4A8KYIfji/y12PRXKY8DqXVl6qLy8M1gqq6tmiw+
	 WLspEDHV2eTlJL6Lr0MIdJDnR7o+06ffdiVFc7jTgeM/x3nWu4rkhQJWnpYmWSjVTl
	 5CFHHFm2TzqwzzOw0ygXj7Lit3Jl9uKGiPS/DnRNM4PAfC6bz+thBpa9EzXPOjVFYM
	 JHvcdIXe2vBCGljSoixWryX89el1P+XD3uwltyo/m5ZNtU5+kGIQN4902CNVud9LLz
	 q+glbSyw7PJjg==
Message-ID: <e7a8a27fd92c1f99e34bd535e8f77f9568bcd1ec.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: in-kernel: remove
 mptcp_pm_has_addr_attr_id
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 26 Feb 2026 09:56:33 +0800
In-Reply-To: <20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org>
References: 
	<20260223-mptcp_pm_has_addr_attr_id-v1-1-1efb38ad6488@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Mon, 2026-02-23 at 18:35 +0100, Matthieu Baerts (NGI0) wrote:
> There is no need to call this helper: it will check if the address ID
> attribute is set, but this attribute has already been parsed
> previously.
> 
> Indeed, the value has been set in 'entry->addr.id' if it was set and
> positive, which is what we were looking at. Then only looking at this
> already parsed value is enough, not need to re-extract all Netlink
> attributes again.

Yes indeed.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Seen when inspecting the code, related to ticket 612/615.
> ---
>  net/mptcp/pm_kernel.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 87e37c729f81..ba15fbf2781f 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -711,7 +711,7 @@ static void __mptcp_pm_release_addr_entry(struct
> mptcp_pm_addr_entry *entry)
>  
>  static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet
> *pernet,
>  					     struct
> mptcp_pm_addr_entry *entry,
> -					     bool needs_id, bool
> replace)
> +					     bool replace)
>  {
>  	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
>  	int ret = -EINVAL;
> @@ -770,7 +770,7 @@ static int
> mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  		}
>  	}
>  
> -	if (!entry->addr.id && needs_id) {
> +	if (!entry->addr.id) {
>  find_next:
>  		entry->addr.id = find_next_zero_bit(pernet-
> >id_bitmap,
>  						   
> MPTCP_PM_MAX_ADDR_ID + 1,
> @@ -781,7 +781,7 @@ static int
> mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  		}
>  	}
>  
> -	if (!entry->addr.id && needs_id)
> +	if (!entry->addr.id)
>  		goto out;
>  
>  	__set_bit(entry->addr.id, pernet->id_bitmap);
> @@ -914,7 +914,7 @@ static int mptcp_pm_kernel_get_local_id(struct
> mptcp_sock *msk,
>  		return -ENOMEM;
>  
>  	entry->addr.port = 0;
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true,
> false);
> +	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> false);
>  	if (ret < 0)
>  		kfree(entry);
>  
> @@ -969,18 +969,6 @@ static int
> mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>  	return 0;
>  }
>  
> -static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
> -				      struct genl_info *info)
> -{
> -	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> -
> -	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX,
> attr,
> -					 mptcp_pm_address_nl_policy,
> info->extack) &&
> -	    tb[MPTCP_PM_ADDR_ATTR_ID])
> -		return true;
> -	return false;
> -}
> -
>  /* Add an MPTCP endpoint */
>  int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info
> *info)
>  {
> @@ -1029,9 +1017,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff
> *skb, struct genl_info *info)
>  			goto out_free;
>  		}
>  	}
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> -
> 						!mptcp_pm_has_addr_attr_id(attr, info),
> -						true);
> +	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> true);
>  	if (ret < 0) {
>  		GENL_SET_ERR_MSG_FMT(info, "too many addresses or
> duplicate one: %d", ret);
>  		goto out_free;
> 
> ---
> base-commit: db54d4a79a413b2702191c0dc1d855bc3c9e1a98
> change-id: 20260223-mptcp_pm_has_addr_attr_id-6bb52e3bd89a
> 
> Best regards,
