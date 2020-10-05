Content-Type: multipart/mixed; boundary="===============1048116720099644055=="
MIME-Version: 1.0
From: syzbot <syzbot+fcf8ca5817d6e92c6567 at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 10:14:05 -0700
Message-ID: <00000000000009067705b0ef9cbd@google.com>
In-Reply-To: c73586823d1a40b68a40bb971a3601dd13fba766.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6203

--===============1048116720099644055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:
INFO: task hung in synchronize_rcu

INFO: task kworker/u4:1:21 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:1    state:D stack:23816 pid:   21 ppid:     2 flags:0x0000=
4000
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 __synchronize_srcu+0x132/0x220 kernel/rcu/srcutree.c:935
 fsnotify_connector_destroy_workfn+0x49/0xa0 fs/notify/mark.c:164
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
INFO: task kworker/u4:3:30 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:23928 pid:   30 ppid:     2 flags:0x0000=
4000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 __synchronize_srcu+0x132/0x220 kernel/rcu/srcutree.c:935
 fsnotify_mark_destroy_workfn+0xfd/0x340 fs/notify/mark.c:836
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
INFO: task syz-executor.4:8263 blocked for more than 144 seconds.
      Not tainted 5.9.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27408 pid: 8263 ppid:  7020 flags:0x0000=
4004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 __lock_sock+0x13d/0x260 net/core/sock.c:2504
 lock_sock_nested+0xf1/0x110 net/core/sock.c:3043
 lock_sock include/net/sock.h:1581 [inline]
 sk_stream_wait_memory+0x775/0xe60 net/core/stream.c:145
 mptcp_sendmsg+0x53b/0x1910 net/mptcp/protocol.c:1201
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:817
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 __sys_sendto+0x21c/0x320 net/socket.c:1992
 __do_sys_sendto net/socket.c:2004 [inline]
 __se_sys_sendto net/socket.c:2000 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2000
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45dea9
Code: Bad RIP value.
RSP: 002b:00007f6bb4dc3c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000000000002e880 RCX: 000000000045dea9
RDX: 00000000ffffffe7 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000118bf78 R08: 0000000000000000 R09: 1400000000000000
R10: 000000000000c000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007fff3409622f R14: 00007f6bb4dc49c0 R15: 000000000118bf2c

Showing all locks held in the system:
2 locks held by kworker/u4:1/21:
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch=
_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atom=
ic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atom=
ic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_=
work_data kernel/workqueue.c:616 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_=
work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work+0x82b/0x1670 kernel/workqueue.c:2240
 #1: ffffc90000dd7da8 (connector_reaper_work){+.+.}-{0:0}, at: process_one_=
work+0x85f/0x1670 kernel/workqueue.c:2244
2 locks held by kworker/u4:3/30:
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch=
_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atom=
ic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atom=
ic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_=
work_data kernel/workqueue.c:616 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_=
work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8880aa071138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work+0x82b/0x1670 kernel/workqueue.c:2240
 #1: ffffc90000e47da8 ((reaper_work).work){+.+.}-{0:0}, at: process_one_wor=
k+0x85f/0x1670 kernel/workqueue.c:2244
1 lock held by khungtaskd/1167:
 #0: ffffffff8a068440 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks=
+0x53/0x260 kernel/locking/lockdep.c:5852
1 lock held by khugepaged/1180:
 #0: ffffffff8a134ba8 (lock#5){+.+.}-{3:3}, at: lru_add_drain_all+0x59/0x6c=
0 mm/swap.c:780
3 locks held by kworker/1:3/2648:
1 lock held by in:imklog/6557:
 #0: ffff8880a2068e30 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x=
100 fs/file.c:930

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 PID: 1167 Comm: khungtaskd Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2648 Comm: kworker/1:3 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Workqueue: events mptcp_worker
RIP: 0010:check_memory_region+0x134/0x180 mm/kasan/generic.c:193
Code: 85 d2 75 0b 48 89 da 48 29 c2 e9 55 ff ff ff 49 39 d2 75 17 49 0f be =
02 41 83 e1 07 49 39 c1 7d 0a 5b b8 01 00 00 00 5d 41 5c <c3> 44 89 c2 e8 e=
3 ef ff ff 5b 83 f0 01 5d 41 5c c3 48 29 c3 48 89
RSP: 0018:ffffc90008d4f868 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000002 RCX: ffffffff815bc144
RDX: fffffbfff1a21b52 RSI: 0000000000000008 RDI: ffffffff8d10da88
RBP: ffff88809f3ee100 R08: 0000000000000000 R09: ffffffff8d10da8f
R10: fffffbfff1a21b51 R11: 0000000000000000 R12: 0000000000000579
R13: 0000000000000004 R14: dffffc0000000000 R15: ffff88809f3eea08
FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558030ecfd70 CR3: 0000000091828000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 hlock_class kernel/locking/lockdep.c:179 [inline]
 check_wait_context kernel/locking/lockdep.c:4140 [inline]
 __lock_acquire+0x704/0x5780 kernel/locking/lockdep.c:4391
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3041
 lock_sock include/net/sock.h:1581 [inline]
 __mptcp_move_skbs+0x1fb/0x510 net/mptcp/protocol.c:1469
 mptcp_worker+0x19f/0x15b0 net/mptcp/protocol.c:1726
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


Tested on:

commit:         f4f9dcc3 net: phy: marvell: Use phy_read_paged() instead o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D14205eaf900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e6c5266df853ae
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca5817d6e92c6=
567
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D153ae9c05000=
00

--===============1048116720099644055==--
