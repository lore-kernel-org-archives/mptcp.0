Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F713BB669
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713652; cv=none; b=Ns/6ENK/aQvfTT8JsVCN1YU1X/iIzQAQJKsRtM4IZCGVWYZCGXBjDKw4wng55hq8doPVZwvfmuqypaEG0VsiVHRk7ULy5a4/y8mhdALNtyUmyEgiYgS2tyNDosJsyVQN97hrF9rTHyw0SxdXGKt1ExfXYy/pwH/tozYeiblzEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713652; c=relaxed/simple;
	bh=QeO97ZIO7emLFfNcWEC2hsJkhpp6OOwkz1s5Ze9MNuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=AZgV07CbmsLGzQrNjBkqiBnTHu85dhqYs7nPBDAxk+BJJ88OMFqef0efu6XWKySkekRGGzJlfjfHk4N0Nxdfu8wgPWXiGbWO5UXx/1AWWeZ+4bRq6R51TFqXa0rd8OS/ktFanDiel9XaF6UHRMfLAwLDQ/uzzeLprjKUp47X2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfVpcKje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfVpcKje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC591F000E9;
	Wed, 22 Jul 2026 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784713651;
	bh=MEubWisO+48ECouDsMZ4yxUlX/rB6LbFom3oJshY/8w=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=SfVpcKjeVlNcL0tDsgqJEo+LQwOujxE6tsFtuIlV/u8DDWuVL0tRMdBuovW0lmCWI
	 iBN3EJQn2Q0Cve3hPnNGOWbTzMm4ZPMje+F7oCTWtIWIyb1Ecans0wxQdv8w+Z13sn
	 7CP7Hw6Pbm1A3QYdY33jWQsve3FGTg92NWwH6URmCWGKM4uq1N0zitLEVWvdLCFz+X
	 0U/B0z+iw3tx6uBj3DnBejqGqekYfN0yo/foNiMXkvFPedD6yZtorwS2QQc6WFg7xL
	 LUiSdIWS6tgvgZALVVe3Z8BiKhUsBgK7mUpkAxUv8TxPM7DjCphCHQBQkbHS/M/rPJ
	 istLgWEB6MxRQ==
Message-ID: <da4b96a3-c7ba-4444-bc41-96760e5ee08d@kernel.org>
Date: Wed, 22 Jul 2026 11:47:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: fix data race in add_addr timer
 callback
Content-Language: fr
To: luoqing <l1138897701@163.com>, mptcp@lists.linux.dev
References: <20260722091311.1218738-1-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: Qing Luo <luoqing@kylinos.cn>, GangYan <gang.yan@linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260722091311.1218738-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Qing,

Thank you for the new version.

On 22/07/2026 11:13, luoqing wrote:
> From: Qing Luo <luoqing@kylinos.cn>
> 
> The timer callback reads entry->retrans_times outside pm.lock to decide
> whether to call mptcp_pm_subflow_established(). Since
> mptcp_pm_announced_del_timer() can concurrently set retrans_times =
> ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

Don't forget to reply to each question from previous reviews ;)

How did you find the bug? Do you have a reproducer or is it by analysing
the code?

Were you assisted by a tool/LLM? If yes, please add the Assisted-by tag.

> Use a local 'completed' flag set inside pm.lock when retrans_times
> reaches ADD_ADDR_RETRANS_MAX. This ensures that
> mptcp_pm_subflow_established() is only called when the retransmission
> naturally exhausts.
> 
> Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/mptcp/pm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6afd39aea110..f93fefbb727e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -380,6 +380,7 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
>  	struct mptcp_sock *msk = entry->sock;
>  	struct sock *sk = (struct sock *)msk;
>  	unsigned int timeout = 0;
> +	bool completed = false;
>  
>  	pr_debug("msk=%p\n", msk);
>  
> @@ -414,12 +415,14 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
>  
>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>  		timeout <<= entry->retrans_times;
> -	else
> +	else {
>  		timeout = 0;
> +		completed = true;
> +	}

Here, you still have the checkpatch warning Gang reported:

  CHECK: braces {} should be used on all arms of this statement

To avoid all these modifications, I think it would be better to have:

  bool completed;

  (...)

  completed = entry->retrans_times >= ADD_ADDR_RETRANS_MAX;
  if (!completed)
      timeout <<= entry->retrans_times;
  else
      timeout = 0;

Or maybe better with the opposite:

  bool retransmit;

  (...)

  retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
  if (retransmit)
      timeout <<= entry->retrans_times;
  else
      timeout = 0;

  (...)

  if (!retransmit)
     mptcp_pm_subflow_established(msk);

By doing that, you only need to modify the if conditions, not the "else"
parts.

>  
>  	spin_unlock_bh(&msk->pm.lock);
>  
> -	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
> +	if (completed)
>  		mptcp_pm_subflow_established(msk);
>  
>  out:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

