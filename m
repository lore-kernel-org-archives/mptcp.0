Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BD1C7608
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989249; cv=none; b=fkiomHIBUZQRVYvHaQFOXByHF5TX0RCLvdbOQRd7X74lGu4Yv9JlY7Eh5FVWUd/bxvvD3/6a0QG/GyYKCH4BrUx671ZXytTbshB61yFNFY4JvGaLLtypmLiXmCgMyMmpECtJSVgRdMjEImDEpX4G2S5glXc9CgWiSQBWTObQg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989249; c=relaxed/simple;
	bh=zhVqtDdyRYUAi33fZA0+cw6mkQ1Q3ijyACjY68Q/Acg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNExJrZAMqAeSf9S5yxU8J1jxPcrND8Y0BmXsXdmL6ZrDblBF7sg4rMwCaX/TcyQsFxRkw4uQqTLWK9m7KE4hkFnhaYW9+KE1Fgkf6nJnv5foW6m7KlZorjRW9nvUlUTV7tgDXzS02cbg9fgFD88EG7w/lainY6DcOqUsMeiLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBV++jdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBV++jdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D24C4CEC6;
	Tue, 15 Oct 2024 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728989248;
	bh=zhVqtDdyRYUAi33fZA0+cw6mkQ1Q3ijyACjY68Q/Acg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBV++jdqyjb8JU/yd3yTs2iQH0W/mZko+qqCAeZalPr6/v8dlQDKJZtjirng6wphL
	 HcVByduLjGDW4JzHn87yENSGCns6459Qrc/aQdoEgolDsI/eR83DmppwD5RD8hVsjK
	 TQNfcRk0q56UzrkJO34Hh/W/HV5tFs26UYA/KV5CMtu7Afp2WqFk4XvhGnKhUV2iRg
	 sjGqnIJ3GElj2hpdVEJ7M78ZlUpx8Pz2m0Hv/gtPsSQ6Mo4eVFVgKnz2WVkKKk6IWP
	 CuKJMMWZfZQq3KOKYURpDBmoQgBVgoaowlTzS2GGBcAFBYQdFhk14ebB0Fe08jfTwa
	 NzpaIUbjhDF5w==
Message-ID: <56da8840-51d5-4b5b-9c43-7ebfdaed25c6@kernel.org>
Date: Tue, 15 Oct 2024 12:47:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v9 4/7] selftests/bpf: Add mptcp_subflow
 bpf_iter test prog
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
 <dffa6284797ec2e3e8c8a1f6891f012bd1efdc20.1728466623.git.tanggeliang@kylinos.cn>
 <22b299af-150b-450c-b2c8-6710cf321c2d@kernel.org>
 <c1b0c2e2a421c8fcfd5b29542ffabc60651c08f1.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c1b0c2e2a421c8fcfd5b29542ffabc60651c08f1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 15/10/2024 09:59, Geliang Tang wrote:
> On Mon, 2024-10-14 at 18:06 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 09/10/2024 11:45, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch adds a ftrace hook for mptcp_sched_get_send() to test
>>> the newly
>>> added mptcp_subflow bpf_iter. This test simulates a typical mptcp
>>> packet
>>> scheduler, which selects a subflow from multiple subflows of an
>>> mptcp
>>> socket to send data.
>>>
>>> Export mptcp_subflow helpers
>>> bpf_iter_mptcp_subflow_new/_next/_destroy,
>>> bpf_mptcp_sock_acquire/_release and other helpers into
>>> bpf_experimental.h.
>>>
>>> Use _acquire() to acquire the msk, then use
>>> bpf_for_each(mptcp_subflow) to
>>> walk the subflow list of this msk. Invoke kfuncs
>>> mptcp_subflow_active() and
>>> bpf_mptcp_subflow_tcp_sock() in the loop to pick a subsocket.
>>> Finally use
>>> bpf_mptcp_subflow_ctx() to get the subflow context of this
>>> subsocket and
>>> use mptcp_subflow_set_scheduled() to set it as being scheduled.
>>
>> Do you think we could have a test not depending on scheduler helpers?
>> Without this dependence, we could already upstream this series, and
>> get
>> feedback without having to wait for the new scheduler API.
> 
> This set can be upstream as is, no need to wait for the new scheduler
> API.
> 
> If no scheduler helpers are used in this test, no need to add this
> mptcp_subflow bpf_iter at all. mptcp_for_each_subflow() helper in
> progs/mptcp_bpf.h can do that.
> 
> mptcp_for_each_subflow(msk, subflow) {
> 	subflow = bpf_core_cast(subflow, struct
> mptcp_subflow_context);
> 	subflows += subflow->subflow_id;
> }
> 
> No need to use this:
> 
> bpf_for_each(mptcp_subflow, subflow, msk)
> 	subflows += subflow->subflow_id;

