Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690995;
	b=qCrDY1N58SJaiiJJxjfzvd0/Kbab32ihsHnljIoCIivqJj7KJJTLAnaA57eB+nH2UHa3
	 IRiT0QBjtAKxTLCS7ZuJHfLds/AsKd9oxqYVS105p2XuPWzwixAVwo/dP5A43uHh75kA1
	 xjrDj/SZk0kajp55waVUpqQureiKYbNNy3tu2ZrqrY3swktUqNLwgneXdevL+4q9tJYzS
	 t3BAsci0glARTOmb7YhbN5C/bdPFSvKdcJYdeQqZj/sxJ6saXoKw3lv/R2z5BhhfPflLk
	 unwCTd0YOfG6aDBfZcHwcpSubEdI75fu6Y1xHxrIj0gvU4Poju3saS1e7D9pxJ7GDIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WeZ3zEYH3JmududU5goAPn8N7F6wq9GHk4hM30HWx1g=;
	b=HE3eqhId289Au79Lkjyl+pThDJxzqRDwF3e4nC5rlpRMxEA7sDiT9CMJ7YNLn65kii+A
	 5g+bztdC4QJJkw7jrMPW80zYyCegOoIsnoihfLoFjsmSUFWVCVR1AOPVtGhaBBoyrgeEi
	 DqFAmV23sN+gC/TNuiu1uhfrv8xq3+lA+73y9TJxVsteNw2T9uQBrYM5BZRoRgSNxcDyc
	 YmrN5ulj9BGV4kOH7PkphGrWSZw+C05raqxWtlEW+PbDRGClX8AkHxNauzldk2KOUESD9
	 NqASSaZJIwgRLpQ/RD+Q682IY1JQESFNXESLBufH/t/XKfSmRwOVRuvIPhZ5mRPZf6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+00Y2oB;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4D606A329
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 07:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9E4D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+00Y2oB
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso2061587a12.1
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 23:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690994; x=1794295794; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WeZ3zEYH3JmududU5goAPn8N7F6wq9GHk4hM30HWx1g=;
        b=z+00Y2oBJsqTIy4LM3k77gkK5g3vXsQP6oJNoN2qfu7yogYotLTzvmX9byN7LiJjQc
         HMpK23hveftK/eV6+vLnAzdU6/5yPxaQ6uPEInQSTuUeb/KN9jCkCI02JgazKvHhq3b1
         vI267cjO+9J+YckLKnacvNlcjANo//aryGi2lVjfVhaY6dKeMMsyUpK00tSjeKSEcpCp
         Swz+n4oR5Sfs9Boe/qT64SAoooinJtmp+izymuVI0IUPZm2UXfO0ijXOG1y6rYUGueGj
         SWTu63qcRS702Q5bkAuTSN23W7Y4yWBcecHKVghKI0HdrZ5qJ7ZZ7h4pPoP0sM2ephfC
         5HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690994; x=1794295794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeZ3zEYH3JmududU5goAPn8N7F6wq9GHk4hM30HWx1g=;
        b=A5NOVHADHLyKFSqET5Zt7CfvL/pXfRNRu0gSuo/E+/70lBsfQagHxNfK9HhmD8n2Wu
         GdCNtYwRUnBKV3yfO1y7IX226Ym6MR7bp8eVXDUP69YpxoYAhbmOaRgwAaKexxMm3HMo
         klKP6D2ZILXeZrV4d2XoHvo8J5LVoeQA7qZDzsvDShHMYizgvpduTABrusE2L7SOYtpO
         jdbPEQiPwZGSOn/M85/RdVVWAWjU/cGAMSKkj6disw0WtuiPiW6fa1dO6mco6q7T+EHH
         viKlVS/4bSI/YGeFd21pMiIOkp1VwfffJ5jQh3bwkAqxl1g6lbzIIwgNgo5cCy7hNQ6Y
         /YwA==
X-Forwarded-Encrypted: i=1; AKwUvBylKvWjUkNeoyCdhuIqibQ0jNi9ivpxLWzrzy4/oQ40ky3K5lCaVzmb4odXAPIeXJ8gvxehxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Rd1KOcK/fIFM6PlAV0BCdqgHHy5/GHN0cYDLQHuWvJmSk1z/X
	YRP5D+6bf311NEYhtyItmPc8SGlrqLLtdcnPrhPpR1DCbvYLhz7gNHQR
