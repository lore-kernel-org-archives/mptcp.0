Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C811D6BB
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041222; cv=none; b=KsZUMgbT1cLZpt1rSfSj54DbJcf3S0aQV10ogoQrG5kKyqUkdBEwzI0D+kZ7xW312X6wfMSRO72/uFScQ6Lyrh37eR9z51lSu86oVlhtjSyjGlc/PO7MRGADaH7vlgaDHnurx66oL4ldqfRofSnmcCHp9rA1q4y1xaG7SR63470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041222; c=relaxed/simple;
	bh=/PcWtkGs3xwRrpEHNd8PsTEICTq6/TReEXdHXawWhK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUWeaBPshTymRe90agnrdcDaAkKbXNCKC+Xjf9rVVYlO4xfoKNhRuMMpvpXtbP1QbfkGYcUNcIrl+ng3y7QtTaJWqNn+iBOO5qANLT3SiOu0M2Q4AYb8Go+zi+pWSfVhFq9GG+PPP9b61a0gFUG/SXrnP0v2GDEvtzyT1KMG/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGkUoqlT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGkUoqlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0571F000E9;
	Fri,  3 Jul 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783041221;
	bh=gCne4FqkAZIgIQzSmq1Ic2ACUZqMUNalSFkyoVljbHo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HGkUoqlT210AQMZeE2O1zdd8iFnMuXQsryL6ASS0oQoFucXSQZxvg2ZRE50I6xpac
	 +3UIUxqjsur+1EQM68GGE8H0oKRmm44EJemeYtioHls8klDtCXAXDdLKXgpyhqO18d
	 e8UUNBbDytuM9Czl/YWSWxDDB/dm99rYgHIBvLKOtz8sdLM3JVRz5YyNaxY9ocoOCn
	 egVVpFssxVA1vkZh+Ntltes/tzuG4WbHY3IwCHQny2VGX92bpQMQpLwiJozPJpgSJa
	 A9SU8bnLC+9ybqHJZRoDEfXTjDPWcR50wmQrA+5upaB/V5cAUlnCmOGhscKmFFBgQ/
	 e1tGn9USSXwoA==
Message-ID: <753354dacb35348baa71a80e7ee21460fa2d119f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3] Squash-to "mptcp: pm: init and release
 mptcp_pm_ops"
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Fri, 03 Jul 2026 09:13:37 +0800
In-Reply-To: <20260702063002.127027-1-gang.yan@linux.dev>
References: <20260702063002.127027-1-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

Thanks for this v3.

On Thu, 2026-07-02 at 14:30 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch removes the need to handle a NULL pm_ops in the fallback
> path, and moves the rcu_read_lock\unlock into mptcp_pm_ops_init.

The commit log doesn't match, but since this is a squash-to patch, it
may not be necessary to update the original commit log when merging.

Anyway, this patch LGTM. I've changed its status to "Queued".

-Geliang

> 
> Following sashiko's comments, it also moves the pr_debug() before
> bpf_module_put() in mptcp_pm_ops_release.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9dc7b41fb562..033f783d4990 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1137,12 +1137,13 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  	spin_unlock_bh(&msk->pm.lock);
>  }
>  
> -static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> -			      struct mptcp_pm_ops *pm_ops)
> +static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char
> *pm_name)
>  {
> +	struct mptcp_pm_ops *pm_ops;
> +
> +	pm_ops = mptcp_pm_find(pm_name);
>  	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> -		pr_warn_once("pm %s fails, fallback to default pm",
> -			     pm_ops->name);
> +		pr_warn_once("pm %s fails, fallback to default pm",
> pm_name);
>  		pm_ops = &mptcp_pm_kernel;
>  	}
>  
> @@ -1161,9 +1162,9 @@ static void mptcp_pm_ops_release(struct
> mptcp_sock *msk)
>  	if (pm_ops->release)
>  		pm_ops->release(msk);
>  
> -	bpf_module_put(pm_ops, pm_ops->owner);
> -
>  	pr_debug("pm %s released\n", pm_ops->name);
> +
> +	bpf_module_put(pm_ops, pm_ops->owner);
>  }
>  
>  void mptcp_pm_destroy(struct mptcp_sock *msk)
> @@ -1185,7 +1186,7 @@ void mptcp_pm_data_reset(struct mptcp_sock
> *msk)
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
>  	rcu_read_lock();
> -	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
> +	mptcp_pm_ops_init(msk, pm_name);
>  	rcu_read_unlock();
>  }
>  
