Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9A1DA0FE
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155890; cv=none; b=SJ25IgAfBKywWEK0TncN4Ul4Soda0QgcM0AJ2K5yWKE+NVrt9hKJlXFSJTnXP6gEhBvmu5b6rPUEMFhFAgniuO6r4dpJsKpMR94yZunUgv+FeroHF/plX/iQleTJhnS7etnCue9rUwnPlTauqllhsx7+0+ZYbM7Z7t6ED4cZrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155890; c=relaxed/simple;
	bh=Lq82igFLt46wobsM4wuI0WMpo4+Bgx+ZNLIT4eLuUcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwF2myQNJsnWcGJz8h8ZNQ2o6sClQ4BbU5YgAFvEe5slr7tqnIJ9rqJwDOBqvgGQjHe0GxmIsIbI9Y5Y/Q4wyjvTYCIJAAqmnNaw/4GNJtB++M9pdEt2GD3TIzUVVg0lsmqKAPF4eT79qOHmiwwEqodRNxMFGtjR6PhgZ23sWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deH53q08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deH53q08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31178C4CED2;
	Mon,  6 Jan 2025 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736155889;
	bh=Lq82igFLt46wobsM4wuI0WMpo4+Bgx+ZNLIT4eLuUcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=deH53q08bgpg6w/U2vaN2C6JJYZ4pMKztomlPy0t4tY3vo2WzQeTV8sMAgHTEQGak
	 FbtTXCrZXUkUqMjZw4Rm+6e/YoJZ2U+do5tF29viRFIwZtDBdBsbvC+1ltbZA3q9CV
	 ovy78+WnL2KkT1rS94H4ekjppguN/3wTgKD7oooGayieOXjDKfp5Zvz5kMAMQ+ylu4
	 Zt+1ucGFHp/JW5vy+Y4mAY3lFUoqaoNe9V73s2JNcGYNtSoSLzhJRJJFyj2zFsxWEH
	 NVS+1zbngKc5U0MedQotFsPHSsAv9K2Etxr4R5hqBHm5TuYIVREBURQfwuRtBy/6We
	 KABakEOg3GLLQ==
Message-ID: <d01d0e8a-5606-4152-aabe-32e4402adeeb@kernel.org>
Date: Mon, 6 Jan 2025 10:31:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 02/11] mptcp: userspace pm set_flags id
 support
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
 <0d06955f697e484c18262a9806520132f07110cf.1736150983.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0d06955f697e484c18262a9806520132f07110cf.1736150983.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/01/2025 09:16, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to in-kernel PM, this patch adds address ID support to set_flags()
> interface of userspace PM, allowing it to work with either an address or
> an address ID.
> 
> When an address ID is used, mptcp_userspace_pm_lookup_addr_by_id() helper
> is used to look up the address entry in the local address list instead of
> using mptcp_userspace_pm_lookup_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 40fd2f788196..60db72060e6e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -577,6 +577,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
>  	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
> +	u8 lookup_by_id = 0;
>  	int ret = -EINVAL;
>  	struct sock *sk;
>  	u8 bkup = 0;
> @@ -592,10 +593,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  		goto set_flags_err;
>  
>  	if (loc.addr.family == AF_UNSPEC) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> -				    "invalid local address family");
> -		ret = -EINVAL;
> -		goto set_flags_err;
> +		lookup_by_id = 1;
> +		if (!loc.addr.id) {
> +			NL_SET_ERR_MSG_ATTR(info->extack, attr,
> +					    "missing address ID");
> +			ret = -EOPNOTSUPP;
> +			goto set_flags_err;
> +		}
>  	}
>  
>  	if (attr_rem) {
> @@ -615,17 +619,22 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  		bkup = 1;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
> -	if (entry) {
> -		if (bkup)
> -			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> -		else
> -			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, loc.addr.id) :
> +			       mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
> +	if (!entry) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		ret = -EINVAL;
> +		goto set_flags_err;

Mmh, you are changing the behaviour here by making it mandatory to have
an entry, and I don't think you can: if I'm not mistaken, with the
userspace PM, it is possible not to find any entries here, e.g. if a
subflow using this address has not been added or the address has not
been announced (I guess the initial address is not there then).

Also, with the userspace PM, it is possible to have an entry with an
ADDR ID == 0.


Do you think this patch is worth it? Setting by ID for the in-kernel PM
makes sense: unique ID for the netns, easier to type the ID than the
full address. While for the userspace PM, it will be managed by a daemon
that will have to track addresses anyway.


>  	}
> +
> +	if (bkup)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> +	else
> +		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	lock_sock(sk);
> -	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
> +	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, &rem.addr, bkup);
>  	release_sock(sk);
>  
>  set_flags_err:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

