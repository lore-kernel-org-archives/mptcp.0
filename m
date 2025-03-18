Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7A206F22
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297214; cv=none; b=OadWUh4agEQGlRWR+ihoArXKVM61EonraMNdvDVw2oZXiJsPf0VvkLTO/vmN6UYcduMNDYc9YZRroinG1B4Sn+qHt+jC3rqeEugc+Zk9lz35X977HhEZtfXKb4X0V28O+I9MHWnfquSUV7/PJdcwmm5M96os4zS2GeYsYHgTIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297214; c=relaxed/simple;
	bh=cCR0OiIJdsHhRkkaHn4tCQYozfQcboq2cMSKf+apsKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKMY8gqZOprCbRn2TOnyBhEeo2+agQIm6tYfW7uk85pKt9aTsJ95odoNhzoFsDXtSF5uKl+f9cpbIcF4GQSSNFkHa3LaKKDP8VpR3QMxNI/KrZgdToHLWkt7Q/FSWthjVzaQ7Y3rrc8SHIr4iQXJguI1T+Qx3NfY+D/3hUjaHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B62oFt6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B62oFt6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D2C4CEDD;
	Tue, 18 Mar 2025 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297213;
	bh=cCR0OiIJdsHhRkkaHn4tCQYozfQcboq2cMSKf+apsKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B62oFt6Sd5egNZnFQ7U6H62U+NbKLgSh8FLIAQEHBvsEeH8/qTL8vcFKEVJ75QYOn
	 dYmT3c3XAfF4OUMibKQuGKc7ERXNNCYmLLzQJJviFbjTa4DLbZT1z4fAmBOvxJ4tR3
	 3a+E8GvvQkKpP5h7GNiUqTzVatDBQkcGagI2MeG+qncOzVi+2AHYrKBcsczIhifwoU
	 lVAUeKEhL9TMe4l3ly/FSRQh72mtZuPXe1PQFwAk+X1ZJCUMA9QiYTKrO76RRLdrcB
	 ApZBmjbQfJjWWSJ804dyLFXZgiNZ99Y6YCGi8KkcC1hsojxBFAjU99BYxv4XGRyvG0
	 3yBUZpp2YxQmQ==
Message-ID: <bf2ad4ed-bf4a-47c7-a7d5-eb23c0825198@kernel.org>
Date: Tue, 18 Mar 2025 12:26:50 +0100
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
 <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
 <05be0df71bcac1bf0f24a7637ba1652aebb8a312.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <05be0df71bcac1bf0f24a7637ba1652aebb8a312.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 18/03/2025 11:35, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-03-17 at 14:57 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 17/03/2025 11:59, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
