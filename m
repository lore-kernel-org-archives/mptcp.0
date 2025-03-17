Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6A23F397
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219845; cv=none; b=A8S5/sWISTU7Iz/lBKd0awLsaL9DbBAl+B4PlnpLVId4X6zutOs4bGyNq1n/rhN3j+h14yw9ae3KzZZmGLG/XNpIquHgjfT86z80ZmypF5m6rmR3a0ONPcbRBSfNEICKb9wY0yM8yS9VeT+dWoHukhxW/Bxa990p58JatHYueLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219845; c=relaxed/simple;
	bh=bNAAkrfg4wow3GDy11flt+3iMQJukTUQceLM3KmFIOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4fmwmXQH23rfGFGBVsz6uGd4SKoBKCZiKViiBQfgBl/kNYLxAcC20D/fYbvvg98Fo5r6hgd7Hrzl/ZwypdpFJj2DNsbEHW+ts3EIZDZuVvZit7qw4QQ3byb81MhJY9WU4/AqAKhtPRn3AYTF7O8W5ZZNkK2FSYvOU27bVjCV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzlckITA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzlckITA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16060C4CEE3;
	Mon, 17 Mar 2025 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742219845;
	bh=bNAAkrfg4wow3GDy11flt+3iMQJukTUQceLM3KmFIOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KzlckITAKcFsYaVmhtCwV8QV0zPr+O02zs6P1tBErsT7TGtBp7Kty6cX9Mgmefrfv
	 13QSv5GOuurtF51QW/IQ6poTxNlwSgq3xfvjmGq4LmbJTikhCs6FbzMCg29ajUsH71
	 01Jvg3XXDcET+mHLJ5eByLZQ2cLSPSmUsED/jdxGkr9f2Bx36iMpP1HG5eQAByrzj7
	 kP1izrNCvXWoMaZqXrfvOJV5UKkhwNptAv1gUl0kHYE4wV842Cqr9lK0RHUWL+j95J
	 Fpzt1+LIGY/DKk5defhbJNgUfbxMFtddWKRPnnfV4Bq3MS2SfPRgaVOVRnR3R7+6HO
	 NqZya4M94qCwQ==
Message-ID: <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
Date: Mon, 17 Mar 2025 14:57:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
 <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/03/2025 11:59, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
>> Hi Geliang, Mat,
>>
>> On 17/03/2025 10:41, Geliang Tang wrote:
>>> On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> To make sure the mptcp_subflow bpf_iter is running in the
>>>> MPTCP context. This patch adds a simplified version of tracking
>>>> for it:
>>>>
>>>> 1. Add a 'struct task_struct *bpf_iter_task' field to struct
>>>> mptcp_sock.
>>>>
>>>> 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
>>>> a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
>>>> the hook returns.
>>>>
>>>> 3. In bpf_iter_mptcp_subflow_new(), check
>>>>
>>>> 	"READ_ONCE(msk->bpf_scheduler_task) == current"
>>>>
>>>> to confirm the correct task, return -EINVAL if it doesn't match.
>>>>
>>>> Also creates helpers for setting, clearing and checking that
>>>> value.

(...)

>>>> +static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock
>>>> *msk)
>>>> +{
>>>> +	struct task_struct *task = READ_ONCE(msk-
>>>>> bpf_iter_task);
>>>> +
>>>> +	if (task && task == current)
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>
>>> This v3 has a bug. When I was testing MPTCP BPF selftests in a
>>> loop, I
>>> found that the test would break in some cases. After debugging, I
>>> found
>>> that "task" and "current" were not equal:
>>>
>>> [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
>>> msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
>>> current=0000000024db2987
>>>
>>> I will try to fix it, but haven't found a solution yet.
>>
>> (sorry for the delay, I need a bit of time to catch up)
>>
>> I talked a bit to Alexei Starovoitov last week. He told me that with
>> the
>> BPF struct_ops, it is possible to tell the verifier that some locks
>> are
>> taken either by some struct_ops types, or even per callbacks of some
>> specific struct_ops (WIP on sched_ext side). It is also possible to
>> get
>> some locks automatically (polymorphism), and there are examples on
>> VFS side.
> 
> Thanks for your reminder, I will look at these BPF codes. Our goal is
> to make mptcp_subflow bpf_iter only used by struct_ops defined by MPTCP
> BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other struct_ops
> are not allowed to use mptcp_subflow bpf_iter.

Yes, that's correct. I didn't check, but **maybe** some mptcp_sched_ops
and mptcp_pm_ops callback might not be allowed to use bpf_iter. In this
case, it might be needed to allow only some of them to use bpf_iter.

Note that it sounds like all mptcp_{pm,sched}_ops callbacks should be
done while holding the msk lock, e.g. being called from the worker and
not from a subflow event, etc. but maybe there are some exceptions needed.

>> In other words, it means we don't need to add this "bpf_iter_task",
>> there are other techniques, but I don't have more details, and I
>> didn't
>> check in the code. If it is not clear for you and you don't find 
>> other
>> examples elsewhere (sched_ext? check WIP patches maybe?), then Alexei
>> said we should not hesitate to ask questions on the BPF mailing list.
> 
> We can send "Add mptcp_subflow bpf_iter support" v3 to the BPF mailing
> list and ask questions during the reviewing process.

Indeed. I hope to be able to find a bit of time this week to send the v3.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