X-Gm-Gg: AYBFou28tkQ9qE3yq+/dYpOI6qYJhMcIXcUpl/T3cCt32Yyod3YQAbRQvixukVcDpdL
	ypooaPj4mgkfuOZvIOUMBWxbAIy31rdH6cm6s69LKGFuqHexw/nUnJ57pPpm4A0d2mih4WM6xlY
	nSSuJ001Qpje4ulLBJlOGxaAjo8RfFSTOSLN/1xR9WE147IzXA9DTV59h3ciDtdJJJGvmFlJzy7
	QJmbOSxcy7SBc26fUGXSl1lL2Qqlo9OXWRL0sZH4TIlAF1znRZhHOzIMDQD0QA3zbjeLz5QgXuD
	dGfGAyEVRnVWxGXh74uULcPq52v8S5Qg9Aux6/qGDqDi2HUjBGRbgDCeCf3gPZupZDRykQu+HoV
	HzOq0iS9u0prC5G1BP3ATIFVKFxtgJ00e1z/qtMAEgni+vRWQX3lg8WYZaBBJ0Nx8AvA57t7E7U
	AnNN/KzQdkSNnh7g1KjgyPav65Z3rEY6z61RiLngPfto3BWbWAQHq8vIAhG7PNFQTZyMkdQFBOD
	vdl+hKbuDR8sJdPuRlwvgFgdynXBzye2rWrX7AXEw3PELXarp784OdKzW0yE7oXporxT9Lfklas
	sLWbrzQhkQKu5G9eJ3qncGAgN1ZpJvrEq37aUTQlz9CgDuqVDoE6JmZ57/pqIeyUcrcl
X-Received: by 2002:a17:90b:2882:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ae89574cd6mr10799919a91.1.1793690993961;
        Mon, 02 Nov 2026 23:29:53 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c627260sm2949385a91.8.2026.11.02.23.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:29:53 -0800 (PST)
Date: Tue, 3 Nov 2026 16:29:48 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] mptcp: fix use-after-free of the subflow context on
 the delegated list
Message-ID: <aumNbD0vtdtLgWN9@v4bel>
References: <aoWBrkNwebJe-koh@v4bel>
 <bf25121c-72cf-40a7-bbaf-5db85aee7f59@kernel.org>
 <aobtmznTdBks0frM@v4bel>
 <994ecd4f-eaf9-4d2f-95a3-611083207d6c@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994ecd4f-eaf9-4d2f-95a3-611083207d6c@kernel.org>

