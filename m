Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA642BDC32
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648438; cv=none; b=AjZYP0BPJHBkOGVgdmbkmISnUPHLazY0rXgYdD7+pyt/vmAeIANW7QswcKb7WxCl6pVybp1G+hvgYZLkMSjBjiu5iGcbJb98pCh2j1Yt03MB94W1+L6QiK3LJzB3eNvUKPaC3BYnAouCtUxTY8KGTB7ftesqcmfgGB5J86bObPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648438; c=relaxed/simple;
	bh=5yJLkCyK/x2ht3SPdiI2h4PS+8TgQaSk09vZvKxSVMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6oJ1xu4t+J15YF2jO9g/TjgRT+ygTCtESIzr5DvE6X3QQGZSf5I9d2k2HpKK9b+STZFgMdj2xrGxLqd6Xh0hYX2Hk9i+ZwLat1ZIVeT6NBpnSJ29XIYD8QE3uhFcgtYDPSymzIUhIbbud0jUkzI/8Ls8zSO7AgFte+vqnkfrow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJb5Ar5V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJb5Ar5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED8C2BCB4;
	Fri,  1 May 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777648438;
	bh=5yJLkCyK/x2ht3SPdiI2h4PS+8TgQaSk09vZvKxSVMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DJb5Ar5VWxIdQuCjr+wKp9tAVdW5K9SR5yH0mzOp/+IG9hYs83oBYZJfqWY8WuC/t
	 9GTdqazX1mQtHmh6eS2kzAmOSjJlUTn3qSS9Fwu4VnUEUP48YTfeu9lHyPgS+yPfOq
	 Iioi4g7rWWZQwhp03fg6Ps2jkmQa9i44J7PmN/+ZD9de99z59+imRwBo6TqF0FX/DI
	 g2yELiN5dFofGDbiTK4z7gKNvN7LjcsHMxngH+dHfSsnT9WJsJSPJu+UieKlnuHHQZ
	 mVooqTwfhiL5J0zzESnQ+bcrJRld8kdQb67pzmR9HiDhGT9Q/zGvweKABCLCqVMsca
	 xwPGv3yf8Fmbw==
Message-ID: <4792fa80-2485-47bc-9c50-0526c2f23484@kernel.org>
Date: Fri, 1 May 2026 17:13:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space insufficient
Content-Language: fr
To: Li Xiasong <xiasonglee@gmail.com>
Cc: mptcp@lists.linux.dev, weiyongjun1@huawei.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, Li Xiasong <lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
 <177755524215.1566930.3209225574765644709.b4-review@b4>
 <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Li,

On 01/05/2026 17:03, Li Xiasong wrote:
> On 4/30/26 9:20 PM, Matthieu Baerts wrote:
>> On Thu, 30 Apr 2026 19:20:25 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:

(...)

>>> @@ -881,24 +889,47 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>>> [ ... skip 26 lines ... ]
>>> +			goto out_unlock;
>>> +
>>> +		if (*echo) {
>>> +			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
>>> +		} else {
>>> +			skip_add_addr = true;
>>
>> Even if I don't think we would have space issues with the echo, should
>> this variable also be set also in case of ADD_ADDR echo?
>>
>> (In this case, the variable could also simply be called 'skip', or
>> 'drop', similar to the MIB counters here.)
>>
> 
> My current understanding is that the skip marker is only required for
> the non-echo ADD_ADDR path, because that is the one tied to the local
> ADD_ADDR retransmission timer flow.
> 
> For the echo case here, it looks more like a reply path to a received
> peer ADD_ADDR, so on option-space shortage, clearing the signal bit and
> accounting the drop might be sufficient.
> 
> But I may be missing something in this area — if you think echo should
> also go through the same skip handling, I can align with that in v3.

Indeed, you are right, I mixed thing up: when an ADD_ADDR echo is
received, the timer for the linked ADD_ADDR is stopped, but no timer
needs to be stopped when sending the ADD_ADDR echo. So no need to change
anything here.

>>> [ ... skip 13 lines ... ]
>>> +	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
>>> +	 * clear the signal bit, cancel the matching retransmission timer, and
>>> +	 * let the PM state machine progress.
>>> +	 */
>>> +	if (skip_add_addr)
>>> +		mptcp_pm_add_addr_skip(msk, addr);
>>
>> If you have to modify something else, maybe the new helper is not
>> needed, and the code can be added here directly? I know I suggested the
>> introduction of this helper, but now that I see the code, I think it
>> would be easier to understand the new comment above without it, and to
>> backport this patch.
>>
> 
> Agreed. I'll likely inline that logic to keep the change simpler and
> easier to backport.
> 
> FYI: I’m replying from my personal address during the holiday period, as
> I currently don’t have access to my corporate mailbox. I’ll keep
> following up on this patchset and send v3 shortly.

All good, no hurry here.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

