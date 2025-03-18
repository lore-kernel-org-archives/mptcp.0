Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CB1F4CB4
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328577; cv=none; b=fQGiIXL3anLdpP0xliyy6J+zaVXEr3Bi88b4+yzQNJKanVEtBpluukgO7ivqlC/Zju+pZnAr8ngJCsRrJrQgk574o3i/rltR89IACJicYax33Vhq97qOtILsXzom/UcJCAQii7r4BPSxUAjs8nabsNfy1FL0KOsiWOQ+AWpv9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328577; c=relaxed/simple;
	bh=Z7dVkvTYdvU8PpkYGl58pkJpY/bguDDyMInZGoK5TtY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=udDt1QSqizXU0VT5sXfjRua0J1RxgHUzPIw/uzzFpY6DVSaPQQLoXrPndB0i76UeGOKTPa6R/a5SXLZItO0K3MpcNlkBz+BATGutWoILSe7dy5Kq7V4XzvK2fhW+dktL4eW1tpOH3SqV0koPA1xbJHPp0ntfGnk/iirXwvcvods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwHxUEo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwHxUEo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CC2C4CEDD;
	Tue, 18 Mar 2025 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328577;
	bh=Z7dVkvTYdvU8PpkYGl58pkJpY/bguDDyMInZGoK5TtY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MwHxUEo4mDK4G6Fadvz9hQpOHxBGSOJjUHlvY1IJ3l4RGYv3922ydtWrwOJP5fiLS
	 KY722yzfd4SQKDwhR0CioJd9guDY9FTGxa3EUbpLkcrXpJNyNoLc1kSGfPkHRDcAhd
	 xvoG5BRRPMK+zRmF0zfNqbaosAosFUXC4deMkxDuMRoUnitBNEHF5V6Y00pd265quP
	 gK1Bnksfy3BfZjT+znVbEcUOoXhsLAeIdHshqt012bZq9D4ctBc/rCGmEabuYXqX9F
	 uT95dhrYWpxxWyC+LSBDZz9mYpI/QB3MxvY0EyeiK6aspio6VaJZZJ1mU7nol2A2iC
	 CQffvzARD1GwQ==
Date: Tue, 18 Mar 2025 13:09:36 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for
 mptcp_sock
In-Reply-To: <2816385e-d07e-4180-ab1c-599069630ab2@kernel.org>
Message-ID: <65206402-a0c5-d268-fcd7-56174e4c8120@kernel.org>
References: <cover.1741577149.git.tanggeliang@kylinos.cn> <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn> <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org> <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org> <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org> <2dacce8d-95a4-a5d3-acc5-201a09b7a39c@kernel.org> <2816385e-d07e-4180-ab1c-599069630ab2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1933760301-1742328577=:54447"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1933760301-1742328577=:54447
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 18 Mar 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/03/2025 02:25, Mat Martineau wrote:
>> On Mon, 17 Mar 2025, Matthieu Baerts wrote:
>>
>>> Hi Geliang,
>>>
>>> On 17/03/2025 11:59, Geliang Tang wrote:
>>>> Hi Matt,
>>>>
>>>> On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
>>>>> Hi Geliang, Mat,
>>>>>
>>>>> On 17/03/2025 10:41, Geliang Tang wrote:
>>>>>> On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
>>>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>>>
>>>>>>> To make sure the mptcp_subflow bpf_iter is running in the
>>>>>>> MPTCP context. This patch adds a simplified version of tracking
>>>>>>> for it:
>>>>>>>
>>>>>>> 1. Add a 'struct task_struct *bpf_iter_task' field to struct
>>>>>>> mptcp_sock.
>>>>>>>
>>>>>>> 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
>>>>>>> a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
>>>>>>> the hook returns.
>>>>>>>
>>>>>>> 3. In bpf_iter_mptcp_subflow_new(), check
>>>>>>>
>>>>>>>     "READ_ONCE(msk->bpf_scheduler_task) == current"
>>>>>>>
>>>>>>> to confirm the correct task, return -EINVAL if it doesn't match.
>>>>>>>
>>>>>>> Also creates helpers for setting, clearing and checking that
>>>>>>> value.
>>>
>>> (...)
>>>
>>>>>>> +static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock
>>>>>>> *msk)
>>>>>>> +{
>>>>>>> +    struct task_struct *task = READ_ONCE(msk-
>>>>>>>> bpf_iter_task);
>>>>>>> +
>>>>>>> +    if (task && task == current)
>>>>>>> +        return true;
>>>>>>> +    return false;
>>>>>>> +}
>>>>>>
>>>>>> This v3 has a bug. When I was testing MPTCP BPF selftests in a
>>>>>> loop, I
>>>>>> found that the test would break in some cases. After debugging, I
>>>>>> found
>>>>>> that "task" and "current" were not equal:
>>>>>>
>>>>>> [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
>>>>>> msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
>>>>>> current=0000000024db2987
>>>>>>
>>>>>> I will try to fix it, but haven't found a solution yet.
>>>>>
>>>>> (sorry for the delay, I need a bit of time to catch up)
>>>>>
>>>>> I talked a bit to Alexei Starovoitov last week. He told me that with
>>>>> the
>>>>> BPF struct_ops, it is possible to tell the verifier that some locks
>>>>> are
>>>>> taken either by some struct_ops types, or even per callbacks of some
>>>>> specific struct_ops (WIP on sched_ext side). It is also possible to
>>>>> get
>>>>> some locks automatically (polymorphism), and there are examples on
>>>>> VFS side.
>>>>
>>>> Thanks for your reminder, I will look at these BPF codes. Our goal is
>>>> to make mptcp_subflow bpf_iter only used by struct_ops defined by MPTCP
>>>> BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other struct_ops
>>>> are not allowed to use mptcp_subflow bpf_iter.
>>>
>>> Yes, that's correct. I didn't check, but **maybe** some mptcp_sched_ops
>>> and mptcp_pm_ops callback might not be allowed to use bpf_iter. In this
>>> case, it might be needed to allow only some of them to use bpf_iter.
>>>
>>> Note that it sounds like all mptcp_{pm,sched}_ops callbacks should be
>>> done while holding the msk lock, e.g. being called from the worker and
>>> not from a subflow event, etc. but maybe there are some exceptions
>>> needed.
>>
>> Hi Matthieu -
>>
>> Is this last paragraph also feedback from Alexei? Can you elaborate a
>> little - is the lock needed for BPF-specific reasons or to avoid having
>> the callback modify msk state?
>
> No, it is not from Alexei, but from me. Currently, some actions on a
> subflow will call some code in pm.c that will simply schedule the worker
> to be called from a different context to do other actions. To convert
> this to an mptcp_pm_ops, I think we should not have two callbacks -- one
> to schedule the worker, and one to react from the worker context -- but
> only one called from the worker context if such callback is set. This
> should also simplify the BPF PMs if all/most callbacks are done from the
> same context while owning the msk lock, no?
>

Ok, thanks for the details. I agree, for the PM callbacks it makes sense 
to only have a worker-context callback.


- Mat


>> I'll try to look around at the verifier and automatic locking techniques
>> you mentioned above, it would be great to have a better way to handle
>> socket locks w/ BPF.
>
> Alexei suggested to look at the VFS code. If I understood correctly, the
> idea is to have some locks automatically taken for some actions, but
> without having to dedicate new kfunc, checking if they are already
> taken, or requiring the BPF code to handle them (auto-releasing them
> then). But I don't have more details about that.
>


--0-1933760301-1742328577=:54447--
