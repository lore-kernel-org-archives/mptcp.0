Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811371D079F
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152551; cv=none; b=EcJSgCqC2bAw1pGwsYXFqqOXnqjFRA/y/zS64REEuYVsN7rcipP3lkZn4D2LHn04A8Z+8Obso0nQemUfyvrbcuN0FN/dVfxlck5kPAcDYAWcPGfcaSMBfzMbARuLlvk8vxxn5OZ8ZZLkbs2H8ozGUbV1i9/KcjFLE3CUVYsbmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152551; c=relaxed/simple;
	bh=sopR6HJTpcGK0NCl8//Mfu0jzdylv5Xk1n8fq12yAIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=igzrFq/kzIApzR+QGtxvfZle4QSjFqhBHl4ngE9kVyJ6ea25v2SE0bFHKg8h04GnHUDBDR9crr2YuvH7UDXDx4g/00Hd2EbjI/S9sooUuJElPsYXAsdjd52BgRthhgFO6ovYT88J3ksj2ONTwDPzIjPpURKWEQCE+iVgHlFEEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnFaQ6MP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnFaQ6MP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7B2C4CEC3;
	Thu, 17 Oct 2024 08:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152551;
	bh=sopR6HJTpcGK0NCl8//Mfu0jzdylv5Xk1n8fq12yAIo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VnFaQ6MP1rDva3QvdWTMjVSUV2bOsDb9/efv99y8Iqsf4IDJNG6HxHQjXfj7uw9pE
	 vjbZfjAnDs+CKvO1/1uuQJ4uNIu4soQgBFrgF7xJC/vJLws5wCrdW0IEZSticqQ99V
	 rkcsf4pmq/34bA5r55MsRVTmqDz/ytyckOC1CgGmp1Ikh1iaqcGmYNbeVc9BdmB0TC
	 w4LqWi9oEufs+YIJ67tFfCthLcVyDA5R5s7tvZQ9U7xjIZSRbA/ihl8nUL9lGI9OFn
	 57L29LAautaQIosD2IgBkPFzwOV9KHguVqzcqUN+F+OHh6YxfEVc364LSqNYbezc56
	 glsrBkMY80dOA==
Message-ID: <719a24cb-bdc1-43cb-b008-855b09e630d6@kernel.org>
Date: Thu, 17 Oct 2024 10:09:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] Squash to "bpf: Add bpf_mptcp_sched_ops"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
 <20241016-mptcp-sched-find-rcu-v1-2-5e9af4fbce11@kernel.org>
 <3aa7ba9211ce89a31eb61def9a0c51ce2cdb1c5d.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3aa7ba9211ce89a31eb61def9a0c51ce2cdb1c5d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 17/10/2024 03:29, Geliang Tang wrote:
> On Wed, 2024-10-16 at 21:05 +0200, Matthieu Baerts (NGI0) wrote:
>> Similar to the previous commit, this splat can be seen:
>>
>>   =============================
>>   WARNING: suspicious RCU usage
>>   6.12.0-rc2+ #1 Tainted: G           OE
>>   -----------------------------
>>   net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
>>
>>   other info that might help us debug this:
>>
>>   rcu_scheduler_active = 2, debug_locks = 1
>>   1 lock held by test_progs/323:
>>   ffff888007e16a40 (&st_map->lock){+.+.}-{3:3}, at:
>> bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:632)
>>
>>   stack backtrace:
>>   CPU: 0 UID: 0 PID: 323 Comm: test_progs Tainted: G          
>> OE      6.12.0-rc2+ #1
>>   Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>   Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl (lib/dump_stack.c:123)
>>    lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>>    mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
>>    bpf_mptcp_sched_init_member (net/mptcp/bpf.c:128
>> net/mptcp/bpf.c:109)
>>    ? btf_type_resolve_ptr (include/linux/btf.h:252
>> kernel/bpf/btf.c:637)
>>    bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:658)
>>    ? __might_fault (mm/memory.c:6700 (discriminator 5)
>> mm/memory.c:6693 (discriminator 5))
>>    ? __pfx_bpf_struct_ops_map_update_elem
>> (kernel/bpf/bpf_struct_ops.c:591)
>>    ? __pfx___might_resched (kernel/sched/core.c:8593)
>>    ? kasan_save_track (arch/x86/include/asm/current.h:49
>> (discriminator 1) mm/kasan/common.c:60 (discriminator 1)
>> mm/kasan/common.c:69 (discriminator 1))
>>    bpf_map_update_value (kernel/bpf/syscall.c:169)
>>    map_update_elem (kernel/bpf/syscall.c:1627)
>>    ? __pfx_map_update_elem (kernel/bpf/syscall.c:1586)
>>    __sys_bpf (kernel/bpf/syscall.c:5622)
>>    ? __pfx___sys_bpf (kernel/bpf/syscall.c:5596)
>>    __x64_sys_bpf (kernel/bpf/syscall.c:5739)
>>    ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347
>> kernel/locking/lockdep.c:4406)
>>    do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1)
>> arch/x86/entry/common.c:83 (discriminator 1))
>>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>>
>> Also similar to the previous commit, this can be fixed by adding the
>> missing rcu_read_lock().
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/bpf.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index
>> 6414824402e6449ba01efb9093b2293232a67915..a9d6b5b939a2631f17a468ee6ba
>> 4867dc33dda63 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c
>> @@ -113,6 +113,7 @@ static int bpf_mptcp_sched_init_member(const
>> struct btf_type *t,
>>  	const struct mptcp_sched_ops *usched;
>>  	struct mptcp_sched_ops *sched;
>>  	u32 moff;
>> +	int ret;
>>  
>>  	usched = (const struct mptcp_sched_ops *)udata;
>>  	sched = (struct mptcp_sched_ops *)kdata;
>> @@ -123,9 +124,12 @@ static int bpf_mptcp_sched_init_member(const
>> struct btf_type *t,
>>  		if (bpf_obj_name_cpy(sched->name, usched->name,
>>  				     sizeof(sched->name)) <= 0)
>>  			return -EINVAL;
>> -		if (mptcp_sched_find(usched->name))
>> -			return -EEXIST;
> 
> This part of mptcp_sched_find() code comes from bpf_tcp_ca_init_member,

When big chunks of code are copied from somewhere else in the kernel, do
you mind adding a comment on top of the new code: this would help
reviewers, but also developers and maintainers later when there are some
adaptations to do, e.g. to stay in sync. In case of issue, we don't lose
time trying to understand what's wrong on our side if we can quickly
compare to another part of the kernel doing something very similar.

> but it was recently deleted by commit 68b04864ca42 ("bpf: Create links
> for BPF struct_ops maps.").
> 
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct
> btf_type *t,
>                 if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
>                                      sizeof(tcp_ca->name)) <= 0)
>                         return -EINVAL;
> -               if (tcp_ca_find(utcp_ca->name))
> -                       return -EEXIST;
>                 return 1;
>         }
> 
> So we should also delete this part directly instead of adding
> rcu_read_lock.
> 
> .validate interface is added in bpf_struct_ops by commit 68b04864ca42,
> I'll implement it in both mptcp_sched_ops and mptcp_pm_ops too.

Indeed, it looks better to implement this ".validate" interface. If
that's OK, I'm planning to add the rcu_read_lock() now to avoid the
warning I mentioned. We can move this to the validation part later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