I agree, but for me, I see this as a preparation step, and then it is
fine if this test is not doing anything useful for the moment. I think
it would be enough to add a comment in the code like:

  /* Here MPTCP-specific kfunc can be called */

And add in the commit message that these kfunc will be added later one,
as a next step.

>> If you remove the use of mptcp_subflow_active() and
>> mptcp_subflow_set_scheduled(), that's enough, no?
> 
> But "subflow" in mptcp_for_each_subflow() loop can't be passed to a
> kernel function:
> 
> mptcp_for_each_subflow(msk, subflow) {
> 	subflow = bpf_core_cast(subflow, struct
> mptcp_subflow_context);
> 	mptcp_subflow_active(subflows);
> }
> 
> This is not allowed by BPF.
> 
> So we add this iter to do this:
> 
> bpf_for_each(mptcp_subflow, subflow, msk)
> 	kfunc(subflow);
> 
> In this test, I must pick some kfuncs accepted "subflow" argument to do
> this test, so mptcp_subflow_active and mptcp_subflow_set_scheduled are
> picked.

I think that can be done later on, the first step is to have these MPTCP
bpf_iter upstreamed I think.

> Also, This iter is for the BPF packet scheduler, why not test the
> actual usage of scheduler helpers in this test?

I understand that, but I think it will be easier to avoid these helpers
for the moment, and make the test as simpler as possible.

(...)

>>> diff --git
>>> a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
>>> b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
>>> new file mode 100644
>>> index 000000000000..4268e4604c5a
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
>>> @@ -0,0 +1,42 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2024, Kylin Software */
>>> +
>>> +/* vmlinux.h, bpf_helpers.h and other 'define' */
>>> +#include "bpf_tracing_net.h"
>>> +#include "mptcp_bpf.h"
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +int subflows;
>>> +int pid;
>>> +
>>> +SEC("fentry/mptcp_sched_get_send")
>>
>> If I understand correctly, this hook will be called twice on the
>> client
>> connection for this test because the client is sending two times one
>> byte, right?
> 
> Yes, in the first call, the subflows are not been added yet, so it is
> called twice. I will add this check to skip the first call:
> 
>        if (msk->pm.server_side || !msk->pm.subflows)
>                return 0;

Good idea! Please add a comment above to explain you added that to only
do the rest once.

If we want to have a simpler test without the scheduler helpers, we can
also use another hook, e.g. just before closing the different subflows?
Up to you.

Also, just to be sure: is this BPF program only used (loaded, running)
by the corresponding test?
Can you remind me why is there a PID check? Is it because all BPF
programs are always loaded for all tests?

