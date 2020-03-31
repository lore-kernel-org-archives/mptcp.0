Content-Type: multipart/mixed; boundary="===============6180044620775753627=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] WARNING in warn_bad_map
Date: Tue, 31 Mar 2020 08:46:53 -0700
Message-ID: <20200331154653.GA77711@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4117

--===============6180044620775753627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

another syzkaller bug on top of yesterday's export at commit
150f17fea64a ("selftests:mptcp: fix failure due to whitespace damage")

No reproducers yet...

------------[ cut here ]------------
Bad mapping: ssn=3D163567 map_seq=3D163566 map_data_len=3D1
WARNING: CPU: 1 PID: 22583 at net/mptcp/subflow.c:477 warn_bad_map.isra.0.p=
art.0+0x33/0x40 net/mptcp/subflow.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22583 Comm: syz-executor.3 Not tainted 5.6.0 #63
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xda/0x116 lib/dump_stack.c:118
 panic+0x1ae/0x509 kernel/panic.c:221
 __warn.cold+0x2a/0x2e kernel/panic.c:582
 report_bug+0x1a9/0x1e0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x97/0xc0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:warn_bad_map.isra.0.part.0+0x33/0x40 net/mptcp/subflow.c:477
Code: 41 54 41 89 d4 53 48 89 fb e8 69 8f 2e ff 41 8b 4d 00 44 89 e6 48 c7 =
c7 88 a1 85 82 8b 13 c6 05 2b fa b6 00 01 e8 4e 31 1d ff <0f> 0b 5b 41 5c 4=
1 5d 5d c3 0f 1f 40 00 55 48 89 e5 41 56 41 55 41
RSP: 0018:ffffc900000bcae0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88810dab353c RCX: ffffffff8120494e
RDX: 0000000000000100 RSI: ffffffff81205e32 RDI: 0000000000000006
RBP: ffffc900000bcaf8 R08: ffff888119934140 R09: 0000000000000035
R10: ffff8880860f3143 R11: ffff88813bd23143 R12: 0000000000027eef
R13: ffff88810dab3544 R14: ffff88810dab3500 R15: ffff8880279d5400
 warn_bad_map net/mptcp/subflow.c:509 [inline]
 validate_mapping net/mptcp/subflow.c:509 [inline]
 get_mapping_status net/mptcp/subflow.c:622 [inline]
 subflow_check_data_avail net/mptcp/subflow.c:660 [inline]
 mptcp_subflow_data_available+0x83f/0x960 net/mptcp/subflow.c:756
 subflow_state_change+0xd7/0x120 net/mptcp/subflow.c:991
 tcp_fin+0x107/0x240 net/ipv4/tcp_input.c:4213
 tcp_data_queue+0xc0c/0x15b0 net/ipv4/tcp_input.c:4813
 tcp_rcv_established+0x302/0xae0 net/ipv4/tcp_input.c:5727
 tcp_v4_do_rcv+0x231/0x350 net/ipv4/tcp_ipv4.c:1621
 tcp_v4_rcv+0x10da/0x1220 net/ipv4/tcp_ipv4.c:2003
 ip_protocol_deliver_rcu+0x20/0x130 net/ipv4/ip_input.c:204
 ip_local_deliver_finish net/ipv4/ip_input.c:231 [inline]
 NF_HOOK include/linux/netfilter.h:421 [inline]
 ip_local_deliver+0xe0/0x100 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:441 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:428 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:414 [inline]
 NF_HOOK include/linux/netfilter.h:421 [inline]
 ip_rcv+0x70/0xa0 net/ipv4/ip_input.c:538
 __netif_receive_skb_one_core+0x68/0xa0 net/core/dev.c:5187
 __netif_receive_skb+0x2a/0xa0 net/core/dev.c:5301
 process_backlog+0x104/0x250 net/core/dev.c:6133
 napi_poll net/core/dev.c:6571 [inline]
 net_rx_action+0x14a/0x520 net/core/dev.c:6639
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x96/0x190 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:check_stack_object+0xbf/0xf0 mm/usercopy.c:58
Code: 48 8b 1b 49 39 de 77 0a e8 9e f2 e7 ff 49 39 df 77 db 41 bc ff ff ff =
ff eb 03 45 31 e4 e8 89 f2 e7 ff 44 89 e0 48 83 c4 08 5b <41> 5c 41 5d 41 5=
e 41 5f 5d c3 e8 72 f2 e7 ff 48 8b 45 d0 41 bc 01
RSP: 0018:ffffc90001fd7908 EFLAGS: 00000296 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffc90006297000
RDX: 00000000000191ad RSI: ffffffff81418617 RDI: ffff8880923c0000
RBP: ffffc90001fd7928 R08: ffff888119934140 R09: ffff8880923c0000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880923c0000 R14: ffffc90001fd4000 R15: 0000000007200000
 __check_object_size mm/usercopy.c:269 [inline]
 __check_object_size+0xa0/0x2c7 mm/usercopy.c:256
 check_object_size include/linux/thread_info.h:119 [inline]
 check_copy_size include/linux/thread_info.h:152 [inline]
 copy_to_user include/linux/uaccess.h:151 [inline]
 pagemap_read+0x18d/0x3c0 fs/proc/task_mmu.c:1601
 do_loop_readv_writev fs/read_write.c:714 [inline]
 do_loop_readv_writev fs/read_write.c:701 [inline]
 do_iter_read+0x26b/0x2e0 fs/read_write.c:935
 vfs_readv+0x8b/0xd0 fs/read_write.c:1053
 kernel_readv fs/splice.c:365 [inline]
 default_file_splice_read+0x20e/0x440 fs/splice.c:422
 do_splice_to+0xbf/0xf0 fs/splice.c:892
 splice_direct_to_actor+0x113/0x390 fs/splice.c:971
 do_splice_direct+0xe8/0x150 fs/splice.c:1080
 do_sendfile+0x2c4/0x610 fs/read_write.c:1520
 __do_sys_sendfile64 fs/read_write.c:1581 [inline]
 __se_sys_sendfile64 fs/read_write.c:1567 [inline]
 __x64_sys_sendfile64+0xeb/0x100 fs/read_write.c:1567
 do_syscall_64+0x91/0x2f0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f56623f5469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007f5662ac4dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000066bfa0 RCX: 00007f56623f5469
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000000246 R12: 00000000000008d4
R13: 000000000041c788 R14: 00007f5662ac55c0 R15: 0000000000000003
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..


Christoph


--===============6180044620775753627==--
