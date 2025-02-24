Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C2505B8
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394797; cv=none; b=Ubk9PdWvwfc09mQZud+djd4z0X51seyrmi/5Vkmz47uf16VHlUGQ1x/rojStNwc+9WHqO1RC9RsNVsQuI+Ya5PyKREdhJLmYqIZsRdIMWw34o5Z27RVMqJcy4vFgeerPe9svWCjMH/F2W4eQS6rfpQ7EyX4FY8Lfu1yo9vsJ/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394797; c=relaxed/simple;
	bh=goVXGq1PZ3sG+/KtpM4PaHWrhGb8z1QQs7GmaQ31bMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osm88XhgnXnBCf4fVrI3EuAUVe7vb5Gh9vEZo/UhkSiYJMw5gM540vH+c3BWKALdUVn3CjamKtps48pXWQ4gQTnYU1HCZPGlEHpLaUNZIrkcwznpiIwMKjplAKtdb6J77rdiZeISEYtZfq84E+6FnaK4XSX6oaTqysUP0VENFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX2m21Zz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX2m21Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC629C4CED6;
	Mon, 24 Feb 2025 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740394797;
	bh=goVXGq1PZ3sG+/KtpM4PaHWrhGb8z1QQs7GmaQ31bMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sX2m21ZzPMOpkDyReta4uBS+9wubSY28Zqwhgm5Ro7wFT1GwbrS52RaIsUXW1XUq/
	 Yo/3OBhnBJXrPriWny7idji7hDDcqFrWP3wGFJP7LB2HV3KdOeS6PHaPRW20tot+Fk
	 gNANxHybyOlfSNw1bzoKcddvPtDw6vLdChnd2CtrzP+hgfH+EjHYicyWreebCPgOAd
	 THmt/cYxRv974TxrOuvgVvSt3x51yA49IUOxUnz7SK/8XpnQNE/FS+expyS4tK51lz
	 tacsNawrrSoE4gdBmVQRbV4FdIvNdDPKLCsHUCwwpXxfdc22DwuCkKsBO7YM0DS1h+
	 +niCoPHPZWw8g==
Message-ID: <22c007d7-f60f-4469-b193-1c2bad4a7273@kernel.org>
Date: Mon, 24 Feb 2025 11:59:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 5/6] sock: add sock_kmemdup helper
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
 <0a3f7a31983f0587ace333f349f3e630c49d075d.1740384564.git.tanggeliang@kylinos.cn>
 <f40a2f15-7735-4131-8087-e5e1f1382f69@kernel.org>
 <bdcc04eab97f31bab5c9d09b2a5458a827774662.camel@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bdcc04eab97f31bab5c9d09b2a5458a827774662.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2025 11:42, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for the review.
> 
> On Mon, 2025-02-24 at 09:54 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 24/02/2025 09:13, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch adds the sock version of kmemdup() helper, named
>>> sock_kmemdup(),
>>> to duplicate a memory block using the socket's option memory
>>> buffer.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  include/net/sock.h |  1 +
>>>  net/core/sock.c    | 23 +++++++++++++++++++++++
>>>  2 files changed, 24 insertions(+)
>>>
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index edbb870e3f86..ffd757e7e329 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -1793,6 +1793,7 @@ static inline struct sk_buff
>>> *sock_alloc_send_skb(struct sock *sk,
>>>  }
>>>  
>>>  void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
>>> +void *sock_kmemdup(struct sock *sk, const void *src, int size,
>>> gfp_t priority);
>>>  void sock_kfree_s(struct sock *sk, void *mem, int size);
>>>  void sock_kzfree_s(struct sock *sk, void *mem, int size);
>>>  void sk_send_sigurg(struct sock *sk);
>>> diff --git a/net/core/sock.c b/net/core/sock.c
>>> index 0d385bf27b38..d09bd697c120 100644
>>> --- a/net/core/sock.c
>>> +++ b/net/core/sock.c
>>> @@ -2805,6 +2805,29 @@ void *sock_kmalloc(struct sock *sk, int
>>> size, gfp_t priority)
>>>  }
>>>  EXPORT_SYMBOL(sock_kmalloc);
>>>  
>>> +/*
>>> + * Duplicate a memory block using the socket's option memory
>>> buffer.
>>> + */
>>> +void *sock_kmemdup(struct sock *sk, const void *src, int size,
>>> gfp_t priority)
>>> +{
>>> + int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
>>> +
>>> + if ((unsigned int)size <= optmem_max &&
>>> +     atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
>>> + void *mem;
>>> + /* First do the add, to avoid the race if kmalloc
>>> + * might sleep.
>>> + */
>>> + atomic_add(size, &sk->sk_omem_alloc);
>>> + mem = kmemdup(src, size, priority);
> 
> I made some updates to this patch here.
> 
>       mem = src ? kmemdup(src, size, priority) :
>                   kmalloc(size, priority);
> 
>>> + if (mem)
>>> + return mem;
>>> + atomic_sub(size, &sk->sk_omem_alloc);
> 
> Then sock_kmalloc() can be implemented through sock_kmemdup(), which
> can reduce the duplication of code between them.
> 
> void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
> {
>       return sock_kmemdup(sk, NULL, size, priority);
> }

Yes, looks good.

I was thinking about not modifying sock_kmalloc() by calling it from
sock_kmemdup(), then calling memcpy(). So similar to what kmemdup() is
doing. But your version looks good.

>> I'm not really convinced by this helper: it is a duplication of
>> sock_kmalloc(), and it is only used once in MPTCP code.
> 
> I found that this new helper can also be used in
> mptcp_copy_ip_options() too.

Indeed.

>> Calling sock_kmalloc() + memset, and using this new helper in
>> different
>> places in the net code might help. But still, I don't know if this
> 
> And there are three other places in the net code where it can be used:
> 
> 	ipv6_dup_options()
> 	sctp_v4_copy_ip_options()
> 	tcp_ao_copy_key()
> 
> That way, this helper can be used in five places.

Indeed, that's what I saw when I quickly looked.

>> would
>> be accepted, it is only saving one line (plus memcpy() will be used
>> when
>> it is not needed, same for the previous patch at the end).
> 
> What do you think of this new version?

Yes, it might be OK, but I don't know if that kind of cleanup would be
accepted by netdev maintainers. Then, do you mind sending a dedicated
patch (or series) introducing this new helper and using it in the
different places to the netdev ML with the appropriated reviewers added
in cc, please?

>> If you still want to propose that, I suggest sending a dedicated
>> series
>> to netdev, not to block MPTCP (only) patches. WDYT?
> 
> Please remove the last two patches from this set if others are ready to
> apply.

Yes, I can do that.

I will not apply patch 4/6 as well, because the modification is similar.
I will first wait to see what kind of feedback the netdev maintainers
will give.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

