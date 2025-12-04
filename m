Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD62135CE
	for <mptcp@lists.linux.dev>; Thu,  4 Dec 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872873; cv=none; b=FlufAgAfaQv45Bukv0vQ8aPs+fRlDAX4nCRFMBAFqhLaFVaU13Hbz3kuUZWmTD4dpsuwXOWYnEMap4Fcll9p2+jxifC6gneS4W9TVFP12nACY0lo1RaTTyLhsFeowGhD56HUzmrQHjhCF4cK3+JoVnDMCMMV4eZBW3zYJ31Z3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872873; c=relaxed/simple;
	bh=su1hvdiGudrEdxyqUV2rlIqRfHWLgKIWs2022ViSC9Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oEda4DN4X79xI6VUSSIX3Rk4nZgaWsjZTYjWJ49Hrh++JMQo21LKuvXCPMI27RawOVFQMQzxFSP1g9dyQ5PmsRNJuzBoj/xp8gn7xCR7suXlDFAlJ/GHGQmuFf+p11y8MU73l5DMQy0r990mpEtdLmhuYNuyfwKUAeXRStGB5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgaYXGUL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgaYXGUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDFEC4CEFB;
	Thu,  4 Dec 2025 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764872872;
	bh=su1hvdiGudrEdxyqUV2rlIqRfHWLgKIWs2022ViSC9Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BgaYXGULIJZ1r2HtvcZ4LgrOJ6YfImOXFmJN+0u80RIyzpEHRYfpo8Bs97bVO7OUJ
	 k3lmr0skC46GyD5AzDuZsx1nIdXe8JVX9LBsw8YhhD2txAkLg9y+YBb/cD1sUpud08
	 E6G1I/4CPeWd/WUxLQw4kp2Ow51jabLX7+IPE1Bpzm+XyQszYkmrvmuMncgnl8Iq10
	 cVRHLWsWCqmxsIEfPRYiI1LVaDEiAw5ihq7Pvl3ceLqX2dnzdZKkOnQGWCyw6/Y/bo
	 tDYjtQKC5lEoYXl/JqZOU0NFs0erpZpFzx4KX10Tqw+7Wqt5V0pm3x8QeCBqif7xTQ
	 x4gHzdhgGbgqg==
Message-ID: <a966baba-1794-4ee7-8fd9-09def1234f7b@kernel.org>
Date: Thu, 4 Dec 2025 19:27:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: avoid deadlock on fallback while
 reinjecting
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
 <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/12/2025 18:44, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 03/12/2025 19:55, Paolo Abeni wrote:
>> Jakub reported an MPTCP deadlock at fallback time:
>>
>>  WARNING: possible recursive locking detected
>>  6.18.0-rc7-virtme #1 Not tainted
>>  --------------------------------------------
>>  mptcp_connect/20858 is trying to acquire lock:
>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280
>>
>>  but task is already holding lock:
>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>
>>  other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&msk->fallback_lock);
>>    lock(&msk->fallback_lock);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>>  3 locks held by mptcp_connect/20858:
>>   #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
>>   #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
>>   #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>
>>  stack backtrace:
>>  CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
>>  Hardware name: Bochs, BIOS Bochs 01/01/2011
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x6f/0xa0
>>   print_deadlock_bug.cold+0xc0/0xcd
>>   validate_chain+0x2ff/0x5f0
>>   __lock_acquire+0x34c/0x740
>>   lock_acquire.part.0+0xbc/0x260
>>   _raw_spin_lock_bh+0x38/0x50
>>   __mptcp_try_fallback+0xd8/0x280
>>   mptcp_sendmsg_frag+0x16c2/0x3050
>>   __mptcp_retrans+0x421/0xaa0
>>   mptcp_release_cb+0x5aa/0xa70
>>   release_sock+0xab/0x1d0
>>   mptcp_sendmsg+0xd5b/0x1bc0
>>   sock_write_iter+0x281/0x4d0
>>   new_sync_write+0x3c5/0x6f0
>>   vfs_write+0x65e/0xbb0
>>   ksys_write+0x17e/0x200
>>   do_syscall_64+0xbb/0xfd0
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>  RIP: 0033:0x7fa5627cbc5e
>>  Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>>  RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
>>  RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
>>  RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
>>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
>>  R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c
>>
>> The packet scheduler could attempt a reinjection after receiving an
>> MP_FAIL and before the infinite map has been transmitted, causing a
>> deadlock since MPTCP needs to do the reinjection atomically from WRT
>> fallback.
>>
>> Address the issue explicitly avoiding the reinjection in the critical
>> scenario. Note that this is the only fallback critical section that
>> could potentially send packets and hit the double-lock.
> 
> Thank you for the fix!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Out-of-curiosity: any idea why we only see it now while the fix tag is
> from July? :)
> 
> Do you want to send it to netdev ASAP, or do you prefer if I do it?
> Should I do it now, or can I send it with other fixes tomorrow?

We still need these patches in our tree anyway, so here they are:

New patches for t/upstream-net and t/upstream:
- 372aa8a6919d: mptcp: avoid deadlock on fallback while reinjecting
- Results: 00ccc7a6f72d..d4a49e165085 (export-net)
- Results: f83b9a74e823..e6e1c3ebe99c (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/5dd0db8d894823fbbaac17b23cc174be4dddd58b/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/db27293f26f389e0aa4807c47fc09a0cc1366702/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

