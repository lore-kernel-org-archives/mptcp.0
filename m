Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC872
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632405004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a998HBsbGMDMXGWAeDnEwq1ThV4M20lglsxMzz7VfUk=;
	b=BSVXoKOhQEEPLQmEnKvvqq6O3hbSgyhrirh8xMDUIwS3UlY+tDr/lIDSdLTqacM2HxgiHL
	N/Zh7dFYbhuIIYEZMAUEM3QAxDSwXTMvJE9KNB5WWXYX81H/aW/e+OydE4Vz+AtfkdrVS9
	ejUnFCZ3XQs8eyPLHSVLEy23eX1afcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-yCoXlmHqOaS3BwHzZt-PTA-1; Thu, 23 Sep 2021 09:50:00 -0400
X-MC-Unique: yCoXlmHqOaS3BwHzZt-PTA-1
Received: by mail-wr1-f71.google.com with SMTP id u10-20020adfae4a000000b0016022cb0d2bso5155691wrd.19
        for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=a998HBsbGMDMXGWAeDnEwq1ThV4M20lglsxMzz7VfUk=;
        b=XU8VIL533n7uZP3V4gZtSDMZWobfVSEJjpSyC3JL3Pt+TkysxYIUhxmp83MWBv3+dg
         7w5fQTp8G+sizupHWvEveT80kTqKMeqeTRl/jve1OnqpswkejlmJV2eHASvHxZ7PmyLU
         PWO9ZYQSaZg3Ld9th91FPfKaahfqOx1HYc0JxuumRrD5nLDwazE3cgH1hhKhYMBhu5sg
         qxZZf/A3tBzCH/kpa5vpx00FULbqDKtAhHigish4V35WhXvq+jD6oVOWZ4c3bUpRisTz
         uHkSdqc2xxCHjBFWmVH2K8MtMzYc/ksxyK5gs6tIjhlmLERspsApjW/UJPTEGUlCJUgp
         j5Fw==
X-Gm-Message-State: AOAM533jJtoLZoueanS0jFBeHkhpATeMe72S76Tpu6NBNAEQ9lsMPMVC
	TyUY6MCEVwlzyxQEglxfcZifV6t2i2ua5YRUPc9jMUc1n01rYCNXegMbTOG1UOiXHB58h6CO6/7
	Dz9XCByh2VR3K1dw=
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr4614182wmd.87.1632404998985;
        Thu, 23 Sep 2021 06:49:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbehTqbAceYHmc33NeQaZRHz5SaUrpEQB+rEeYZJOYl8kBl0ZafCIV72xpESDf87lnVEAptQ==
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr4614160wmd.87.1632404998631;
        Thu, 23 Sep 2021 06:49:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id w1sm9140373wmc.19.2021.09.23.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:49:58 -0700 (PDT)
Message-ID: <c2b5f3d3ca524e1825965e81e4fbd5c6a3536b77.camel@redhat.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_recvmmsg
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com>, 
	mptcp@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Thu, 23 Sep 2021 15:49:57 +0200
