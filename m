Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9C1C9B81
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744431; cv=none; b=Cj0e7HPUrrisDwnELDh7NSwCm0Ay8TL6Vj7zLRuJXZ3A9i0Aw3G01J16cbw57iGWIc65u+ceoR3IGAL5R4I2uVjBf9I9rRXFscuOLcolfwzBe2XORdnR2deLtZFgw1eKY3KTh7wsTy9yXCeffZ8Ilzr1qzSkRj6kmTe8SKL/xqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744431; c=relaxed/simple;
	bh=WTBqeCZsUkQ14VH4gMN6q8rIftg9K/j4M7lLTN2qw/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWFWn8jZ65b8kDFiWn8xxTWDDMm51vb/AYmVqBG9TRTcn6LY2l4i91MGsKpfFrBoUAzeDf7obu3W884EHhji+yauBjvZQVgMxkRVgcRN3618ToNLuDTumPQ8VOuVew+FGTo36zEwIRATdww8R5OzIPxFUF+C4gxG3yzq5nzNk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGShyeGp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGShyeGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE9FC4CECE;
	Mon,  4 Nov 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730744431;
	bh=WTBqeCZsUkQ14VH4gMN6q8rIftg9K/j4M7lLTN2qw/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pGShyeGp10XVubdfk7FsOiz610GnhHYZsFzQ/xGehTxtsknPglr1kSK4SAr+jSu6F
	 GbzXmk3mpf8gklHGOzGCh6ehDzBaJkX1N59oY7fN3yhcExvg2ax4Xc496JIDoh7TAv
	 66j6j1OL17dfTrlEPBFTJuHve4K+7q1FI0Mu+YMp1+avdRYUJyaSR+tFQtVI9swivH
	 ZX14juypDyoyJuxLNLRdR9XyT+xsWMPJNCAgV919coL1GcMPTom41VQtckCHD395Cn
	 VWeF9FEwrc591JGeNP9nprO5v2fjpkKFWnWbNIyAv21DbNdG3bmLTGSP1N9UfyCaR3
	 xXIThWFgThPrQ==
Message-ID: <492160b7-3854-4990-ad3e-625594593a90@kernel.org>
Date: Mon, 4 Nov 2024 19:20:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 17/36] mptcp: update local address flags
 when setting it
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <7ab7696f338aa9ac73d65439350b38412c2e613d.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7ab7696f338aa9ac73d65439350b38412c2e613d.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the patch.

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Just like in-kernel pm, when userspace pm does set_flags, it needs to send
> out MP_PRIO signal, and also modify the flags of the corresponding address
> entry in the local address list. This patch implements the missing logic.
> 
> Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")

If it is a fix, can you extract this patch, and target mptcp-net please?

When you will do that, you will also need to add
mptcp_userspace_pm_lookup_addr() helper: can you do that in the same
patch, but using list_for_each_entry(), not mptcp_for_each_address()
(nor the new version)? That way, it will be easier to backport the patch
without having to depend on other patches or having too many changes.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d815bfa57532..ec2ac0f9c8f5 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -543,6 +543,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
>  	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
> @@ -574,6 +575,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>  		bkup = 1;
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
> +	if (entry) {
> +		if (bkup)
> +			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> +		else
> +			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
>  	release_sock(sk);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

