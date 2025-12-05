Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D1329392
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942476; cv=none; b=GMJSXkLXumOmONbUMEEl/Y+D9sUmLlJODsTjPWYeI9FAilTfdAfAPH7wa/xS/0xMp2OgbhSs1pHv1qgzN0yEEsHTcE9a9fQlBc6IjAMKimjSS24lzm/XAh8n/c0uWVhRDy6ug7t/8qQky9+JsoanSgtF+XcT61ybj9b+wWZwY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942476; c=relaxed/simple;
	bh=pGra20UjN/H/euv3lCCNsRzmZXWeFcXwaKdlp3sIjQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROo9e/6lmAiNbUg5u2Hao/WGa1sOVHtYWrJJd6ZuQ2KND7S6P+AnWW1ZdXL/lTb9TA/kODAtjwAb0TzUUcnh1ag7lNhftKWewcrgK0yGlv7Lz3hWh2Pt9zsdYX9QNJQU2AutpayeExDbPc7GiIylAByFHillDE8fgpneQD3OvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCk1eD/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCk1eD/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D41C4CEF1;
	Fri,  5 Dec 2025 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764942475;
	bh=pGra20UjN/H/euv3lCCNsRzmZXWeFcXwaKdlp3sIjQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCk1eD/1aDRgm0EPsykni3JMaKeWbzIX5LTDqd9jyh9v6U4rKa5YuI2JFlZu57j6D
	 HxqmZ3Lu/FCTWn/j6Xmo1fSkjRtpTMRYMmWG+bg8KPpqDQRk9e51MZLa4oinukTFYg
	 OEZOtAaLumvYsGSzUL/toZow4d0Ny6AnqQitlJQdhZbho0cHYe2ufcQIUFNDUVPJuA
	 X/4wTQP8Y8fcKMSQWusRleONW70wuBEN4etS7JW1INB9iepzDg8OspZJyTHI9JC34B
	 r2KMsjJVNOLCMXnidFupWaPwXWOZvih7sxOWIyr5zSx1nEIt5P1w6KtforKFaLt8Sv
	 XxKygulm4Zelw==
Message-ID: <01a8fa17-6223-410c-921f-985d02ff880b@kernel.org>
Date: Fri, 5 Dec 2025 14:47:52 +0100
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
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
 <e41302f4-6866-49a1-a1bd-49804fe0a6b9@kernel.org>
 <ffcda047-0f64-4348-a65b-d3c2d139e6e4@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ffcda047-0f64-4348-a65b-d3c2d139e6e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/12/2025 09:06, Paolo Abeni wrote:
> On 12/4/25 6:44 PM, Matthieu Baerts wrote:
>> On 03/12/2025 19:55, Paolo Abeni wrote:
>>> Jakub reported an MPTCP deadlock at fallback time:
>>>
>>>  WARNING: possible recursive locking detected
>>>  6.18.0-rc7-virtme #1 Not tainted
>>>  --------------------------------------------
>>>  mptcp_connect/20858 is trying to acquire lock:
>>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280
>>>
>>>  but task is already holding lock:
>>>  ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>>
>>>  other info that might help us debug this:
>>>   Possible unsafe locking scenario:
>>>
>>>         CPU0
>>>         ----
>>>    lock(&msk->fallback_lock);
>>>    lock(&msk->fallback_lock);
>>>
>>>   *** DEADLOCK ***
>>>
>>>   May be due to missing lock nesting notation
>>>
>>>  3 locks held by mptcp_connect/20858:
>>>   #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
>>>   #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
>>>   #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0
>>>
>>>  stack backtrace:
>>>  CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
>>>  Hardware name: Bochs, BIOS Bochs 01/01/2011
>>>  Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0x6f/0xa0
>>>   print_deadlock_bug.cold+0xc0/0xcd
>>>   validate_chain+0x2ff/0x5f0
>>>   __lock_acquire+0x34c/0x740
>>>   lock_acquire.part.0+0xbc/0x260
>>>   _raw_spin_lock_bh+0x38/0x50
>>>   __mptcp_try_fallback+0xd8/0x280
>>>   mptcp_sendmsg_frag+0x16c2/0x3050
>>>   __mptcp_retrans+0x421/0xaa0
>>>   mptcp_release_cb+0x5aa/0xa70
>>>   release_sock+0xab/0x1d0
>>>   mptcp_sendmsg+0xd5b/0x1bc0
>>>   sock_write_iter+0x281/0x4d0
>>>   new_sync_write+0x3c5/0x6f0
>>>   vfs_write+0x65e/0xbb0
>>>   ksys_write+0x17e/0x200
>>>   do_syscall_64+0xbb/0xfd0
>>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>  RIP: 0033:0x7fa5627cbc5e
>>>  Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>>>  RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>>  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
>>>  RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
>>>  RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
>>>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
>>>  R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c
>>>
>>> The packet scheduler could attempt a reinjection after receiving an
>>> MP_FAIL and before the infinite map has been transmitted, causing a
>>> deadlock since MPTCP needs to do the reinjection atomically from WRT
>>> fallback.
>>>
>>> Address the issue explicitly avoiding the reinjection in the critical
>>> scenario. Note that this is the only fallback critical section that
>>> could potentially send packets and hit the double-lock.
>>
>> Thank you for the fix!
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Out-of-curiosity: any idea why we only see it now while the fix tag is
>> from July? :)
> 
> The deadlock is deterministic, when the relevant pre-conditions are
> reached; but such pre-req are quite/very unlikely:
> 
> - the peer send an MP_FAIL [1]
> - the ssk/pm/msk tries to send an ack reply with infinite mapping
> - allocation of such skb fails [2]
> - the scheduler kick a mptcp-level retransmission before any other
>   later transmit [3]
> 
> Eech of [1], [2] and [3] is quite/very unlikely and we need all of them
> with suitable/strict time scheduling.

Thank you for your reply!

[1] is expected in this selftest, [3] I can understand, but not [2]. Or
an issue with the memory size allocated per VM in the new NIPA LF machines?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

