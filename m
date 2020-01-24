Content-Type: multipart/mixed; boundary="===============7267128258253297206=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] possible deadlock in do_ip_setsockopt
Date: Fri, 24 Jan 2020 08:36:13 -0800
Message-ID: <20200124163613.GE60524@MacBook-Pro-64.local>
In-Reply-To: 20200124160811.GB60524@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3497

--===============7267128258253297206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FWIW, I changed syzkaller to run on net-next and am hitting the same panic.


Christoph

On 24/01/20 - 08:08:12, Christoph Paasch wrote:
> Finally got around to setup syzkaller with MPTCP. And it immediately star=
ts
> having some fun. No reproducer yet, will share it once it's out there.
> =

> This is on top of the export-branch.
> =

> =

> Christoph
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.5.0-rc6 #2 Not tainted
> ------------------------------------------------------
> syz-executor.0/16334 is trying to acquire lock:
> ffffffff84f7a080 (rtnl_mutex){+.+.}, at: do_ip_setsockopt.isra.0+0x277/0x=
3820 net/ipv4/ip_sockglue.c:644
> =

> but task is already holding lock:
> ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: lock_sock include/net/sock.=
h:1516 [inline]
> ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: mptcp_setsockopt+0x28/0x90 =
net/mptcp/protocol.c:1284
> =

> which lock already depends on the new lock.
> =

> =

> the existing dependency chain (in reverse order) is:
> =

> -> #1 (sk_lock-AF_INET){+.+.}:
>        lock_sock_nested+0xca/0x120 net/core/sock.c:2944
>        lock_sock include/net/sock.h:1516 [inline]
>        do_ip_setsockopt.isra.0+0x281/0x3820 net/ipv4/ip_sockglue.c:645
>        ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
>        udp_setsockopt+0x5d/0xa0 net/ipv4/udp.c:2639
>        __sys_setsockopt+0x152/0x240 net/socket.c:2130
>        __do_sys_setsockopt net/socket.c:2146 [inline]
>        __se_sys_setsockopt net/socket.c:2143 [inline]
>        __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>        do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

> -> #0 (rtnl_mutex){+.+.}:
>        check_prev_add kernel/locking/lockdep.c:2475 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>        validate_chain kernel/locking/lockdep.c:2970 [inline]
>        __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
>        lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
>        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>        __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
>        do_ip_setsockopt.isra.0+0x277/0x3820 net/ipv4/ip_sockglue.c:644
>        ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
>        tcp_setsockopt net/ipv4/tcp.c:3159 [inline]
>        tcp_setsockopt+0x8c/0xd0 net/ipv4/tcp.c:3153
>        kernel_setsockopt+0x121/0x1f0 net/socket.c:3767
>        mptcp_setsockopt+0x69/0x90 net/mptcp/protocol.c:1288
>        __sys_setsockopt+0x152/0x240 net/socket.c:2130
>        __do_sys_setsockopt net/socket.c:2146 [inline]
>        __se_sys_setsockopt net/socket.c:2143 [inline]
>        __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>        do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

> other info that might help us debug this:
> =

>  Possible unsafe locking scenario:
> =

>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_INET);
>                                lock(rtnl_mutex);
>                                lock(sk_lock-AF_INET);
>   lock(rtnl_mutex);
> =

>  *** DEADLOCK ***
> =

> 1 lock held by syz-executor.0/16334:
>  #0: ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: lock_sock include/net/=
sock.h:1516 [inline]
>  #0: ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: mptcp_setsockopt+0x28/=
0x90 net/mptcp/protocol.c:1284
> =

> stack backtrace:
> CPU: 0 PID: 16334 Comm: syz-executor.0 Not tainted 5.5.0-rc6 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  check_noncircular+0x337/0x3f0 kernel/locking/lockdep.c:1808
>  check_prev_add kernel/locking/lockdep.c:2475 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>  validate_chain kernel/locking/lockdep.c:2970 [inline]
>  __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
>  lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
>  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>  __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
>  do_ip_setsockopt.isra.0+0x277/0x3820 net/ipv4/ip_sockglue.c:644
>  ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
>  tcp_setsockopt net/ipv4/tcp.c:3159 [inline]
>  tcp_setsockopt+0x8c/0xd0 net/ipv4/tcp.c:3153
>  kernel_setsockopt+0x121/0x1f0 net/socket.c:3767
>  mptcp_setsockopt+0x69/0x90 net/mptcp/protocol.c:1288
>  __sys_setsockopt+0x152/0x240 net/socket.c:2130
>  __do_sys_setsockopt net/socket.c:2146 [inline]
>  __se_sys_setsockopt net/socket.c:2143 [inline]
>  __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f12788b0469
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007f1278fa0dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 000000000066bf00 RCX: 00007f12788b0469
> RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000008
> RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020000140 R11: 0000000000000246 R12: 0000000000000a4c
> R13: 000000000041d04b R14: 00007f1278fa15c0 R15: 0000000000000003
> syz-executor.0 (2091) used greatest stack depth: 24704 bytes left
> syz-executor.2 (2092) used greatest stack depth: 24448 bytes left
> syz-executor.6 (2098) used greatest stack depth: 24336 bytes left
> =

> =

> =

>=20
--===============7267128258253297206==--
