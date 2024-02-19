Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA2381BD
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354392; cv=none; b=r7GeDznptqHl3SkPe28jxhDCIJfBRQ/cwE+kB/kBriRM+zQEN3XgkYfvIQzCCUl1JuKujDH3hNa8ftbb4IjF6dVM6dl8E/wPjJUgueG8jnckGtlnYsai9y9iqHkSka1zemme3dMARLBU3eZgxy9fk0gypC4q06shlUbq6NQXoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354392; c=relaxed/simple;
	bh=83ikDrqIAYiA2CPinNlduSUjf7C+xFk0UGC7W360r0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3UjdrLhmMElDCGWT0WqlXNlgf6Z6RTDkk17Ffc+ALS7Stvt6kC2qP+MG8TJ5cnghykDBvzon8Yd4xFTV7aoETRu0jvnO3pn3o+WICjFnr5KGkHrsUbu6MlRqiy4o3h2hyJz2gX7yod0SdF8FDA5JlH3ZJGJRKR80S/mTMJUjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDnEcNF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDnEcNF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9FC433C7;
	Mon, 19 Feb 2024 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354391;
	bh=83ikDrqIAYiA2CPinNlduSUjf7C+xFk0UGC7W360r0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDnEcNF+gLBAfCyOSaLqgHCkie/GeFVIS65RnouS7+13/zc75/TH8k8MFBvpUQ6f9
	 1Fru1RNKrbKpJ5pfQeHGbVopbZG84ROq9dtDt8KRtPwongmK4oQd1STSyImtDH2+CY
	 MbEFT0z/sEstt2Sment8+L15phwTmpG2FW4JTpBd0uFsXsawrDVIRPwjDKVrlaN5aQ
	 I+f3Yr599xhAGAitoYoUGtXAJWwDx9HHqI+A5z50hzkAZr5He0iMbDf/jw1/H76Dqt
	 oweTOTziQvBO+bVtuyBtZF8zQFPGM6lXkDWAQglGiQKk9JZVRoA+4GJEYf9bSW7Qji
	 y8yrNSj2K76Pg==
Message-ID: <59e46854-b8f1-48ee-9a83-25cbbce3330a@kernel.org>
Date: Mon, 19 Feb 2024 15:53:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v13 05/14] mptcp: check userspace pm flags
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
 <c600e3c58ad50e778c3357af6b58aa9008b28de6.1708069036.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c600e3c58ad50e778c3357af6b58aa9008b28de6.1708069036.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/02/2024 08:42, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
> announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
> mptcp_pm_nl_subflow_create_doit() too.
> 
> If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
> in the output of dump_addr. This looks a bit strange:
> 
>         id 10 flags  10.0.3.2
> 
> This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
> to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
> flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
> missing from the netlink attribute, always set this flag.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d6b7be3afbe5..73ad286247f1 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -360,11 +360,20 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> -	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
> +	err = mptcp_pm_parse_entry(laddr, info, true, &local);
>  	if (err < 0) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
>  		goto create_err;
>  	}
> +	addr_l = local.addr;

Detail: do we still need addr_l? Can we not use local.addr directly below?

> +
> +	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> +		GENL_SET_ERR_MSG(info, "invalid addr flags");
> +		err = -EINVAL;
> +		goto create_err;
> +	}
> +	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> +		local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;

(not sure the 'if' is needed: why not always setting it?)

>  
>  	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
>  	if (err < 0) {
> @@ -378,7 +387,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> -	local.addr = addr_l;
>  	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
>  	if (err < 0) {
>  		GENL_SET_ERR_MSG(info, "did not match address and id");

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