On Tue, Sep 08, 2026 at 07:46:19PM +0200, Matthieu Baerts wrote:
> Hi Hyunwoo,
> 
> On 20/08/2026 14:05, Hyunwoo Kim wrote:
> > On Wed, Aug 19, 2026 at 12:22:18PM +0200, Matthieu Baerts wrote:
> >> Hi Hyunwoo,
> >>
> >> On 19/08/2026 12:13, Hyunwoo Kim wrote:
> >>> mptcp_subflow_delegate() links the subflow context into a per-CPU napi
> >>> list and takes a reference on the subflow socket. The context is a
> >>> separate allocation, reached through icsk_ulp_data, and the list holds
> >>> no reference to it.
> >>>
> >>> inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
> >>> outstanding references. That path ends in tcp_cleanup_ulp(), which calls
> >>> subflow_ulp_release(). subflow_ulp_release() frees the context with
> >>> kfree_rcu() but does not remove it from the list. Once the grace period
> >>> elapses and the context is actually freed, the next mptcp_napi_poll()
> >>> dequeues that entry and mptcp_subflow_delegated_next() writes to the
> >>> freed context with list_del_init(). That is the use-after-free.
> >>>
> >>> The freeing path cannot dequeue the entry itself: the list is per-CPU
> >>> and only the CPU that queued the subflow may touch it, as
> >>> tcp_release_cb_override() already notes.
> >>>
> >>> Delay the free instead. Add MPTCP_DELEGATE_DEAD.
> >>> mptcp_subflow_free_ctx() sets it and frees the context only if the
> >>> subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
> >>> bit is set when it clears the scheduled bit. Either
> >>> mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
> >>> leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
> >>> first, does not see the dead bit and mptcp_subflow_free_ctx() does the
> >>> free.
> >>>
> >>> Also skip mptcp_subflow_process_delegated() once the dead bit is set.
> >>> subflow_ulp_release() has already dropped the msk reference by then, so
> >>> the pending actions must not run.
> >>>
> >>> Finally, move delegated_status out of struct_group(reset).
> >>> mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
> >>> the scheduled bit while the entry is still queued would let
> >>> mptcp_subflow_free_ctx() free a context the napi list still points to.
> >>> delegated_node is already outside the group.
> >> Thank you for looking at this. Do you have more context about how the
> >> bug was discovered? Do you have a reproducer and/or a KASAN calltrace or
> >> similar?
> >>
> >> Having this would help the reviewers.
> > 
> > Sorry for the late reply. The poc was extremely unstable, so I wanted 
> > to improve its reproduction rate a bit before sending it.
> 
> No delay at all when compared to my reply, sorry!
> > Attached are the poc, the KASAN log, and the mdelay diff used for 
> > reproduction.
> 
> By chance, do you have a decoded stack trace? e.g. using the following
> script with the vmlinux and modules used to generate the KASAN trace:
> 
>   ./scripts/decode_stacktrace.sh
> 
> Note that we are still looking at a possible simpler fix, but no luck so
> far. In any cases, we will take this patch in our tree first, then send
> it to netdev.

Ah.. I had missed this mail.

It seems this issue has not been resolved in netdev yet. May I ask how
you plan to handle it?


decode trace:

[   40.361339] ==================================================================
[   40.361745] BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report (lib/list_debug.c:49)
[   40.362167] Read of size 8 at addr ffff88800cc13cc8 by task poc/88
[   40.362476]
[   40.362564] CPU: 3 UID: 65534 PID: 88 Comm: poc Not tainted 7.2.0-rc7 #1 PREEMPT(lazy)
[   40.362566] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   40.362568] Call Trace:
[   40.362569]  <IRQ>
[   40.362570]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   40.362574]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   40.362577]  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock.h:122 (discriminator 4))
[   40.362580]  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
[   40.362582]  kasan_report (mm/kasan/report.c:595)
[   40.362584]  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
[   40.362586]  __list_del_entry_valid_or_report (lib/list_debug.c:49)
[   40.362588]  mptcp_napi_poll (include/linux/list.h:132 include/linux/list.h:246 include/linux/list.h:318 net/mptcp/protocol.h:787 net/mptcp/protocol.c:4620)
[   40.362591]  ? call_timer_fn (kernel/time/timer.c:1748)
[   40.362593]  __napi_poll (net/core/dev.c:7735)
[   40.362596]  ? __pfx_delayed_work_timer_fn (include/linux/list.h:404 (discriminator 2))
[   40.362599]  net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
[   40.362601]  ? __pfx_net_rx_action (include/net/gro.h:525)
[   40.362603]  ? _raw_spin_lock_irq (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:174)
[   40.362605]  ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:183)
[   40.362607]  ? try_to_wake_up (include/linux/spinlock.h:571 kernel/sched/core.c:4292)
[   40.362611]  handle_softirqs (kernel/softirq.c:622)
[   40.362614]  ? __pfx_handle_softirqs (include/linux/wait_bit.h:77)
[   40.362615]  ? __hrtimer_rearm_deferred (kernel/time/hrtimer.c:707 kernel/time/hrtimer.c:2141 kernel/time/hrtimer.c:2161)
[   40.362618]  do_softirq (kernel/softirq.c:523 (discriminator 20) kernel/softirq.c:510 (discriminator 20))
[   40.362619]  </IRQ>
[   40.362620]  <TASK>
[   40.362620]  __local_bh_enable_ip (kernel/softirq.c:450)
[   40.362621]  inet_stream_connect (net/ipv4/af_inet.c:756)
[   40.362624]  __sys_connect (net/socket.c:2154)
[   40.362627]  ? __pfx___sys_connect (net/socket.c:2136)
[   40.362630]  ? __sys_setsockopt (include/linux/file.h:63 include/linux/file.h:83 net/socket.c:2385)
[   40.362632]  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
[   40.362633]  ? fpregs_assert_state_consistent (include/linux/instrumented.h:82 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:133 arch/x86/kernel/fpu/core.c:912)
[   40.362636]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   40.362639]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   40.362641] RIP: 0033:0x4216eb
[   40.362643] Code: 48 89 e5 48 83 ec 10 89 55 f8 48 89 75 f0 89 7d fc e8 b9 ec 02 00 8b 55 f8 48 8b 75 f0 41 89 c0 8b 7d fc b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 89 45 fc e8 12 ed 02 00 8b 45 fc
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 10          	sub    $0x10,%rsp
   7:	89 55 f8             	mov    %edx,-0x8(%rbp)
   a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  11:	e8 b9 ec 02 00       	call   0x2eccf
  16:	8b 55 f8             	mov    -0x8(%rbp),%edx
  19:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  1d:	41 89 c0             	mov    %eax,%r8d
  20:	8b 7d fc             	mov    -0x4(%rbp),%edi
  23:	b8 2a 00 00 00       	mov    $0x2a,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 2d                	ja     0x5f
  32:	44 89 c7             	mov    %r8d,%edi
  35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  38:	e8 12 ed 02 00       	call   0x2ed4f
  3d:	8b 45 fc             	mov    -0x4(%rbp),%eax

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 2d                	ja     0x35
   8:	44 89 c7             	mov    %r8d,%edi
   b:	89 45 fc             	mov    %eax,-0x4(%rbp)
   e:	e8 12 ed 02 00       	call   0x2ed25
  13:	8b 45 fc             	mov    -0x4(%rbp),%eax
