Content-Type: multipart/mixed; boundary="===============1430517281212391396=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] WARNING in mptcp_incoming_options
Date: Tue, 14 Apr 2020 08:49:48 -0700
Message-ID: <20200414154948.GX74496@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4164

--===============1430517281212391396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I had another syzkaller today, tracked at https://github.com/multipath-tcp/=
mptcp_net-next/issues/13


It's on top of the export-branch (a1dc37e01c93 ("tcp: mptcp: use mptcp
receive buffer space to select rcv window")), merged with KCSAN.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30472 at net/mptcp/options.c:720 check_fully_establish=
ed net/mptcp/options.c:720 [inline]
WARNING: CPU: 1 PID: 30472 at net/mptcp/options.c:720 mptcp_incoming_option=
s+0xb89/0xba0 net/mptcp/options.c:826
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30472 Comm: syz-executor.6 Not tainted 5.6.0 #68
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x11d/0x181 lib/dump_stack.c:118
 panic+0x210/0x63b kernel/panic.c:221
 __warn.cold+0x36/0x3f kernel/panic.c:582
 report_bug+0x1f4/0x230 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x97/0xc0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:check_fully_established net/mptcp/options.c:720 [inline]
RIP: 0010:mptcp_incoming_options+0xb89/0xba0 net/mptcp/options.c:826
Code: d0 fe 48 8b 7c 24 10 e8 45 af e7 ff 48 8b 7c 24 18 e8 4b 3e d8 fe 41 =
0f b6 44 24 48 88 44 24 28 e9 60 f5 ff ff e8 a7 f7 d0 fe <0f> 0b e9 28 fe f=
f ff e8 9b 74 b8 fe 90 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ffffc900135ab950 EFLAGS: 00010293
RAX: ffff88808c232180 RBX: ffff88810731d078 RCX: ffffffff82685e4f
RDX: 0000000000000000 RSI: ffffffff82686029 RDI: 0000000000000001
RBP: ffffc900135ab9d0 R08: ffff88808c232180 R09: 0000888101fde840
R10: 0000888101fde849 R11: 0000888101fde843 R12: ffff888101fde800
R13: ffff888139f3e500 R14: 0000000000000040 R15: 00000000c6d2182c
 tcp_data_queue+0x73d/0x2150 net/ipv4/tcp_input.c:4777
 tcp_rcv_state_process+0x726/0x23e1 net/ipv4/tcp_input.c:6387
 tcp_v4_do_rcv+0x220/0x510 net/ipv4/tcp_ipv4.c:1643
 sk_backlog_rcv include/net/sock.h:996 [inline]
 __release_sock+0x135/0x1e0 net/core/sock.c:2460
 tcp_close+0x438/0xa30 net/ipv4/tcp.c:2438
 inet_release+0x86/0x100 net/ipv4/af_inet.c:427
 __sock_release+0x12b/0x160 net/socket.c:605
 sock_release+0x21/0x30 net/socket.c:625
 __mptcp_close_ssk net/mptcp/protocol.c:1069 [inline]
 mptcp_close+0x1ca/0x500 net/mptcp/protocol.c:1292
 inet_release+0x86/0x100 net/ipv4/af_inet.c:427
 __sock_release+0x85/0x160 net/socket.c:605
 sock_close+0x24/0x30 net/socket.c:1283
 __fput+0x1eb/0x4f0 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xc2/0x130 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x228/0x230 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x39d/0x3f0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f262df7528d
Code: c1 20 00 00 75 10 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 =
83 ec 08 e8 ee fb ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 8=
9 c2 e8 37 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff2660f5a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00007f262df7528d
RDX: 0000000000000000 RSI: 0000000000001044 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000670a00 R09: 00000000b0077044
R10: 00000000b0077048 R11: 0000000000000293 R12: 00000000000001f4
R13: 000000000009b8f8 R14: 0000000000670a00 R15: 0000000000000bb8
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..




Christoph

--===============1430517281212391396==--
