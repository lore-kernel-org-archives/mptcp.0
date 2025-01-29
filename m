Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A01946A1
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185794; cv=none; b=DENz3bbc5HZ6bHt5WOUxc/bhbRhETiauO+pc/PS7fJ/bgNClyKjPUNR7aCxd4Epv1e1NscdL/g6pZDtlOcUoAe15NuOhjO6oNyE9PC51LTKlXiocDsPx6yAnWh49+RGF2LdrA7COyxLVEAsNKi2mtzhUypz79JYVhPZTycPYGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185794; c=relaxed/simple;
	bh=ucyZMwqPbgw0HKpfcwECeuuhCHUg5VGr3GXYNP0NWIA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iC5luP5vnM2fVfFGmjxfgiKe3Cy01VX7qKtzLst7lYceBlB9i6JzuWS5r9Oe9i+mlbW2Zb3hde3X62/SwqwcUmwTjovDBinnt/neWeXZBUsLpdb3FkJ6C1wnzatu/JGrfKtx+021YP3OypfXJMCfB1zUEe09o179Poy+43IVJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arsh7sJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arsh7sJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D26C4CED1;
	Wed, 29 Jan 2025 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738185793;
	bh=ucyZMwqPbgw0HKpfcwECeuuhCHUg5VGr3GXYNP0NWIA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Arsh7sJgTTsfvIvmFdRIB7qv52KxtqYj0nmZ8OMDa2R/e81wQImRigsyT9ZV4G7sR
	 twPFdpUbpDY1dGGZXD9ioX11qVeHr9Vm9dsD1ZtexT/I4Y+iBWwCbQZAVWhQ8qCzsa
	 1LCUDU7jLyotJeiFWUIqY+Y5CJCrFgWPB9U2cg5IATUIzvVAt0vXnlOp8ct3xZzaY7
	 YvAk6mZXhv3sISmNd+iWg7Y+0+TIyTnLca/SD0OiZgXJgUzOBbVhaw/avZgstGMFCc
	 r7rSCtZ4b3EZQi6wWsxE7gd74cuIQGg2ypiJ6i06ei564L/EkXaemmiKpzmqT+PEej
	 p3PnvanwmLFwg==
Date: Wed, 29 Jan 2025 13:23:13 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] split get_subflow interface into two
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
Message-ID: <61cc48f4-abc7-4f44-9340-028f113820e9@kernel.org>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 23 Dec 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v2:
> - use get_send for retransmit scheduling if get_retrans is NULL as Mat
>   suggested (thanks)
>

Hi Geliang -

