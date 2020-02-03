Content-Type: multipart/mixed; boundary="===============7228688564211425518=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: use-after-free Write in __lock_sock
Date: Mon, 03 Feb 2020 12:52:39 -0800
Message-ID: <20200203205239.GF63861@MacBook-Pro-64.local>
In-Reply-To: 1395b15ce4b8c6e62ea6ab37bf8f1234600095e5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3575

--===============7228688564211425518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/02/20 - 11:49:34, Paolo Abeni wrote:
> On Fri, 2020-01-31 at 17:12 -0800, Christoph Paasch wrote:
> > Another one, probably the same root-cause. =

> =

> Indeed.
> =

> > Syzkaller hit 'KASAN: use-after-free Read in __lock_sock' bug.
> > =

> > TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending c=
ookies.  Check SNMP counters.
> > TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending c=
ookies.  Check SNMP counters.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: use-after-free in __lock_acquire+0x33fd/0x4680 kernel/locki=
ng/lockdep.c:3827
> > Read of size 8 at addr ffff88810ecadf20 by task syz-executor.3/6806
> > =

> > CPU: 1 PID: 6806 Comm: syz-executor.3 Not tainted 5.5.0-next-20200131 #5
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-=
0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xef/0x16e lib/dump_stack.c:118
> >  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
> >  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
> >  kasan_report+0xe/0x20 mm/kasan/common.c:641
> >  __lock_acquire+0x33fd/0x4680 kernel/locking/lockdep.c:3827
> >  lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
> >  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
> >  _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
> >  spin_lock_bh include/linux/spinlock.h:343 [inline]
> >  __lock_sock+0x145/0x260 net/core/sock.c:2414
> >  lock_sock_nested+0xf6/0x120 net/core/sock.c:2938
> >  lock_sock include/net/sock.h:1516 [inline]
> >  mptcp_listen+0x8c/0x2f0 net/mptcp/protocol.c:1586
> >  __sys_listen+0x182/0x250 net/socket.c:1696
> >  __do_sys_listen net/socket.c:1705 [inline]
> >  __se_sys_listen net/socket.c:1703 [inline]
> >  __x64_sys_listen+0x50/0x70 net/socket.c:1703
> >  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x7faaa0ca0469
> > Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> > RSP: 002b:00007faaa134edd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
> > TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending c=
ookies.  Check SNMP counters.
> > RAX: ffffffffffffffda RBX: 000000000066c050 RCX: 00007faaa0ca0469
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> > RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000070e
> > R13: 0000000000419e4d R14: 00007faaa134f5c0 R15: 0000000000000003
> > =

> > Allocated by task 6796:
> >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  __kasan_kmalloc mm/kasan/common.c:515 [inline]
> >  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:488
> >  slab_post_alloc_hook mm/slab.h:584 [inline]
> >  slab_alloc_node mm/slub.c:2778 [inline]
> >  slab_alloc mm/slub.c:2786 [inline]
> >  kmem_cache_alloc+0xd8/0x2e0 mm/slub.c:2791
> >  sk_prot_alloc+0x5f/0x2c0 net/core/sock.c:1597
> >  sk_alloc+0x36/0xf90 net/core/sock.c:1657
> >  inet6_create net/ipv6/af_inet6.c:180 [inline]
> >  inet6_create+0x35f/0xf50 net/ipv6/af_inet6.c:107
> >  __sock_create+0x3d9/0x740 net/socket.c:1433
> >  sock_create net/socket.c:1484 [inline]
> >  __sys_socket+0xef/0x200 net/socket.c:1526
> >  __do_sys_socket net/socket.c:1535 [inline]
> >  __se_sys_socket net/socket.c:1533 [inline]
> >  __x64_sys_socket+0x6f/0xb0 net/socket.c:1533
> >  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > =

> > Freed by task 6800:
> >  save_stack+0x1b/0x80 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  kasan_set_free_info mm/kasan/common.c:337 [inline]
> >  __kasan_slab_free+0x12f/0x180 mm/kasan/common.c:476
> >  slab_free_hook mm/slub.c:1444 [inline]
> >  slab_free_freelist_hook mm/slub.c:1477 [inline]
> >  slab_free mm/slub.c:3024 [inline]
> >  kmem_cache_free+0xaf/0x360 mm/slub.c:3040
> >  sk_prot_free net/core/sock.c:1638 [inline]
> >  __sk_destruct+0x490/0x680 net/core/sock.c:1724
> >  sk_destruct+0xc6/0x100 net/core/sock.c:1739
> >  __sk_free+0xef/0x3d0 net/core/sock.c:1750
> >  sk_free+0x78/0xa0 net/core/sock.c:1761
> >  sock_put include/net/sock.h:1719 [inline]
> >  sk_common_release+0x254/0x370 net/core/sock.c:3200
> >  __mptcp_close+0x3f3/0x5f0 net/mptcp/protocol.c:1131
> >  __mptcp_fallback_to_tcp net/mptcp/protocol.c:78 [inline]
> >  __mptcp_tcp_fallback net/mptcp/protocol.c:119 [inline]
> >  __mptcp_tcp_fallback+0x765/0xa50 net/mptcp/protocol.c:103
> =

> Oh crap! AFAICS the problem is:
> =

> __mptcp_tcp_fallback() frees the msk and graft socket to the subflow
> sk.
> =

> A racing socket ops can grab the 'old' socket->sk and try to access the
> freed struct sock.
> =

> What makes the problem very nasty is that callers access socket->sk in
> a lockless way, so I don't see how we can avoid the freed sock access. =

> =

> Additional equally bad issue: a racing socket ops can also access the
> NULL socket->sk in between sock_orphan() and sock_graph() !!!
> =

> One (=3D=3Dthe only) sulution I can think of is both ugly and dumb:
> postpone msk free at subflow ctx deallocation time (addining a ptr
> field inside the ULP context) and ensure check for TCP fallback are in
> place in every MPTCP op, under the msk socket lock.
> =

> Me looks for more coffee :(

What if mptcp_sock would have a struct tcp_sock at the beginning and we
simply "convert" the mptcp_sock to the subflow tcp_sock ? (basically, copy
the content from tcp_sock of the subflow to the tcp_sock of the mptcp_sock).

And then just let things continue. No need to change the sk-pointer,...
That should work, no?


Christoph

--===============7228688564211425518==--