>>>> Hi Geliang, Mat,
>>>>
>>>> On 17/03/2025 10:41, Geliang Tang wrote:
>>>>> On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
>>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>>
>>>>>> To make sure the mptcp_subflow bpf_iter is running in the
>>>>>> MPTCP context. This patch adds a simplified version of
>>>>>> tracking
>>>>>> for it:
>>>>>>
>>>>>> 1. Add a 'struct task_struct *bpf_iter_task' field to struct
>>>>>> mptcp_sock.
>>>>>>
>>>>>> 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before
>>>>>> calling
>>>>>> a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL)
>>>>>> after
>>>>>> the hook returns.
>>>>>>
>>>>>> 3. In bpf_iter_mptcp_subflow_new(), check
>>>>>>
>>>>>> 	"READ_ONCE(msk->bpf_scheduler_task) == current"
>>>>>>
>>>>>> to confirm the correct task, return -EINVAL if it doesn't
>>>>>> match.
>>>>>>
>>>>>> Also creates helpers for setting, clearing and checking that
>>>>>> value.
>>
>> (...)
>>
>>>>>> +static inline bool mptcp_check_bpf_iter_task(struct
>>>>>> mptcp_sock
>>>>>> *msk)
>>>>>> +{
>>>>>> +	struct task_struct *task = READ_ONCE(msk-
>>>>>>> bpf_iter_task);
>>>>>> +
>>>>>> +	if (task && task == current)
>>>>>> +		return true;
>>>>>> +	return false;
>>>>>> +}
>>>>>
>>>>> This v3 has a bug. When I was testing MPTCP BPF selftests in a
>>>>> loop, I
>>>>> found that the test would break in some cases. After debugging,
>>>>> I
>>>>> found
>>>>> that "task" and "current" were not equal:
>>>>>
>>>>> [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
>>>>> msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
>>>>> current=0000000024db2987
>>>>>
>>>>> I will try to fix it, but haven't found a solution yet.
>>>>
>>>> (sorry for the delay, I need a bit of time to catch up)
>>>>
>>>> I talked a bit to Alexei Starovoitov last week. He told me that
>>>> with
>>>> the
>>>> BPF struct_ops, it is possible to tell the verifier that some
>>>> locks
>>>> are
>>>> taken either by some struct_ops types, or even per callbacks of
>>>> some
>>>> specific struct_ops (WIP on sched_ext side). It is also possible
>>>> to
>>>> get
>>>> some locks automatically (polymorphism), and there are examples
>>>> on
>>>> VFS side.
>>>
>>> Thanks for your reminder, I will look at these BPF codes. Our goal
>>> is
>>> to make mptcp_subflow bpf_iter only used by struct_ops defined by
>>> MPTCP
>>> BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other
>>> struct_ops
>>> are not allowed to use mptcp_subflow bpf_iter.
> 
> I checked and found that other struct_ops **cannot** use mptcp_subflow
> bpf_iter. Although we registered this bpf_iter for use with
> BPF_PROG_TYPE_STRUCT_OPS type, we checked in bpf_iter_mptcp_subflow_new
> that sk->sk_protocol must be IPPROTO_MPTCP. Does this mean that other
> struct_ops cannot use mptcp_subflow bpf_iter successfully? I don't know
> if this check is sufficient.

Sorry, I don't know. With the current version, I don't see any links
between mptcp_subflow bpf_iter and mptcp_{sched,pm}_ops, then I don't
know how the restriction works, right? I guess there might be a
restriction because "struct mptcp_sock*" are used in arguments? But I
guess that's not enough because such structures can be obtained from
different struct_ops. Probably something else is missing to have this
link then?

>> Yes, that's correct. I didn't check, but **maybe** some
>> mptcp_sched_ops
>> and mptcp_pm_ops callback might not be allowed to use bpf_iter. In
>> this
>> case, it might be needed to allow only some of them to use bpf_iter.
> 
> I guess it's not easy to allow only some callbacks of a struct_ops to
> access certain functions, because The BPF verifier verifies the
> struct_ops as a whole. But I will continue to look for a solution.

Alexei told me that this work was in progress for sched_ext, but I don't
know more about that, sorry.

>> Note that it sounds like all mptcp_{pm,sched}_ops callbacks should be
>> done while holding the msk lock, e.g. being called from the worker
>> and
>> not from a subflow event, etc. but maybe there are some exceptions
>> needed.
> 
> I checked the following 19 callbacks of mptcp_{pm,sched}_ops that have
> been implemented in my code tree. Except for the three exceptions
> (get_local_id, get_priority and add_addr_received), the other 17
> callbacks are all be done while holding the msk lock:

Thank you for having checked!

> struct mptcp_sched_ops {
>         int (*get_send)(struct mptcp_sock *msk);
>         int (*get_retrans)(struct mptcp_sock *msk);
> }
> 
> struct mptcp_pm_ops {
>         /* required */
>         int (*get_local_id)(struct mptcp_sock *msk,
>                             struct mptcp_pm_addr_entry *skc);
>         bool (*get_priority)(struct mptcp_sock *msk,
>                              struct mptcp_addr_info *skc);
> 
>         /* optional */
>         void (*established)(struct mptcp_sock *msk);
>         void (*subflow_established)(struct mptcp_sock *msk);
> 
>         /* required */
>         bool (*allow_new_subflow)(struct mptcp_sock *msk);
>         bool (*accept_new_subflow)(const struct mptcp_sock *msk);
>         bool (*add_addr_echo)(struct mptcp_sock *msk,
>                               const struct mptcp_addr_info *addr);
> 
>         /* optional */
>         int (*add_addr_received)(struct mptcp_sock *msk,
>                                  const struct mptcp_addr_info *addr);
>         void (*rm_addr_received)(struct mptcp_sock *msk);
> 
>         /* optional */
>         int (*add_addr)(struct mptcp_sock *msk,
>                         struct mptcp_pm_addr_entry *entry);
>         int (*del_addr)(struct mptcp_sock *msk,
>                         const struct mptcp_pm_addr_entry *entry);
>         int (*flush_addrs)(struct mptcp_sock *msk,
>                            struct list_head *rm_list);
> 
>         /* optional */
>         int (*address_announce)(struct mptcp_sock *msk,
>                                 struct mptcp_pm_addr_entry *local);
>         int (*address_remove)(struct mptcp_sock *msk,
>                               struct mptcp_pm_addr_entry *local);
>         int (*subflow_create)(struct mptcp_sock *msk,
>                               struct mptcp_pm_addr_entry *local,
>                               struct mptcp_addr_info *remote);
>         int (*subflow_destroy)(struct mptcp_sock *msk,
>                                struct mptcp_pm_addr_entry *local,
>                                struct mptcp_addr_info *remote);
> 
>         /* required */
>         int (*set_priority)(struct mptcp_sock *msk,
>                             struct mptcp_pm_addr_entry *local,
>                             struct mptcp_pm_addr_entry *remote);

Mmh, all 8 callbacks from add_addr to here seem to be linked to Netlink
commands, right? If yes, they should not be here: they don't make sense
for a BPF PM, no? BPF PMs should be configured with BPF, and not via
Netlink. Netlink is only for the built-in PMs (in-kernel and userspace PMs)

> };
> 
> For these three exceptions, add_addr_received is invoked in
> mptcp_pm_add_addr_received, here the socket lock of ssk is already
> holding.

For add_addr_received, I think it is safer to have the callback from the
worker context. In other words, when an ADD_ADDR received on a subflow:

- the ADD_ADDR echo should be sent: I don't think it is worth it letting
the other peer resending it just in case the userspace PM was not "ready"

- if pm->ops->add_addr_received is set, schedule the worker and set
  msk->pm.remote

- then pm->ops->add_addr_received will be called from the worker.

> Similarly, in subflow_chk_local_id, get_local_id and get_priority are
> called, where the socket lock of ssk is already holding too.
> 
> In addition, get_local_id and get_priority are also called in
> subflow_token_join_request, which is in atomic and can hold msk lock
> through bh_lock_sock. If locking is required here, I can send a patch
> to do this.

Yes, for the ID and backup, I guess we will need an exception there, and
a way not to let the BPF PMs calling bpf_iter. We should not hold the
msk lock here.

I guess the easier would be to ask the BPF maintainers what we should do
here. Maybe this can be done after having sent the mptcp_subflow v3
series, or at the same time. I will see what I can do.

> In this way, all callbacks of mptcp_{pm,sched}_ops can be done while
> holding the msk lock or the ssk lock.

At least on the scheduler side, that will be the case (or maybe not if
we change the API to cover more cases :) ).

Anyway, probably best to wait for BPF maintainers recommendations
instead of guessing.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

