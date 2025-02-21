Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059221DC9B0
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158590; cv=none; b=C20neenUO0YmEabQROsoUgosN+FTk6TYcW+/FYsI0JYr6VEMQaRSDFfe5S+71+NaG7H3UW5Pm3/Z8FiCBuOPanSlCCHxAY2E0SRU9TXk4CL02hxhKrSi2LI2IECvheKgLOVspj5V9n9ATH/rTgfqDoidUjs2HUzCW1Se2kebWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158590; c=relaxed/simple;
	bh=V1paQJI3fuQXQW0tz9RfPG8PyquOUM5ymwGJjtDuRyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyDpDEj3lgxiZDVLSH4aZbUy8KR5zH2xe2BNaJ+VgaZMwjR3OnTmtowJ0oVo9NGeLpxArSt/mTsMyAfbVW/ZtvSK86esGYe2FtwLwORm9h9mWQjbIcg0hxnN0krTfhAEQWPP1mJsefDwVNb08NTYPBg3hgSlpgjfuhxUZ/3aaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH0xt+ih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH0xt+ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24837C4CEE4;
	Fri, 21 Feb 2025 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158589;
	bh=V1paQJI3fuQXQW0tz9RfPG8PyquOUM5ymwGJjtDuRyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dH0xt+iheEcvqG9re9SmGaZI8oK8h4AeiiAcVKpVztJNa07yMsJDmZSu8VSY+9kIe
	 CkMDntSbQXJt+lBl4rpV6QJbG2NwjvNzGd57GoXoxAuUfw9AQbYGDfYCRAB7vvtIwv
	 EyJAjVW9Biwyb2wZxU2SWYK5IP6dmgbA6Hhgx7wZY9nOyZ5RHoQSt2t0jC9X4OF6Ed
	 l/syV89Q4vpW/pmRZSnVlFHySgV6+M9O9v81SBQSxEYsMQSz31sKOYg4S0vv8LzuCU
	 yMmmGzAekxEoavDkxYf+pKkkE66gW8zKIAKuqxILfW0yo+ThYg/d9lmbhFZL8KwGZ6
	 N6l+ingEencMg==
Message-ID: <0cc8475a-248e-4a07-93db-7381199c4eaa@kernel.org>
Date: Fri, 21 Feb 2025 18:23:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 1/9] mptcp: pm: use addr entry for
 get_local_id
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
 <aebbbe7e861ff37a7f5225e8cccda396c56011ea.1740019794.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aebbbe7e861ff37a7f5225e8cccda396c56011ea.1740019794.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/02/2025 03:57, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
> to "new_entry" is not allowed in BPF if we use the same code to implement
> the get_local_id() interface of a BFP path manager:
> 
> 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> 	new_entry.addr = *skc;
> 	new_entry.addr.id = 0;
> 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> 
> To solve the issue, this patch moves this assignment to "new_entry" forward
> to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
> both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 11 ++++++++---
>  net/mptcp/pm_netlink.c   |  9 ++++-----
>  net/mptcp/pm_userspace.c | 17 ++++++-----------
>  net/mptcp/protocol.h     |  6 ++++--
>  4 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 16cacce6c10f..94620ab172b7 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -403,20 +403,25 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  {
> -	struct mptcp_addr_info skc_local;
> +	struct mptcp_pm_addr_entry skc_local;
>  	struct mptcp_addr_info msk_local;
>  
>  	if (WARN_ON_ONCE(!msk))
>  		return -1;
>  
> +	memset(&skc_local, 0, sizeof(struct mptcp_pm_addr_entry));

Detail: do we need memset? Can you not initialise it to 0 instead?

  struct mptcp_pm_addr_entry skc_local = { 0 };

> +
>  	/* The 0 ID mapping is defined by the first subflow, copied into the msk
>  	 * addr
>  	 */
>  	mptcp_local_address((struct sock_common *)msk, &msk_local);
> -	mptcp_local_address((struct sock_common *)skc, &skc_local);
> -	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
> +	mptcp_local_address((struct sock_common *)skc, &skc_local.addr);
> +	if (mptcp_addresses_equal(&msk_local, &skc_local.addr, false))
>  		return 0;
>  
> +	skc_local.addr.id = 0;
> +	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +
>  	if (mptcp_pm_is_userspace(msk))
>  		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
>  	return mptcp_pm_nl_get_local_id(msk, &skc_local);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d4328443d844..0a0fe890c53d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -1159,11 +1160,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
>  	if (!entry)
>  		return -ENOMEM;
>  
> -	entry->addr = *skc;
> -	entry->addr.id = 0;
> +	*entry = *skc;
>  	entry->addr.port = 0;
>  	entry->ifindex = 0;
> -	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  	entry->lsk = NULL;
Small detail: is it still needed to reset all these info (except the
port number)?

If I'm not mistaken, now all the "entry" should be set to 0, no?

>  	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
>  	if (ret < 0)
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