>>> +int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
>>> +{
>>> +	struct mptcp_subflow_context *subflow;
>>> +	struct sock *ssk = NULL;
>>> +
>>> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
>>> +		return 0;
>>> +
>>> +	msk = bpf_mptcp_sock_acquire(msk);
>>> +	if (!msk)
>>> +		return 0;
>>> +	bpf_for_each(mptcp_subflow, subflow, msk) {
>>> +		if (subflow->token != msk->token)
>>> +			break;
>>
>> Out of curiosity, why is this needed? Is it needed for the verifier?
>> Or
>> just an extra check?
>> Can you add a comment here explaining why this is there please?
> 
> I'll drop it.

Just to be clear: I'm not asking to drop it, but to understand why it is
needed. The main reason is to have other people using it in future
programs, because they saw it was used here. If it is here as an
"assert", something that cannot be wrong, that's fine, as long as it is
marked (by a comment) as is.

>>> +
>>> +		if (!mptcp_subflow_active(subflow))
>>> +			continue;
>>> +
>>> +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
>>
>> Do you get 'ssk' just to use bpf_mptcp_subflow_tcp_sock() and
>> bpf_mptcp_subflow_ctx()?
> 
> Yes, almost every BPF scheduler use these helpers, so test them here.

For me, that's fine to keep using these helpers, even if their usage is
limited in the test. You can keep it here, and keep
bpf_mptcp_subflow_ctx(ssk) below, then use 'subflow' below to compare
the token with the one of the msk for example. Feel free to add a
comment mentioning that it is just to show these helpers can be used in
the 'bpf_for_each()' and outside.

>>> +	}
>>> +	bpf_mptcp_sock_release(msk);
>>> +
>>> +	if (!ssk)
>>> +		return 0;
>>> +	subflow = bpf_mptcp_subflow_ctx(ssk);
>>> +	mptcp_subflow_set_scheduled(subflow, true);
>>> +	subflows = subflow->subflow_id;
>>
>> Here, it looks like you only check if the last subflow is in the
>> list.
>>
>> Would it not be better to count the number of subflows in the list?
>> Or
>> if you want to read something from 'subflow', you could add all
>> subflow_id?
>>
>>   subflows = 0;
>>
>>   (...)
>>
>>   bpf_for_each(mptcp_subflow, subflow, msk)
>>       subflows += subflow->subflow_id;
>>
>> By doing that, we will catch if one is missing, and the order is not
>> important.
> 
> Yes, "subflows += subflow->subflow_id" is much better.
> 
>>
>> If still want to use bpf_mptcp_subflow_tcp_sock() and
>> bpf_mptcp_subflow_ctx(), maybe you can save other fields from the
>> last
>> subflow: the token to compare it with the one in the msk? Or the port
>> number or the address?
> 
> Sorry, I don't fully understand your last paragraph. But I stored the
> dport number in the code below. Is it the same as what you thought? If
> so, I'll send a squash-to patch for it.

I was just thinking about something you could do to keep using these new
helpers: keep the ref to the last subflow, and compare with data from
the msk, e.g.

  struct mptcp_subflow_context *subflow;
  struct sock *sk = (struct sock *)msk;
  struct sock *ssk = NULL;
  int all_ids = 0;

  /* TODO: why is it needed? */
  if (bpf_get_current_pid_tgid() >> 32 != pid)
      return 0;

  /* to do the test only once: on the client side, at the 2nd send */
  if (msk->pm.server_side || !msk->pm.subflows)
      return 0;

  msk = bpf_mptcp_sock_acquire(msk);
  if (!msk)
      return 0;

  bpf_for_each(mptcp_subflow, subflow, msk) {
      /* Here MPTCP-specific kfunc can be called: this test is not doing
       * anything really useful, only to verify the iteration works.
       */

      /* assert: if not OK, something wrong on the kernel side */
      if (subflow->token != msk->token)
          break;

      /* to check we iterate over all subflows */
      local_ids += subflow->subflow_id;

      /* only to check the following kfunc works */
      ssk = bpf_mptcp_subflow_tcp_sock(subflow);
  }

  if (!ssk)
      goto out;

  /* assert: if not OK, something wrong on the kernel side */
  if (ssk->sk_dport != sk->sk_dport)
      goto out;

  /* only to check the following kfunc works */
  subflow = bpf_mptcp_subflow_ctx(ssk);
  if (subflow->token != msk->token)
      goto out;

  ids = local_ids;


(not tested)

→ So not using anything linked to the packet scheduler, just very simple
check to make sure 'bpf_iter' + bpf_mptcp_subflow_tcp_sock() and
bpf_mptcp_subflow_ctx() work as expected. Like that, it sounds easier to
upstream as it is.

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

