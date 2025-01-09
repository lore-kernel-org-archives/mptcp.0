Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B514F98
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437077; cv=none; b=rL/NEMIm96HYp6vMxU7D0upgxow2tuz9hqgu/BH5S2JycxwEQxJHdjCd3kSYSuDLAPQw99UUEsSt5TYLHs1hF6cRfIbVSDfNkNcgKlk0xv2vbMzgUwI2aCkzUt2WbatQs6A+neZijIzf9W8vSWdIWISSPKf2S+9Xy/Z72gNq14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437077; c=relaxed/simple;
	bh=1tNufiSXZlJANJgiq805hGcvNXgJwHkkIZlPuutk95A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rm+dxgwwtLXs9ymL7lp3IZg2RNAlelURka88xcaQlJg0zRTUDKj/blo9Nx0DQgcT0zPdh26/nZZ9od3brqgofSP31BhaoDS19kL2NttpFf1q8qqHFKRNfPNL4cseL5x4htGORiaVZmCS8HQlwU2HgVEB4XDb9rIVPyZRCwTCRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e25XSTnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e25XSTnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D3C4CED2;
	Thu,  9 Jan 2025 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437076;
	bh=1tNufiSXZlJANJgiq805hGcvNXgJwHkkIZlPuutk95A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e25XSTnBy5q+7ze4DznFgxHgnL+sbe3sF3orTWynQhrvF0vBLURDpeW61JY+qThxH
	 uOV3TJ7FCbk38+hJ3Mum3Ytjpsh43ZaoWegIbC3jtcRHddgkK9lunHeFQvklEWMMdM
	 /tef9P5EBnHoCvzkAOUgqTbPxcv3VGz/EcNkm7xuh9TPYvrQjm8mbOAqE01bXM/Yf9
	 fIjHYMIp2Havgr3+bvhRhqlebKSZbW4ZH4YiO6J8rWhe/sr0yGLBMwTEV7t2jHencZ
	 ePKv0jWU1GFudh7FOWcOlAW7PfOaVCE2E1wGTXdsSj3X9xnroWxN5ooUJTy7r7AY/T
	 Pz4rym1UtOn5g==
Message-ID: <41184f6c-cc2c-4059-831b-baccca1cc5f4@kernel.org>
Date: Thu, 9 Jan 2025 16:37:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 7/8] mptcp: add mptcp_pm_addr_id_bitmap_t
 type
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
 <789602f25f9fc73043f85417b6e147c49d894b66.1734074788.git.tanggeliang@kylinos.cn>
 <0a9019be-238d-4b02-ae7e-b510503ff6ac@kernel.org>
 <e0bf78833216705521b8c0e4c696d39f1efba53b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e0bf78833216705521b8c0e4c696d39f1efba53b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 09/01/2025 05:15, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-12-30 at 17:30 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 13/12/2024 08:35, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Similar to defining types such as nodemask_t, dma_cap_mask_t and
>>>    A. > > cpumask_t to simplify the use of bitmap, a new type for
>>>       MPTCP
>>> userspace pm id bitmap, mptcp_pm_addr_id_bitmap_t is defined to
>>> easily modify dump_addr() interface of the path managers to accept
>>> an mptcp_pm_addr_id_bitmap_t type parameter. It also allows this
>>> parameter of dump_addr() can be modified by BPF program when
>>> implementing this interface of a BFP path manager. Because a
>>> dump_addr() interface that accepts an 'unsigned long *bitmap'
>>> or 'unsigned long bitmap[]' parameter is difficult to implement
>>> in BPF program.
>>>
>>> In addition, this also makes it easier for us to implement similar
>>> logic to mptcp_userspace_pm_append_new_local_addr() in BPF path
>>> manager, because there's no way to use DECLARE_BITMAP macro in BPF
>>> program, and it's not easy to reimplement it in BPF.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  include/net/mptcp.h      |  7 +++++++
>>>  net/mptcp/pm_userspace.c | 14 ++++++--------
>>>  net/mptcp/protocol.h     |  3 ---
>>>  3 files changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>> index 814b5f2e3ed5..220b1f60e8c1 100644
>>> --- a/include/net/mptcp.h
>>> +++ b/include/net/mptcp.h
>>> @@ -120,6 +120,13 @@ struct mptcp_sched_ops {
>>>   void (*release)(struct mptcp_sock *msk);
>>>  } ____cacheline_aligned_in_smp;
>>>  
>>> +/* max value of mptcp_addr_info.id */
>>> +#define MPTCP_PM_MAX_ADDR_ID U8_MAX
>>> +
>>> +typedef struct {
>>> + DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
>>> +} mptcp_pm_addr_id_bitmap_t;
>>
>> Why do you need to declare it here and not in protocol.h? Is it for
>> the
>> future BPF PM?
> 
> Yes, it's for the BPF PM. If we define a struct mptcp_pm_addr_id_bitmap
> as in the previous version [1], we can indeed put it in protocol.h:
> 
> struct mptcp_pm_addr_id_bitmap {
> DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
> };
> 
> and just declare it in include/net/mptcp.h:
> 
> struct mptcp_pm_addr_id_bitmap;
> 
> But as your comments in [1], 'why do you need a
> specific structure with only one field?'
> 
> This new version uses 'typedef' to define a new type, similar to
> nodemask_t, dma_cap_mask_t and cpumask_t. I think this is a good way to
> handle structures with only one field. But on the other hand, we can't
> declare a 'mptcp_pm_addr_id_bitmap_t' in include/net/mptcp.h, we need
> to move the entire typedef to include/net/mptcp.h, and the
> corresponding MPTCP_PM_MAX_ADDR_ID also needs to be moved together.
> 
> Which one do you prefer, mptcp_pm_addr_id_bitmap_t or struct
> mptcp_pm_addr_id_bitmap? I will use it in the next version.

My question was more to know why BPF is not happy if the struct or
typedef is declared in net/mptcp/protocol.h instead of include/net/mptcp.h.

If really it has to be declared in 'include', then maybe better to add
the minimum (struct mptcp_pm_addr_id_bitmap;) and the typedef in protocol.h.

>> Maybe you don't really need this bitmap if it is only needed for the
>> dump interfaces that are probably not needed with BPF?
>>
>> Then maybe there is no need to change anything here?

Regarding these two questions: why do you need the bitmap? If I'm not
mistaken, the BPF PM doesn't need to implement the 'dump' and 'get_addr'
interfaces: no need to expose this to userspace via netlink if the PM is
handled in kernelspace with BPF, no?

A BPF PM can expose what it wants via BPF.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