[   40.362644] RSP: 002b:00007fbe0147b1d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
[   40.362646] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00000000004216eb
[   40.362648] RDX: 0000000000000010 RSI: 00007fbe0147b200 RDI: 000000000000000a
[   40.362648] RBP: 00007fbe0147b1e0 R08: 0000000000000000 R09: 0000000000000000
[   40.362649] R10: 00007fbe0147b1f8 R11: 0000000000000293 R12: 00007fbe0147b1f8
[   40.362650] R13: 00007fbe0157b678 R14: 00007fbe0147b1f4 R15: 00007fffd4bc16c0
[   40.362652]  </TASK>
[   40.362653]
[   40.373597] Allocated by task 90:
[   40.373755]  kasan_save_stack (mm/kasan/common.c:57)
[   40.373934]  kasan_save_track (mm/kasan/common.c:78)
[   40.374113]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[   40.374288]  __kmalloc_cache_noprof (include/linux/kasan.h:263 mm/slub.c:5489)
[   40.374500]  subflow_create_ctx (include/linux/slab.h:988 include/linux/slab.h:1309 net/mptcp/subflow.c:1845)
[   40.374690]  subflow_ulp_init (net/mptcp/subflow.c:1977)
[   40.374873]  tcp_set_ulp (net/ipv4/tcp_ulp.c:146 net/ipv4/tcp_ulp.c:167)
[   40.375043]  mptcp_subflow_create_socket (net/mptcp/subflow.c:1806)
[   40.375271]  __mptcp_nmpc_sk.part.0 (net/mptcp/protocol.c:111 net/mptcp/protocol.c:143)
[   40.375479]  mptcp_connect (net/mptcp/protocol.c:139 net/mptcp/protocol.c:4009)
[   40.375651]  __inet_stream_connect (net/ipv4/af_inet.c:684)
[   40.375857]  inet_stream_connect (net/ipv4/af_inet.c:755)
[   40.376046]  __sys_connect (net/socket.c:2154)
[   40.376218]  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
[   40.376402]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   40.376574]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   40.376805]
[   40.376884] Freed by task 22:
[   40.377027]  kasan_save_stack (mm/kasan/common.c:57)
[   40.377206]  kasan_save_track (mm/kasan/common.c:78)
[   40.377385]  kasan_save_free_info (mm/kasan/generic.c:584)
[   40.377579]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   40.377761]  kvfree_rcu_cb (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6662)
[   40.377936]  rcu_core (kernel/rcu/tree.c:2645 kernel/rcu/tree.c:2897)
[   40.378098]  handle_softirqs (kernel/softirq.c:622)
[   40.378280]  run_ksoftirqd (kernel/softirq.c:1076 kernel/softirq.c:1068)
[   40.378449]  smpboot_thread_fn (kernel/smpboot.c:160)
[   40.378638]  kthread (kernel/kthread.c:436)
[   40.378792]  ret_from_fork (arch/x86/kernel/process.c:158)
[   40.378967]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   40.379150]
[   40.379228] Last potentially related work creation:
[   40.379453]  kasan_save_stack (mm/kasan/common.c:57)
[   40.379631]  kasan_record_aux_stack (mm/kasan/generic.c:556)
[   40.379834]  __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3159)
[   40.380066]  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
[   40.380245]  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
[   40.380446]  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
[   40.380652]  __tcp_close (net/ipv4/tcp.c:3299)
[   40.380820]  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
[   40.381013]  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
[   40.381216]  mptcp_destroy (net/mptcp/protocol.c:3651)
[   40.381386]  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
[   40.381585]  __mptcp_close (net/mptcp/protocol.c:3386)
[   40.381759]  mptcp_close (net/mptcp/protocol.c:3401)
[   40.381920]  inet_release (net/ipv4/af_inet.c:442)
[   40.382088]  __sock_release (net/socket.c:710)
[   40.382264]  sock_close (net/socket.c:1501 (discriminator 1))
[   40.382423]  __fput (fs/file_table.c:512)
[   40.382574]  fput_close_sync (fs/file_table.c:617)
[   40.382753]  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
[   40.382929]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   40.383100]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   40.383330]
[   40.383411] Second to last potentially related work creation:
[   40.383672]  kasan_save_stack (mm/kasan/common.c:57)
[   40.383850]  kasan_record_aux_stack (mm/kasan/generic.c:556)
[   40.384053]  kvfree_call_rcu (mm/slab_common.c:1288)
[   40.384229]  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
[   40.384409]  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
[   40.384608]  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
[   40.384815]  __tcp_close (net/ipv4/tcp.c:3299)
[   40.384982]  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
[   40.385175]  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
[   40.385377]  mptcp_destroy (net/mptcp/protocol.c:3651)
[   40.385547]  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
[   40.385746]  __mptcp_close (net/mptcp/protocol.c:3386)
[   40.385921]  mptcp_close (net/mptcp/protocol.c:3401)
[   40.386082]  inet_release (net/ipv4/af_inet.c:442)
[   40.386250]  __sock_release (net/socket.c:710)
[   40.386427]  sock_close (net/socket.c:1501 (discriminator 1))
[   40.386584]  __fput (fs/file_table.c:512)
[   40.386734]  fput_close_sync (fs/file_table.c:617)
[   40.386912]  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
[   40.387087]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   40.387259]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   40.387491]
[   40.387570] The buggy address belongs to the object at ffff88800cc13c00
[   40.387570]  which belongs to the cache kmalloc-512 of size 512
[   40.388121] The buggy address is located 200 bytes inside of
[   40.388121]  freed 512-byte region [ffff88800cc13c00, ffff88800cc13e00)
[   40.388662]
[   40.388741] The buggy address belongs to the physical page:
[   40.388994] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcc10
[   40.389344] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   40.389689] flags: 0x100000000000040(head|node=0|zone=1)
[   40.389932] page_type: f5(slab)
[   40.390083] raw: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
[   40.390431] raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[   40.390777] head: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
[   40.391126] head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[   40.391477] head: 0100000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
[   40.391827] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   40.392175] page dumped because: kasan: bad access detected
[   40.392428]
[   40.392507] Memory state around the buggy address:
[   40.392727]  ffff88800cc13b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   40.393051]  ffff88800cc13c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   40.393376] >ffff88800cc13c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   40.393701]                                               ^
[   40.393953]  ffff88800cc13d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   40.394277]  ffff88800cc13d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   40.394603] ==================================================================


Best regards,
Hyunwoo Kim
