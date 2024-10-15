Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF71E6339
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990658; cv=none; b=ju+Z+PfCLky46qrncZ2QcRwlhpHuxhOjxbvGFOUcfrQHkniURDBZpk2RpIW/CaJLsP4/FFWdPXElwyaUmwjMsK5ERgjVUeksxglyMrPYuan3vsk/zk8iQi97Hah3TppPXiBGJsIF9Svy98nG9oA4ytbGNzAfAGo6AkbPhZAVz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990658; c=relaxed/simple;
	bh=ShDD1K5Yxz36M6PkVGkAg1GNikJma3qep1qYIIsqxvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gGFU8I9vGxOmkV8bUupU4/iOtWeLXt3Xzf1RFbGEx6SGdTh/TC4/wFa431Hqg+2sn0tyBYHn3NLauzNrqnVy4EbgqCrFdN3aTgaC+3Utg6O4vFgzfmkHT1O2viyz2kKkqDCp3T71h9vEn+m78bMTnP6Y14ffFM2OuvEz621yH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd4UO2I6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd4UO2I6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F70C4CEC6;
	Tue, 15 Oct 2024 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728990658;
	bh=ShDD1K5Yxz36M6PkVGkAg1GNikJma3qep1qYIIsqxvk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cd4UO2I6oClGa2fYMgO1Qe1drELnQ1/t3G1s3wGmVdS2vw5N0QKlqJs41qLtZpXIe
	 lfSUlxVmRhe2UH/lv5DfYvyUzlebFWlxsAVjREWbsej64EiUbZ2M16GKiBO5ja92/z
	 B+ggsKY6RLX/Cl6pbPkKbAZZbQlVYIb0WRpus3jKP+FR73y8jIHkiBw16J4/daQYj7
	 1Gq59V3oAgl1U5xbuzNpufCAddnbqZjXCmGUi/lNRFqaM96H7hIQvJhxf8TK6WLB3M
	 IajABHj6iNXePXamOAx3ZMcNY/VFRw7p0i35+RMdUpzM/kHXlmATVrpMTE2tOxqlTq
	 YOMMOMal6R2VQ==
Message-ID: <4f8e6390-447f-4a7b-93b5-5d17c894f8ff@kernel.org>
Date: Tue, 15 Oct 2024 13:10:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
 <30504191-4b5f-1a69-08a3-5ae0f444c802@gmail.com>
 <953bf596-94e5-4829-adec-5997e1557487@kernel.org>
 <c011f12106022a519cba25ce18d2a83a12dca184.camel@kernel.org>
 <48326975-95fc-4255-80f2-8583749194e5@kernel.org>
 <cae74d0b020f3f694d8e2f4892ca5121bbb07c67.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cae74d0b020f3f694d8e2f4892ca5121bbb07c67.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2024 11:38, Geliang Tang wrote:
