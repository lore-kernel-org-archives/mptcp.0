Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F6BE4E
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052544; cv=none; b=nuZX3IwRJB/eF3kw/HAVs6h4eq/Ko9YnH5YyYbvM2/mjKrD7idQeMhnmiWT5lCf/z4qahhgQfRZJznNHy2+TnES5gcory8fb/aAQCqfZuUfRhJ2tQnivmwUPcTUzisohrOOf/KGLuNI2QTAbE58cvQHpDKj2kXfGNOZWxzLDV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052544; c=relaxed/simple;
	bh=PAouRYhRJOxfBAFY7qj/WZzmguXmeQnFs35SwXMot3s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UOeiRQUJrGAduHS8takWo4HDQ+qor0GfjSRP9c5+rkpZNvE3M1qrF1lLUQg6xNh0F2FXzRa+qFxe6ZLHuB9vEm+e39zqKBP6zJqAg5beBhHdhYTqrKVJeJi8YeO9czc4T0wWjmidLTAGuxA4OB0aMzf8+fP4fnKjdV9JPdf42AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggpM7ydZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggpM7ydZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B0BC4CEE8;
	Tue,  4 Mar 2025 01:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052543;
	bh=PAouRYhRJOxfBAFY7qj/WZzmguXmeQnFs35SwXMot3s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ggpM7ydZrB2gHWeGGjHO9HDirS2Ij1fbZj49hAv0vcwvMOwQMhpcW5WreS8BmBhiJ
	 2bebXub0ZyJjPXGJO3ODEi9si79KaHbDPuXkHvf89/zrTVw2hBWDz5goiA5f6zqgQG
	 ng5daaBrn9FsbdF8rolJAuLIv/XZuA3rlQwG/lCSTjWVv5fF72jW7jOXZqYTbLrsUZ
	 XE+Gvh9HGqCwCPQ4dQEvfNUo/4pT0eAWU/CDeF9Y76rDvCMHTq54XXvwXLE/X8ESgZ
	 /pCXDhrBKyJQwgOWghpXjWcGaejTNpptCD0DbDpE6jlTzENksAAe2kmbV5f543edlX
	 6ea126vQGjg+w==
Date: Mon, 3 Mar 2025 17:42:23 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
In-Reply-To: <bd3c2f86-a6e2-4452-9694-1cdfb0298ddd@kernel.org>
Message-ID: <38a21708-c57f-e69f-e1cd-af7767fd7568@kernel.org>
References: <20250226180727.2499531-2-matttbe@kernel.org> <9f669869ee804aeb6dbe7fd1511034b0ca9bf8c4.camel@kernel.org> <97e5dc17-d23a-496e-830c-982cf6ab9424@kernel.org> <bdf769b3-d787-63fe-47ed-5cb8c85a6602@kernel.org>
 <bd3c2f86-a6e2-4452-9694-1cdfb0298ddd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 1 Mar 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 01/03/2025 02:37, Mat Martineau wrote:
>> On Thu, 27 Feb 2025, Matthieu Baerts wrote:
>>
>>> Hi Geliang, Mat,
>>>
>>> On 27/02/2025 03:03, Geliang Tang wrote:
>>>> Hi Matt,
>>>>
>>>> On Wed, 2025-02-26 at 19:07 +0100, Matthieu Baerts (NGI0) wrote:
>>>>> From what we understood, when being used from a CG [gs]etsockopt
>>>>> hook,
>>>>> the socket lock will be held. It seems that the BPF infra will make
>>>>> sure
>>>>> in this case. Mat will try to get the confirmation.
>>>>>
>>>>> The idea is then to add this msk_owned_by_me() check to make sure the
>>>>> assumption is correct, and will continue to be: the new selftest
>>>>> should
>>>>> complain if not when used with a debug kconfig. In other words, if
>>>>> the
>>>>> tests continue to pass with this patch, the Squash-to series can
>>>>> probably be applied.
>>>>>
>>>>> Note that this is just a debug check, hoping that the selftest will
>>>>> cover all cases. We can then not use this check to return an error if
>>>>> it
>>>>> is not held.
>>>>>
>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>
>>>> Thanks for updating this for me.
>>>>
>>>> LGTM!
>>>>
>>>> Reviewed-by: Geliang Tang <geliang@kernel.org>
>>>
>>> Thank you for the review!
>>>
>>>>> ---
>>>>> Based-on: <cover.1740368110.git.tanggeliang@kylinos.cn>
>>>>
>>>> I changed the state of this set, Squash to "Add mptcp_subflow bpf_iter
>>>> support" v4, together with this squash-to patch, as "Queued".
>>>
>>> Thank you. If that's OK, I will wait for Mat's green light before
>>> applying the patches, because he wanted to look at the BPF code to make
>>> sure our assumption was correct.
>>>
>>
>> Ok, I did miss it before but in the cases of setsockopt/getsockopt, the
>> socket lock is acquired by the bpf wrapper code:
>>
>> https://elixir.bootlin.com/linux/v6.14-rc4/source/kernel/bpf/cgroup.c#L1955
>>
>> That's why the test passes. There's still the general issue that the
>> iterator could be used in any bpf code that can pass a valid msk
>> pointer. The existing lock checks in the export branch check that the
>> socket is locked, but it could be locked by some other owner.
>
> Thank you for having looked! Because these new kfuncs are currently only
> tied to BPF_PROG_TYPE_CGROUP_SOCKOPT, can we apply all these squash-to
> patches and send this to BPF maintainers?

Hi Matthieu -

I think once the squash-to patches are accepted into our repo (a few more 
changes are needed), it would be ok to upstream them to the BPF 
maintainers.

- Mat


>
>
> When bpf_iter will be used in the schedulers and the PM, more checks can
> be added later.
>
>> As we've already discussed, msk_owned_by_me() doesn't work everywhere
>> because we can't change behavior if the lock isn't owned. However, we
>> don't need to handle every locking case like lockdep does - for the
>> scheduler BPF case, we only care if the BPF code is running in the
>> scheduler context. So, I think we can do a simplified version of
>> tracking the lock context:
>>
>> 1. Add a 'struct task_struct *bpf_scheduler_task' field to struct
>> mptcp_sock.
>>
>> 2. Do a WRITE_ONCE(msk->bpf_scheduler_context, current) before calling a
>> packet scheduler hook, and WRITE_ONCE(msk->bpf_scheduler_task, NULL)
>> after the hook returns.
>>
>> 3. In bpf_iter_mptcp_subflow_new(), check "READ_ONCE(msk->
>> bpf_scheduler_task) == current" to confirm the correct task, return
>> -EINVAL if it doesn't match.
>
> That's a very good idea! Yes, we will need to add such checks before
> msk_owned_by_me() when the bpf_iter will be used elsewhere.
>
>> (It would help to create helper functions for setting and checking that
>> value)
>
> +1.
>
>> Do you think this iterator will be useful in other places, like bpf path
>> manager? The same approach would work there, but a better name than
>> "bpf_scheduler_task" would help.
> Yes, good point! "msk->bpf_struct_ops_task"?
>
> (that's something that could also be added after having applied "use
> bpf_iter in bpf schedulers") series)
>
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
>
>
