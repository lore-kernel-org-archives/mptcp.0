Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521EB4A3D41
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367938; cv=none; b=jX1bAxq6OMF7XMywfw+1K4jK+0u74ck+NO24smPT2DRGtWSpCA4G8KeqcWAhwdsVlTpEyxUasHCk02z++OyStCj82sIDEJNwH7guK1Xeft/E6BCoQMA8SklCmEKWHTGj9JgYRznL7XvwnsRW52tFHkxpejPxToFVN3zVLIkCEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367938; c=relaxed/simple;
	bh=kqfYEGZxepfT2aE0D1oGjeXaD/qQ1VAA2TD+bk5RDJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qomxq89fHai2dv1ZY9+Cg2IR8mOTgpUM/puE6MO3eRsyrHEqbxrj+a4c2x/nCdf/XQPhn0K/rQKmGuva81BqEQS5bAkeEy8weqgHWrFFGATrAUxPNACXwpciK2bxijSGgMT0Ei2BO0O6u8v0FJQNdQ2WTdIpTUAYufoXQA1q/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkV1Lvtf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkV1Lvtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6F41F000E9;
	Wed,  2 Sep 2026 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367936;
	bh=DwmyGJ+9wRemxdvqlRFGLUBmAg6miPq/JbJOjf77SLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MkV1LvtfwQQW/sqFCRYqOMcPrrma78QO+vzO4GnA0X7p8RbynzXWAEJNrNHM+2qcJ
	 IG4MCJbr8KabsXl3X3AMarYtxHDhc5LSxTe0w+QPNYGcah3giou0NxL71F5TF4Q+Kq
	 eHuIXj3fEt/zNzXwrk2DGrXUAxE47jQXObuyD41LFF4j7rlxjKiUX9NLsH4HvVlsNO
	 NOcN+z7Wyncn59Bs8rtFpSxtqzKMsvSG7zhhQjYzrPJwdsekV6jS+QvwM2Gh5TPkZ/
	 lp2QRe324pgwRXIM/kl0iNAwARkE4opftUA7hfBr9hbRZjVfdObTzIyuukKoOMTsk3
	 jRu4XxHRyhpig==
Message-ID: <67a2bdd2-6936-4d1d-8d38-18be961d35c4@kernel.org>
Date: Wed, 2 Sep 2026 18:52:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: pm: cap userspace extra_subflows at
 U8_MAX
Content-Language: fr
To: Quanye Yang <quanyeyang@proton.me>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Tao Cui <cui.tao@linux.dev>
References: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

+ Cc: Tao Cui

On 02/09/2026 17:39, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> The userspace PM increments extra_subflows with no upper bound. The
> field is a u8, so the 256th extra subflow wraps the counter to 0 and
> the next close hits WARN_ON_ONCE().
> 
> Refuse admission at U8_MAX for incoming MP_JOIN and for the Netlink
> create path.
> 
> Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
> Cc: stable@vger.kernel.org

(No need to add stable on patches sent to the MPTCP ML, that will be
added later when sending these patches to netdev)

> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

"Closes:" can be used here.

(...)

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index fab16d953dbf..6d798dd96702 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -427,16 +427,22 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	local.ifindex = entry.ifindex;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	msk->pm.extra_subflows++;
> -	spin_unlock_bh(&msk->pm.lock);
> +	if (msk->pm.extra_subflows == U8_MAX) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		GENL_SET_ERR_MSG(info, "too many extra subflows");
> +		err = -ENOSPC;

Maybe a goto could be used here ...

> +	} else {
> +		msk->pm.extra_subflows++;
> +		spin_unlock_bh(&msk->pm.lock);
>  
> -	lock_sock(sk);
> -	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> -	release_sock(sk);
> +		lock_sock(sk);
> +		err = __mptcp_subflow_connect(sk, &local, &addr_r);
> +		release_sock(sk);
> +		if (err)
> +			GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> +	}
>  
>  	if (err) {
> -		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> -

... to here, not to modify the rest of the code?
>  		spin_lock_bh(&msk->pm.lock);
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);
>  		spin_unlock_bh(&msk->pm.lock);

This part hasn't been fixed on Tao's series [1]. Would it be OK for both
of you if this part of Quanye's patch is added to Tao's v2 series with
Quanye as author?

[1] https://lore.kernel.org/20260831093206.689827-1-cui.tao@linux.dev

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