v2 looks good for further testing on the export branch. Thanks for 
revising!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> I got the following error when running bpf burst sched selftests in auto-btf-debug mode:
>
> [  167.258293][   T49] BUG: sleeping function called from invalid context at net/core/sock.c:3652
> [  167.258981][   T49] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 49, name: kworker/0:2
> [  167.259547][   T49] preempt_count: 0, expected: 0
> [  167.259826][   T49] RCU nest depth: 1, expected: 0
> [  167.259975][   T49] 5 locks held by kworker/0:2/49:
> [  167.260137][   T49]  #0: ffff888001130948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e4/0x16b0
> [  167.260741][   T49]  #1: ffffc90000347d90 ((work_completion)(&msk->work)){+.+.}-{0:0}, at: process_one_work+0xdf9/0x16b0
> [  167.261206][   T49]  #2: ffff88800c620e58 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_worker+0x7b/0xad0
> [  167.261476][   T49]  #3: ffffffff8977e620 (rcu_read_lock){....}-{1:2}, at: __bpf_prog_enter+0x1f/0x170
> [  167.261742][   T49]  #4: ffff88800b6f8258 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: bpf_prog_87e3c1bd65224f1c_bpf_burst_get_subflow+0x12c/0x58b
> [  167.262309][   T49] CPU: 0 UID: 0 PID: 49 Comm: kworker/0:2 Tainted: G           OE      6.12.0-rc6+ #9
> [  167.262591][   T49] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  167.262774][   T49] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  167.262950][   T49] Workqueue: events mptcp_worker
> [  167.263097][   T49] Call Trace:
> [  167.263211][   T49]  <TASK>
> [  167.263301][   T49]  dump_stack_lvl+0x9e/0xe0
> [  167.263453][   T49]  __might_resched+0x35d/0x590
> [  167.263599][   T49]  ? __pfx___might_resched+0x10/0x10
> [  167.263829][   T49]  __lock_sock_fast+0x2f/0xd0
> [  167.264035][   T49]  mptcp_pm_nl_subflow_chk_stale+0x1e2/0x3c0
> [  167.264304][   T49]  ? bpf_prog_87e3c1bd65224f1c_bpf_burst_get_subflow+0x12c/0x58b
> [  167.264604][   T49]  bpf_prog_87e3c1bd65224f1c_bpf_burst_get_subflow+0x12c/0x58b
> [  167.264995][   T49]  ? mptcp_sched_get_retrans+0x1f8/0x330
> [  167.265215][   T49]  ? __pfx_mptcp_sched_get_retrans+0x10/0x10
> [  167.265432][   T49]  ? mark_lock+0x371/0x3c0
> [  167.265678][   T49]  ? __mptcp_retrans+0xf4/0x9a0
> [  167.265973][   T49]  ? mptcp_worker+0x7b/0xad0
>
> mptcp_pm_subflow_chk_stale is a sleeping function, it shouldn't be
> invoked under BPF rcu_read_lock.
>
> One solution is to set mptcp_pm_subflow_chk_stale with KF_SLEEPABLE
> flag:
>
> BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
>
> Then set bpf_burst_get_subflow with BPF_F_SLEEPABLE:
>
>      err = bpf_program__set_flags(skel->progs.bpf_burst_get_subflow,
>                                   BPF_F_SLEEPABLE);
>
> But another error ocurrs:
>
> [  101.732098][    C0] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:968
> [  101.732781][    C0] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1640, name: test_progs-no_a
> [  101.733477][    C0] preempt_count: 303, expected: 0
> [  101.733793][    C0] RCU nest depth: 2, expected: 0
> [  101.734043][    C0] 6 locks held by test_progs-no_a/1640:
> [  101.734187][    C0] #0: ffff888007526e58 (sk_lock-AF_INET){+.+.}-{0:0}, at: sk_wait_data (net/core/sock.c:3131 (discriminator 2))
> [  101.734440][    C0] #1: ffffffff95b7e620 (rcu_read_lock){....}-{1:2}, at: process_backlog (include/linux/local_lock_internal.h:38 (discriminator 1) net/core/dev.c:6115 (discriminator 1))
> [  101.734728][    C0] #2: ffffffff95b7e620 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish (include/linux/rcupdate.h:337 (discriminator 1) include/linux/rcupdate.h:849 (discriminator 1) net/ipv4/ip_input.c:232 (discriminator 1))
> [  101.735103][    C0] #3: ffff888008eb8e58 (k-slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv (include/linux/skbuff.h:1670 include/net/tcp.h:2530 net/ipv4/tcp_ipv4.c:2348)
> [  101.735560][    C0] #4: ffff8880075261d8 (slock-AF_INET){+.-.}-{2:2}, at: mptcp_incoming_options (net/mptcp/options.c:1053 net/mptcp/options.c:1203)
> [  101.736023][    C0] #5: ffffffff95b7d980 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable (include/linux/rcupdate.h:337 (discriminator 1) include/linux/rcupdate_trace.h:57 (discriminator 1) kernel/bpf/trampoline.c:966 (discriminator 1))
> [  101.736325][    C0] CPU: 0 UID: 0 PID: 1640 Comm: test_progs-no_a Tainted: G           OE      6.12.0-rc7+ #5
> [  101.736676][    C0] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  101.736940][    C0] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  101.737146][    C0] Call Trace:
> [  101.737259][    C0]  <IRQ>
> [  101.737331][    C0] dump_stack_lvl (lib/dump_stack.c:123)
> [  101.737489][    C0] __might_resched (kernel/sched/core.c:8657)
> [  101.737625][    C0] ? __lock_acquire (kernel/locking/lockdep.c:5202 (discriminator 1))
> [  101.737772][    C0] ? __pfx___might_resched (kernel/sched/core.c:8611)
> [  101.737919][    C0] __might_fault (mm/memory.c:6715 (discriminator 1))
> [  101.738051][    C0] __bpf_prog_enter_sleepable (include/linux/bpf.h:2089 (discriminator 1) kernel/bpf/trampoline.c:970 (discriminator 1))
> [  101.738195][    C0] ? __bpf_prog_enter_sleepable (include/linux/rcupdate.h:337 (discriminator 1) include/linux/rcupdate_trace.h:57 (discriminator 1) kernel/bpf/trampoline.c:966 (discriminator 1))
> [  101.738357][    C0] ? mptcp_sched_get_send (net/mptcp/sched.c:183)
> [  101.738511][    C0] ? __pfx_mptcp_sched_get_send (net/mptcp/sched.c:158)
> [  101.738641][    C0] ? __bpf_tramp_enter (include/linux/rcupdate.h:347 (discriminator 1) include/linux/rcupdate.h:880 (discriminator 1) include/linux/percpu-refcount.h:209 (discriminator 1) include/linux/percpu-refcount.h:222 (discriminator 1) kernel/bpf/trampoline.c:1010 (discriminator 1))
> [  101.738774][    C0] ? bpf_trampoline_6442561300+0x31/0xd7
> [  101.738911][    C0] ? mptcp_sched_get_send (net/mptcp/sched.c:158)
> [  101.739067][    C0] ? __mptcp_subflow_push_pending (net/mptcp/protocol.c:1682 (discriminator 1))
> [  101.739231][    C0] ? __pfx___mptcp_subflow_push_pending (net/mptcp/protocol.c:1655)
> [  101.739378][    C0] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 1) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 1) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 1) include/asm-generic/qspinlock.h:111 (discriminator 1) kernel/locking/spinlock_debug.c:116 (discriminator 1))
> [  101.739556][    C0] ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
> [  101.739743][    C0] ? mptcp_incoming_options (net/mptcp/options.c:1067 net/mptcp/options.c:1203)
>
> This means get_send() interface of this scheduler can't be set with
> BPF_F_SLEEPABLE flag since it's invoked in ack_update_msk() under mptcp
> data lock.
>
> So this patch has to split get_subflow() interface of packet scheduer into
> two interfaces: get_send() and get_retrans(). Then we can set get_retrans()
> interface alone with BPF_F_SLEEPABLE flag.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/529
>
> Geliang Tang (9):
>  mptcp: split get_subflow interface into two
>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "selftests/bpf: Add bpf_first scheduler & test"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
>  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
>  Squash to "selftests/bpf: Add bpf_red scheduler & test"
>  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
>  Squash to "bpf: Export mptcp packet scheduler helpers"
>  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
>
> include/net/mptcp.h                           |  5 +--
> net/mptcp/bpf.c                               | 13 +++++--
> net/mptcp/sched.c                             | 35 +++++++++++++------
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 14 ++++++--
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  4 +--
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 22 +++++-------
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  4 +--
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  4 +--
> .../selftests/bpf/progs/mptcp_bpf_rr.c        |  4 +--
> 9 files changed, 65 insertions(+), 40 deletions(-)
>
> -- 
> 2.45.2
>
>
>
