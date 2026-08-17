Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F66427FA1
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980750; cv=none; b=LkdSkH9kXyrGHJkWAkDNXMUL9OcPQTtIseGVaqjmdpkZ9IwphXHqXj3owgVNqyqe0GoXm9i/ETZbmnrfd/mJ+z0F/dabjTdOQc1Tf3GEIIe/KDXEZ3ssxjdc1k7SIQejb9mTxhGxlzzr7SpA6ydQBgCyMNjzQH0bHASaZ3CtQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980750; c=relaxed/simple;
	bh=Rv2EJ6v8FtRjZ7BP1/spXiooAQVOc8ZrcgJGcgRC+v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUnH9/vsABIaGLdxy1FPiPxf/HgZvfWZBBqRjF1ODJklpU5TiU9L5gVK+Ymh7w4EtHOltf6RsCZpAWJWbndmcujGudchNoLfIQ8wA4993wChLvp7emTxNaSD65fapNZIBuNhs30IuELY2biy8c3V/qvnTRYAMd73SsFcGcPunzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDbQJnn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDbQJnn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C623A1F000E9;
	Mon, 17 Aug 2026 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980748;
	bh=ULiR9uoCkdZRA1ABfuzlhACiuALh8ACJSElS2eeBVM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dDbQJnn/B8ZANTleq7h+aInc1Tc1H6fpmi/QXtmeL6W4LbaF/YS0rQCkPz2YDAE3S
	 1Y5EbMjcKH9TOvuDVYhftQs8JCtXrVDNWxzcOtVAzTLq2q+bIs8aObIp31Hh5MpKSF
	 D2VWLxjs6javiXdVfQahr8xOsYwJ7CvzrwSWkgtsKEWInlETwPfyP8JtIl2DvOKzLX
	 SYFafOlgU2E5CWSshpchl8Jl9CWuSZzUKlxBNvnUQwa98EGSG//zUQnlgbHHi6ISf9
	 CVQFyGYDu7Zjja0wE3Fzsq9V5jj0c16YX2MPfy5rFOlUEnCKXs9S5WjJKYWJ+7NfLd
	 I/fhG/55OznKw==
Message-ID: <58c90e83-2cf1-44f2-80fb-1803a9d1af1c@kernel.org>
Date: Mon, 17 Aug 2026 17:32:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
 <d1a6a67f-41c0-4650-b62e-6a4476bab86b@redhat.com>
 <2e2b6eff-0d2c-40b9-b66c-f650bb5d1104@kernel.org>
 <d8a12a12-de80-4283-937f-b3ae49171d66@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d8a12a12-de80-4283-937f-b3ae49171d66@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/08/2026 15:09, Paolo Abeni wrote:
> On 8/17/26 1:07 PM, Matthieu Baerts wrote:
>> On 17/08/2026 09:39, Paolo Abeni wrote:
>>> On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
>>>> When iterating over each MPTCP connection after having manipulated MPTCP
>>>> endpoints, there is no need to operate on closing (or not ready)
>>>> connections.
>>>>
>>>> We can then safely skip those.
>>>>
>>>> Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
>>>> fully_established state, but it is better to check the connection state,
>>>> which is what mptcp_is_fully_established() is doing.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  net/mptcp/pm_kernel.c | 16 +++++++++++-----
>>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>>> index d3014bf57bf3..c185e53fe42b 100644
>>>> --- a/net/mptcp/pm_kernel.c
>>>> +++ b/net/mptcp/pm_kernel.c
>>>> @@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>>>>  		struct sock *sk = (struct sock *)msk;
>>>>  		struct mptcp_addr_info mpc_addr;
>>>>  
>>>> -		if (!READ_ONCE(msk->fully_established) ||
>>>> +		if (!mptcp_is_fully_established(sk) ||
>>>>  		    mptcp_pm_is_userspace(msk))
>>>>  			goto next;
>>>
>>> I'm a little double-minded here.
>>>
>>> The add/removal operations are issued by the user space to update
>>> subflows, as a consequence of endpoint addition/removal.
>>>
>>> Possibly removing the subflow even for not fully established connections
>>> could be the right thing to do, I'm not 110% sure either way. Possibly
>>> worth to call this out with a comment?
>>
>> Indeed, I'm also not sure. Initially, I only converted this
>> READ_ONCE(msk->fully_established), also because later in
>> mptcp_pm_create_subflow_or_signal_addr(), mptcp_is_fully_established()
>> is used.
>>
>> Probably best to stick to this one.
>>
>> On the other hand, I just noticed that there is no check for "fallback
>> done" here: so the operations leading to a notification (ADD_ADDR,
>> RM_ADDR) will send a dup-ACK (pure ACK without MPTCP options), and
>> adding an MPTCP endpoint will lead to... the creation of a new subflow,
>> even after a fallback, e.g.
> 
> Sorry, I was not clear enough. I'm specifically doubtful WRT the remove
> operations (i.e. mptcp_nl_flush_addrs_list,
> mptcp_nl_remove_id_zero_address,
> mptcp_nl_remove_subflow_and_signal_addr) and _not_ vs the 'add' one
> (mptcp_nl_add_subflow_or_signal_addr). I'm fine with the check change there.

Sorry, I think it was me not being clear enough:

- In mptcp_nl_add_subflow_or_signal_addr: use mptcp_is_fully_established
- In the others (flush, 2 remove): check only msk->fully_established

To avoid acting on fallback MPTCP connections, should we target patch 1
(reset fully_estab after a fallback) and this one here for -net?
Or only patch 1?

>>> Also the asymmetry with the user-space PM is a bit strange. I can't
>>> recall why it was needed in the first place?!?
>>
>> Are you talking about all the mptcp_pm_is_userspace() checks? If yes,
>> they are required because the pm_type sysctl could be changed, and we
>> could end-up with a mix of msk handled by different PMs in the same
>> netns.
>>
>> It would be better to do the opposite I guess:
>>
>>   if (!mptcp_pm_is_kernel(msk))
>>       goto next;
> Yup, I prefer the check this way more.
> 
> My doubt is that user-space will allow creating subflow even for not
> established msk.

It shouldn't: in __mptcp_subflow_connect(), it will return early if
mptcp_is_fully_established() is false.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

