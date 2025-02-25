Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23EEEA9
	for <mptcp@lists.linux.dev>; Tue, 25 Feb 2025 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457284; cv=none; b=ZxycGQS7IZAFRPYjbZ17HeJqE0E4q7P+sPTBEx5e9vdO4yH9gCl8YIGg1h59/f7XY8hXLTgIihpMCEbFId3cwk6ndS1cE5fIK+T+7LKztUPbAVYF7chCrDW5nvCznKtdVfG/9+G3p+Wai47vFFjTWcSugI0CZq0/x/d82089CB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457284; c=relaxed/simple;
	bh=yOnOyuIgrkElKpWoZ9qQulmz6o89DK9nkn5e0G5657o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVFGRFlcAMa/gdkLoe7bBqEevRh84+zxhFGsTpVEZOu58JPoqlvl6e4QkC9HBUrE9suXgyz3y7/129SRD1FPbOu3qfAeiMiiOvO4IM7huSTOTHIAplj6mR68eDAqq3TW4ENqhqcQCVlJu5TeuG+9tN3Wqr6ibCVhwPUSwIq6Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSiowOn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSiowOn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E8DC4CEDD;
	Tue, 25 Feb 2025 04:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740457283;
	bh=yOnOyuIgrkElKpWoZ9qQulmz6o89DK9nkn5e0G5657o=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MSiowOn9Q3z6+5vJDcadnmURn6EWZEF/5wlIL0g1VnGPTSOM5mLZ5achC1UpGZcuu
	 8s0tCH9okrvKv8Ygla4s5dKkpivFmc+mcpZr6Rv+VSN4Infsyc8OEvanCicSCJg2uD
	 bv5hYjkAUemXoifcvxOl0trZKszfTtdznossgq2/qky1u4kY/oiPmMwtFTKQ/NAZ36
	 RER7SN+pVMYDhbMx23fg/f83FLrgdDU6sK8gWSYkkfYoaicHt6F/ac8TJyulKBP4rn
	 zakd7wjpafTdgmGFK6jy3Ew7pIWTKzPmP4bf2vDH9fw6exvYhQfUH+PnVvcT4Xcoz7
	 YYB63cN9eP6ZA==
Message-ID: <8ccd5c340bb75c8e325c8b8a1207671785cf911d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: userspace: avoid scheduling
 in-kernel PM worker
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 25 Feb 2025 12:21:18 +0800
In-Reply-To: <20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
References: 
	<20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2025-02-24 at 20:01 +0100, Matthieu Baerts (NGI0) wrote:
> When the userspace PM is used, there is no need to schedule the PM
> worker for in-kernel specific tasks, e.g. creating new subflows, or
> sending more ADD_ADDR.
> 
> Now, these tasks will be done only if the in-kernel PM is being used.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - I don't know if this should be seen as a fix. Maybe yes because it
>    was not supposed to do that from the beginning, and it feels less
>    risky not to schedule the worker when it is not needed. I'm open
> to
>    suggestions here.
>  - I'm mainly sharing this patch now because Geliang is going to
> modify
>    these helpers to separate PM specific code.
>    @Geliang: please rebase your series on top of this one (or include
>    this patch if it is easier).
> Cc: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> 16cacce6c10fe86467aa7ef8e588f9f535b586fb..4eabb83328905676759768fb44c
> 859f5682721e3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -138,7 +138,7 @@ void mptcp_pm_fully_established(struct mptcp_sock
> *msk, const struct sock *ssk)
>  	 * racing paths - accept() and check_fully_established()
>  	 * be sure to serve this event only once.
>  	 */
> -	if (READ_ONCE(pm->work_pending) &&
> +	if (mptcp_pm_is_kernel(msk) && READ_ONCE(pm->work_pending)
> &&

I think there's no need to modify this. work_pending is set to 0 by 
userspace pm, for all cases where work_pending is 1, the path manager
must be an in-kernel pm.

So there is no need to add mptcp_pm_is_kernel() check here. Just
checking work_pending is sufficient.

>  	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
>  		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
>  
> @@ -166,7 +166,7 @@ void mptcp_pm_subflow_established(struct
> mptcp_sock *msk)
>  
>  	pr_debug("msk=%p\n", msk);
>  
> -	if (!READ_ONCE(pm->work_pending))
> +	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm-
> >work_pending))
>  		return;

No need to modify this too, work_pending has been checked later in
mptcp_pm_subflow_established:

    if (READ_ONCE(pm->work_pending))
        mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

>  
>  	spin_lock_bh(&pm->lock);
> @@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock
> *msk,
>  
>  	pr_debug("msk=%p\n", msk);
>  
> +	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm-
> >work_pending))
> +		return;
> +

Same here, work_pending has been checked later in
mptcp_pm_add_addr_echoed:

if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm-
>work_pending))
    mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

>  	spin_lock_bh(&pm->lock);
>  
>  	if (mptcp_lookup_anno_list_by_saddr(msk, addr) &&
> READ_ONCE(pm->work_pending))
> @@ -278,6 +281,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock
> *msk,
>  	for (i = 0; i < rm_list->nr; i++)
>  		mptcp_event_addr_removed(msk, rm_list->ids[i]);
>  
> +	if (!mptcp_pm_is_kernel(msk))
> +		return;

This mptcp_pm_is_kernel() is indeed needed.

WDYT?

Thanks,
-Geliang

> +
>  	spin_lock_bh(&pm->lock);
>  	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
>  		pm->rm_list_rx = *rm_list;
> 
> ---
> base-commit: 3716d837622ee1baf6fbe7e6a6a7a3df116e75fe
> change-id: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6
> 
> Best regards,

