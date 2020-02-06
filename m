Content-Type: multipart/mixed; boundary="===============5222497865647884268=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Read in
 ipv6_sock_mc_close
Date: Thu, 06 Feb 2020 08:39:23 +0100
Message-ID: <61a4e15d4df675a2d08fcf39f240afcca772689b.camel@redhat.com>
In-Reply-To: 20200204183600.GH33105@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3593

--===============5222497865647884268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-04 at 10:36 -0800, Christoph Paasch wrote:
> Hello,
> =

> another one, on top of export with Florian's patch that he posted on netd=
ev
> just now. C-repro is attached. It needs -lpthread and triggers after a few
> seconds.
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:2=
32 [inline]
> BUG: KASAN: use-after-free in ipv6_sock_mc_close+0xe6/0xf0 net/ipv6/mcast=
.c:321
> Read of size 8 at addr ffff88807dccb3a8 by task syz-executor.7/20598
> =

> CPU: 0 PID: 20598 Comm: syz-executor.7 Not tainted 5.5.0-next-20200203 #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
>  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  __read_once_size include/linux/compiler.h:232 [inline]
>  ipv6_sock_mc_close+0xe6/0xf0 net/ipv6/mcast.c:321
>  inet6_release+0x3c/0x70 net/ipv6/af_inet6.c:465
>  __sock_release+0xd2/0x290 net/socket.c:605
>  sock_close+0x18/0x20 net/socket.c:1283
>  __fput+0x2da/0x850 fs/file_table.c:280
>  task_work_run+0x144/0x1c0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
>  do_syscall_64+0x4d7/0x5b0 arch/x86/entry/common.c:304
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f2d8d13328d
> Code: c1 20 00 00 75 10 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 4=
8 83 ec 08 e8 ee fb ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48=
 89 c2 e8 37 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffc782065e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2d8d13328d
> RDX: fffffffffffffff7 RSI: 0000000000000081 RDI: 0000000000000006
> RBP: 0000000000000007 R08: 0000000000673858 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
> R13: 0000000000673868 R14: 0000000000673870 R15: 00000000000007d0
> =

> Allocated by task 20610:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc mm/kasan/common.c:515 [inline]
>  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:488
>  slab_post_alloc_hook mm/slab.h:584 [inline]
>  slab_alloc_node mm/slub.c:2778 [inline]
>  slab_alloc mm/slub.c:2786 [inline]
>  kmem_cache_alloc+0xd8/0x2e0 mm/slub.c:2791
>  sk_prot_alloc+0x5f/0x2c0 net/core/sock.c:1597
>  sk_alloc+0x36/0xf90 net/core/sock.c:1657
>  inet6_create net/ipv6/af_inet6.c:180 [inline]
>  inet6_create+0x35f/0xf50 net/ipv6/af_inet6.c:107
>  __sock_create+0x3d9/0x740 net/socket.c:1433
>  sock_create net/socket.c:1484 [inline]
>  __sys_socket+0xef/0x200 net/socket.c:1526
>  __do_sys_socket net/socket.c:1535 [inline]
>  __se_sys_socket net/socket.c:1533 [inline]
>  __x64_sys_socket+0x6f/0xb0 net/socket.c:1533
>  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

> Freed by task 20598:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:337 [inline]
>  __kasan_slab_free+0x12f/0x180 mm/kasan/common.c:476
>  slab_free_hook mm/slub.c:1444 [inline]
>  slab_free_freelist_hook mm/slub.c:1477 [inline]
>  slab_free mm/slub.c:3024 [inline]
>  kmem_cache_free+0xaf/0x360 mm/slub.c:3040
>  sk_prot_free net/core/sock.c:1638 [inline]
>  __sk_destruct+0x490/0x680 net/core/sock.c:1724
>  sk_destruct+0xc6/0x100 net/core/sock.c:1739
>  __sk_free+0xef/0x3d0 net/core/sock.c:1750
>  sk_free+0x78/0xa0 net/core/sock.c:1761
>  sock_put include/net/sock.h:1719 [inline]
>  sk_common_release+0x254/0x370 net/core/sock.c:3200
>  __mptcp_close+0x3f3/0x5f0 net/mptcp/protocol.c:1131
>  inet_release+0xe9/0x1f0 net/ipv4/af_inet.c:427
>  inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:470
>  __sock_release+0xd2/0x290 net/socket.c:605
>  sock_close+0x18/0x20 net/socket.c:1283
>  __fput+0x2da/0x850 fs/file_table.c:280
>  task_work_run+0x144/0x1c0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
>  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
>  do_syscall_64+0x4d7/0x5b0 arch/x86/entry/common.c:304
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

> The buggy address belongs to the object at ffff88807dccaa00
>  which belongs to the cache MPTCPv6 of size 2536
> The buggy address is located 2472 bytes inside of
>  2536-byte region [ffff88807dccaa00, ffff88807dccb3e8)
> The buggy address belongs to the page:
> page:ffffea0001f73200 refcount:1 mapcount:0 mapping:ffff888115c2ec80 inde=
x:0xffff88807dcc9500 compound_mapcount: 0
> flags: 0x100000000010200(slab|head)
> raw: 0100000000010200 ffffea000213f800 0000000200000002 ffff888115c2ec80
> raw: ffff88807dcc9500 00000000800c000b 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> =

> Memory state around the buggy address:
>  ffff88807dccb280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88807dccb300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff88807dccb380: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>                                   ^
>  ffff88807dccb400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88807dccb480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If I read the report correctly, it looks like fput is called with count
=3D=3D 1 twice on the same fd. I'm unsure this is really mptcp specific.
Could you please share the syz repro too? (it's somehow more readable
than the c ones ;)

Thanks,

Paolo

--===============5222497865647884268==--
