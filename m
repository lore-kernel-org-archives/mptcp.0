Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2220B80D
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510000; cv=none; b=mlpO8fqTbF8HoKS90/HXfAj0YWE3VazbbAvzvl/wkdUw7O1SO+GMylcgh9JDCnIT10RYu7T9fXnyEYb/lu59NA+q68SmqnFhs5e6P7/U2qPpgdfnZrPyV71Gwsz3GCR0vKMc1gsvfSo8KsBzIc7zZfrjRCLilm03TQR8qSYH88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510000; c=relaxed/simple;
	bh=sN/hxhqaM3p4fU9fiRJFinrUjEaJ/0se3mQpKQEfh18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqwxKu/HbzHLLzjP04Ta3SVQ/x64mTvfupwPFTgz7leRTH2zIKZ8AwYJFeUJYLzv7vwwE2P/x6En3lPc633qrndOkweDwygVggONXAx+yEaPqKuZkiTrm1ujRKiSPWhxifxowz2QrffLg0kfalUBub7jxZvMFl/1XThhB8sPYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgAzIVyk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgAzIVyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43C4C4CEE0;
	Fri, 10 Jan 2025 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736509998;
	bh=sN/hxhqaM3p4fU9fiRJFinrUjEaJ/0se3mQpKQEfh18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgAzIVykvQtuf2XD1Zq6GdGBxbBzP8X7kGpLUigG2QKVrdWKgZPYNlTYnwi6zoRTD
	 ykNorkfnOa0mmQjFHUmFnEz4t9j/fAm7QdHAqnBME9LGQYjABCpg2NDu8h3DiSHiIa
	 relL0faeuxJeN4pUxcr6epQCDKdysWa8ZjUm56MAXwBMlkqOgq5BZRr09pI5FYZ0Ze
	 BIj5rU1Q6uJhI34uvnDvdCdph/YcYUMAHIxp+nJALwY86e5U64nsQOkp/K+3sInyYw
	 YyDNaUNKr3lWP0UGhxMS+mQiIW4pUp+Naptr0D+z2VcRN7lfAhMDuw0eJG/k1Z3Ucj
	 zopTAKr8Cd/yw==
Message-ID: <68170ee3-dfef-4720-b132-b8f70eafcf7c@kernel.org>
Date: Fri, 10 Jan 2025 12:53:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 7/7] mptcp: add local parameter for
 set_flags
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
 <3613363fc62da1323303ff776fba2914433e95c7.1736494320.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3613363fc62da1323303ff776fba2914433e95c7.1736494320.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/01/2025 08:36, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch updates the interfaces set_flags to reduce repetitive
> code, adds a new parameter 'local' for them. The local address is
> parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass
> it to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 52fd9830b685..ec6afa5c3525 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1951,61 +1951,51 @@ static int mptcp_nl_set_flags(struct net *net,
>  	return ret;
>  }
>  
> -int mptcp_pm_nl_set_flags(struct genl_info *info)
> +int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> +			  struct genl_info *info)
>  {
> -	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
>  	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
>  			   MPTCP_PM_ADDR_FLAG_FULLMESH;
>  	struct net *net = genl_info_net(info);
>  	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
> -	struct nlattr *attr;
>  	u8 lookup_by_id = 0;
>  	u8 bkup = 0;
> -	int ret;
> -
> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
> -		return -EINVAL;
>  
>  	pernet = pm_nl_get_pernet(net);
>  
> -	attr = info->attrs[MPTCP_PM_ATTR_ADDR];

As I mentioned in the "use GENL_REQ_ATTR_CHECK in userspace pm" series,
I think this 'attr' can be kept here -- because we still have access to
'info' -- ...

> -	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (addr.addr.family == AF_UNSPEC) {
> +	if (local->addr.family == AF_UNSPEC) {
>  		lookup_by_id = 1;
> -		if (!addr.addr.id) {
> +		if (!local->addr.id) {
>  			GENL_SET_ERR_MSG(info, "missing address ID");

... and use NL_SET_ERR_MSG_ATTR() here and below.

That way, the code around the reporting of errors would be uniformed
with the rest, and that could still help userspace devs.

I can do the modifications when applying the patches of the other series
and this one here.

(...)

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 4007f67cc7b1..431454578021 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -564,19 +564,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
>  	return err;
>  }
>  
> -int mptcp_userspace_pm_set_flags(struct genl_info *info)
> +int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
> +				 struct genl_info *info)
>  {
> -	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
>  	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
>  	struct mptcp_pm_addr_entry *entry;
> -	struct nlattr *attr, *attr_rem;
> +	struct nlattr *attr_rem;
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  	u8 bkup = 0;
>  
> -	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
> -	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
> +	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
>  		return ret;
>  
>  	msk = mptcp_userspace_pm_get_sock(info);
> @@ -585,12 +584,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
>  
>  	sk = (struct sock *)msk;
>  
> -	attr = info->attrs[MPTCP_PM_ATTR_ADDR];

Same here.

> -	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
> -	if (ret < 0)
> -		goto set_flags_err;
> -
> -	if (loc.addr.family == AF_UNSPEC) {
> +	if (local->addr.family == AF_UNSPEC) {
>  		GENL_SET_ERR_MSG(info, "invalid local address family");
>  		ret = -EINVAL;
>  		goto set_flags_err;
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

