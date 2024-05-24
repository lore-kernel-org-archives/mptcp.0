Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11C2BAF3
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562214; cv=none; b=n3P4JGr5dQTPSZnFNye9YiJKQufSI7HgvM+wPA95Qs1BhoeOmOEWDx/fYSr37K5B5QVRk1GNbYsR9TnKKpxTL7TXAnd5NujeuGbAatGTcRKUTV7Apa5OsMLSO9LAETDZsPHVijLrNb36ZhyJKwP0gwKASSxGGVSU57Lx532nA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562214; c=relaxed/simple;
	bh=dK1GuSAjxuvT7odI/RCcfZzZiEJ0WPbi0udC8yYYtBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcTDo0C8X4qB1UYt2jK+3LeL8NDDoPEClAiIgy5gq218SapAfx7tN1lx8OqT6/J6Gq6iLf8uGXpmlyqiUaWLGp2CUU24grp2iM6cZ+EyOOlvZPEx9TpIvlrerDvsrZgacOQsTc/Lcb7mt2BrfGt17Qq56qmuNZ/9m8l4ZcZ3+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDvsY4vD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDvsY4vD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B16DC2BBFC;
	Fri, 24 May 2024 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716562214;
	bh=dK1GuSAjxuvT7odI/RCcfZzZiEJ0WPbi0udC8yYYtBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDvsY4vDt7B0O+6w1bE7EirRq9Nka453ET80r67+Jre2Cs66i9cNE3MuXGMW4kLhy
	 KWEmASeZn//iCa1Nu9iKvNCEXHRPZnEtUMXUb42G5k3tVO+ZQUh5/LGW3lTbTgFXiE
	 eZ39fdMSiQoxPgSiG8lv8hkMZaXq51I4MhyMjjctr8A807wtuHDYLs0oNla7sYhJ/t
	 8g204CXEAt8//TMaW6ZhAmTKHHQ9/mbNoXlE4WscCeppiBiJZy50l7qhsrT8RdAk0G
	 b/vUbV1pW+sk+jE8ZnMx7g5FzI57nCc8xFZC8v2dwZ4B4n6CIMHHqElHvSTVgcP0RH
	 ZYMyTcGqkmA3A==
Message-ID: <d7f1de2a-b1a2-4a00-869d-a1c6dc9240a7@kernel.org>
Date: Fri, 24 May 2024 16:50:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: make RMADDR MIB counter clearly
Content-Language: en-GB
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: geliang@kernel.org, mptcp@lists.linux.dev
References: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yonglong,

Thank you for sharing this patch!

On 23/05/2024 09:56, Yonglong Li wrote:
> From: YonglongLi <liyonglong@chinatelecom.cn>
> 
> it should inc RMADDR MIB counter when received RMADDR but didn't
> find any subflow related,

I suggest using this text instead:

 The RmAddr MIB counter is supposed to be incremented once when a valid
 RM_ADDR has been received. Before this patch, it could have been
 incremented as many times as the number of subflows connected to the
 the linked address ID, so it could have been 0, 1 or more than 1.

 The "RmSubflow" is incremented after a local operation. In this case,
 it is normal to tied it with the number of subflows that have been
 actually removed.

WDYT?

> 
> Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
> 

There should be no empty lines here between the Fixes and the SoB tags.

(I can modify the commit message when applying the patch, no need to
send a v2)

> Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/pm_netlink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7f53e02..766a840 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>  			spin_lock_bh(&msk->pm.lock);
>  
>  			removed = true;
> -			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> +			if (rm_type == MPTCP_MIB_RMSUBFLOW)
> +				__MPTCP_INC_STATS(sock_net(sk), rm_type);
>  		}
>  		if (rm_type == MPTCP_MIB_RMSUBFLOW)
>  			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
> +		else if (rm_type == MPTCP_MIB_RMADDR)
> +			__MPTCP_INC_STATS(sock_net(sk), rm_type);

The modification looks good to me.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

It would be good to modify the selftests to avoid any regressions later,
and to cover this case. But I'm not sure how to reproduce your case
where a RM_ADDR is received but for an ID that is not being used by the
PM. Do you know more about your case? Maybe because the subflows have
just been removed?

The issue to reproduce that in the selftests is that we cannot (easily)
send a RM_ADDR for an ID that is not currently handled by the PM (if I'm
not mistaken). Probably better to do that with Packetdrill [1].

What we can do instead, is to have subflows reusing the same ID multiple
times, e.g. using the fullmesh PM. Before the end of the connection, we
can send a RM_ADDR for an address that is used for multiple subflows by
the other end. Then we can check that the counter has been decreased
only once. That's what I tried to do, but I got another issue, see [2].

[1] https://github.com/multipath-tcp/packetdrill
[2] https://github.com/multipath-tcp/mptcp_net-next/issues/492

>  		if (!removed)
>  			continue;
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

