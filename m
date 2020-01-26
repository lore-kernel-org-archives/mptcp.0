Content-Type: multipart/mixed; boundary="===============0104819476872701180=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: protocol: fix panic on user
 pointer access
Date: Sun, 26 Jan 2020 11:48:37 -0700
Message-ID: <20200126184837.GA70494@MacBook-Pro-64.local>
In-Reply-To: 20200126164735.29905-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3517

--===============0104819476872701180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 26/01/20 - 17:47:35, Florian Westphal wrote:
> Its not possible to call the kernel_(s|g)etsockopt functions here,
> the address points to user memory:
> =

> General protection fault in user access. Non-canonical address?
> WARNING: CPU: 1 PID: 5352 at arch/x86/mm/extable.c:77 ex_handler_uaccess+=
0xba/0xe0 arch/x86/mm/extable.c:77
> Kernel panic - not syncing: panic_on_warn set ...
> [..]
> Call Trace:
>  fixup_exception+0x9d/0xcd arch/x86/mm/extable.c:178
>  general_protection+0x2d/0x40 arch/x86/entry/entry_64.S:1202
>  do_ip_getsockopt+0x1f6/0x1860 net/ipv4/ip_sockglue.c:1323
>  ip_getsockopt+0x87/0x1c0 net/ipv4/ip_sockglue.c:1561
>  tcp_getsockopt net/ipv4/tcp.c:3691 [inline]
>  tcp_getsockopt+0x8c/0xd0 net/ipv4/tcp.c:3685
>  kernel_getsockopt+0x121/0x1f0 net/socket.c:3736
>  mptcp_getsockopt+0x69/0x90 net/mptcp/protocol.c:830
>  __sys_getsockopt+0x13a/0x220 net/socket.c:2175
> =

> v2: also fix a circular locking dependency reported by Christoph:
>     release the mptcp-level lock before calling set/getsockopt on the
>     underlying tcp subflow socket, else this yields:
> =

>  WARNING: possible circular locking dependency detected
>  5.5.0-rc6 #2 Not tainted
>  ------------------------------------------------------
>  syz-executor.0/16334 is trying to acquire lock:
>  ffffffff84f7a080 (rtnl_mutex){+.+.}, at: do_ip_setsockopt.isra.0+0x277/0=
x3820 net/ipv4/ip_sockglue.c:644
>  but task is already holding lock:
>  ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: lock_sock include/net/sock=
.h:1516 [inline]
>  ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: mptcp_setsockopt+0x28/0x90=
 net/mptcp/protocol.c:1284
> =

>  which lock already depends on the new lock.
>  the existing dependency chain (in reverse order) is:
> =

>  -> #1 (sk_lock-AF_INET){+.+.}:
>         lock_sock_nested+0xca/0x120 net/core/sock.c:2944
>         lock_sock include/net/sock.h:1516 [inline]
>         do_ip_setsockopt.isra.0+0x281/0x3820 net/ipv4/ip_sockglue.c:645
>         ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
>         udp_setsockopt+0x5d/0xa0 net/ipv4/udp.c:2639
>         __sys_setsockopt+0x152/0x240 net/socket.c:2130
>         __do_sys_setsockopt net/socket.c:2146 [inline]
>         __se_sys_setsockopt net/socket.c:2143 [inline]
>         __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>         do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

>  -> #0 (rtnl_mutex){+.+.}:
>         check_prev_add kernel/locking/lockdep.c:2475 [inline]
>         check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>         validate_chain kernel/locking/lockdep.c:2970 [inline]
>         __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
>         lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
>         __mutex_lock_common kernel/locking/mutex.c:956 [inline]
>         __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
>         do_ip_setsockopt.isra.0+0x277/0x3820 net/ipv4/ip_sockglue.c:644
>         ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
>         tcp_setsockopt net/ipv4/tcp.c:3159 [inline]
>         tcp_setsockopt+0x8c/0xd0 net/ipv4/tcp.c:3153
>         kernel_setsockopt+0x121/0x1f0 net/socket.c:3767
>         mptcp_setsockopt+0x69/0x90 net/mptcp/protocol.c:1288
>         __sys_setsockopt+0x152/0x240 net/socket.c:2130
>         __do_sys_setsockopt net/socket.c:2146 [inline]
>         __se_sys_setsockopt net/socket.c:2143 [inline]
>         __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
>         do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> =

>  other info that might help us debug this:
> =

>   Possible unsafe locking scenario:
> =

