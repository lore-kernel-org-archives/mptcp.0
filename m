Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DF2E1C57
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361362; cv=none; b=W96xa0UxbJd+7rgADRdkSlO2bBmGmjidr9DR6lM2XwScOwoI0i4B++7YHlNQFBXCC0/4yXrWr/kVsJha3atevulHOTcAQ/lk3DHczZoqEUZ4vVVfd2JvLmgItP23ptn11Pfvy6OWuUlyo7JwkufyNgMPVnBN4nWjo0/A0KD1Y1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361362; c=relaxed/simple;
	bh=ue3qxDFQQN6OcJIxQJSvmF8VfA6G6B2Ru4sprcfYb9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwhomhHp3+YivdquKRLYcIrOvwOiC+yQvN+x+BV72NIj6kt31YKvWBe3gsTA5buPj9nfgHfp837vnyEDVat4SKKbfw+VN+moZ+s0wwWtqTKRwkR5h+Oi/su5ZmJjne6zN9ijSJwJO+ZBlkrhUZlb2NaZkpQWUlQa4auNYakmfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK5BdVxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK5BdVxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90933C113D0;
	Wed, 10 Dec 2025 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765361359;
	bh=ue3qxDFQQN6OcJIxQJSvmF8VfA6G6B2Ru4sprcfYb9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PK5BdVxsHE8Bk8UMyjOuZJbRUSmfWt5Qrnftl3RQiVlxi+Tz/LsIF7gGuQ5IiPYqM
	 dbDShQV8IWqE324hezXojnS+a2RIqchXeUtiNruRlp0z6fYlnQr2L0zCJOsuYheiSu
	 F0HrVKCADvJXrWmcqBt2w7vgb6IuU6F8CJYrQalefc1Zov7Z3yqdTbIQMO2EbJWnUJ
	 HyVQOHhzvpivh82u+1iB8QyvFfzGxVectd9+pROhJit5H3mi3UkgseVbwZd7GUgMXg
	 vo41s4dldFWbS+cN0ns77RT3mPRpRLiqzL4Fi69i5A5ZbJtyqZcF4BsAAFZd3qzlYJ
	 r/VHGt9ST+vQw==
Message-ID: <6485d73a-6064-4fbe-817f-e23d5b22e1fe@kernel.org>
Date: Wed, 10 Dec 2025 11:09:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: use sk_is_tcp helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1765354225.git.tanggeliang@kylinos.cn>
 <f33c663ae39d50dbca2623822519f5628c04f9f0.1765354225.git.tanggeliang@kylinos.cn>
 <b0db8dd7-a0dd-4673-bfa5-a62ebf8facc5@kernel.org>
 <001cfd6acc587905f0e95b6f2195b4d817a867a6.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <001cfd6acc587905f0e95b6f2195b4d817a867a6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2025 11:04, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2025-12-10 at 10:54 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the patches.
>>
>> On 10/12/2025 09:12, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch enhances the validation by using sk_is_tcp to determine
>>> whether
>>> the socket is a TCP socket. This approach is more rigorous than
>>> simply
>>> checking if sk_protocol equals IPPROTO_TCP, as the helper also
>>> verifies
>>> sk_family and sk_type.
>>>
>>> Note: The modifications in the bpf_sk_stream_memory_free section
>>> should be
>>> squashed into the commit "bpf: Export mptcp packet scheduler
>>> helpers".
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  net/mptcp/bpf.c      | 4 ++--
>>>  net/mptcp/protocol.h | 2 +-
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index b261551f5d1b..372a21b96495 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>> @@ -193,7 +193,7 @@ static struct bpf_struct_ops
>>> bpf_mptcp_sched_ops = {
>>>  
>>>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>>>  {
>>> -	if (sk && sk_fullsock(sk) && sk->sk_protocol ==
>>> IPPROTO_TCP && sk_is_mptcp(sk))
>>> +	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) &&
>>> sk_is_mptcp(sk))
>>
>> I know that BPF has a few extra "hidden" checks: are you adding this
>> because you saw issues where the protocol could be set to TCP, but
>> the
>> family and type are not the expected ones?
> 
> No, let's drop this patch then. 

OK!

> How do you think about patch 2? Is sk_is_msk() a good name? I will
> directly include patch 2 in the KTLS series.

I think sk_is_mptcp() would have been a better name, but it is already
used. It might be good to rename sk_is_mptcp() to tp_is_mptcp(), but I
don't know if it is wise to re-use sk_is_mptcp() for another purpose for
the backports... So sk_is_msk() looks good at the end I think.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

