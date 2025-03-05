Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8276C61
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138534; cv=none; b=aC0r4h1GNEZ9lJVIZbNi6Bp5oCY0LBjJpyslMrZirpQS5q+v0XweqaaLBHlJXDp0HM1GBOnV6+GP9oasWFUAD5pQncNR7OQP6VaL6VfTgRBG6jI1SemvIBjSVgpi5MU/V514FGaF6LinG5NFLZc46arJApQ/3HXqPW9CVjiKJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138534; c=relaxed/simple;
	bh=YAXg8MxeTTs6tn7iZU3VXJPOI64M3eQPegKmCeL2SNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bT5E21ZzFGepQ9jSIQ32xrYDw03BlqgevbpswoP5O3eE2BTK8DUz5qyjotB6fbSr4SWZnHp+CLB74MSoDCpHbezyfFnxPbZAzDV4UZZ06LFoUJQR/wcMpo1C4KoSerJecddM+5jNS4fxIBiLqLET933VkimJw7LQGeAxAB+yS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IywSpVWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IywSpVWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5415C4CEE5;
	Wed,  5 Mar 2025 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138533;
	bh=YAXg8MxeTTs6tn7iZU3VXJPOI64M3eQPegKmCeL2SNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IywSpVWMWz8pqnRget8jahdsge6/afjCAbBwaspKPwpum5styLU2PHO0qWkG7OEJh
	 hLz5wREIG5fVU4ThtYxqOYBnJFq+vTobAEZLny7oau6iqehJHg2FjuZJ/VI9zCJsAV
	 RdT7/pDsXZB50BNbv9Lkl4SOsD3gX+w+InOIBM6rN2N9ITixfrGurlizc+XE8ZkEi6
	 w7+iaUNT4En6K9iiptiov19KAktCJTpOF/oB3Syo9QyTsoc6Q028kYpX2pqaYYXJqX
	 A4EToeOBhdmi3Fpp++UDb6ypJQ4L+wkc1R9OVk0QIIy38labsKK8eg2oefG2ZbOfc+
	 SNa7o9Xv5FDFA==
Date: Tue, 4 Mar 2025 17:35:32 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
In-Reply-To: <ee5929b0-ddec-4f75-bab6-9164f896f7d8@kernel.org>
Message-ID: <f14f07de-7a2e-bf31-2266-5790140fa918@kernel.org>
References: <20250226180727.2499531-2-matttbe@kernel.org> <9f669869ee804aeb6dbe7fd1511034b0ca9bf8c4.camel@kernel.org> <97e5dc17-d23a-496e-830c-982cf6ab9424@kernel.org> <bdf769b3-d787-63fe-47ed-5cb8c85a6602@kernel.org> <bd3c2f86-a6e2-4452-9694-1cdfb0298ddd@kernel.org>
 <38a21708-c57f-e69f-e1cd-af7767fd7568@kernel.org> <ee5929b0-ddec-4f75-bab6-9164f896f7d8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Mar 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 04/03/2025 02:42, Mat Martineau wrote:
>> On Sat, 1 Mar 2025, Matthieu Baerts wrote:
>>
>>> Hi Mat,
>>>
>>> On 01/03/2025 02:37, Mat Martineau wrote:
>>>> On Thu, 27 Feb 2025, Matthieu Baerts wrote:
>>>>
>>>>> Hi Geliang, Mat,
>>>>>
>>>>> On 27/02/2025 03:03, Geliang Tang wrote:
>>>>>> Hi Matt,
>>>>>>
>>>>>> On Wed, 2025-02-26 at 19:07 +0100, Matthieu Baerts (NGI0) wrote:
>>>>>>> From what we understood, when being used from a CG [gs]etsockopt
>>>>>>> hook,
>>>>>>> the socket lock will be held. It seems that the BPF infra will make
>>>>>>> sure
>>>>>>> in this case. Mat will try to get the confirmation.
>>>>>>>
>>>>>>> The idea is then to add this msk_owned_by_me() check to make sure the
>>>>>>> assumption is correct, and will continue to be: the new selftest
>>>>>>> should
>>>>>>> complain if not when used with a debug kconfig. In other words, if
>>>>>>> the
>>>>>>> tests continue to pass with this patch, the Squash-to series can
>>>>>>> probably be applied.
>>>>>>>
>>>>>>> Note that this is just a debug check, hoping that the selftest will
>>>>>>> cover all cases. We can then not use this check to return an error if
>>>>>>> it
>>>>>>> is not held.
>>>>>>>
>>>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>>>
>>>>>> Thanks for updating this for me.
>>>>>>
>>>>>> LGTM!
>>>>>>
>>>>>> Reviewed-by: Geliang Tang <geliang@kernel.org>
>>>>>
>>>>> Thank you for the review!
>>>>>
>>>>>>> ---
>>>>>>> Based-on: <cover.1740368110.git.tanggeliang@kylinos.cn>
>>>>>>
>>>>>> I changed the state of this set, Squash to "Add mptcp_subflow bpf_iter
>>>>>> support" v4, together with this squash-to patch, as "Queued".
>>>>>
>>>>> Thank you. If that's OK, I will wait for Mat's green light before
>>>>> applying the patches, because he wanted to look at the BPF code to make
>>>>> sure our assumption was correct.
>>>>>
>>>>
>>>> Ok, I did miss it before but in the cases of setsockopt/getsockopt, the
>>>> socket lock is acquired by the bpf wrapper code:
>>>>
>>>> https://elixir.bootlin.com/linux/v6.14-rc4/source/kernel/bpf/
>>>> cgroup.c#L1955
>>>>
>>>> That's why the test passes. There's still the general issue that the
>>>> iterator could be used in any bpf code that can pass a valid msk
>>>> pointer. The existing lock checks in the export branch check that the
>>>> socket is locked, but it could be locked by some other owner.
>>>
>>> Thank you for having looked! Because these new kfuncs are currently only
>>> tied to BPF_PROG_TYPE_CGROUP_SOCKOPT, can we apply all these squash-to
>>> patches and send this to BPF maintainers?
>>
>> Hi Matthieu -
>>
>> I think once the squash-to patches are accepted into our repo (a few
>> more changes are needed), it would be ok to upstream them to the BPF
>> maintainers.
>
> Thank you for your reply! But I admit I'm a bit lost: which changes are
> you talking about?
>
> In the "Add mptcp_subflow bpf_iter support" series we sent to the BPF
> maintainers, this support is only added to CG [gs]etsockopt where the sk
> lock is owned, so no need to have extra checks for the moment, no? Then
> the "Squash to "Add mptcp_subflow bpf_iter support"" v4 (not the last
> one you looked at, the v5) should be enough, no?
>

Hi Matthieu -

Thanks for clarifying, I misunderstood the scope of "all these squash-to 
patches" to include v5 :)

I see what you mean, and I do agree that squashing the v4 patches 
(https://patchwork.kernel.org/project/mptcp/cover/cover.1740368110.git.tanggeliang@kylinos.cn/) 
for another round of BPF maintainer review is ok with me since the sockopt 
calls have the necessary locking, so we can separately upstream the 
iterator series (with sockopt limitations) now.

> My understanding is that setting "msk->bpf_XXX" to "current" will only
> be needed when mptcp_subflow bpf_iter will be allowed to be used with
> struct_ops, no? If yes, better to keep this complexity for later, no?

Agree here as well, the task_struct checking is only needed once there are 
other locking situations to verify.


- Mat