>         CPU0                    CPU1
>         ----                    ----
>    lock(sk_lock-AF_INET);
>                                 lock(rtnl_mutex);
>                                 lock(sk_lock-AF_INET);
>    lock(rtnl_mutex);
> =

> Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operat=
ions")
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

I kicked off syzkaller on top of net-next + this patch here.

I'm still getting some circular lockdep-warnings in the setsockopt codepath
(no reproducer yet):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.5.0-rc7 #1 Not tainted
------------------------------------------------------
syz-executor.3/22312 is trying to acquire lock:
ffffffff84f7aac0 (rtnl_mutex){+.+.}, at: ipv6_sock_mc_close+0xc1/0xf0 net/i=
pv6/mcast.c:323

but task is already holding lock:
ffff888111f74010 (sk_lock-AF_INET6){+.+.}, at: lock_sock include/net/sock.h=
:1516 [inline]
ffff888111f74010 (sk_lock-AF_INET6){+.+.}, at: mptcp_close+0x18/0x30 net/mp=
tcp/protocol.c:665

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET6){+.+.}:
       lock_sock_nested+0xca/0x120 net/core/sock.c:2944
       lock_sock include/net/sock.h:1516 [inline]
       do_ipv6_setsockopt.isra.0+0x362/0x4360 net/ipv6/ipv6_sockglue.c:165
       ipv6_setsockopt+0x101/0x180 net/ipv6/ipv6_sockglue.c:944
       udpv6_setsockopt+0x5d/0xa0 net/ipv6/udp.c:1564
       __sys_setsockopt+0x152/0x240 net/socket.c:2130
       __do_sys_setsockopt net/socket.c:2146 [inline]
       __se_sys_setsockopt net/socket.c:2143 [inline]
       __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
       do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (rtnl_mutex){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
       lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
       ipv6_sock_mc_close+0xc1/0xf0 net/ipv6/mcast.c:323
       inet6_release+0x3c/0x70 net/ipv6/af_inet6.c:465
       __sock_release+0x1dd/0x290 net/socket.c:605
       __mptcp_close_ssk net/mptcp/protocol.c:592 [inline]
       __mptcp_close+0xec/0x360 net/mptcp/protocol.c:654
       inet_release+0xe9/0x1f0 net/ipv4/af_inet.c:427
       inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:470
       __sock_release+0xd2/0x290 net/socket.c:605
       sock_close+0x18/0x20 net/socket.c:1283
       __fput+0x2da/0x850 fs/file_table.c:280
       task_work_run+0x144/0x1c0 kernel/task_work.c:113
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
       prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
       syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
       do_syscall_64+0x4d7/0x5b0 arch/x86/entry/common.c:304
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET6);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor.3/22312:
 #0: ffff888109b4a500 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_lock i=
nclude/linux/fs.h:791 [inline]
 #0: ffff888109b4a500 (&sb->s_type->i_mutex_key#10){+.+.}, at: __sock_relea=
se+0x86/0x290 net/socket.c:604
 #1: ffff888111f74010 (sk_lock-AF_INET6){+.+.}, at: lock_sock include/net/s=
ock.h:1516 [inline]
 #1: ffff888111f74010 (sk_lock-AF_INET6){+.+.}, at: mptcp_close+0x18/0x30 n=
et/mptcp/protocol.c:665

stack backtrace:
CPU: 0 PID: 22312 Comm: syz-executor.3 Not tainted 5.5.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 check_noncircular+0x337/0x3f0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
 lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
 ipv6_sock_mc_close+0xc1/0xf0 net/ipv6/mcast.c:323
 inet6_release+0x3c/0x70 net/ipv6/af_inet6.c:465
 __sock_release+0x1dd/0x290 net/socket.c:605
 __mptcp_close_ssk net/mptcp/protocol.c:592 [inline]
 __mptcp_close+0xec/0x360 net/mptcp/protocol.c:654
 inet_release+0xe9/0x1f0 net/ipv4/af_inet.c:427
 inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:470
 __sock_release+0xd2/0x290 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1283
 __fput+0x2da/0x850 fs/file_table.c:280
 task_work_run+0x144/0x1c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x4d7/0x5b0 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f691394128d
