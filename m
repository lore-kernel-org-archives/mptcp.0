Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC50248F57
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958526; cv=none; b=VixpkelUGg3Koe4sS7iUWyNoNdp61IGOx3M42Zj23/ZNTFySgVeW72Lwqyp4neY5kA4ScViE9Ud3kBub96485OR+j25qS5/SVwNzAKeM5MD0FJwL1z+Y+iBtJG4tVcW+eyhAkVmJlmTws/whn1e2ao3mJZphjjD0atOLHFhnxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958526; c=relaxed/simple;
	bh=TqWaTiYAQOl3rBwjQkr+itdws0qbo9i9BU8xWO3PTGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKz4G+OWjSG19sZwuYbs3xFsugA07Zpl8EYBKunT0LWZ971oA7w52K6jqJJLLSwAsnGc2JtaVc+ecgaRGm1BS28nG8mHJ4QLZxtFm3wG1UC8Bvwsk6uVJMigSOoOfvDDX8BDWwaQFYvOuswI9Y8FFUAlHUnQrJ0zV9Z5/KMKBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q50xxlRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q50xxlRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05751F000E9;
	Thu,  2 Jul 2026 02:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958525;
	bh=09F9aqNVg7DsJmehdLGJRsFMqf09QRNYyCRP5vOtxHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q50xxlRbrIOnC2c8zV3xI9Y6XkCow0ll3vz/Jtuz3Yq2RSIYRQOp6whIlswIwaBxw
	 XlUmFYZbHgxjWJqgcffSWg/JBS3L8Um9zu7d3NxDXwDLDZaFzEMB8stAaW+Q/zJ+oD
	 RCkzPo4y1Ha+iWUzR2dYWilZ/+62MHv9T4gHsiX7uRm0iAEbKwNRcnJWdR/IqlZYvI
	 lw4uROqOUwZL90FLCsYTtlTccSLX9/6dV/mOLUcpBIH7s4Rr3CofUo3hmXGLCd/uyO
	 qBvQ+ktpQ4wFOE0T8DYvUdFmYU38FfVBEuA+4jfXOVDRNSV3TXyWfltbRUoaYksBLc
	 mgxFTItLUxMEA==
Message-ID: <e35e67705a9c50e30ad5486e197162501d9cf90a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] Squash-to "mptcp: pm: init and release
 mptcp_pm_ops"
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, Gang Yan <yangang@kylinos.cn>
Date: Thu, 02 Jul 2026 10:15:18 +0800
In-Reply-To: <20260701073713.197616-1-gang.yan@linux.dev>
References: <20260701073713.197616-1-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

Thanks for this v2.

On Wed, 2026-07-01 at 15:37 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch removes the need to handle a NULL pm_ops in the fallback
> path, and moves the rcu_read_lock\unlock into mptcp_pm_ops_init.
> 
> Following sashiko's comments, it also moves the pr_debug() before
> bpf_module_put() in mptcp_pm_ops_release.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9dc7b41fb562..5fe4276cf895 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1137,12 +1137,14 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
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
> +	rcu_read_lock();
> +	pm_ops = mptcp_pm_find(pm_name);
>  	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
> -		pr_warn_once("pm %s fails, fallback to default pm",
> -			     pm_ops->name);
> +		pr_warn_once("pm %s fails, fallback to default pm",
> pm_name);
>  		pm_ops = &mptcp_pm_kernel;
>  	}
>  
> @@ -1151,6 +1153,7 @@ static void mptcp_pm_ops_init(struct mptcp_sock
> *msk,
>  		msk->pm.ops->init(msk);
>  
>  	pr_debug("pm %s initialized\n", pm_ops->name);

nit: Here we can also print "pm_name" to keep it consistent with
pr_warn_once().

> +	rcu_read_unlock();

Then this unlock line can be moved ahead of the previous pr_debug()
line.

>  }
>  
>  static void mptcp_pm_ops_release(struct mptcp_sock *msk)
> @@ -1161,9 +1164,9 @@ static void mptcp_pm_ops_release(struct
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
> @@ -1184,9 +1187,7 @@ void mptcp_pm_data_reset(struct mptcp_sock
> *msk)
>  	pm->rm_list_rx.nr = 0;
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
> -	rcu_read_lock();
> -	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
> -	rcu_read_unlock();

Or we leave rcu_read_lock() and rcu_read_unlock() where they are,
without moving them into mptcp_pm_ops_init().

Thanks,
-Geliang

> +	mptcp_pm_ops_init(msk, pm_name);
>  }
>  
>  void mptcp_pm_data_init(struct mptcp_sock *msk)

