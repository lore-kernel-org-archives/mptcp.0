Content-Type: multipart/mixed; boundary="===============8673557878167267058=="
MIME-Version: 1.0
From: syzbot <syzbot+be889269e2b87ab34afb at syzkaller.appspotmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] KASAN: slab-out-of-bounds Read in subflow_syn_recv_sock
Date: Wed, 15 Jul 2020 09:28:25 -0700
Message-ID: <000000000000c88b2c05aa7d69af@google.com>
X-Status: 
X-Keywords:                  
X-UID: 5021

--===============8673557878167267058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    d113c0f2 Merge tag 'wireless-drivers-2020-07-13' of git://..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=3D158d14d0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D368e8612711aa2cc
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbe889269e2b87ab34=
afb
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D123882bf100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b2c6f7100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be889269e2b87ab34afb(a)syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in subflow_syn_recv_sock+0x945/0xd80 net/mpt=
cp/subflow.c:447
Read of size 1 at addr ffff8880a8d6dc40 by task syz-executor124/9639

CPU: 0 PID: 9639 Comm: syz-executor124 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 subflow_syn_recv_sock+0x945/0xd80 net/mptcp/subflow.c:447
 tcp_get_cookie_sock+0xca/0x510 net/ipv4/syncookies.c:209
 cookie_v6_check+0x14f2/0x2250 net/ipv6/syncookies.c:255
 tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1134 [inline]
 tcp_v6_do_rcv+0xf50/0x1290 net/ipv6/tcp_ipv6.c:1459
 tcp_v6_rcv+0x312b/0x3470 net/ipv6/tcp_ipv6.c:1670
 ip6_protocol_deliver_rcu+0x2e8/0x1670 net/ipv6/ip6_input.c:433
 ip6_input_finish+0x7f/0x160 net/ipv6/ip6_input.c:474
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:483
 dst_input include/net/dst.h:449 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ipv6_rcv+0x28e/0x3c0 net/ipv6/ip6_input.c:307
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5281
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5395
 process_backlog+0x28d/0x7f0 net/core/dev.c:6239
 napi_poll net/core/dev.c:6684 [inline]
 net_rx_action+0x4a1/0xe60 net/core/dev.c:6752
 __do_softirq+0x34c/0xa60 kernel/softirq.c:292
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x111/0x170 arch/x86/kernel/irq_64.c:77
 do_softirq kernel/softirq.c:337 [inline]
 do_softirq+0x16b/0x1e0 kernel/softirq.c:324
 __local_bh_enable_ip+0x1f8/0x250 kernel/softirq.c:189
 local_bh_enable include/linux/bottom_half.h:32 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:723 [inline]
 ip6_finish_output2+0x91d/0x17b0 net/ipv6/ip6_output.c:118
 __ip6_finish_output net/ipv6/ip6_output.c:143 [inline]
 __ip6_finish_output+0x447/0xab0 net/ipv6/ip6_output.c:128
 ip6_finish_output+0x34/0x1f0 net/ipv6/ip6_output.c:153
 NF_HOOK_COND include/linux/netfilter.h:296 [inline]
 ip6_output+0x1db/0x520 net/ipv6/ip6_output.c:176
 dst_output include/net/dst.h:443 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_xmit+0x1258/0x1e80 net/ipv6/ip6_output.c:280
 inet6_csk_xmit+0x339/0x610 net/ipv6/inet6_connection_sock.c:135
 __tcp_transmit_skb+0x1884/0x3690 net/ipv4/tcp_output.c:1240
 __tcp_send_ack.part.0+0x3aa/0x590 net/ipv4/tcp_output.c:3787
 __tcp_send_ack net/ipv4/tcp_output.c:3793 [inline]
 tcp_send_ack+0x7d/0xa0 net/ipv4/tcp_output.c:3793
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6058 [inline]
 tcp_rcv_state_process+0x374c/0x4add net/ipv4/tcp_input.c:6227
 tcp_v6_do_rcv+0x7ad/0x1290 net/ipv6/tcp_ipv6.c:1474
 sk_backlog_rcv include/net/sock.h:997 [inline]
 __release_sock+0x134/0x3a0 net/core/sock.c:2550
 release_sock+0x54/0x1b0 net/core/sock.c:3066
 tcp_sendmsg+0x36/0x40 net/ipv4/tcp.c:1442
 inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:638
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 __sys_sendto+0x21c/0x320 net/socket.c:1995
 __do_sys_sendto net/socket.c:2007 [inline]
 __se_sys_sendto net/socket.c:2003 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2003
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44ad39
Code: Bad RIP value.
RSP: 002b:00007f9c42a5ed98 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000006e7a28 RCX: 000000000044ad39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006e7a20 R08: 00000000200000c0 R09: 000000000000001c
R10: 0000000024004044 R11: 0000000000000246 R12: 00000000006e7a2c
R13: 0000000000000000 R14: 0000000000000000 R15: 20c49ba5e353f7cf

Allocated by task 9639:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x12c/0x3b0 mm/slab.c:3484
 reqsk_alloc include/net/request_sock.h:84 [inline]
 inet_reqsk_alloc+0x91/0x710 net/ipv4/tcp_input.c:6516
 cookie_v6_check+0x5a5/0x2250 net/ipv6/syncookies.c:173
 tcp_v6_cookie_check net/ipv6/tcp_ipv6.c:1134 [inline]
 tcp_v6_do_rcv+0xf50/0x1290 net/ipv6/tcp_ipv6.c:1459
 tcp_v6_rcv+0x312b/0x3470 net/ipv6/tcp_ipv6.c:1670
 ip6_protocol_deliver_rcu+0x2e8/0x1670 net/ipv6/ip6_input.c:433
 ip6_input_finish+0x7f/0x160 net/ipv6/ip6_input.c:474
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:483
 dst_input include/net/dst.h:449 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ipv6_rcv+0x28e/0x3c0 net/ipv6/ip6_input.c:307
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5281
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5395
 process_backlog+0x28d/0x7f0 net/core/dev.c:6239
 napi_poll net/core/dev.c:6684 [inline]
 net_rx_action+0x4a1/0xe60 net/core/dev.c:6752
 __do_softirq+0x34c/0xa60 kernel/softirq.c:292

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880a8d6daf0
 which belongs to the cache request_sock_TCPv6 of size 336
The buggy address is located 0 bytes to the right of
 336-byte region [ffff8880a8d6daf0, ffff8880a8d6dc40)
The buggy address belongs to the page:
page:ffffea0002a35b40 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0xffff8880a8d6dff6
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000229a488 ffff8880994fc550 ffff88809949ee00
raw: ffff8880a8d6dff6 ffff8880a8d6d000 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a8d6db00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a8d6db80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a8d6dc00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff8880a8d6dc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a8d6dd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller(a)googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
--===============8673557878167267058==--
