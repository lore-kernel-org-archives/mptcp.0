Content-Type: multipart/mixed; boundary="===============4154805850151332248=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Fri, 31 Jan 2020 17:12:37 -0800
Message-ID: <20200201011237.GK6008@MacBook-Pro-64.local>
In-Reply-To: 20200131154356.GV19649@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3571

--===============4154805850151332248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Another one, probably the same root-cause. This time it's a read-after-free:

Syzkaller hit 'KASAN: use-after-free Read in __lock_sock' bug.

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending cooki=
es.  Check SNMP counters.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending cooki=
es.  Check SNMP counters.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in __lock_acquire+0x33fd/0x4680 kernel/locking/l=
ockdep.c:3827
Read of size 8 at addr ffff88810ecadf20 by task syz-executor.3/6806

CPU: 1 PID: 6806 Comm: syz-executor.3 Not tainted 5.5.0-next-20200131 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 __lock_acquire+0x33fd/0x4680 kernel/locking/lockdep.c:3827
 lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:343 [inline]
 __lock_sock+0x145/0x260 net/core/sock.c:2414
 lock_sock_nested+0xf6/0x120 net/core/sock.c:2938
 lock_sock include/net/sock.h:1516 [inline]
 mptcp_listen+0x8c/0x2f0 net/mptcp/protocol.c:1586
 __sys_listen+0x182/0x250 net/socket.c:1696
 __do_sys_listen net/socket.c:1705 [inline]
 __se_sys_listen net/socket.c:1703 [inline]
 __x64_sys_listen+0x50/0x70 net/socket.c:1703
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7faaa0ca0469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007faaa134edd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending cooki=
es.  Check SNMP counters.
RAX: ffffffffffffffda RBX: 000000000066c050 RCX: 00007faaa0ca0469
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000070e
R13: 0000000000419e4d R14: 00007faaa134f5c0 R15: 0000000000000003

Allocated by task 6796:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:488
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slub.c:2778 [inline]
 slab_alloc mm/slub.c:2786 [inline]
 kmem_cache_alloc+0xd8/0x2e0 mm/slub.c:2791
 sk_prot_alloc+0x5f/0x2c0 net/core/sock.c:1597
 sk_alloc+0x36/0xf90 net/core/sock.c:1657
 inet6_create net/ipv6/af_inet6.c:180 [inline]
 inet6_create+0x35f/0xf50 net/ipv6/af_inet6.c:107
 __sock_create+0x3d9/0x740 net/socket.c:1433
 sock_create net/socket.c:1484 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1526
 __do_sys_socket net/socket.c:1535 [inline]
 __se_sys_socket net/socket.c:1533 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1533
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6800:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x12f/0x180 mm/kasan/common.c:476
 slab_free_hook mm/slub.c:1444 [inline]
 slab_free_freelist_hook mm/slub.c:1477 [inline]
 slab_free mm/slub.c:3024 [inline]
 kmem_cache_free+0xaf/0x360 mm/slub.c:3040
 sk_prot_free net/core/sock.c:1638 [inline]
 __sk_destruct+0x490/0x680 net/core/sock.c:1724
 sk_destruct+0xc6/0x100 net/core/sock.c:1739
 __sk_free+0xef/0x3d0 net/core/sock.c:1750
 sk_free+0x78/0xa0 net/core/sock.c:1761
 sock_put include/net/sock.h:1719 [inline]
 sk_common_release+0x254/0x370 net/core/sock.c:3200
 __mptcp_close+0x3f3/0x5f0 net/mptcp/protocol.c:1131
 __mptcp_fallback_to_tcp net/mptcp/protocol.c:78 [inline]
 __mptcp_tcp_fallback net/mptcp/protocol.c:119 [inline]
 __mptcp_tcp_fallback+0x765/0xa50 net/mptcp/protocol.c:103
 mptcp_recvmsg+0x10e/0xe00 net/mptcp/protocol.c:710
 inet6_recvmsg+0x4f6/0x670 net/ipv6/af_inet6.c:592
 sock_recvmsg_nosec net/socket.c:886 [inline]
 sock_recvmsg+0xfb/0x180 net/socket.c:904
 ____sys_recvmsg+0x203/0x5e0 net/socket.c:2566
 ___sys_recvmsg+0xe4/0x150 net/socket.c:2608
 __sys_recvmsg+0xe9/0x1b0 net/socket.c:2642
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88810ecade80
 which belongs to the cache MPTCPv6 of size 2520
The buggy address is located 160 bytes inside of
 2520-byte region [ffff88810ecade80, ffff88810ecae858)
The buggy address belongs to the page:
page:ffffea00043b2a00 refcount:1 mapcount:0 mapping:ffff888115ffa280 index:=
0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff888115ffa280
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810ecade00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810ecade80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810ecadf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88810ecadf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810ecae000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


No C-reproducer yet, but only a syzkaller:

# {Threaded:true Collide:false Repeat:true RepeatTimes:0 Procs:8 Sandbox:no=
ne Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:true NetDevi=
ces:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:fal=
se DevlinkPCI:true UseTmpDir:true HandleSegv:true Repro:false Trace:false}
r0 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
bind$inet6(r0, &(0x7f0000000000)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c)
listen(r0, 0x0)
r1 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
connect$inet6(r1, &(0x7f0000000200)=3D{0xa, 0x4e22, 0x0, @empty}, 0x1c)
recvmsg(r1, &(0x7f0000000840)=3D{0x0, 0x0, 0x0, 0x0, 0x0, 0x3a}, 0x0)
listen(r1, 0x0)



Christoph

On 31/01/20 - 07:43:57, Christoph Paasch wrote:
> Hello,
> =

> syzkaller hit another one (on top of latest net-tree). C-repro is attached
> to the e-mail.
> =