Code: c1 20 00 00 75 10 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 =
83 ec 08 e8 ee fb ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 8=
9 c2 e8 37 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffec314aaf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00007f691394128d
RDX: 0000001b30220000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000004 R08: 00000000006704a8 R09: 000000008fa73b09
R10: 000000008fa73b0d R11: 0000000000000293 R12: 0000000000000001
R13: 000000000002076c R14: 00000000006704a8 R15: 00000000000007d0
syz-executor.2 (2179) used greatest stack depth: 24704 bytes left
syz-executor.1 (2127) used greatest stack depth: 24384 bytes left
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.5.0-rc7 #1 Not tainted
------------------------------------------------------
syz-executor.5/16250 is trying to acquire lock:
ffff88811348e690 (sk_lock-AF_INET6){+.+.}, at: lock_sock include/net/sock.h=
:1516 [inline]
ffff88811348e690 (sk_lock-AF_INET6){+.+.}, at: do_ipv6_setsockopt.isra.0+0x=
362/0x4360 net/ipv6/ipv6_sockglue.c:165

but task is already holding lock:
ffffffff84f7aac0 (rtnl_mutex){+.+.}, at: do_ipv6_setsockopt.isra.0+0x358/0x=
4360 net/ipv6/ipv6_sockglue.c:164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
       ipv6_sock_mc_close+0xc1/0xf0 net/ipv6/mcast.c:323
       inet6_release+0x3c/0x70 net/ipv6/af_inet6.c:465
       __sock_release+0x1dd/0x290 net/socket.c:605
       __mptcp_close_ssk net/mptcp/protocol.c:592 [inline]
       __mptcp_close+0xec/0x360 net/mptcp/protocol.c:654
       inet_release+0xe9/0x1f0 net/ipv4/af_inet.c:427
       inet6_release+0x4c/0x70 net/ipv6/af_inet6.c:470
       __sock_release+0xd2/0x290 net/socket.c:605
       sock_close+0x18/0x20 net/socket.c:1283
       __fput+0x2da/0x850 fs/file_table.c:280
       task_work_run+0x144/0x1c0 kernel/task_work.c:113
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:164
       prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
       syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
       do_syscall_64+0x4d7/0x5b0 arch/x86/entry/common.c:304
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (sk_lock-AF_INET6){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
       lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
       lock_sock_nested+0xca/0x120 net/core/sock.c:2944
       lock_sock include/net/sock.h:1516 [inline]
       do_ipv6_setsockopt.isra.0+0x362/0x4360 net/ipv6/ipv6_sockglue.c:165
       ipv6_setsockopt+0x101/0x180 net/ipv6/ipv6_sockglue.c:944
       udpv6_setsockopt+0x5d/0xa0 net/ipv6/udp.c:1564
       __sys_setsockopt+0x152/0x240 net/socket.c:2130
       __do_sys_setsockopt net/socket.c:2146 [inline]
       __se_sys_setsockopt net/socket.c:2143 [inline]
       __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
       do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_INET6);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

1 lock held by syz-executor.5/16250:
 #0: ffffffff84f7aac0 (rtnl_mutex){+.+.}, at: do_ipv6_setsockopt.isra.0+0x3=
58/0x4360 net/ipv6/ipv6_sockglue.c:164

stack backtrace:
CPU: 1 PID: 16250 Comm: syz-executor.5 Not tainted 5.5.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 check_noncircular+0x337/0x3f0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
 lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
 lock_sock_nested+0xca/0x120 net/core/sock.c:2944
 lock_sock include/net/sock.h:1516 [inline]
 do_ipv6_setsockopt.isra.0+0x362/0x4360 net/ipv6/ipv6_sockglue.c:165
 ipv6_setsockopt+0x101/0x180 net/ipv6/ipv6_sockglue.c:944
 udpv6_setsockopt+0x5d/0xa0 net/ipv6/udp.c:1564
 __sys_setsockopt+0x152/0x240 net/socket.c:2130
 __do_sys_setsockopt net/socket.c:2146 [inline]
 __se_sys_setsockopt net/socket.c:2143 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f35bd9ad469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007f35be09ddd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000066bf00 RCX: 00007f35bd9ad469
RDX: 000000000000002c RSI: 0000000000000029 RDI: 0000000000000015
RBP: 00000000ffffffff R08: 0000000000000108 R09: 0000000000000000
R10: 0000000020000540 R11: 0000000000000246 R12: 0000000000000a50
R13: 0000000000439e70 R14: 00007f35be09e5c0 R15: 0000000000000003
syz-executor.7 (2193) used greatest stack depth: 24704 bytes left
syz-executor.1 (2164) used greatest stack depth: 24568 bytes left
syz-executor.6 (2142) used greatest stack depth: 24448 bytes left
syz-executor.3 (2140) used greatest stack depth: 24336 bytes left



Cheers,
Christoph






--===============0104819476872701180==--
