Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF63314B4
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117260; cv=none; b=r3JKYycJUjlo91ZxqU1/qbyHhgxo/jbEl7yPiYT8+SHNVutVhvgixImHGao+WbOEzLwcLsBMPLOrBV39nTN9Q+fudmKx6+12I1gn5PXF+6y3hhSIxuzJkGwbnAxXQ6WNGFPOk+hqRJpLjpq+lS8o6IW0KHOfTbv5pbtKurzkUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117260; c=relaxed/simple;
	bh=ltcgHlC3MRT12wdsdBssD5T1kDVzRL5N9kVJwmLAVWg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cgqxzx0+RPErRYABWkVE+AujvZcSKSKSw63FVOlnedm71vxmhelQ6DXHK4BHyNuIJdc7KTrPKZLKa9Ld4tlbQA4bYvz0zbNHZp8+29+4iOjxSfVMce20htSHcJdWkasL8n4NOzNulTlMjSWhFrLNoEXPLE37hyg6TBm2+uP71FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQu6CBMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQu6CBMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19277C116D0;
	Tue,  3 Feb 2026 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117260;
	bh=ltcgHlC3MRT12wdsdBssD5T1kDVzRL5N9kVJwmLAVWg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qQu6CBMY7eHVd7pshuXqgusIBay97f18xo+p4RMFixSobNN75LAPrSrpVrEh5HzE2
	 Oq3xME+8UcS1IjFxhMN0J0lrEOeF3tF2oVwGyDXl6tLe3ntGII9KvvOcmkZhnj8AXo
	 cEygv5lWHVrIIjuKZORtETaYqgqR8rHGjOyHTYzL4e7j2KbqpJ/6ObS6ecs9A3DJYQ
	 24yVsN0JpDebghe3aZRPohnU0erZwH2P5WQyaw+t60mVFLVbeG0ooO3BK4APv+8QYg
	 CfQOVBuYvCCpzLfQ1cN0smO/fOu+8TfMWw4U7zq1dqyZhzJC1iOeVTlSY3JV35p4CV
	 KVR327XGfipmw==
Message-ID: <8ee8b5cb-0673-49bf-a2dc-f5855516f65c@kernel.org>
Date: Tue, 3 Feb 2026 12:14:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: allow overridden write_space to
 be invoked
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
 <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
 <9a2ce3981452685fe178892d0631b289b8d55e01.camel@kernel.org>
 <3a02e802-56c6-4c99-8f7d-aa618a8f46b7@kernel.org>
 <19b28307eb2492546fbf363ede5856447e4fe06d.camel@kernel.org>
 <f6bbb80f-0c08-4c28-908f-6d7422a990c6@kernel.org>
 <b21ef1e4-5d3d-4e12-aade-4ac94d18be26@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b21ef1e4-5d3d-4e12-aade-4ac94d18be26@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2026 12:13, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/02/2026 11:56, Matthieu Baerts wrote:
>> On 03/02/2026 11:31, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for your reply.
>>>
>>> On Tue, 2026-02-03 at 10:42 +0100, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 03/02/2026 07:54, Geliang Tang wrote:
>>>>> Hi Matt, Mat, Paolo,
>>>>>
>>>>> On Sun, 2026-01-04 at 13:29 +0800, Geliang Tang wrote:
>>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>>
>>>>>> psock may override its own sk_write_space functions. This patch
>>>>>> ensures
>>>>>> that the overridden sk_write_space can be invoked by MPTCP.
>>>>>>
>>>>>> Note: This patch was initially included in the NVME MPTCP set.
>>>>>
>>>>> This patch was initially developed to resolve the "timeout" errors
>>>>> observed in the NVMe MPTCP tests described in [1], because NVMe TCP
>>>>> overrides its own sk_write_space. During subsequent development, I
>>>>> discovered that not only NVMe TCP overrides its own sk_write_space,
>>>>> but
>>>>> KTLS and psock also override it. 
>>>>>
>>>>> Therefore, this patch is needed in all three series. To reduce
>>>>> dependencies between these three series, I propose to merge this
>>>>> patch
>>>>> into the mainline first.
>>>>
>>>> Just to be sure, when you say "mainline", do you mean our MPTCP tree
>>>> with the export branch?
>>>>
>>>> Because we are at the end of a cycle here, my priority is to flush
>>>> patches that are ready or fix issues. If I'm not mistaken, this patch
>>>> is
>>>> needed for new features that are not in our tree, not in net or net-
>>>> next
>>>> trees, right?
>>>
>>> Yes, it is needed for new features. In this case, merging it into the
>>> export branch first is also an option. It can be sent to net-next in
>>> the next cycle. I plan to submit the KTLS series and the NVMe series to
>>> the KTLS and NVMe communities for feedback respectively. If this
>>> write_space patch enters net-next early, it would be more convenient.
>>
>> I see.
>>
>> Is only this patch 2/3 from this series needed? Or the whole series?
> 
> I just applied this patch (only this one) and I will try to send it this
> cycle.

New patches for t/upstream:
- d8af4a2b24b5: mptcp: allow overridden write_space to be invoked
- Results: 9577d6866c4a..a5bb737958a3 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/9dd2299cd09c36fd30169ecf0f0d984746c0ea66/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

