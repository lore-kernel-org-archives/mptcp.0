Content-Type: multipart/mixed; boundary="===============2489341068535220598=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] KASAN: slab-out-of-bounds Write in
 tcp_mstamp_refresh
Date: Fri, 24 Jan 2020 09:19:16 -0800
Message-ID: <20200124171916.GH60524@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 3499

--===============2489341068535220598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One more:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp=
_output.c:57
Write of size 8 at addr ffff888116aa21d0 by task syz-executor.0/5478

CPU: 1 PID: 5478 Comm: syz-executor.0 Not tainted 5.5.0-rc6 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:639
 tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp_output.c:57
 tcp_rcv_space_adjust+0x72/0x7f0 net/ipv4/tcp_input.c:612
 tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
 __tcp_splice_read net/ipv4/tcp.c:749 [inline]
 tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
 sock_splice_read+0xb9/0x120 net/socket.c:962
 do_splice_to+0x111/0x160 fs/splice.c:892
 do_splice+0x1259/0x1560 fs/splice.c:1205
 __do_sys_splice fs/splice.c:1447 [inline]
 __se_sys_splice fs/splice.c:1427 [inline]
 __x64_sys_splice+0x2b7/0x320 fs/splice.c:1427
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
syz-executor.7 uses obsolete (PF_INET,SOCK_PACKET)
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f16bc65a469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007f16bcd08dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 000000000066c050 RCX: 00007f16bc65a469
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00000000ffffffff R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000b38
R13: 000000000041e1c1 R14: 00007f16bcd095c0 R15: 0000000000000003

Allocated by task 5470:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:486
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slub.c:2759 [inline]
 slab_alloc mm/slub.c:2767 [inline]
 kmem_cache_alloc+0xd8/0x2e0 mm/slub.c:2772
 sk_prot_alloc+0x5f/0x2c0 net/core/sock.c:1597
 sk_alloc+0x36/0xf90 net/core/sock.c:1657
 inet_create net/ipv4/af_inet.c:321 [inline]
 inet_create+0x368/0xdc0 net/ipv4/af_inet.c:247
 __sock_create+0x3d9/0x740 net/socket.c:1433
 sock_create net/socket.c:1484 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1526
 __do_sys_socket net/socket.c:1535 [inline]
 __se_sys_socket net/socket.c:1533 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1533
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff888116aa1980
 which belongs to the cache MPTCP of size 2008
The buggy address is located 120 bytes to the right of
 2008-byte region [ffff888116aa1980, ffff888116aa2158)
The buggy address belongs to the page:
page:ffffea00045aa800 refcount:1 mapcount:0 mapping:ffff8881181d7400 index:=
0x0 compound_mapcount: 0
raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881181d7400
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888116aa2080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888116aa2100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888116aa2180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                 ^
 ffff888116aa2200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888116aa2280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--===============2489341068535220598==--