> =3D=3D=3D=3D
> netlink: 8 bytes leftover after parsing attributes in process `syz-execut=
or.5'.
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending coo=
kies.  Check SNMP counters.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in atomic_try_cmpxchg include/asm-generic/atom=
ic-instrumented.h:693 [inline]
> BUG: KASAN: use-after-free in queued_spin_lock include/asm-generic/qspinl=
ock.h:78 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock include/linux/spinlock.h:1=
81 [inline]
> BUG: KASAN: use-after-free in __raw_spin_lock_bh include/linux/spinlock_a=
pi_smp.h:136 [inline]
> BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x71/0xd0 kernel/locking/=
spinlock.c:175
> Write of size 4 at addr ffff8880491a0e88 by task syz-executor.1/2083
> =

> CPU: 1 PID: 2083 Comm: syz-executor.1 Not tainted 5.5.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xb7/0xfe lib/dump_stack.c:118
>  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
>  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:639
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x130/0x1a0 mm/kasan/generic.c:192
>  atomic_try_cmpxchg include/asm-generic/atomic-instrumented.h:693 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:78 [inline]
>  do_raw_spin_lock include/linux/spinlock.h:181 [inline]
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
>  _raw_spin_lock_bh+0x71/0xd0 kernel/locking/spinlock.c:175
>  spin_lock_bh include/linux/spinlock.h:343 [inline]
>  __lock_sock+0x105/0x190 net/core/sock.c:2414
>  lock_sock_nested+0x10f/0x140 net/core/sock.c:2938
>  lock_sock include/net/sock.h:1516 [inline]
>  mptcp_setsockopt+0x2f/0x1f0 net/mptcp/protocol.c:800
>  __sys_setsockopt+0x152/0x240 net/socket.c:2130
>  __do_sys_setsockopt net/socket.c:2146 [inline]
>  __se_sys_setsockopt net/socket.c:2143 [inline]
>  __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>  do_syscall_64+0xb7/0x3d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fe1942da469
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007fe194946dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 000000000066c1a0 RCX: 00007fe1942da469
> RDX: 0000000000000039 RSI: 0000000000000029 RDI: 0000000000000006
> RBP: 00000000ffffffff R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000020000180 R11: 0000000000000246 R12: 0000000000000a59
> R13: 000000000041d0d6 R14: 00007fe1949475c0 R15: 0000000000000003
> =

> Allocated by task 2163:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc mm/kasan/common.c:513 [inline]
>  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:486
>  slab_post_alloc_hook mm/slab.h:584 [inline]
>  slab_alloc_node mm/slub.c:2759 [inline]
>  slab_alloc mm/slub.c:2767 [inline]
>  kmem_cache_alloc+0xc1/0x250 mm/slub.c:2772
>  sk_prot_alloc+0x5f/0x2c0 net/core/sock.c:1597
>  sk_alloc+0x32/0x8c0 net/core/sock.c:1657
>  inet6_create net/ipv6/af_inet6.c:180 [inline]
>  inet6_create+0x292/0xd70 net/ipv6/af_inet6.c:107
>  __sock_create+0x213/0x4d0 net/socket.c:1433
>  sock_create net/socket.c:1484 [inline]
>  __sys_socket+0xef/0x200 net/socket.c:1526
>  __do_sys_socket net/socket.c:1535 [inline]
>  __se_sys_socket net/socket.c:1533 [inline]
>  __x64_sys_socket+0x6f/0xb0 net/socket.c:1533
>  do_syscall_64+0xb7/0x3d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> =

> Freed by task 2069:
>  save_stack+0x1b/0x80 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:335 [inline]
>  __kasan_slab_free+0x12f/0x180 mm/kasan/common.c:474
>  slab_free_hook mm/slub.c:1425 [inline]
>  slab_free_freelist_hook mm/slub.c:1458 [inline]
>  slab_free mm/slub.c:3005 [inline]
>  kmem_cache_free+0x80/0x2b0 mm/slub.c:3021
>  sk_prot_free net/core/sock.c:1638 [inline]
>  __sk_destruct+0x459/0x5a0 net/core/sock.c:1724
>  sk_destruct+0xc6/0x100 net/core/sock.c:1739
>  __sk_free+0xef/0x3d0 net/core/sock.c:1750
>  sk_free+0x78/0xa0 net/core/sock.c:1761
>  sock_put include/net/sock.h:1719 [inline]
>  sk_common_release+0x24a/0x370 net/core/sock.c:3200
>  __mptcp_close+0x3c3/0x530 net/mptcp/protocol.c:662
>  __mptcp_fallback_to_tcp net/mptcp/protocol.c:75 [inline]
>  __mptcp_tcp_fallback net/mptcp/protocol.c:116 [inline]
>  __mptcp_tcp_fallback+0x716/0x970 net/mptcp/protocol.c:100
>  mptcp_sendmsg+0xe1/0x14e0 net/mptcp/protocol.c:334
>  inet6_sendmsg+0x115/0x140 net/ipv6/af_inet6.c:576
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xee/0x190 net/socket.c:672
>  __sys_sendto+0x21a/0x330 net/socket.c:1998
>  __do_sys_sendto net/socket.c:2010 [inline]
>  __se_sys_sendto net/socket.c:2006 [inline]
>  __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2006
>  do_syscall_64+0xb7/0x3d0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> =

> The buggy address belongs to the object at ffff8880491a0e00
>  which belongs to the cache MPTCPv6 of size 1616
> The buggy address is located 136 bytes inside of
>  1616-byte region [ffff8880491a0e00, ffff8880491a1450)
> The buggy address belongs to the page:
> page:ffffea0001246800 refcount:1 mapcount:0 mapping:ffff888116aa8800 inde=
x:0x0 compound_mapcount: 0
> raw: 0100000000010200 dead000000000100 dead000000000122 ffff888116aa8800
> raw: 0000000000000000 0000000080120012 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> =

> Memory state around the buggy address:
>  ffff8880491a0d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880491a0e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880491a0e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff8880491a0f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880491a0f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> =

> =

> Cheers,
> Christoph
> =

> =


> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> =

> #define _GNU_SOURCE
> =

> #include <arpa/inet.h>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <net/if.h>
> #include <net/if_arp.h>
> #include <netinet/in.h>
> #include <pthread.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <sys/uio.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> =

> #include <linux/capability.h>
> #include <linux/futex.h>
> #include <linux/genetlink.h>
> #include <linux/if_addr.h>
> #include <linux/if_ether.h>
> #include <linux/if_link.h>
> #include <linux/if_tun.h>
> #include <linux/in6.h>
> #include <linux/ip.h>
> #include <linux/neighbour.h>
> #include <linux/net.h>
> #include <linux/netlink.h>
> #include <linux/rtnetlink.h>
> #include <linux/tcp.h>
> #include <linux/veth.h>
> =

> unsigned long long procid;
> =

> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
> =

> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> =

> static void use_temporary_dir(void)
> {
>   char tmpdir_template[] =3D "./syzkaller.XXXXXX";
>   char *tmpdir =3D mkdtemp(tmpdir_template);
>   if (!tmpdir)
>     exit(1);
>   if (chmod(tmpdir, 0777))
>     exit(1);
>   if (chdir(tmpdir))
>     exit(1);
> }
> =

> static void thread_start(void *(*fn)(void *), void *arg)
> {
>   pthread_t th;
>   pthread_attr_t attr;
>   pthread_attr_init(&attr);
>   pthread_attr_setstacksize(&attr, 128 << 10);
>   int i;
>   for (i =3D 0; i < 100; i++) {
>     if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
>       pthread_attr_destroy(&attr);
>       return;
>     }
>     if (errno =3D=3D EAGAIN) {
>       usleep(50);
>       continue;
>     }
>     break;
>   }
>   exit(1);
> }
> =

> typedef struct
> {
>   int state;
> } event_t;
> =

> static void event_init(event_t *ev)
> {
>   ev->state =3D 0;
> }
> =

> static void event_reset(event_t *ev)
> {
>   ev->state =3D 0;
> }
> =

> static void event_set(event_t *ev)
> {
>   if (ev->state)
>     exit(1);
>   __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
>   syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000=
);
> }
> =

> static void event_wait(event_t *ev)
> {
>   while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
>     syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
> }
> =

> static int event_isset(event_t *ev)
> {
>   return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
> }
> =

> static int event_timedwait(event_t *ev, uint64_t timeout)
> {
>   uint64_t start =3D current_time_ms();
>   uint64_t now =3D start;
>   for (;;) {
>     uint64_t remain =3D timeout - (now - start);
>     struct timespec ts;
>     ts.tv_sec =3D remain / 1000;
>     ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
>     syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &t=
s);
>     if (__atomic_load_n(&ev->state, __ATOMIC_RELAXED))
>       return 1;
>     now =3D current_time_ms();
>     if (now - start > timeout)
>       return 0;
>   }
> }
> =

> static bool write_file(const char *file, const char *what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] =3D 0;
>   int len =3D strlen(buf);
>   int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>   if (fd =3D=3D -1)
>     return false;
>   if (write(fd, buf, len) !=3D len) {
>     int err =3D errno;
>     close(fd);
>     errno =3D err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
> =

> struct nlmsg
> {
>   char *pos;
>   int nesting;
>   struct nlattr *nested[8];
>   char buf[1024];
> };
> =

> static struct nlmsg nlmsg;
> =

> static void netlink_init(struct nlmsg *nlmsg, int typ, int flags,
>                          const void *data, int size)
> {
>   memset(nlmsg, 0, sizeof(*nlmsg));
>   struct nlmsghdr *hdr =3D (struct nlmsghdr *)nlmsg->buf;
>   hdr->nlmsg_type =3D typ;
>   hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
>   memcpy(hdr + 1, data, size);
>   nlmsg->pos =3D (char *)(hdr + 1) + NLMSG_ALIGN(size);
> }
> =

> static void netlink_attr(struct nlmsg *nlmsg, int typ, const void *data,
>                          int size)
> {
>   struct nlattr *attr =3D (struct nlattr *)nlmsg->pos;
>   attr->nla_len =3D sizeof(*attr) + size;
>   attr->nla_type =3D typ;
>   memcpy(attr + 1, data, size);
>   nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
> }
> =

> static void netlink_nest(struct nlmsg *nlmsg, int typ)
> {
>   struct nlattr *attr =3D (struct nlattr *)nlmsg->pos;
>   attr->nla_type =3D typ;
>   nlmsg->pos +=3D sizeof(*attr);
>   nlmsg->nested[nlmsg->nesting++] =3D attr;
> }
> =

> static void netlink_done(struct nlmsg *nlmsg)
> {
>   struct nlattr *attr =3D nlmsg->nested[--nlmsg->nesting];
>   attr->nla_len =3D nlmsg->pos - (char *)attr;
> }
> =

> static int netlink_send_ext(struct nlmsg *nlmsg, int sock, uint16_t reply=
_type,
>                             int *reply_len)
> {
>   if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
>     exit(1);
>   struct nlmsghdr *hdr =3D (struct nlmsghdr *)nlmsg->buf;
>   hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
>   struct sockaddr_nl addr;
>   memset(&addr, 0, sizeof(addr));
>   addr.nl_family =3D AF_NETLINK;
>   unsigned n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
>                       (struct sockaddr *)&addr, sizeof(addr));
>   if (n !=3D hdr->nlmsg_len)
>     exit(1);
>   n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
>   if (hdr->nlmsg_type =3D=3D NLMSG_DONE) {
>     *reply_len =3D 0;
>     return 0;
>   }
>   if (n < sizeof(struct nlmsghdr))
>     exit(1);
>   if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
>     *reply_len =3D n;
>     return 0;
>   }
>   if (n < sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))
>     exit(1);
>   if (hdr->nlmsg_type !=3D NLMSG_ERROR)
>     exit(1);
>   return -((struct nlmsgerr *)(hdr + 1))->error;
> }
> =

> static int netlink_send(struct nlmsg *nlmsg, int sock)
> {
>   return netlink_send_ext(nlmsg, sock, 0, NULL);
> }
> =

> static int netlink_next_msg(struct nlmsg *nlmsg, unsigned int offset,
>                             unsigned int total_len)
> {
>   struct nlmsghdr *hdr =3D (struct nlmsghdr *)(nlmsg->buf + offset);
>   if (offset =3D=3D total_len || offset + hdr->nlmsg_len > total_len)
>     return -1;
>   return hdr->nlmsg_len;
> }
> =

> static void netlink_add_device_impl(struct nlmsg *nlmsg, const char *type,
>                                     const char *name)
> {
>   struct ifinfomsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
>                sizeof(hdr));
>   if (name)
>     netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
>   netlink_nest(nlmsg, IFLA_LINKINFO);
>   netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
> }
> =

> static void netlink_add_device(struct nlmsg *nlmsg, int sock, const char =
*type,
>                                const char *name)
> {
>   netlink_add_device_impl(nlmsg, type, name);
>   netlink_done(nlmsg);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_veth(struct nlmsg *nlmsg, int sock, const char *n=
ame,
>                              const char *peer)
> {
>   netlink_add_device_impl(nlmsg, "veth", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   netlink_nest(nlmsg, VETH_INFO_PEER);
>   nlmsg->pos +=3D sizeof(struct ifinfomsg);
>   netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_hsr(struct nlmsg *nlmsg, int sock, const char *na=
me,
>                             const char *slave1, const char *slave2)
> {
>   netlink_add_device_impl(nlmsg, "hsr", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   int ifindex1 =3D if_nametoindex(slave1);
>   netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
>   int ifindex2 =3D if_nametoindex(slave2);
>   netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_linked(struct nlmsg *nlmsg, int sock, const char =
*type,
>                                const char *name, const char *link)
> {
>   netlink_add_device_impl(nlmsg, type, name);
>   netlink_done(nlmsg);
>   int ifindex =3D if_nametoindex(link);
>   netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_vlan(struct nlmsg *nlmsg, int sock, const char *n=
ame,
>                              const char *link, uint16_t id, uint16_t prot=
o)
> {
>   netlink_add_device_impl(nlmsg, "vlan", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
>   netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int ifindex =3D if_nametoindex(link);
>   netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_macvlan(struct nlmsg *nlmsg, int sock, const char=
 *name,
>                                 const char *link)
> {
>   netlink_add_device_impl(nlmsg, "macvlan", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   uint32_t mode =3D MACVLAN_MODE_BRIDGE;
>   netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int ifindex =3D if_nametoindex(link);
>   netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_add_geneve(struct nlmsg *nlmsg, int sock, const char =
*name,
>                                uint32_t vni, struct in_addr *addr4,
>                                struct in6_addr *addr6)
> {
>   netlink_add_device_impl(nlmsg, "geneve", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
>   if (addr4)
>     netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
>   if (addr6)
>     netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> #define IFLA_IPVLAN_FLAGS 2
> #define IPVLAN_MODE_L3S 2
> #undef IPVLAN_F_VEPA
> #define IPVLAN_F_VEPA 2
> =

> static void netlink_add_ipvlan(struct nlmsg *nlmsg, int sock, const char =
*name,
>                                const char *link, uint16_t mode, uint16_t =
flags)
> {
>   netlink_add_device_impl(nlmsg, "ipvlan", name);
>   netlink_nest(nlmsg, IFLA_INFO_DATA);
>   netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
>   netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
>   netlink_done(nlmsg);
>   netlink_done(nlmsg);
>   int ifindex =3D if_nametoindex(link);
>   netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static void netlink_device_change(struct nlmsg *nlmsg, int sock,
>                                   const char *name, bool up, const char *=
master,
>                                   const void *mac, int macsize,
>                                   const char *new_name)
> {
>   struct ifinfomsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   if (up)
>     hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
>   hdr.ifi_index =3D if_nametoindex(name);
>   netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
>   if (new_name)
>     netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
>   if (master) {
>     int ifindex =3D if_nametoindex(master);
>     netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
>   }
>   if (macsize)
>     netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static int netlink_add_addr(struct nlmsg *nlmsg, int sock, const char *de=
v,
>                             const void *addr, int addrsize)
> {
>   struct ifaddrmsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   hdr.ifa_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
>   hdr.ifa_prefixlen =3D addrsize =3D=3D 4 ? 24 : 120;
>   hdr.ifa_scope =3D RT_SCOPE_UNIVERSE;
>   hdr.ifa_index =3D if_nametoindex(dev);
>   netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
>                sizeof(hdr));
>   netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
>   netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
>   return netlink_send(nlmsg, sock);
> }
> =

> static void netlink_add_addr4(struct nlmsg *nlmsg, int sock, const char *=
dev,
>                               const char *addr)
> {
>   struct in_addr in_addr;
>   inet_pton(AF_INET, addr, &in_addr);
>   int err =3D netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr=
));
>   (void)err;
> }
> =

> static void netlink_add_addr6(struct nlmsg *nlmsg, int sock, const char *=
dev,
>                               const char *addr)
> {
>   struct in6_addr in6_addr;
>   inet_pton(AF_INET6, addr, &in6_addr);
>   int err =3D netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_ad=
dr));
>   (void)err;
> }
> =

> static void netlink_add_neigh(struct nlmsg *nlmsg, int sock, const char *=
name,
>                               const void *addr, int addrsize, const void =
*mac,
>                               int macsize)
> {
>   struct ndmsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   hdr.ndm_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
>   hdr.ndm_ifindex =3D if_nametoindex(name);
>   hdr.ndm_state =3D NUD_PERMANENT;
>   netlink_init(nlmsg, RTM_NEWNEIGH, NLM_F_EXCL | NLM_F_CREATE, &hdr,
>                sizeof(hdr));
>   netlink_attr(nlmsg, NDA_DST, addr, addrsize);
>   netlink_attr(nlmsg, NDA_LLADDR, mac, macsize);
>   int err =3D netlink_send(nlmsg, sock);
>   (void)err;
> }
> =

> static int tunfd =3D -1;
> static int tun_frags_enabled;
> =

> #define TUN_IFACE "syz_tun"
> =

> #define LOCAL_MAC 0xaaaaaaaaaaaa
> #define REMOTE_MAC 0xaaaaaaaaaabb
> =

> #define LOCAL_IPV4 "172.20.20.170"
> #define REMOTE_IPV4 "172.20.20.187"
> =

> #define LOCAL_IPV6 "fe80::aa"
> #define REMOTE_IPV6 "fe80::bb"
> =

> #define IFF_NAPI 0x0010
> #define IFF_NAPI_FRAGS 0x0020
> =

> static void initialize_tun(void)
> {
>   tunfd =3D open("/dev/net/tun", O_RDWR | O_NONBLOCK);
>   if (tunfd =3D=3D -1) {
>     printf("tun: can't open /dev/net/tun: please enable CONFIG_TUN=3Dy\n"=
);
>     printf("otherwise fuzzing or reproducing might not work as intended\n=
");
>     return;
>   }
>   const int kTunFd =3D 240;
>   if (dup2(tunfd, kTunFd) < 0)
>     exit(1);
>   close(tunfd);
>   tunfd =3D kTunFd;
>   struct ifreq ifr;
>   memset(&ifr, 0, sizeof(ifr));
>   strncpy(ifr.ifr_name, TUN_IFACE, IFNAMSIZ);
>   ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_NAPI | IFF_NAPI_FRAGS;
>   if (ioctl(tunfd, TUNSETIFF, (void *)&ifr) < 0) {
>     ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
>     if (ioctl(tunfd, TUNSETIFF, (void *)&ifr) < 0)
>       exit(1);
>   }
>   if (ioctl(tunfd, TUNGETIFF, (void *)&ifr) < 0)
>     exit(1);
>   tun_frags_enabled =3D (ifr.ifr_flags & IFF_NAPI_FRAGS) !=3D 0;
>   char sysctl[64];
>   sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/accept_dad", TUN_IFACE);
>   write_file(sysctl, "0");
>   sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/router_solicitations", TUN_=
IFACE);
>   write_file(sysctl, "0");
>   int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>   if (sock =3D=3D -1)
>     exit(1);
>   netlink_add_addr4(&nlmsg, sock, TUN_IFACE, LOCAL_IPV4);
>   netlink_add_addr6(&nlmsg, sock, TUN_IFACE, LOCAL_IPV6);
>   uint64_t macaddr =3D REMOTE_MAC;
>   struct in_addr in_addr;
>   inet_pton(AF_INET, REMOTE_IPV4, &in_addr);
>   netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in_addr, sizeof(in_addr),
>                     &macaddr, ETH_ALEN);
>   struct in6_addr in6_addr;
>   inet_pton(AF_INET6, REMOTE_IPV6, &in6_addr);
>   netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in6_addr, sizeof(in6_addr),
>                     &macaddr, ETH_ALEN);
>   macaddr =3D LOCAL_MAC;
>   netlink_device_change(&nlmsg, sock, TUN_IFACE, true, 0, &macaddr, ETH_A=
LEN,
>                         NULL);
>   close(sock);
> }
> =

> const int kInitNetNsFd =3D 239;
> =

> #define DEVLINK_FAMILY_NAME "devlink"
> =

> #define DEVLINK_CMD_PORT_GET 5
> #define DEVLINK_CMD_RELOAD 37
> #define DEVLINK_ATTR_BUS_NAME 1
> #define DEVLINK_ATTR_DEV_NAME 2
> #define DEVLINK_ATTR_NETDEV_NAME 7
> #define DEVLINK_ATTR_NETNS_FD 138
> =

> static int netlink_devlink_id_get(struct nlmsg *nlmsg, int sock)
> {
>   struct genlmsghdr genlhdr;
>   struct nlattr *attr;
>   int err, n;
>   uint16_t id =3D 0;
>   memset(&genlhdr, 0, sizeof(genlhdr));
>   genlhdr.cmd =3D CTRL_CMD_GETFAMILY;
>   netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
>   netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, DEVLINK_FAMILY_NAME,
>                strlen(DEVLINK_FAMILY_NAME) + 1);
>   err =3D netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n);
>   if (err) {
>     return -1;
>   }
>   attr =3D (struct nlattr *)(nlmsg->buf + NLMSG_HDRLEN +
>                            NLMSG_ALIGN(sizeof(genlhdr)));
>   for (; (char *)attr < nlmsg->buf + n;
>        attr =3D (struct nlattr *)((char *)attr + NLMSG_ALIGN(attr->nla_le=
n))) {
>     if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
>       id =3D *(uint16_t *)(attr + 1);
>       break;
>     }
>   }
>   if (!id) {
>     return -1;
>   }
>   recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0); /* recv ack */
>   return id;
> }
> =

> static void netlink_devlink_netns_move(const char *bus_name,
>                                        const char *dev_name, int netns_fd)
> {
>   struct genlmsghdr genlhdr;
>   int sock;
>   int id, err;
>   sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
>   if (sock =3D=3D -1)
>     exit(1);
>   id =3D netlink_devlink_id_get(&nlmsg, sock);
>   if (id =3D=3D -1)
>     goto error;
>   memset(&genlhdr, 0, sizeof(genlhdr));
>   genlhdr.cmd =3D DEVLINK_CMD_RELOAD;
>   netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
>   netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) =
+ 1);
>   netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) =
+ 1);
>   netlink_attr(&nlmsg, DEVLINK_ATTR_NETNS_FD, &netns_fd, sizeof(netns_fd)=
);
>   err =3D netlink_send(&nlmsg, sock);
>   if (err) {
>   }
> error:
>   close(sock);
> }
> =

> static struct nlmsg nlmsg2;
> =

> static void initialize_devlink_ports(const char *bus_name, const char *de=
v_name,
>                                      const char *netdev_prefix)
> {
>   struct genlmsghdr genlhdr;
>   int len, total_len, id, err, offset;
>   uint16_t netdev_index;
>   int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
>   if (sock =3D=3D -1)
>     exit(1);
>   int rtsock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>   if (rtsock =3D=3D -1)
>     exit(1);
>   id =3D netlink_devlink_id_get(&nlmsg, sock);
>   if (id =3D=3D -1)
>     goto error;
>   memset(&genlhdr, 0, sizeof(genlhdr));
>   genlhdr.cmd =3D DEVLINK_CMD_PORT_GET;
>   netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
>   netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) =
+ 1);
>   netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) =
+ 1);
>   err =3D netlink_send_ext(&nlmsg, sock, id, &total_len);
>   if (err) {
>     goto error;
>   }
>   offset =3D 0;
>   netdev_index =3D 0;
>   while ((len =3D netlink_next_msg(&nlmsg, offset, total_len)) !=3D -1) {
>     struct nlattr *attr =3D (struct nlattr *)(nlmsg.buf + offset + NLMSG_=
HDRLEN +
>                                             NLMSG_ALIGN(sizeof(genlhdr)));
>     for (; (char *)attr < nlmsg.buf + offset + len;
>          attr =3D (struct nlattr *)((char *)attr + NLMSG_ALIGN(attr->nla_=
len))) {
>       if (attr->nla_type =3D=3D DEVLINK_ATTR_NETDEV_NAME) {
>         char *port_name;
>         char netdev_name[IFNAMSIZ];
>         port_name =3D (char *)(attr + 1);
>         snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
>                  netdev_index);
>         netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
>                               netdev_name);
>         break;
>       }
>     }
>     offset +=3D len;
>     netdev_index++;
>   }
> error:
>   close(rtsock);
>   close(sock);
> }
> =

> static void initialize_devlink_pci(void)
> {
>   int netns =3D open("/proc/self/ns/net", O_RDONLY);
>   if (netns =3D=3D -1)
>     exit(1);
>   int ret =3D setns(kInitNetNsFd, 0);
>   if (ret =3D=3D -1)
>     exit(1);
>   netlink_devlink_netns_move("pci", "0000:00:10.0", netns);
>   ret =3D setns(netns, 0);
>   if (ret =3D=3D -1)
>     exit(1);
>   close(netns);
>   initialize_devlink_ports("pci", "0000:00:10.0", "netpci");
> }
> =

> #define DEV_IPV4 "172.20.20.%d"
> #define DEV_IPV6 "fe80::%02x"
> #define DEV_MAC 0x00aaaaaaaaaa
> =

> static void netdevsim_add(unsigned int addr, unsigned int port_count)
> {
>   char buf[16];
>   sprintf(buf, "%u %u", addr, port_count);
>   if (write_file("/sys/bus/netdevsim/new_device", buf)) {
>     snprintf(buf, sizeof(buf), "netdevsim%d", addr);
>     initialize_devlink_ports("netdevsim", buf, "netdevsim");
>   }
> }
> static void initialize_netdevices(void)
> {
>   char netdevsim[16];
>   sprintf(netdevsim, "netdevsim%d", (int)procid);
>   struct
>   {
>     const char *type;
>     const char *dev;
>   } devtypes[] =3D { { "ip6gretap", "ip6gretap0" },
>                    { "bridge", "bridge0" },
>                    { "vcan", "vcan0" },
>                    { "bond", "bond0" },
>                    { "team", "team0" },
>                    { "dummy", "dummy0" },
>                    { "nlmon", "nlmon0" },
>                    { "caif", "caif0" },
>                    { "batadv", "batadv0" },
>                    { "vxcan", "vxcan1" },
>                    { "netdevsim", netdevsim },
>                    { "veth", 0 },
>                    { "xfrm", "xfrm0" }, };
>   const char *devmasters[] =3D { "bridge", "bond", "team", "batadv" };
>   struct
>   {
>     const char *name;
>     int macsize;
>     bool noipv6;
>   } devices[] =3D { { "lo", ETH_ALEN },
>                   { "sit0", 0 },
>                   { "bridge0", ETH_ALEN },
>                   { "vcan0", 0, true },
>                   { "tunl0", 0 },
>                   { "gre0", 0 },
>                   { "gretap0", ETH_ALEN },
>                   { "ip_vti0", 0 },
>                   { "ip6_vti0", 0 },
>                   { "ip6tnl0", 0 },
>                   { "ip6gre0", 0 },
>                   { "ip6gretap0", ETH_ALEN },
>                   { "erspan0", ETH_ALEN },
>                   { "bond0", ETH_ALEN },
>                   { "veth0", ETH_ALEN },
>                   { "veth1", ETH_ALEN },
>                   { "team0", ETH_ALEN },
>                   { "veth0_to_bridge", ETH_ALEN },
>                   { "veth1_to_bridge", ETH_ALEN },
>                   { "veth0_to_bond", ETH_ALEN },
>                   { "veth1_to_bond", ETH_ALEN },
>                   { "veth0_to_team", ETH_ALEN },
>                   { "veth1_to_team", ETH_ALEN },
>                   { "veth0_to_hsr", ETH_ALEN },
>                   { "veth1_to_hsr", ETH_ALEN },
>                   { "hsr0", 0 },
>                   { "dummy0", ETH_ALEN },
>                   { "nlmon0", 0 },
>                   { "vxcan0", 0, true },
>                   { "vxcan1", 0, true },
>                   { "caif0", ETH_ALEN },
>                   { "batadv0", ETH_ALEN },
>                   { netdevsim, ETH_ALEN },
>                   { "xfrm0", ETH_ALEN },
>                   { "veth0_virt_wifi", ETH_ALEN },
>                   { "veth1_virt_wifi", ETH_ALEN },
>                   { "virt_wifi0", ETH_ALEN },
>                   { "veth0_vlan", ETH_ALEN },
>                   { "veth1_vlan", ETH_ALEN },
>                   { "vlan0", ETH_ALEN },
>                   { "vlan1", ETH_ALEN },
>                   { "macvlan0", ETH_ALEN },
>                   { "macvlan1", ETH_ALEN },
>                   { "ipvlan0", ETH_ALEN },
>                   { "ipvlan1", ETH_ALEN },
>                   { "veth0_macvtap", ETH_ALEN },
>                   { "veth1_macvtap", ETH_ALEN },
>                   { "macvtap0", ETH_ALEN },
>                   { "macsec0", ETH_ALEN },
>                   { "veth0_to_batadv", ETH_ALEN },
>                   { "veth1_to_batadv", ETH_ALEN },
>                   { "batadv_slave_0", ETH_ALEN },
>                   { "batadv_slave_1", ETH_ALEN },
>                   { "geneve0", ETH_ALEN },
>                   { "geneve1", ETH_ALEN }, };
>   int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>   if (sock =3D=3D -1)
>     exit(1);
>   unsigned i;
>   for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
>     netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
>   for (i =3D 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
>     char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
>     sprintf(slave0, "%s_slave_0", devmasters[i]);
>     sprintf(veth0, "veth0_to_%s", devmasters[i]);
>     netlink_add_veth(&nlmsg, sock, slave0, veth0);
>     sprintf(slave1, "%s_slave_1", devmasters[i]);
>     sprintf(veth1, "veth1_to_%s", devmasters[i]);
>     netlink_add_veth(&nlmsg, sock, slave1, veth1);
>     sprintf(master, "%s0", devmasters[i]);
>     netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL=
);
>     netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL=
);
>   }
>   netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NU=
LL);
>   netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NU=
LL);
>   netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
>   netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
>   netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
>   netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
>   netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
>   netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
>   netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0",
>                      "veth1_virt_wifi");
>   netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
>   netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_80=
21Q));
>   netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_80=
21AD));
>   netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
>   netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
>   netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L=
2, 0);
>   netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L=
3S,
>                      IPVLAN_F_VEPA);
>   netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
>   netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap"=
);
>   netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
>   char addr[32];
>   sprintf(addr, DEV_IPV4, 14 + 10);
>   struct in_addr geneve_addr4;
>   if (inet_pton(AF_INET, addr, &geneve_addr4) <=3D 0)
>     exit(1);
>   struct in6_addr geneve_addr6;
>   if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <=3D 0)
>     exit(1);
>   netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
>   netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
>   netdevsim_add((int)procid, 4);
>   for (i =3D 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
>     char addr[32];
>     sprintf(addr, DEV_IPV4, i + 10);
>     netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
>     if (!devices[i].noipv6) {
>       sprintf(addr, DEV_IPV6, i + 10);
>       netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
>     }
>     uint64_t macaddr =3D DEV_MAC + ((i + 10ull) << 40);
>     netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macadd=
r,
>                           devices[i].macsize, NULL);
>   }
>   close(sock);
> }
> static void initialize_netdevices_init(void)
> {
>   int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>   if (sock =3D=3D -1)
>     exit(1);
>   struct
>   {
>     const char *type;
>     int macsize;
>     bool noipv6;
>     bool noup;
>   } devtypes[] =3D { { "nr", 7, true }, { "rose", 5, true, true }, };
>   unsigned i;
>   for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
>     char dev[32], addr[32];
>     sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
>     sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
>     netlink_add_addr4(&nlmsg, sock, dev, addr);
>     if (!devtypes[i].noipv6) {
>       sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
>       netlink_add_addr6(&nlmsg, sock, dev, addr);
>     }
>     int macsize =3D devtypes[i].macsize;
>     uint64_t macaddr =3D 0xbbbbbb +
>                        ((unsigned long long)i << (8 * (macsize - 2))) +
>                        (procid << (8 * (macsize - 1)));
>     netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macad=
dr,
>                           macsize, NULL);
>   }
>   close(sock);
> }
> =

> static int read_tun(char *data, int size)
> {
>   if (tunfd < 0)
>     return -1;
>   int rv =3D read(tunfd, data, size);
>   if (rv < 0) {
>     if (errno =3D=3D EAGAIN)
>       return -1;
>     if (errno =3D=3D EBADFD)
>       return -1;
>     exit(1);
>   }
>   return rv;
> }
> =

> static void flush_tun()
> {
>   char data[1000];
>   while (read_tun(&data[0], sizeof(data)) !=3D -1) {
>   }
> }
> =

> #define MAX_FDS 30
> =

> #define XT_TABLE_SIZE 1536
> #define XT_MAX_ENTRIES 10
> =

> struct xt_counters
> {
>   uint64_t pcnt, bcnt;
> };
> =

> struct ipt_getinfo
> {
>   char name[32];
>   unsigned int valid_hooks;
>   unsigned int hook_entry[5];
>   unsigned int underflow[5];
>   unsigned int num_entries;
>   unsigned int size;
> };
> =

> struct ipt_get_entries
> {
>   char name[32];
>   unsigned int size;
>   void *entrytable[XT_TABLE_SIZE / sizeof(void *)];
> };
> =

> struct ipt_replace
> {
>   char name[32];
>   unsigned int valid_hooks;
>   unsigned int num_entries;
>   unsigned int size;
>   unsigned int hook_entry[5];
>   unsigned int underflow[5];
>   unsigned int num_counters;
>   struct xt_counters *counters;
>   char entrytable[XT_TABLE_SIZE];
> };
> =

> struct ipt_table_desc
> {
>   const char *name;
>   struct ipt_getinfo info;
>   struct ipt_replace replace;
> };
> =

> static struct ipt_table_desc ipv4_tables[] =3D { { .name =3D "filter" },
>                                                { .name =3D "nat" },
>                                                { .name =3D "mangle" },
>                                                { .name =3D "raw" },
>                                                { .name =3D "security" }, =
};
> =

> static struct ipt_table_desc ipv6_tables[] =3D { { .name =3D "filter" },
>                                                { .name =3D "nat" },
>                                                { .name =3D "mangle" },
>                                                { .name =3D "raw" },
>                                                { .name =3D "security" }, =
};
> =

> #define IPT_BASE_CTL 64
> #define IPT_SO_SET_REPLACE (IPT_BASE_CTL)
> #define IPT_SO_GET_INFO (IPT_BASE_CTL)
> #define IPT_SO_GET_ENTRIES (IPT_BASE_CTL + 1)
> =

> struct arpt_getinfo
> {
>   char name[32];
>   unsigned int valid_hooks;
>   unsigned int hook_entry[3];
>   unsigned int underflow[3];
>   unsigned int num_entries;
>   unsigned int size;
> };
> =

> struct arpt_get_entries
> {
>   char name[32];
>   unsigned int size;
>   void *entrytable[XT_TABLE_SIZE / sizeof(void *)];
> };
> =

> struct arpt_replace
> {
>   char name[32];
>   unsigned int valid_hooks;
>   unsigned int num_entries;
>   unsigned int size;
>   unsigned int hook_entry[3];
>   unsigned int underflow[3];
>   unsigned int num_counters;
>   struct xt_counters *counters;
>   char entrytable[XT_TABLE_SIZE];
> };
> =

> struct arpt_table_desc
> {
>   const char *name;
>   struct arpt_getinfo info;
>   struct arpt_replace replace;
> };
> =

> static struct arpt_table_desc arpt_tables[] =3D { { .name =3D "filter" },=
 };
> =

> #define ARPT_BASE_CTL 96
> #define ARPT_SO_SET_REPLACE (ARPT_BASE_CTL)
> #define ARPT_SO_GET_INFO (ARPT_BASE_CTL)
> #define ARPT_SO_GET_ENTRIES (ARPT_BASE_CTL + 1)
> =

> static void checkpoint_iptables(struct ipt_table_desc *tables, int num_ta=
bles,
>                                 int family, int level)
> {
>   struct ipt_get_entries entries;
>   socklen_t optlen;
>   int fd, i;
>   fd =3D socket(family, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < num_tables; i++) {
>     struct ipt_table_desc *table =3D &tables[i];
>     strcpy(table->info.name, table->name);
>     strcpy(table->replace.name, table->name);
>     optlen =3D sizeof(table->info);
>     if (getsockopt(fd, level, IPT_SO_GET_INFO, &table->info, &optlen)) {
>       switch (errno) {
>       case EPERM:
>       case ENOENT:
>       case ENOPROTOOPT:
>         continue;
>       }
>       exit(1);
>     }
>     if (table->info.size > sizeof(table->replace.entrytable))
>       exit(1);
>     if (table->info.num_entries > XT_MAX_ENTRIES)
>       exit(1);
>     memset(&entries, 0, sizeof(entries));
>     strcpy(entries.name, table->name);
>     entries.size =3D table->info.size;
>     optlen =3D sizeof(entries) - sizeof(entries.entrytable) + table->info=
.size;
>     if (getsockopt(fd, level, IPT_SO_GET_ENTRIES, &entries, &optlen))
>       exit(1);
>     table->replace.valid_hooks =3D table->info.valid_hooks;
>     table->replace.num_entries =3D table->info.num_entries;
>     table->replace.size =3D table->info.size;
>     memcpy(table->replace.hook_entry, table->info.hook_entry,
>            sizeof(table->replace.hook_entry));
>     memcpy(table->replace.underflow, table->info.underflow,
>            sizeof(table->replace.underflow));
>     memcpy(table->replace.entrytable, entries.entrytable, table->info.siz=
e);
>   }
>   close(fd);
> }
> =

> static void reset_iptables(struct ipt_table_desc *tables, int num_tables,
>                            int family, int level)
> {
>   struct xt_counters counters[XT_MAX_ENTRIES];
>   struct ipt_get_entries entries;
>   struct ipt_getinfo info;
>   socklen_t optlen;
>   int fd, i;
>   fd =3D socket(family, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < num_tables; i++) {
>     struct ipt_table_desc *table =3D &tables[i];
>     if (table->info.valid_hooks =3D=3D 0)
>       continue;
>     memset(&info, 0, sizeof(info));
>     strcpy(info.name, table->name);
>     optlen =3D sizeof(info);
>     if (getsockopt(fd, level, IPT_SO_GET_INFO, &info, &optlen))
>       exit(1);
>     if (memcmp(&table->info, &info, sizeof(table->info)) =3D=3D 0) {
>       memset(&entries, 0, sizeof(entries));
>       strcpy(entries.name, table->name);
>       entries.size =3D table->info.size;
>       optlen =3D sizeof(entries) - sizeof(entries.entrytable) + entries.s=
ize;
>       if (getsockopt(fd, level, IPT_SO_GET_ENTRIES, &entries, &optlen))
>         exit(1);
>       if (memcmp(table->replace.entrytable, entries.entrytable,
>                  table->info.size) =3D=3D 0)
>         continue;
>     }
>     table->replace.num_counters =3D info.num_entries;
>     table->replace.counters =3D counters;
>     optlen =3D sizeof(table->replace) - sizeof(table->replace.entrytable)=
 +
>              table->replace.size;
>     if (setsockopt(fd, level, IPT_SO_SET_REPLACE, &table->replace, optlen=
))
>       exit(1);
>   }
>   close(fd);
> }
> =

> static void checkpoint_arptables(void)
> {
>   struct arpt_get_entries entries;
>   socklen_t optlen;
>   unsigned i;
>   int fd;
>   fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < sizeof(arpt_tables) / sizeof(arpt_tables[0]); i++) {
>     struct arpt_table_desc *table =3D &arpt_tables[i];
>     strcpy(table->info.name, table->name);
>     strcpy(table->replace.name, table->name);
>     optlen =3D sizeof(table->info);
>     if (getsockopt(fd, SOL_IP, ARPT_SO_GET_INFO, &table->info, &optlen)) {
>       switch (errno) {
>       case EPERM:
>       case ENOENT:
>       case ENOPROTOOPT:
>         continue;
>       }
>       exit(1);
>     }
>     if (table->info.size > sizeof(table->replace.entrytable))
>       exit(1);
>     if (table->info.num_entries > XT_MAX_ENTRIES)
>       exit(1);
>     memset(&entries, 0, sizeof(entries));
>     strcpy(entries.name, table->name);
>     entries.size =3D table->info.size;
>     optlen =3D sizeof(entries) - sizeof(entries.entrytable) + table->info=
.size;
>     if (getsockopt(fd, SOL_IP, ARPT_SO_GET_ENTRIES, &entries, &optlen))
>       exit(1);
>     table->replace.valid_hooks =3D table->info.valid_hooks;
>     table->replace.num_entries =3D table->info.num_entries;
>     table->replace.size =3D table->info.size;
>     memcpy(table->replace.hook_entry, table->info.hook_entry,
>            sizeof(table->replace.hook_entry));
>     memcpy(table->replace.underflow, table->info.underflow,
>            sizeof(table->replace.underflow));
>     memcpy(table->replace.entrytable, entries.entrytable, table->info.siz=
e);
>   }
>   close(fd);
> }
> =

> static void reset_arptables()
> {
>   struct xt_counters counters[XT_MAX_ENTRIES];
>   struct arpt_get_entries entries;
>   struct arpt_getinfo info;
>   socklen_t optlen;
>   unsigned i;
>   int fd;
>   fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < sizeof(arpt_tables) / sizeof(arpt_tables[0]); i++) {
>     struct arpt_table_desc *table =3D &arpt_tables[i];
>     if (table->info.valid_hooks =3D=3D 0)
>       continue;
>     memset(&info, 0, sizeof(info));
>     strcpy(info.name, table->name);
>     optlen =3D sizeof(info);
>     if (getsockopt(fd, SOL_IP, ARPT_SO_GET_INFO, &info, &optlen))
>       exit(1);
>     if (memcmp(&table->info, &info, sizeof(table->info)) =3D=3D 0) {
>       memset(&entries, 0, sizeof(entries));
>       strcpy(entries.name, table->name);
>       entries.size =3D table->info.size;
>       optlen =3D sizeof(entries) - sizeof(entries.entrytable) + entries.s=
ize;
>       if (getsockopt(fd, SOL_IP, ARPT_SO_GET_ENTRIES, &entries, &optlen))
>         exit(1);
>       if (memcmp(table->replace.entrytable, entries.entrytable,
>                  table->info.size) =3D=3D 0)
>         continue;
>     } else {
>     }
>     table->replace.num_counters =3D info.num_entries;
>     table->replace.counters =3D counters;
>     optlen =3D sizeof(table->replace) - sizeof(table->replace.entrytable)=
 +
>              table->replace.size;
>     if (setsockopt(fd, SOL_IP, ARPT_SO_SET_REPLACE, &table->replace, optl=
en))
>       exit(1);
>   }
>   close(fd);
> }
> =

> #define NF_BR_NUMHOOKS 6
> #define EBT_TABLE_MAXNAMELEN 32
> #define EBT_CHAIN_MAXNAMELEN 32
> #define EBT_BASE_CTL 128
> #define EBT_SO_SET_ENTRIES (EBT_BASE_CTL)
> #define EBT_SO_GET_INFO (EBT_BASE_CTL)
> #define EBT_SO_GET_ENTRIES (EBT_SO_GET_INFO + 1)
> #define EBT_SO_GET_INIT_INFO (EBT_SO_GET_ENTRIES + 1)
> #define EBT_SO_GET_INIT_ENTRIES (EBT_SO_GET_INIT_INFO + 1)
> =

> struct ebt_replace
> {
>   char name[EBT_TABLE_MAXNAMELEN];
>   unsigned int valid_hooks;
>   unsigned int nentries;
>   unsigned int entries_size;
>   struct ebt_entries *hook_entry[NF_BR_NUMHOOKS];
>   unsigned int num_counters;
>   struct ebt_counter *counters;
>   char *entries;
> };
> =

> struct ebt_entries
> {
>   unsigned int distinguisher;
>   char name[EBT_CHAIN_MAXNAMELEN];
>   unsigned int counter_offset;
>   int policy;
>   unsigned int nentries;
>   char data[0] __attribute__((aligned(__alignof__(struct ebt_replace))));
> };
> =

> struct ebt_table_desc
> {
>   const char *name;
>   struct ebt_replace replace;
>   char entrytable[XT_TABLE_SIZE];
> };
> =

> static struct ebt_table_desc ebt_tables[] =3D { { .name =3D "filter" },
>                                               { .name =3D "nat" },
>                                               { .name =3D "broute" }, };
> =

> static void checkpoint_ebtables(void)
> {
>   socklen_t optlen;
>   unsigned i;
>   int fd;
>   fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < sizeof(ebt_tables) / sizeof(ebt_tables[0]); i++) {
>     struct ebt_table_desc *table =3D &ebt_tables[i];
>     strcpy(table->replace.name, table->name);
>     optlen =3D sizeof(table->replace);
>     if (getsockopt(fd, SOL_IP, EBT_SO_GET_INIT_INFO, &table->replace,
>                    &optlen)) {
>       switch (errno) {
>       case EPERM:
>       case ENOENT:
>       case ENOPROTOOPT:
>         continue;
>       }
>       exit(1);
>     }
>     if (table->replace.entries_size > sizeof(table->entrytable))
>       exit(1);
>     table->replace.num_counters =3D 0;
>     table->replace.entries =3D table->entrytable;
>     optlen =3D sizeof(table->replace) + table->replace.entries_size;
>     if (getsockopt(fd, SOL_IP, EBT_SO_GET_INIT_ENTRIES, &table->replace,
>                    &optlen))
>       exit(1);
>   }
>   close(fd);
> }
> =

> static void reset_ebtables()
> {
>   struct ebt_replace replace;
>   char entrytable[XT_TABLE_SIZE];
>   socklen_t optlen;
>   unsigned i, j, h;
>   int fd;
>   fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>   if (fd =3D=3D -1) {
>     switch (errno) {
>     case EAFNOSUPPORT:
>     case ENOPROTOOPT:
>       return;
>     }
>     exit(1);
>   }
>   for (i =3D 0; i < sizeof(ebt_tables) / sizeof(ebt_tables[0]); i++) {
>     struct ebt_table_desc *table =3D &ebt_tables[i];
>     if (table->replace.valid_hooks =3D=3D 0)
>       continue;
>     memset(&replace, 0, sizeof(replace));
>     strcpy(replace.name, table->name);
>     optlen =3D sizeof(replace);
>     if (getsockopt(fd, SOL_IP, EBT_SO_GET_INFO, &replace, &optlen))
>       exit(1);
>     replace.num_counters =3D 0;
>     table->replace.entries =3D 0;
>     for (h =3D 0; h < NF_BR_NUMHOOKS; h++)
>       table->replace.hook_entry[h] =3D 0;
>     if (memcmp(&table->replace, &replace, sizeof(table->replace)) =3D=3D =
0) {
>       memset(&entrytable, 0, sizeof(entrytable));
>       replace.entries =3D entrytable;
>       optlen =3D sizeof(replace) + replace.entries_size;
>       if (getsockopt(fd, SOL_IP, EBT_SO_GET_ENTRIES, &replace, &optlen))
>         exit(1);
>       if (memcmp(table->entrytable, entrytable, replace.entries_size) =3D=
=3D 0)
>         continue;
>     }
>     for (j =3D 0, h =3D 0; h < NF_BR_NUMHOOKS; h++) {
>       if (table->replace.valid_hooks & (1 << h)) {
>         table->replace.hook_entry[h] =3D
>             (struct ebt_entries *)table->entrytable + j;
>         j++;
>       }
>     }
>     table->replace.entries =3D table->entrytable;
>     optlen =3D sizeof(table->replace) + table->replace.entries_size;
>     if (setsockopt(fd, SOL_IP, EBT_SO_SET_ENTRIES, &table->replace, optle=
n))
>       exit(1);
>   }
>   close(fd);
> }
> =

> static void checkpoint_net_namespace(void)
> {
>   checkpoint_ebtables();
>   checkpoint_arptables();
>   checkpoint_iptables(ipv4_tables, sizeof(ipv4_tables) / sizeof(ipv4_tabl=
es[0]),
>                       AF_INET, SOL_IP);
>   checkpoint_iptables(ipv6_tables, sizeof(ipv6_tables) / sizeof(ipv6_tabl=
es[0]),
>                       AF_INET6, SOL_IPV6);
> }
> =

> static void reset_net_namespace(void)
> {
>   reset_ebtables();
>   reset_arptables();
>   reset_iptables(ipv4_tables, sizeof(ipv4_tables) / sizeof(ipv4_tables[0]=
),
>                  AF_INET, SOL_IP);
>   reset_iptables(ipv6_tables, sizeof(ipv6_tables) / sizeof(ipv6_tables[0]=
),
>                  AF_INET6, SOL_IPV6);
> }
> =

> static void setup_common()
> {
>   if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
>   }
> }
> =

> static void loop();
> =

> static void sandbox_common()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   setsid();
>   int netns =3D open("/proc/self/ns/net", O_RDONLY);
>   if (netns =3D=3D -1)
>     exit(1);
>   if (dup2(netns, kInitNetNsFd) < 0)
>     exit(1);
>   close(netns);
>   struct rlimit rlim;
>   rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
>   setrlimit(RLIMIT_AS, &rlim);
>   rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
>   setrlimit(RLIMIT_MEMLOCK, &rlim);
>   rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
>   setrlimit(RLIMIT_FSIZE, &rlim);
>   rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
>   setrlimit(RLIMIT_STACK, &rlim);
>   rlim.rlim_cur =3D rlim.rlim_max =3D 0;
>   setrlimit(RLIMIT_CORE, &rlim);
>   rlim.rlim_cur =3D rlim.rlim_max =3D 256;
>   setrlimit(RLIMIT_NOFILE, &rlim);
>   if (unshare(CLONE_NEWNS)) {
>   }
>   if (unshare(CLONE_NEWIPC)) {
>   }
>   if (unshare(0x02000000)) {
>   }
>   if (unshare(CLONE_NEWUTS)) {
>   }
>   if (unshare(CLONE_SYSVSEM)) {
>   }
>   typedef struct
>   {
>     const char *name;
>     const char *value;
>   } sysctl_t;
>   static const sysctl_t sysctls[] =3D {
>     { "/proc/sys/kernel/shmmax", "16777216" },
>     { "/proc/sys/kernel/shmall", "536870912" },
>     { "/proc/sys/kernel/shmmni", "1024" },
>     { "/proc/sys/kernel/msgmax", "8192" },
>     { "/proc/sys/kernel/msgmni", "1024" },
>     { "/proc/sys/kernel/msgmnb", "1024" },
>     { "/proc/sys/kernel/sem", "1024 1048576 500 1024" },
>   };
>   unsigned i;
>   for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
>     write_file(sysctls[i].name, sysctls[i].value);
> }
> =

> int wait_for_loop(int pid)
> {
>   if (pid < 0)
>     exit(1);
>   int status =3D 0;
>   while (waitpid(-1, &status, __WALL) !=3D pid) {
>   }
>   return WEXITSTATUS(status);
> }
> =

> static void drop_caps(void)
> {
>   struct __user_cap_header_struct cap_hdr =3D {};
>   struct __user_cap_data_struct cap_data[2] =3D {};
>   cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
>   cap_hdr.pid =3D getpid();
>   if (syscall(SYS_capget, &cap_hdr, &cap_data))
>     exit(1);
>   const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
>   cap_data[0].effective &=3D ~drop;
>   cap_data[0].permitted &=3D ~drop;
>   cap_data[0].inheritable &=3D ~drop;
>   if (syscall(SYS_capset, &cap_hdr, &cap_data))
>     exit(1);
> }
> =

> static int do_sandbox_none(void)
> {
>   if (unshare(CLONE_NEWPID)) {
>   }
>   int pid =3D fork();
>   if (pid !=3D 0)
>     return wait_for_loop(pid);
>   setup_common();
>   sandbox_common();
>   drop_caps();
>   initialize_netdevices_init();
>   if (unshare(CLONE_NEWNET)) {
>   }
>   initialize_devlink_pci();
>   initialize_tun();
>   initialize_netdevices();
>   loop();
>   exit(1);
> }
> =

> #define FS_IOC_SETFLAGS _IOW('f', 2, long)
> static void remove_dir(const char *dir)
> {
>   DIR *dp;
>   struct dirent *ep;
>   int iter =3D 0;
> retry:
>   while (umount2(dir, MNT_DETACH) =3D=3D 0) {
>   }
>   dp =3D opendir(dir);
>   if (dp =3D=3D NULL) {
>     if (errno =3D=3D EMFILE) {
>       exit(1);
>     }
>     exit(1);
>   }
>   while ((ep =3D readdir(dp))) {
>     if (strcmp(ep->d_name, ".") =3D=3D 0 || strcmp(ep->d_name, "..") =3D=
=3D 0)
>       continue;
>     char filename[FILENAME_MAX];
>     snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
>     while (umount2(filename, MNT_DETACH) =3D=3D 0) {
>     }
>     struct stat st;
>     if (lstat(filename, &st))
>       exit(1);
>     if (S_ISDIR(st.st_mode)) {
>       remove_dir(filename);
>       continue;
>     }
>     int i;
>     for (i =3D 0;; i++) {
>       if (unlink(filename) =3D=3D 0)
>         break;
>       if (errno =3D=3D EPERM) {
>         int fd =3D open(filename, O_RDONLY);
>         if (fd !=3D -1) {
>           long flags =3D 0;
>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
>           }
>           close(fd);
>           continue;
>         }
>       }
>       if (errno =3D=3D EROFS) {
>         break;
>       }
>       if (errno !=3D EBUSY || i > 100)
>         exit(1);
>       if (umount2(filename, MNT_DETACH))
>         exit(1);
>     }
>   }
>   closedir(dp);
>   int i;
>   for (i =3D 0;; i++) {
>     if (rmdir(dir) =3D=3D 0)
>       break;
>     if (i < 100) {
>       if (errno =3D=3D EPERM) {
>         int fd =3D open(dir, O_RDONLY);
>         if (fd !=3D -1) {
>           long flags =3D 0;
>           if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
>           }
>           close(fd);
>           continue;
>         }
>       }
>       if (errno =3D=3D EROFS) {
>         break;
>       }
>       if (errno =3D=3D EBUSY) {
>         if (umount2(dir, MNT_DETACH))
>           exit(1);
>         continue;
>       }
>       if (errno =3D=3D ENOTEMPTY) {
>         if (iter < 100) {
>           iter++;
>           goto retry;
>         }
>       }
>     }
>     exit(1);
>   }
> }
> =

> static void kill_and_wait(int pid, int *status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   int i;
>   for (i =3D 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>       return;
>     usleep(1000);
>   }
>   DIR *dir =3D opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent *ent =3D readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd =3D open(abort, O_WRONLY);
>       if (fd =3D=3D -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) !=3D pid) {
>   }
> }
> =

> static void setup_loop()
> {
>   checkpoint_net_namespace();
> }
> =

> static void reset_loop()
> {
>   reset_net_namespace();
> }
> =

> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
>   flush_tun();
> }
> =

> static void close_fds()
> {
>   int fd;
>   for (fd =3D 3; fd < MAX_FDS; fd++)
>     close(fd);
> }
> =

> struct thread_t
> {
>   int created, call;
>   event_t ready, done;
> };
> =

> static struct thread_t threads[16];
> static void execute_call(int call);
> static int running;
> =

> static void *thr(void *arg)
> {
>   struct thread_t *th =3D (struct thread_t *)arg;
>   for (;;) {
>     event_wait(&th->ready);
>     event_reset(&th->ready);
>     execute_call(th->call);
>     __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
>     event_set(&th->done);
>   }
>   return 0;
> }
> =

> static void execute_one(void)
> {
>   int i, call, thread;
>   int collide =3D 0;
> again:
>   for (call =3D 0; call < 7; call++) {
>     for (thread =3D 0; thread < (int)(sizeof(threads) / sizeof(threads[0]=
));
>          thread++) {
>       struct thread_t *th =3D &threads[thread];
>       if (!th->created) {
>         th->created =3D 1;
>         event_init(&th->ready);
>         event_init(&th->done);
>         event_set(&th->done);
>         thread_start(thr, th);
>       }
>       if (!event_isset(&th->done))
>         continue;
>       event_reset(&th->done);
>       th->call =3D call;
>       __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
>       event_set(&th->ready);
>       if (collide && (call % 2) =3D=3D 0)
>         break;
>       event_timedwait(&th->done, 45);
>       break;
>     }
>   }
>   for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i=
++)
>     sleep_ms(1);
>   close_fds();
>   if (!collide) {
>     collide =3D 1;
>     goto again;
>   }
> }
> =

> static void execute_one(void);
> =

> #define WAIT_FLAGS __WALL
> =

> static void loop(void)
> {
>   setup_loop();
>   int iter;
>   for (iter =3D 0;; iter++) {
>     char cwdbuf[32];
>     sprintf(cwdbuf, "./%d", iter);
>     if (mkdir(cwdbuf, 0777))
>       exit(1);
>     reset_loop();
>     int pid =3D fork();
>     if (pid < 0)
>       exit(1);
>     if (pid =3D=3D 0) {
>       if (chdir(cwdbuf))
>         exit(1);
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status =3D 0;
>     uint64_t start =3D current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5 * 1000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>     remove_dir(cwdbuf);
>   }
> }
> =

> uint64_t r[2] =3D { 0xffffffffffffffff, 0xffffffffffffffff };
> =

> void execute_call(int call)
> {
>   intptr_t res;
>   switch (call) {
>   case 0:
>     res =3D syscall(__NR_socket, 0xaul, 1ul, 0ul);
>     if (res !=3D -1)
>       r[0] =3D res;
>     break;
>   case 1:
>     *(uint16_t *)0x20000000 =3D 0xa;
>     *(uint16_t *)0x20000002 =3D htobe16(0x4e22);
>     *(uint32_t *)0x20000004 =3D htobe32(0);
>     *(uint8_t *)0x20000008 =3D 0;
>     *(uint8_t *)0x20000009 =3D 0;
>     *(uint8_t *)0x2000000a =3D 0;
>     *(uint8_t *)0x2000000b =3D 0;
>     *(uint8_t *)0x2000000c =3D 0;
>     *(uint8_t *)0x2000000d =3D 0;
>     *(uint8_t *)0x2000000e =3D 0;
>     *(uint8_t *)0x2000000f =3D 0;
>     *(uint8_t *)0x20000010 =3D 0;
>     *(uint8_t *)0x20000011 =3D 0;
>     *(uint8_t *)0x20000012 =3D 0;
>     *(uint8_t *)0x20000013 =3D 0;
>     *(uint8_t *)0x20000014 =3D 0;
>     *(uint8_t *)0x20000015 =3D 0;
>     *(uint8_t *)0x20000016 =3D 0;
>     *(uint8_t *)0x20000017 =3D 0;
>     *(uint32_t *)0x20000018 =3D 0;
>     syscall(__NR_bind, r[0], 0x20000000ul, 0x1cul);
>     break;
>   case 2:
>     syscall(__NR_listen, r[0], 0);
>     break;
>   case 3:
>     res =3D syscall(__NR_socket, 0xaul, 1ul, 0x106ul);
>     if (res !=3D -1)
>       r[1] =3D res;
>     break;
>   case 4:
>     *(uint16_t *)0x20000200 =3D 0xa;
>     *(uint16_t *)0x20000202 =3D htobe16(0x4e22);
>     *(uint32_t *)0x20000204 =3D htobe32(0);
>     *(uint8_t *)0x20000208 =3D 0;
>     *(uint8_t *)0x20000209 =3D 0;
>     *(uint8_t *)0x2000020a =3D 0;
>     *(uint8_t *)0x2000020b =3D 0;
>     *(uint8_t *)0x2000020c =3D 0;
>     *(uint8_t *)0x2000020d =3D 0;
>     *(uint8_t *)0x2000020e =3D 0;
>     *(uint8_t *)0x2000020f =3D 0;
>     *(uint8_t *)0x20000210 =3D 0;
>     *(uint8_t *)0x20000211 =3D 0;
>     *(uint8_t *)0x20000212 =3D 0;
>     *(uint8_t *)0x20000213 =3D 0;
>     *(uint8_t *)0x20000214 =3D 0;
>     *(uint8_t *)0x20000215 =3D 0;
>     *(uint8_t *)0x20000216 =3D 0;
>     *(uint8_t *)0x20000217 =3D 0;
>     *(uint32_t *)0x20000218 =3D 0;
>     syscall(__NR_connect, r[1], 0x20000200ul, 0x1cul);
>     break;
>   case 5:
>     *(uint64_t *)0x20000840 =3D 0;
>     *(uint32_t *)0x20000848 =3D 0;
>     *(uint64_t *)0x20000850 =3D 0;
>     *(uint64_t *)0x20000858 =3D 0;
>     *(uint64_t *)0x20000860 =3D 0;
>     *(uint64_t *)0x20000868 =3D 0;
>     *(uint32_t *)0x20000870 =3D 0;
>     syscall(__NR_recvmsg, r[1], 0x20000840ul, 0ul);
>     break;
>   case 6:
>     syscall(__NR_setsockopt, r[1], 6ul, 0x13ul, 0ul, 0ul);
>     break;
>   }
> }
> int main(void)
> {
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
>   for (procid =3D 0; procid < 8; procid++) {
>     if (fork() =3D=3D 0) {
>       use_temporary_dir();
>       do_sandbox_none();
>     }
>   }
>   sleep(1000000);
>   return 0;
> }
> =

>=20

--===============4154805850151332248==--
