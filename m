Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A55695
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261134; cv=none; b=bg8Mdl3dNQ8+X7Ol8C0AGU/VmB6PEF7CREvNgkkllKD3CW5aYt54oVVeLDLdKNb4K8GLRuQDQoa6X40bbA8CxernREKbRzofzukJA83044mw62ixZ7ci5kjbFQFflKTbHUkhmmuvK18/96SJW9rGb6K+bPiDrRg1JbYRgmizCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261134; c=relaxed/simple;
	bh=nBPa33H9I8k7e3+KfKZtw/nMxg3WSkrOVrbyY9Zk2m4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dSRarSUg9X2O/GQJbNg2f/HInzH/yWdPtt9hcVD6pdd4FANye069fZ9m2JWtAurJySfwnv8bJakiDn5IfSGl02KmA6AcK4FbcsqJESsWg3BaNdBYUo7tNl/HwPkf9T5ay+dNl0dNXy1ItLDDeuhKl9fzwBNmHJVDer+0RZODzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvKT1qHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvKT1qHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B218C4CEE3;
	Tue, 18 Mar 2025 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261133;
	bh=nBPa33H9I8k7e3+KfKZtw/nMxg3WSkrOVrbyY9Zk2m4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YvKT1qHb8moduQ2Xe8gDPAf0uDF2Qu2ZD6UaHgvn1ixp1CbYl7pE+XJDj6dK8RPg9
	 LYN98m0/3/adTF1pJyYzuZ6AOHkK+4IW2eIcIxVo3YcnxQOz+J4QymdxnF3dcVYwiB
	 Swdyc+UE6wQgXp4OAdjO2MyKsARD5dobFqUABWISlE/YNR7ejaFUBvhrKSb8XB0FRb
	 YlhRjHpTzAWhF+uGCSIDcCVrtYZu4Ggqe944pIsTe/2QsEd+K+NFqvEOCFzD1JfUyJ
	 i+pTCvnIN5v033MSOpAmrefOrXYXKDPeJMRYnH0TOcm38vfn01tHBgx6TJzNu+AX3B
	 UOg8wQ60BbgPQ==
Date: Mon, 17 Mar 2025 18:25:30 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for
 mptcp_sock
In-Reply-To: <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
Message-ID: <2dacce8d-95a4-a5d3-acc5-201a09b7a39c@kernel.org>
References: <cover.1741577149.git.tanggeliang@kylinos.cn> <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn> <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org> <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org> <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2139611155-1742261133=:21025"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2139611155-1742261133=:21025
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 17 Mar 2025, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 17/03/2025 11:59, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
>>> Hi Geliang, Mat,
>>>
>>> On 17/03/2025 10:41, Geliang Tang wrote:
>>>> On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> To make sure the mptcp_subflow bpf_iter is running in the
>>>>> MPTCP context. This patch adds a simplified version of tracking
>>>>> for it:
>>>>>
>>>>> 1. Add a 'struct task_struct *bpf_iter_task' field to struct
>>>>> mptcp_sock.
>>>>>
>>>>> 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
>>>>> a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
>>>>> the hook returns.
>>>>>
>>>>> 3. In bpf_iter_mptcp_subflow_new(), check
>>>>>
>>>>> 	"READ_ONCE(msk->bpf_scheduler_task) == current"
>>>>>
>>>>> to confirm the correct task, return -EINVAL if it doesn't match.
>>>>>
>>>>> Also creates helpers for setting, clearing and checking that
>>>>> value.
>
> (...)
>
>>>>> +static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock
>>>>> *msk)
>>>>> +{
>>>>> +	struct task_struct *task = READ_ONCE(msk-
>>>>>> bpf_iter_task);
>>>>> +
>>>>> +	if (task && task == current)
>>>>> +		return true;
>>>>> +	return false;
>>>>> +}
>>>>
>>>> This v3 has a bug. When I was testing MPTCP BPF selftests in a
>>>> loop, I
>>>> found that the test would break in some cases. After debugging, I
>>>> found
>>>> that "task" and "current" were not equal:
>>>>
>>>> [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
>>>> msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
>>>> current=0000000024db2987
>>>>
>>>> I will try to fix it, but haven't found a solution yet.
>>>
>>> (sorry for the delay, I need a bit of time to catch up)
>>>
>>> I talked a bit to Alexei Starovoitov last week. He told me that with
>>> the
>>> BPF struct_ops, it is possible to tell the verifier that some locks
>>> are
>>> taken either by some struct_ops types, or even per callbacks of some
>>> specific struct_ops (WIP on sched_ext side). It is also possible to
>>> get
>>> some locks automatically (polymorphism), and there are examples on
>>> VFS side.
>>
>> Thanks for your reminder, I will look at these BPF codes. Our goal is
>> to make mptcp_subflow bpf_iter only used by struct_ops defined by MPTCP
>> BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other struct_ops
>> are not allowed to use mptcp_subflow bpf_iter.
>
> Yes, that's correct. I didn't check, but **maybe** some mptcp_sched_ops
> and mptcp_pm_ops callback might not be allowed to use bpf_iter. In this
> case, it might be needed to allow only some of them to use bpf_iter.
>
> Note that it sounds like all mptcp_{pm,sched}_ops callbacks should be
> done while holding the msk lock, e.g. being called from the worker and
> not from a subflow event, etc. but maybe there are some exceptions needed.

Hi Matthieu -

Is this last paragraph also feedback from Alexei? Can you elaborate a 
little - is the lock needed for BPF-specific reasons or to avoid having 
the callback modify msk state?

I'll try to look around at the verifier and automatic locking techniques 
you mentioned above, it would be great to have a better way to handle 
socket locks w/ BPF.

- Mat

>
>>> In other words, it means we don't need to add this "bpf_iter_task",
>>> there are other techniques, but I don't have more details, and I
>>> didn't
>>> check in the code. If it is not clear for you and you don't find
>>> other
>>> examples elsewhere (sched_ext? check WIP patches maybe?), then Alexei
>>> said we should not hesitate to ask questions on the BPF mailing list.
>>
>> We can send "Add mptcp_subflow bpf_iter support" v3 to the BPF mailing
>> list and ask questions during the reviewing process.
>
> Indeed. I hope to be able to find a bit of time this week to send the v3.
>
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
>
>
--0-2139611155-1742261133=:21025--
