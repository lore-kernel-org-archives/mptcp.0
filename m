Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55546AA68
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647936; cv=none; b=Vz9fYYHsWLBvpM/CR4MT3KTPVBCUyYKEbtz1EdDFJ7t0vHyIKEoPrakeIuI9Mbb/re14NpM5lU/G6jda+3pl+du15fQ/PLku3To1WZy/iVckYCXWh7HuJfT5orFhPEVnKFNRptXn3ZlqHKhRXi+Zx7o4Bcl70bIJEtPloT245cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647936; c=relaxed/simple;
	bh=FAouj4DJQsSL177U3PztIpS40g6ZLZq07pNm2m8o5iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=KTdXqddnAqGSXoWvatYd8w8x6WJ1EI0S3tFqmPYiGb8Yc0IDicDsaVx7luYxPIoVDJSRlLwXgyiiHKyV0CrNjTX/8+bXZUAzF3n768qcqEnUkKLYeDS+Wy6bFlwG3D5wFFoJNDzjXUlInhjd2GSs3D9TUfVAbKPv7AYQNIM8Jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MahIJnGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MahIJnGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7BC1F000E9;
	Tue, 21 Jul 2026 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784647935;
	bh=WrYvLMv1hdIePlAKuyeYLDeHqVuCYr+gC4eT/4t81BI=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=MahIJnGsx/7e2GBE8+1A6AocAlprphqZYD5kqJVwv6shB87yNo4C+Xf6Q8SLozJbL
	 7HiUvvCDCOdJr7zkbvObTiuESxx+OnV9BzurWmnTgWJOz0BXtFFFckIjvpYstuCa4c
	 eVMoHHtiq3MpiFObB3XIw5Xartkhe8QnHpzqWXyS5ffY4NkN1WmUwtAwaQ5B2UAGe5
	 5ktWSuUk00Rgugd/h3VysVjT9tjRWPTTFg5bNtepkyVJxKwAi6LS9J2z2De3Od+b9u
	 8VWYatLfRXJxBWUf6Zfj7tfHYd+PjYyk0jadOi8rmF/OHVjOlYI0jNOlQXqj8g3GDG
	 fhWdjCLh5vC1w==
Message-ID: <061288be-4e92-4060-a7ac-24d329f4186f@kernel.org>
Date: Tue, 21 Jul 2026 17:32:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: fix data race in add_addr timer
 callback
Content-Language: fr
To: luoqing <l1138897701@163.com>
References: <20260717064028.767876-1-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260717064028.767876-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for sharing this patch.

I have similar comments than the ones I sent on:

https://lore.kernel.org/178410664361.3802972.16804879942885801851.b4-review@b4

On 17/07/2026 08:40, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> The timer callback reads entry->retrans_times outside pm.lock to decide
> whether to call mptcp_pm_subflow_established(). Since
> mptcp_pm_announced_del_timer() can concurrently set retrans_times =
> ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

How did you find the bug? Do you have a reproducer or is it by analysing
the code?

Were you assisted by a tool/LLM? If yes, please add the Assisted-by tag.

> Use a local 'completed' flag set inside pm.lock only when the timer
> callback itself increments retrans_times to ADD_ADDR_RETRANS_MAX. This
> ensures that mptcp_pm_subflow_established() is only called when the
> retransmission naturally exhausts.

A fix should have a Fixes tag, please add one.

> Signed-off-by: luoqing <luoqing@kylinos.cn>

For legal reasons, you are supposed to put your full name. Having only
one "word" for your full name, without capital letters looks wrong, no?

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6afd39aea110..ed39a1241ffd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -380,6 +380,8 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
>  	struct mptcp_sock *msk = entry->sock;
>  	struct sock *sk = (struct sock *)msk;
>  	unsigned int timeout = 0;
> +	bool completed = false;
> +	u8 retrans_times;

Do you need two new variables? One should be enough.

>  
>  	pr_debug("msk=%p\n", msk);
>  
> @@ -399,27 +401,32 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  
> +	retrans_times = READ_ONCE(entry->retrans_times);

Why do you require READ_ONCE() here? Can retrans_times be modified
without the pm lock?

> +
>  	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
>  	 * callback. Once cancel updates retrans_times to MAX, suppress further
>  	 * retransmissions here. If this callback acquires pm.lock first, one
>  	 * final transmit attempt is still possible.
>  	 */
> -	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX &&
> +	if (retrans_times < ADD_ADDR_RETRANS_MAX &&
>  	    !mptcp_pm_should_add_signal_addr(msk)) {
>  		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
>  		mptcp_pm_announce_addr(msk, &entry->addr, false);
>  		mptcp_pm_add_addr_send_ack(msk);
> -		entry->retrans_times++;
> +		retrans_times++;
> +		WRITE_ONCE(entry->retrans_times, retrans_times);

Same here, why WRITE_ONCE()?
>  	}
>  
> -	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> -		timeout <<= entry->retrans_times;
> -	else
> +	if (retrans_times < ADD_ADDR_RETRANS_MAX)
> +		timeout <<= retrans_times;
> +	else {
>  		timeout = 0;
> +		completed = true;
> +	}

Either you have:

  completed = entry->retrans_times >= ADD_ADDR_RETRANS_MAX;
  if (!completed)
      timeout <<= retrans_times;
  else
      timeout = 0;

(preferred)

or

  if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
      timeout <<= retrans_times;
  else
      timeout = 0;

  retrans_times = entry->retrans_times;

But I don't think you need to have both "completed" and "retrans_times".
With only "completed", you can minimise this patch.

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

