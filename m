Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799110;
	b=U5HyMrKsrp2tr3PRh7JQXzLxkYihOwf2PJG5NMccZz1Hv9BRK486coCciNCnz0fSBUlU
	 nK5R3s0SaCt0CGoNga+3adSjE5P41DwwpEMBpBW1R2OeeE0/yccYUC6b4bgn2JqsVblrR
	 1Q54L8V9YVrohGzT3ac/twqc8VSJ4g4feYHM/eDAdHaMjywfEtBmnNXrEjGMssDDUS4bN
	 gKWZiIcCEXhvBMMLIevC+4r6nYpeBU4iqTAoy+HTQFsx+Y/8wj2flNgj0lQfHiUoY+D+L
	 nbw0hbvRzULZ3IPIN5MF9m1WKs2V3m1Jlcl15WIluHWavF8Q5ejD6u93GteKZEz9/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799110;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=s0o3D+PmBGoyfGPorsJgKVylCQEgoQ5lUAcayUAABEc=;
	b=e0liBg6z7twjqrOop80zB2KU0sOL3hRWQCLbEF+p7FYmef5jlAtc4rJzinYki/07BY8D
	 rXJwQyRwY3Tv0WeHidR9dFwSD4hxp4F5vhgVzYh8JLx73Feb/e3w16oK28lUWNTjMGgy2
	 Zrmyr3P766Yi9zTtmiGIZ2og3vaPHdM6zWFJbFMv1pBLnDV5iwdxM+EgviPdrGoO26H1s
	 inqNVo7ooJRQf5ksVNnV2kRJBmCPPT2iGhSq8mfb3k6vLKWLBTzr6swxvnpyXPuD1rOqR
	 TerGtAHn1OGqDnqEjAjKyVpsGPI3gCvb6EjFFGF5MJjIKmlr4xiCCRx0lSwBm8suqqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM3ujoDm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4234606A31F
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM3ujoDm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8161F01825;
	Fri, 23 Oct 2026 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792799109;
	bh=s0o3D+PmBGoyfGPorsJgKVylCQEgoQ5lUAcayUAABEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kM3ujoDmYVc0NGefj54k2PDMOULJRToXJITlXZM/QZNJFhrhpF247YidNsICWFa41
	 rHI7sdKIukWqdEolKZ7bv4/6xND0hCqwsMRHiOICtjbrIRdErLweZ9CVLk/MV0QKmz
	 yrQAjCWylA58YPIHZxi8jEQJrNh+PHDtiZim4lFENHQbw4Z/TwlOLEUS8PfrvbfqwD
	 PQrXCfhF9C4wn1GxIOw48OH5PN144owEsCJFlpVYzp//jsTusvPdY4z9yRYxNXtcSB
	 /+dJE3sJS5NPm1sHLZsDyzdxm713oN6IZNy9HxhN0GYk0IwJ+XvAl+JIFYSSCuhREi
	 Lp5CC3qUv8hIQ==
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: kernel: c-flag: mark as used only
 when it is
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, yimingqian591@gmail.com, kuba@kernel.org
Date: Fri, 23 Oct 2026 23:45:08 +0000
Message-ID: <179279910840.3132.11347843926681774689@kernel.org>
In-Reply-To:
 <20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org>
References:
 <20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The subject and first paragraph of the commit message describe
  a different fix from the one in the code.

--

mptcp: pm: kernel: c-flag: mark as used only when it is

This patch changes fill_local_addresses_vec_c_flag() so that
local_addr_used is incremented before the address family check. The
counter then stays consistent when endpoints are removed. Without this,
removing endpoints could decrement local_addr_used below zero and
trigger a warning in __mark_subflow_endp_available().

Closes: https://lore.kernel.org/20261006114409.117190-1-yimingqian591@gmail.com

> mptcp: pm: kernel: c-flag: mark as used only when it is
>
> The ID was marked as used before checking if it could actually be used
> in all conditions: if the families match and the local endpoint is not
> the one linked to the initial endpoint.

[Severity: Medium]
Do the subject and this first paragraph match what the diff does?

In fill_local_addresses_vec_c_flag(), the bitmap update still happens
before both checks, and the patch does not move it:

    __clear_bit(local->addr.id, msk->pm.id_avail_bitmap);

    if (local->addr.id == msk->mpc_endpoint_id)
        continue;

    msk->pm.local_addr_used++;

    if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
        continue;

So an endpoint whose family does not match the remote address, and which
never gets a subflow, is now counted as used in both id_avail_bitmap and
local_addr_used. That is the opposite of "mark as used only when it is".

The code itself looks right. select_local_address() returns the first
subflow endpoint that still has its avail bit set, so the loop has to
clear the bit to make progress. If it skipped mismatched endpoints
without clearing their bit, the loop could spin forever on the same
endpoint.

The actual fix is keeping local_addr_used in step with id_avail_bitmap,
which is what __mark_subflow_endp_available() relies on. Only the final
paragraph ("increment local_addr_used similar to ...") says that, plus
the v2 changelog below the "---", and that changelog is dropped when the
patch is applied.

Could the subject and the opening paragraph be reworded to describe that
instead, something like "c-flag: keep local_addr_used in sync with
id_avail_bitmap"?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..fb611c4b3eb8d 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -584,13 +584,15 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
>  
>  		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>  
> -		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
> -			continue;
> -
>  		if (local->addr.id == msk->mpc_endpoint_id)
>  			continue;
>  
> +		/* Increment before checking families, similar to non C-flag */
>  		msk->pm.local_addr_used++;
> +
> +		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
> +			continue;
> +
>  		msk->pm.extra_subflows++;
>  		i++;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74%40kernel.org