> On Tue, 2024-10-15 at 11:01 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for your reply!
>>
>> On 15/10/2024 09:27, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for this review.
>>>
>>> On Mon, 2024-10-14 at 18:08 +0200, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 09/10/2024 12:05, MPTCP CI wrote:
>>>>> Hi Geliang,
>>>>>
>>>>> Thank you for your modifications, that's great!
>>>>>
>>>>> But sadly, our CI spotted some issues with it when trying to
>>>>> build
>>>>> it.
>>>>>
>>>>> You can find more details there:
>>>>>
>>>>>  
>>>>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11252652867
>>>>
>>>> I was looking at applying this series, but there are some issues
>>>> reported by the CI:
>>>>
>>>>   warning: symbol 'bpf_*mptcp_*' was not declared. Should it be
>>>> static?
>>>>
>>>> Could it be possible to have a fix for that please before
>>>> applying
>>>> the
>>>> series?
>>>
>>> No fix is ​​needed, just ignore these warnings.
>>
>> If possible, I would prefer not to ignore these warnings, because
>> other
>> CI might report the same issue. I didn't check, but can you not
>> simply
>> declare these new helpers as "static"? It looks like we can have
>> kfunc
>> declared as static, no?
>>
>>> This error is also
>>> reported in other places:
>>>
>>> $ make C=1 -o net/socket.o
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND objtool
>>>   INSTALL libsubcmd_headers
>>>   DESCEND bpf/resolve_btfids
>>>   INSTALL libsubcmd_headers
>>>   CC      net/socket.o
>>>   CHECK   net/socket.c
>>> net/socket.c:1704:21: warning: symbol 'update_socket_protocol' was
>>> not
>>> declared. Should it be static?
>>
>> In this example, you are showing one symbol that has been added for
>> MPTCP, maybe we forgot something :)
>>
>>> It seems that it is because "-Wmissing-declarations" is not
>>> recognized
>>> by sparse
>>
>> I don't see complains about that when introducing new kfunc, maybe we
>> are supposed to do something else to avoid that?
>>
>>>> I guess you are missing __bpf_kfunc_start_defs() and
>>>> __bpf_kfunc_end_defs() around the declaration of the BPF
>>>> dedicated
>>>> kfunc, no?
>>>
>>> No. __bpf_kfunc_start_defs() and __bpf_kfunc_end_defs() are indeed
>>> used
>>> in patch 2.
>>
>> Thanks, I missed that.
>>
>>>> Also, where should I apply these patches? Before "mptcp: add
>>>> sched_data
>>>> helpers"?
>>>
>>> Yes, before "mptcp: add sched_data helpers", after "selftests/bpf:
>>> Add
>>> mptcp subflow subtest".
>>
>> OK!
>>
>>>> But then there should not be any dependences on the BPF
>>>> scheduler work (and I think that would be better without this
>>>> dependence, see my comment on patch 4/7)
>>>
>>> This set doesn't have any dependence on the BPF packet scheduler
>>> since
>>> the selftest is added as a ftrace. It somehow depends on packet
>>> scheduler since it invoke some packet scheduler functions such as
>>> mptcp_subflow_active() and bpf_mptcp_subflow_tcp_sock().
>>
>> OK, but if I insert the series just after "selftests/bpf: Add mptcp
>> subflow subtest", it will not have access to mptcp_subflow_active().
>> I
>> still need to check your reply on the patch 4/7, but it would be
>> easier
>> if the test doesn't depend on "mptcp_subflow_active()": it's just a
> 
> Do you mean only drop "mptcp_subflow_active" and
> "mptcp_subflow_set_scheduled" in the test or drop all the helpers,
> include "bpf_mptcp_subflow_tcp_sock" and "bpf_mptcp_subflow_ctx"?

I initially didn't understand these kfunc would be included in patch 1,
so I thought the test would not work if this series was placed before
the other BPF scheduler patches we have in the tree.

But thinking about that, I still think it is better to avoid using
anything linked to the BPF scheduler. So yes, I think it is best not to
include these scheduler-related kfunc in this series: not in the kernel
code, nor in the BPF selftests.


> If it is the latter, the test is simplified like this, right?
> 
>         if (bpf_get_current_pid_tgid() >> 32 != pid)
>                 return 0;
> 
>         if (msk->pm.server_side || !msk->pm.subflows)
>                 return 0;
> 
>         ids = 0;
> 
>         msk = bpf_mptcp_sock_acquire(msk);
>         if (!msk)
>                 return 0;
>         bpf_for_each(mptcp_subflow, subflow, msk) {
>                 ids += subflow->subflow_id;
>         bpf_mptcp_sock_release(msk);
> 
>         return 0;
> 
> To me both are fine, which one do you prefer? I can refactor the code
> and send the squash-to patches. Or maybe a v10 is better?

Yes for the simpler test (see my reply attached to the patch 4/7)
without any references to the packet scheduler.

And yes for the v10, it will be easier. Also including your other
squash-to patch you sent: Squash to "selftests/bpf: More endpoints for
endpoint_init".

Thanks!
Matt
-- 
Sponsored by the NGI0 Core fund.

