Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1F63B1
	for <mptcp@lists.linux.dev>; Thu, 28 Dec 2023 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNlZk/nY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41CEC433C7;
	Thu, 28 Dec 2023 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703756658;
	bh=XvJa7Gqy/C1BMEXq0ECCyJgNHqxqxhMiw/pq3ppGfWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GNlZk/nYONwCnp4kQOqawCDQ7KOBS497rdoHlbjG+sE6638VkL1N6lk4mgozrYSMe
	 xQ8iVDguCALsIpaWwe0XIwliHvhOxOIippbMoUsooExRRpajJF5XQybKxD9J3e9w4h
	 3uuBX7x5ZpJD6Q/2UY+NOwa3vjcjLR4FPMwmSHDste/HHiwZeBLiRj/bRKcQexG3tT
	 fR1GjYjUnE8NQpjBIyOFeJOCQuUTbgZawJUmN5ZGPEyxdVDKQ3r6jM7BoVWbvlRHZe
	 ArmEQe8sLshCKpdMaPH7eneZI2hlTf2ZP2X2dHSx5SXLdIdb75ug4OIrHunCyhlvme
	 xM91BSGrIGWbA==
Message-ID: <c22d8a90-8b52-4518-8e46-d270f9988c7a@kernel.org>
Date: Thu, 28 Dec 2023 10:44:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v14 00/25] userspace pm enhancements
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
References: <cover.1702029538.git.geliang.tang@linux.dev>
 <2f9f4b7b-d8ea-40ad-97e3-61d1e767ceb4@kernel.org>
 <ca9fb0ef220d57b2da0b33ce825d452409e1598b.camel@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ca9fb0ef220d57b2da0b33ce825d452409e1598b.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 28/12/2023 03:31, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2023-12-27 at 12:38 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 08/12/2023 11:07, Geliang Tang wrote:
>>> v14:
>>>  - implement flush operation in user space as Mat suggested.
>>>  - update selftests.
>>>  - Now this series includes five parts:
>>>
>>> Part 1: dump for userspace pm (patches 1-9)
>>> Part 2: fixes for creating id 0 subflow (patches 10-13)
>>> Part 3: v4-mapped addr support (patches 14-15)
>>> Part 4: flush for userspace pm (patches 16-18)
>>> Part 5: address entry refcount for userspace pm (patches 19-25)
>>
>> For tracking purposes, which patches can we drop on Patchwork?
>>
>> https://patchwork.kernel.org/project/mptcp/list/?series=808195&state=7
>>
>> - Part 1: If I understood correctly, patches 1-9 are supposed to be
>> replaced by a new series "dump for userspace pm", right? Then can we
>> drop patches 1, 2 and 5 from Patchwork? (Patch 3 has been marked as
>> "Rejected", I guess that's OK.)
> 
> Patches 1, 2 and 3 can been marked as "Rejected".

Done!

> Patches 4-9 can been marked as "Changes Requested", they will
> been included in the next version.

I marked these patches (except patch 5) as "Superseded" because there is
already a new version if I'm not mistaken: now part of "dump for
userspace pm" series, right?

Or maybe patch 5 has also been replaced by another patch?

>> - Part 2: does it depend on part 1, or can it be applied separatelly
>> in
>> -net because they are fixes? Or at least the modifications in the
>> code,
>> the selftests tests could go only in -next if it is difficult to get
>> them in -net.
>>
>> - Part 3: Is it also a fix? I mean: did we forget to support v4-
>> mapped
>> addr in one command, but others have this support? Can it be sent
>> separately to -net?
> 
> Yes, patches 10, 11, 12, 14 are fixes. They don't depend on part 1 but
> will conflict with part 1. I'll make them a new series for -net.

Thank you, so we can send them to -net and have them backported in
stable versions.

>> - Part 4: it is not clear to me if they were needed? They have been
>> marked as "Rejected", but please tell me if they are still needed and
>> just the title here was wrong.
> 
> Patch 18 can be marked as "Changes Requested". We can test flushing
> addresses in userspace in it.

We can indeed check that it doesn't affect addresses from the userspace
PM. I just marked it as "Changes Requested".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
