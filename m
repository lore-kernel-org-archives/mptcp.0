Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180051EBA0D
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552647; cv=none; b=cB3XHXpKa8Ck/5b97BXuFNerXow6GOEWS3YSWG+b6+ZE7ZICvr6Xavv2hVv1xV+qKGka6Bb8dOaV/6S3wxwNr0gtdQeb4CsDzf8qZCVm3j/Q+ic/ryhI4NAQ7ERuJEXTSCRt1E/zHlwwlN53Vsi3PbxBQ4BSjnExpZLBq7kJUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552647; c=relaxed/simple;
	bh=Y0U32QdcTwJD6i1TKQJNOVPIKGdRgpthSSPSiodqWiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0QSLXLaRhQU3jRG5VvTdZzW+J7uBBWeiNcvhZee7/ESk3VCkNzR9FptsbWHn+oIMu7TDaI/SgmMpm7E9yFrNY0y7NnA+cZgCzrfUZ2OxZnz+JtsitGKxh3VKxUOvjenMlwJPjUYysHzlBp5PVxGe48knD4RoK1W7SUsEaoHPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQWIrmGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQWIrmGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93059C4CEE3;
	Fri, 21 Mar 2025 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742552646;
	bh=Y0U32QdcTwJD6i1TKQJNOVPIKGdRgpthSSPSiodqWiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQWIrmGhW7ZKzo+3xC46r7AwUdnUZkqIQgdWLSj/SjVa5PIaHaFiFXO2IzA4jvQT5
	 guGncizu7oapUwTc6QhEf16knDFPow1/3gIKivoc50GqkQJf5WxR3h+8uyxN+aOTK5
	 6mAaWhv85s0A2KNoLr/PXLTLLyHHFPDPqlE4hEfz1svlubpQNrYNlXzI1dxWdjLMB1
	 uUmTouZI+sHd4EB9omxz2yx4+ApisjPbA2Gpd5SFrv40PxQHSm2746zNSHhUkHq+Qh
	 8nn05RQ1LM8iwtlzIhcxgOMecigEt8nhKNK6F38IJll6hs3hUPevYlc1X8y0Qz8Cxu
	 5ZA4fF6/Io9Vw==
Message-ID: <839203dc-922b-4e52-8e92-81a96efbc524@kernel.org>
Date: Fri, 21 Mar 2025 11:24:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 03/10] mptcp: pm: add established()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
 <3f7cfd8a8e45e26e9afacf66f0adc61b9cd9356c.1742521397.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3f7cfd8a8e45e26e9afacf66f0adc61b9cd9356c.1742521397.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 02:44, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a .established interface for struct mptcp_pm_ops, and
> calls pm->ops->established in from mptcp_pm_worker(). Then get rid of
> the corresponding code from __mptcp_pm_kernel_worker().
> 
> Since mptcp_pm_addr_send_ack() is a sleepable kfunc, which is invoked
> by mptcp_pm_create_subflow_or_signal_addr(), .established() interface
> of BPF PM should be invoked by __bpf_prog_enter_sleepable(), which
> can't be invoked under a lock. This patch unlocks the pm lock before
> invoking this interface in mptcp_pm_worker(), while holding this lock
> in mptcp_pm_kernel_established().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h   | 3 +++
>  net/mptcp/pm.c        | 9 ++++++++-
>  net/mptcp/pm_kernel.c | 9 ++++-----
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 9f28ef550e10..d7410f08399e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -124,6 +124,9 @@ struct mptcp_pm_ops {
>  	bool (*get_priority)(struct mptcp_sock *msk,
>  			     struct mptcp_addr_info *skc);
>  
> +	/* optional */
> +	void (*established)(struct mptcp_sock *msk);
> +
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
>  	struct list_head	list;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4895318b94cc..a121c08b456e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -516,7 +516,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
>  	 * be sure to serve this event only once.
>  	 */
>  	if (READ_ONCE(pm->work_pending) &&

For future BPF PM, we will need to deal with this variable. For the
moment, it is not clear, and in-kernel PM specific. I need to think
about that.

> -	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
> +	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) &&
> +	    pm->ops->established)
>  		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
>  
>  	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
> @@ -964,6 +965,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
>  		mptcp_pm_rm_addr_recv(msk);
>  	}
> +	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> +		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
> +		spin_unlock_bh(&pm->lock);
> +		pm->ops->established(msk);
> +		spin_lock_bh(&pm->lock);

Mmh, do you remember why the lock is held? To protect pm->status I
guess, right?

It looks fine to do the unlock/lock, but that's strange if the goal is
to lock right after.

> +	}
>  	__mptcp_pm_kernel_worker(msk);
>  
>  	spin_unlock_bh(&msk->pm.lock);
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 7ec81d5195d4..6d30d5958f0e 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -367,9 +367,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  	mptcp_pm_nl_check_work_pending(msk);
>  }
>  
> -static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
> +static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
>  {
> +	spin_lock_bh(&msk->pm.lock);
>  	mptcp_pm_create_subflow_or_signal_addr(msk);
> +	spin_unlock_bh(&msk->pm.lock);

Maybe we could move the lock inside
mptcp_pm_create_subflow_or_signal_addr(), only where it is needed?

>  }
>  
>  static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
> @@ -1348,10 +1350,6 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
>  		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
>  		mptcp_pm_nl_add_addr_received(msk);
>  	}
> -	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> -		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
> -		mptcp_pm_nl_fully_established(msk);
> -	}
>  	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
>  		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
>  		mptcp_pm_nl_subflow_established(msk);
> @@ -1422,6 +1420,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
>  struct mptcp_pm_ops mptcp_pm_kernel = {
>  	.get_local_id		= mptcp_pm_kernel_get_local_id,
>  	.get_priority		= mptcp_pm_kernel_get_priority,
> +	.established		= mptcp_pm_kernel_established,
>  	.init			= mptcp_pm_kernel_init,
>  	.name			= "kernel",
>  	.owner			= THIS_MODULE,

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