In-Reply-To: <0000000000003216d705cc8a62d6@google.com>
References: <0000000000003216d705cc8a62d6@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-09-21 at 17:13 -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    1f77990c4b79 Add linux-next specific files for 20210920
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1383891d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ab1346371f2e6884
> dashboard link: https://syzkaller.appspot.com/bug?extid=3360da629681aa0d22fe
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1625f1ab300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eb1b3b300000
> 
> The issue was bisected to:
> 
> commit 020250f31c4c75ac7687a673e29c00786582a5f4
> Author: Dmitry Kadashev <dkadashev@gmail.com>
> Date:   Thu Jul 8 06:34:43 2021 +0000
> 
>     namei: make do_linkat() take struct filename
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f5ef77300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f5ef77300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f5ef77300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com
> Fixes: 020250f31c4c ("namei: make do_linkat() take struct filename")
> 
> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu: 	0-...!: (10499 ticks this GP) idle=0af/1/0x4000000000000000 softirq=10678/10678 fqs=1 
> 	(t=10500 jiffies g=13089 q=109)
> rcu: rcu_preempt kthread starved for 10497 jiffies! g13089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28696 pid:   14 ppid:     2 flags:0x00004000
> Call Trace:
>  context_switch kernel/sched/core.c:4955 [inline]
>  __schedule+0x940/0x26f0 kernel/sched/core.c:6236
>  schedule+0xd3/0x270 kernel/sched/core.c:6315
>  schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
>  rcu_gp_fqs_loop+0x186/0x810 kernel/rcu/tree.c:1955
>  rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2128
>  kthread+0x405/0x4f0 kernel/kthread.c:327
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 8510 Comm: syz-executor827 Not tainted 5.15.0-rc2-next-20210920-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:84 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0xc8/0x180 mm/kasan/generic.c:189
> Code: 38 00 74 ed 48 8d 50 08 eb 09 48 83 c0 01 48 39 d0 74 7a 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 <48> 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 80 38 00
> RSP: 0018:ffffc9000cd676c8 EFLAGS: 00000283
> RAX: ffffed100e9a110e RBX: ffffed100e9a110f RCX: ffffffff88ea062a
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888074d08870
> RBP: ffffed100e9a110e R08: 0000000000000001 R09: ffff888074d08877
> R10: ffffed100e9a110e R11: 0000000000000000 R12: ffff888074d08000
> R13: ffff888074d08000 R14: ffff888074d08088 R15: ffff888074d08000
> FS:  0000555556d8e300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000180 CR3: 0000000068909000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>  test_and_clear_bit include/asm-generic/bitops/instrumented-atomic.h:83 [inline]
>  mptcp_release_cb+0x14a/0x210 net/mptcp/protocol.c:3016
>  release_sock+0xb4/0x1b0 net/core/sock.c:3204
>  mptcp_wait_data net/mptcp/protocol.c:1770 [inline]
>  mptcp_recvmsg+0xfd1/0x27b0 net/mptcp/protocol.c:2080
>  inet6_recvmsg+0x11b/0x5e0 net/ipv6/af_inet6.c:659
>  sock_recvmsg_nosec net/socket.c:944 [inline]
>  ____sys_recvmsg+0x527/0x600 net/socket.c:2626
>  ___sys_recvmsg+0x127/0x200 net/socket.c:2670
>  do_recvmmsg+0x24d/0x6d0 net/socket.c:2764
>  __sys_recvmmsg net/socket.c:2843 [inline]
>  __do_sys_recvmmsg net/socket.c:2866 [inline]
>  __se_sys_recvmmsg net/socket.c:2859 [inline]
>  __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2859
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fc200d2dc39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc5758e5a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc200d2dc39
> RDX: 0000000000000002 RSI: 00000000200017c0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000f0b5ff
> R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000003
> R13: 00007ffc5758e5d0 R14: 00007ffc5758e5c0 R15: 0000000000000003
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.444 msecs
> NMI backtrace for cpu 0
> CPU: 0 PID: 8509 Comm: syz-executor827 Not tainted 5.15.0-rc2-next-20210920-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
>  nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
>  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>  rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
>  print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
>  check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
>  rcu_pending kernel/rcu/tree.c:3878 [inline]
>  rcu_sched_clock_irq.cold+0x9d/0x746 kernel/rcu/tree.c:2597
>  update_process_times+0x16d/0x200 kernel/time/timer.c:1785
>  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
>  tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428
>  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>  __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
>  hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
>  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
>  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
>  </IRQ>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:lock_release+0x3f1/0x720 kernel/locking/lockdep.c:5633
> Code: 7e 83 f8 01 0f 85 8d 01 00 00 9c 58 f6 c4 02 0f 85 78 01 00 00 48 f7 04 24 00 02 00 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c5 48 c7 45 00 00 00 00 00 c7 45 08 00 00 00 00 48 8b 84 24
> RSP: 0018:ffffc9000cde7660 EFLAGS: 00000206
> RAX: dffffc0000000000 RBX: 70dbee1ebc366ab9 RCX: ffffc9000cde76b0
> RDX: 1ffff11003a0bc2b RSI: 0000000000000201 RDI: 0000000000000000
> RBP: 1ffff920019bcece R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000443 R12: 0000000000000001
> R13: 0000000000000002 R14: ffff88801d05e160 R15: ffff88801d05d700
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:174 [inline]
>  _raw_spin_unlock_bh+0x12/0x30 kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:413 [inline]
>  unlock_sock_fast include/net/sock.h:1644 [inline]
>  unlock_sock_fast include/net/sock.h:1636 [inline]
>  mptcp_subflow_cleanup_rbuf net/mptcp/protocol.c:468 [inline]
>  mptcp_cleanup_rbuf net/mptcp/protocol.c:499 [inline]
>  mptcp_recvmsg+0xb8b/0x27b0 net/mptcp/protocol.c:2027
>  inet6_recvmsg+0x11b/0x5e0 net/ipv6/af_inet6.c:659
>  sock_recvmsg_nosec net/socket.c:944 [inline]
>  ____sys_recvmsg+0x527/0x600 net/socket.c:2626
>  ___sys_recvmsg+0x127/0x200 net/socket.c:2670
>  do_recvmmsg+0x24d/0x6d0 net/socket.c:2764
>  __sys_recvmmsg net/socket.c:2843 [inline]
>  __do_sys_recvmmsg net/socket.c:2866 [inline]
>  __se_sys_recvmmsg net/socket.c:2859 [inline]
>  __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2859
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fc200d2dc39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc5758e5a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc200d2dc39
> RDX: 0000000000000002 RSI: 00000000200017c0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000f0b5ff
> R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000003
> R13: 00007ffc5758e5d0 R14: 00007ffc5758e5c0 R15: 0000000000000003
> ----------------
> Code disassembly (best guess):
>    0:	38 00                	cmp    %al,(%rax)
>    2:	74 ed                	je     0xfffffff1
>    4:	48 8d 50 08          	lea    0x8(%rax),%rdx
>    8:	eb 09                	jmp    0x13
>    a:	48 83 c0 01          	add    $0x1,%rax
>    e:	48 39 d0             	cmp    %rdx,%rax
>   11:	74 7a                	je     0x8d
>   13:	80 38 00             	cmpb   $0x0,(%rax)
>   16:	74 f2                	je     0xa
>   18:	48 89 c2             	mov    %rax,%rdx
>   1b:	b8 01 00 00 00       	mov    $0x1,%eax
>   20:	48 85 d2             	test   %rdx,%rdx
>   23:	75 56                	jne    0x7b
>   25:	5b                   	pop    %rbx
>   26:	5d                   	pop    %rbp
>   27:	41 5c                	pop    %r12
>   29:	c3                   	retq
> * 2a:	48 85 d2             	test   %rdx,%rdx <-- trapping instruction
>   2d:	74 5e                	je     0x8d
>   2f:	48 01 ea             	add    %rbp,%rdx
>   32:	eb 09                	jmp    0x3d
>   34:	48 83 c0 01          	add    $0x1,%rax
>   38:	48 39 d0             	cmp    %rdx,%rax
>   3b:	74 50                	je     0x8d
>   3d:	80 38 00             	cmpb   $0x0,(%rax)
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

