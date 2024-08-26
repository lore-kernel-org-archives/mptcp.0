Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1AC13B59E
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661877; cv=none; b=bpREV3SHUqIig53l4b8Ks6vzQa1HHpbT2ura5pm9lnZtQ3hdn9OJf3qgr8gTtlfW3rUS4KLx7/qe84cNqpmaqi7XgcJpsgrRiy9piNBVm32BmlL56vr8uGX1c738HrULROsqigS7QXUVafEQAh0a5YxsP52GsC4+Zn2hK/NCTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661877; c=relaxed/simple;
	bh=4IdDiSTDfdWjDVsdlyV32q2YiCZWaFF03eVWQZDf4T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBXjKV6Gmdfd/odIol8ymLkpIwdVyr/ps4JTBEnAHF3UfrooQHrE00NGwZTxnmb8J7e+7vvNPmq3O6YYmKRunnhEgAWQ7kTMv3daa4FichSJ89F1scEdDZeuh22TxI3tGkUUgS8046L8Rz1JTvwRsUNtYXeL9mhorVp7qg+O1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR67tMGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR67tMGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E7C91B7D;
	Mon, 26 Aug 2024 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724661876;
	bh=4IdDiSTDfdWjDVsdlyV32q2YiCZWaFF03eVWQZDf4T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DR67tMGciQjhqHYr7sNd3KLuMN6t7cG+d0NrjsVAlRYUawLFnp54blyZJmKMReQck
	 2akUtN4BT92mf6iJ5wWosGY45eh1gp6nSV2Wv8pMTrJZmx0KXGxDz9xdyI08jUo4vG
	 2KN6MOAsummjQE+MzG8XFOgiQwmMqdxHwWKlYC0CmZz/9SAUD3qAWpsId6nOHgJRm1
	 9HQ3fMAMaKK0QdgDL+sgSKyFW6O2t3CskgdZg4OiNtE455TNGnp8s/ZjVgsgnx9dNr
	 5mDm98iV1C9DbGvc7l7R9SgUa5VAD8xtJxuWDM7ZSDueznobLul2jomjnPkarb/Lx3
	 X16gk7cDhu2og==
Message-ID: <547fdd31-a052-4274-a59e-d7177887dbbe@kernel.org>
Date: Mon, 26 Aug 2024 10:44:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
 <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/08/2024 04:57, Geliang Tang wrote:
> On Wed, 2024-08-21 at 11:37 +0200, Matthieu Baerts wrote:
>> On 21/08/2024 10:00, Geliang Tang wrote:
>>> On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
>>>> On 20/08/2024 10:44, Geliang Tang wrote:

(...)

>>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>>
>>>> (might be better to use this helper in our WIP MPTCP BPF packets
>>>> scheduler examples, instead of converting them to a fixed array)
>>>
>>> Yes, but there are still some access permission issues that need to
>>> be
>>> resolved.
>>
>> OK, because structures cannot be modified I suppose.
> 
> No, it seems the subflow cast by bpf_core_cast() can't be passed to a
> kernel function, regardless of whether this function modifies the
> subflow or not. An "arg#0 is untrusted_ptr_ expected ptr_" error
> occurs.
> 
> For example, mptcp_subflow_active() is a kernel function, and pass the
> subflow to it in progs/mptcp_bpf_first.c like this:
> 
> '''
> ... ...
> extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> __ksym;
> 
> ... ...
> SEC("struct_ops")
> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
>              struct mptcp_sched_data *data)
> {
>         struct mptcp_subflow_context *subflow, *tmp;
> 
>         mptcp_for_each_subflow(msk, tmp) {
>                 subflow = bpf_core_cast(tmp, struct
> mptcp_subflow_context);

(Why do you need to cast "tmp" (struct mptcp_subflow_context *) in the
same type of pointer? I don't think it changes anything for the error
you got (see below), but it looks strange.)

>                 if (!mptcp_subflow_active(subflow))
>                         continue;
>         }
>         return 0;
> }
> 
> '''
> 
> An "arg#0 is untrusted_ptr_ expected ptr_" error occurs:
> 
> '''
> ; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
> 21: (e5) may_goto pc+1
> 22: R1=2488 R2=2488 R6=trusted_ptr_mptcp_sock(off=2488) R7=0
> R8=trusted_ptr_mptcp_sock(off=2488) R9=0 R10=fp0
> ; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
> 22: (05) goto pc-14
> 9: (79) r6 = *(u64 *)(r6 +0)          ; R6_w=ptr_list_head()
> 10: (1f) r6 -= r7                     ; R6_w=ptr_list_head() R7=0
> 11: (bf) r1 = r6                      ; R1_w=ptr_list_head()
> R6_w=ptr_list_head()
> 12: (0f) r1 += r7                     ; R1=ptr_list_head() R7=0
> 13: (1d) if r1 == r8 goto pc+9        ; R1=ptr_list_head()
> R8=trusted_ptr_mptcp_sock(off=2488)
> ; subflow = bpf_core_cast(tmp, struct mptcp_subflow_context); @
> mptcp_bpf_first.c:28
> 14: (bf) r1 = r6                      ; R1_w=ptr_list_head()
> R6=ptr_list_head()
> 15: (18) r2 = 0x6d14                  ; R2_w=27924
> 17: (85) call bpf_rdonly_cast#159867          ;
> R0_w=untrusted_ptr_mptcp_subflow_context()
> ; if (!mptcp_subflow_active(subflow)) @ mptcp_bpf_first.c:29
> 18: (bf) r1 = r0                      ;
> R0_w=untrusted_ptr_mptcp_subflow_context()
> R1_w=untrusted_ptr_mptcp_subflow_context()
> 19: (85) call mptcp_subflow_active#111397
> arg#0 is untrusted_ptr_ expected ptr_ or socket
> processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 2
> peak_states 2 mark_read 2
> -- END PROG LOAD LOG --
> '''
> 
> How can I fix this? I need your advice.

I'm not an expert in this, but I guess it means you cannot use
'mptcp_subflow_active()', because it can modify the 'subflow' structure
that you got with bpf_core_cast() for a read-only usage.

I guess it means we cannot iterate through the list and modify items
from the list "directly" with BPF. Except if there is something else we
can use, and I don't know about (which is very likely), we might have to
continue extracting the subflows into an array of a fixed size.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

