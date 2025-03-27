Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC527FBA1
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074891; cv=none; b=BFez+mAc4TOylyVxCb1SfGHgAFTeZPmk/U0lbeRplb5LAKLmQNVsGuzjkMBIkgItaNQv5hLKNV/+BKjpuiZAotOaao24j1vNozz6iLGV423tgL+FFz68wuQ2wgeSEfz35IcLwo/bd/2NwnsvNuIoNUe8ZUrCFYlJUSqDIEERWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074891; c=relaxed/simple;
	bh=HoCHVhcaT5kg78GkAgKlDjTp59TU8Mfzei0BYme60t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6RIW25zxnDzEtRUASdALOjXkZpHtCLLXclqfhMHKv1uektWRKamdt8exCyZu0XjX4sRDgssAynRc0tW/9ukt82x4PUPbBQEyXTgTDVEa/D6XFix+XtUjUgZYv3XaSdniV3pB/JfZFbNT1KUKwYyZt0yTMN38G3FPi4z3cSwlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOwofVxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOwofVxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEA1C4CEDD;
	Thu, 27 Mar 2025 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743074890;
	bh=HoCHVhcaT5kg78GkAgKlDjTp59TU8Mfzei0BYme60t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JOwofVxFRz3GBR79a7pBwfi12un6bqLIIG8SrIVEmlukOrWGUF802569wQovwKmyc
	 NR0520cAMd40GwKWJLQJN8ujonFsBmaw4D1tFzBUHwcyglququx3A2jKsDir5zZemd
	 nZmEcBz6pPjQZTxtDdCc6+1Glyp96v6bwrHevRusQH2JEHCh7VxpfkWQsQOZJZjC1c
	 Z+MbSU0ugEA1I/s6oScr4lCKp9t3e2k6a211pKU9nwgEYgiFmVmkeeizGB30RWkmTh
	 oabb58uOTmUs8vaC1ymd48gr4jMM+aTscHRLONzmCoXPSBLsQIWj4bHV8tAAnqc4a5
	 oSAVNHE45aFtg==
Message-ID: <1d540cc3-d239-400f-ba72-c485a10a9c08@kernel.org>
Date: Thu, 27 Mar 2025 12:28:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 4/7] mptcp: pm: update pm lock order in
 mptcp_pm_worker
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
 <739e3667698915fa690d08c751c1846bd9442df2.1743054942.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <739e3667698915fa690d08c751c1846bd9442df2.1743054942.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/03/2025 07:04, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Later functions that cannot hold the mptcp pm lock will be called from
> the PM worker, so this patch modifies the order of holding the lock
> at the beginning of this function and releasing the lock at the end.
> 
> The new order is to obtain a copy of pm->status while holding the mptcp
> pm lock, then read the copy after releasing the lock.
> 
> For each PM status flag, hold the lock, clear this flag of pm->status,
> and then call each handling function before or after releasing the lock
> as needed.
> 
> Finally, hold the lock before calling __mptcp_pm_kernel_worker() and
> release it afterwards.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c72d2fade555..1e681acaad7f 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -932,26 +932,33 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
>  void mptcp_pm_worker(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
> +	u8 status;
>  
>  	msk_owned_by_me(msk);
>  
>  	if (!(pm->status & MPTCP_PM_WORK_MASK))
>  		return;
>  
> -	spin_lock_bh(&msk->pm.lock);
> +	spin_lock_bh(&pm->lock);
> +	status = READ_ONCE(pm->status);

Do you think it would be OK to clear all the bits that are going to be
checked here (or once at the end), using MPTCP_PM_WORK_MASK? Before the
PM lock was released temporally in some sections, I guess it should be fine.

Also you don't need READ_ONCE() here as pm->status is protected only by
the pm lock.

> +	spin_unlock_bh(&pm->lock);
>  
> -	pr_debug("msk=%p status=%x\n", msk, pm->status);
> -	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
> +	pr_debug("msk=%p status=%x\n", msk, status);
> +	if (status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
> +		spin_lock_bh(&pm->lock);

I *think* we should change the way the PM lock is currently handled. For
the moment, we lock very big sections, and not only when it is needed.
That is probably easier somehow, but it might not be clear when it is
locked or not, and required unlock/lock in some other cases.

Changing the lock might have a cost in some cases, but probably a gain
in others. Concretely, here, we should not lock now, and let the callee
the responsibility to do so only when required.

By doing that, all PM callbacks will not be called with the PM locks,
which would make easier to deal with kfunc with BPF.

If you are not comfortable doing such modifications, do not hesitate to
tell us to get some helps. I can try to look when I have a bit of time
if you prefer.

>  		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);

(so this should be done before/after)

>  		mptcp_pm_addr_send_ack(msk);
> +		spin_unlock_bh(&pm->lock);
>  	}
> -	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> +	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> +		spin_lock_bh(&pm->lock);

(same here)

>  		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);

(same here)

>  		mptcp_pm_rm_addr_recv(msk);
> +		spin_unlock_bh(&pm->lock);
>  	}
> +	spin_lock_bh(&pm->lock);

(same here and in the next patches)

>  	__mptcp_pm_kernel_worker(msk);
> -
> -	spin_unlock_bh(&msk->pm.lock);
> +	spin_unlock_bh(&pm->lock);
>  }
>  
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

