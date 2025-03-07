Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1351AF4C1
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337642; cv=none; b=DBcjgfM6OgBHiglIeysY/b8QiVmrlHnrNW80K5WJ3gyGT8RxVnTbgQR1oL1VL+9CE6GNsT+TI0SUTeb58oTGIJXfYixvkYUEPOYlG2V/+yuDBBLFtUe3YURj54US/aFi23guLV4jdcDYig+tTexarUJiOk8Xp9VWrAoZw1n6pgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337642; c=relaxed/simple;
	bh=bTLqLfcjBRnAQg5oaWwlHVhzQ3CP4FYNpgCRA2BECzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxeu6PH8tqxtukgPhs3YsrPdZZMSfGaU5ELREdkFYLqZ1eovd14Ifh9I5w194JTrQMWgZubhynRGw5Q9LaMdzMqM26diBqZSrS5BVeR7HbgW3YF02XA9c10LlBfk5TdDNwlaLXYKaRWYu0nc2XbqISxtqOBpVMqZz7jssBijoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljC15m+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljC15m+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8FBC4CED1;
	Fri,  7 Mar 2025 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337641;
	bh=bTLqLfcjBRnAQg5oaWwlHVhzQ3CP4FYNpgCRA2BECzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ljC15m+noiqmB343o5cwjNJDad1mqcCOIX9a6x63UVOlrIn+eBJYENwuET392W+E0
	 UN9hWUTW1fVz8956BrAy+92NdwDjNfjTtNudliJEWVBU9adpU2s65Qylt/ZylaJ55n
	 hf0NY+0ZS2K4ieN2PCvvm5MX2HXSLt9NyhJs5XQ1aiOdLO8TJSjCnAUiLWrNk4x+zL
	 K0WCM1dFf3MIVmEAJNLxJzWKw0uOudKS17GfmhAaeQms/X3+/WelElvEwSOBTT/Iop
	 EjSMNapSwj2Ym0JsqsaGwIHXv+dBNJohkXV9BIwCWlqqQWkI3CmMyQL8ye/gvdmIYj
	 Cdq8njHCfQ1Hw==
Message-ID: <620b17f1-a5eb-4f9c-b411-92277d8bb3dc@kernel.org>
Date: Fri, 7 Mar 2025 09:53:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 2/5] Squash to "bpf: Extend
 bpf_skc_to_mptcp_sock to MPTCP sock"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
 <c43f5e1fe8da4db01749ede9d18af1a3a2134fd4.1740997925.git.tanggeliang@kylinos.cn>
 <b45a0591-597a-46cf-7315-cf4dce7dbd7a@kernel.org>
 <7691b3bbc2cc5e9507a4187877e4cd821a73744b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7691b3bbc2cc5e9507a4187877e4cd821a73744b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/03/2025 04:54, Geliang Tang wrote:
> On Mon, 2025-03-03 at 17:37 -0800, Mat Martineau wrote:

(...)

>> The code above will set msk->bpf_iter_task even when the lock is not
>> held, 
>> and then it is never cleared.
>>
>> To set/clear as expected for get/setsockopt I think the task pointer
>> would 
>> have to be set in places where the locks are acquired and released,
>> like 
>> these:
>>
>> https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1955
>> https://elixir.bootlin.com/linux/v6.14-rc5/source/kernel/bpf/cgroup.c#L1846
>>
> 
> The get/setsockopt scenario is a bit complicated. I think we can use
> the bpf_iter_task check only for bpf schedulers, keep the
> get/setsockopt scenario unchanged, and continue to use the
> msk_owned_by_me(msk) check. What do you think?

I think in any case, it doesn't hurt to keep msk_owned_by_me(msk) for
lockdep.

If we think it is difficult to have the bpf_iter for both CG
[gs]etsockopt and struct_ops, then we can also drop the patches for the
[gs]etsockopt.

Or, from a kfunc, is it easy to check if we are called from a struct_ops?

> In addition, I think it's better to add bpf_iter_task to struct
> mptcp_sched_data instead in struct mptcp_sock, since it's more related
> to mptcp scheduler. For specific usage, please see [1]. What do you
> think of this?

Please see my reply to your comment on this thread. In short, we can
always add new parameters later, when we need them, no?

https://lore.kernel.org/706a3051-8328-4321-8eea-71d4120ea996@kernel.org

> 
> Thanks,
> -Geliang
> 
> [1]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1739788598.git.tanggeliang@kylinos.cn/
> 
>>
>> - Mat
>>
>>> +		return msk;
>>> +	}
>>>
>>> -	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
>>> -		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>>> +	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
>>> +		msk = mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>>> +		mptcp_set_bpf_iter_task(msk);
>>> +		return msk;
>>> +	}
>>>
>>> 	return NULL;
>>> }
>>> -- 
>>> 2.43.0
>>>
>>>
>>>
> 
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