DATA_READY removal is less invasive than I thought, and the code really
looks better, so checking such alternative fix, too.
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5df0b5971c8..cc996e8973b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -528,7 +528,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 		sk->sk_shutdown |= RCV_SHUTDOWN;
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
@@ -742,10 +741,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk)) {
-		set_bit(MPTCP_DATA_READY, &msk->flags);
+	if (move_skbs_to_msk(msk, ssk))
 		sk->sk_data_ready(sk);
-	}
+
 	mptcp_data_unlock(sk);
 }
 
@@ -847,7 +845,6 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		sk->sk_shutdown |= RCV_SHUTDOWN;
 
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 		sk->sk_data_ready(sk);
 	}
 
@@ -1759,21 +1756,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	return copied ? : ret;
 }
 
-static void mptcp_wait_data(struct sock *sk, long *timeo)
-{
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-
-	sk_wait_event(sk, timeo,
-		      test_bit(MPTCP_DATA_READY, &msk->flags), &wait);
-
-	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	remove_wait_queue(sk_sleep(sk), &wait);
-}
-
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -2077,19 +2059,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld", timeo);
-		mptcp_wait_data(sk, &timeo);
-	}
-
-	if (skb_queue_empty_lockless(&sk->sk_receive_queue) &&
-	    skb_queue_empty(&msk->receive_queue)) {
-		/* entire backlog drained, clear DATA_READY. */
-		clear_bit(MPTCP_DATA_READY, &msk->flags);
-
-		/* .. race-breaker: ssk might have gotten new data
-		 * after last __mptcp_move_skbs() returned false.
-		 */
-		if (unlikely(__mptcp_move_skbs(msk)))
-			set_bit(MPTCP_DATA_READY, &msk->flags);
+		sk_wait_data(sk, &timeo, NULL);
 	}
 
 out_err:
@@ -2098,9 +2068,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tcp_recv_timestamp(msg, sk, &tss);
 	}
 
-	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
-		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
-		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
+		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
 		mptcp_rcv_space_adjust(msk, copied);
 
@@ -2368,7 +2338,6 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	inet_sk_state_store(sk, TCP_CLOSE);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-	set_bit(MPTCP_DATA_READY, &msk->flags);
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
 	mptcp_close_wake_up(sk);
@@ -3385,8 +3354,11 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 {
-	return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM :
-	       0;
+	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
+            skb_queue_empty_lockless(&msk->receive_queue))
+		return 0;
+
+	return EPOLLIN | EPOLLRDNORM;
 }
 
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
@@ -3421,7 +3393,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN)
-		return mptcp_check_readable(msk);
+		return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM : 0;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);

