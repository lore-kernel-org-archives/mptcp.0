Content-Type: multipart/mixed; boundary="===============5670710029127183030=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] WARNING: CPU: 0 PID: 17298 at
 net/mptcp/protocol.c:305 mptcp_reset_timer+0x89/0xb0 net/mptcp/protocol.c:305
Date: Mon, 23 Mar 2020 10:47:56 +0100
Message-ID: <7cef4e425a372f4fad34983cad76e255d7da6e7c.camel@redhat.com>
In-Reply-To: 20200323043133.GB1381@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4043

--===============5670710029127183030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-03-22 at 21:31 -0700, Christoph Paasch wrote:
> Hello,
> =

> I had a syzkaller failure today.
> =

> Reproducer is:
> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbo=
x: Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:false NetDev=
ices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCS=
AN:false DevlinkPCI:false UseTmpDir:false HandleSegv:false Repro:false Trac=
e:false}
> r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> bind$inet(r1, &(0x7f00000013c0)=3D{0x2, 0x4e20, @multicast2}, 0x10)
> connect$inet(r1, &(0x7f0000000040)=3D{0x2, 0x0, @loopback}, 0x10)
> listen(r1, 0x3)
> connect$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e20, @loopback}, 0x4d)
> sendmsg$inet(r0, &(0x7f0000000280)=3D{0x0, 0x0, &(0x7f0000000000)=3D[{&(0=
x7f0000000080)=3D"ff", 0x20000081}], 0x1}, 0x0)
> =

> The panic:
> =

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 17298 at net/mptcp/protocol.c:305 mptcp_reset_timer+=
0x89/0xb0 net/mptcp/protocol.c:305
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 17298 Comm: syz-executor.5 Not tainted 5.6.0-rc5 #61
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x150/0x1a0 lib/dump_stack.c:118
>  panic+0x2de/0x725 kernel/panic.c:221
>  __warn.cold+0x2f/0x33 kernel/panic.c:582
>  report_bug+0x291/0x300 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
>  do_error_trap+0x10a/0x1b0 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>  invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:mptcp_reset_timer+0x89/0xb0 net/mptcp/protocol.c:305
> Code: 80 3c 10 00 75 2d 48 8b 15 04 8b e9 00 49 8d b4 24 08 04 00 00 4c 8=
9 e7 48 01 da e8 c1 cc 99 ff 5b 41 5c 5d c3 e8 27 55 0a fe <0f> 0b bb 14 00=
 00 00 eb b3 48 c7 c7 00 90 40 84 e8 c2 66 3a fe eb
> RSP: 0018:ffffc9001328f070 EFLAGS: 00010212
> RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000321d000
> RDX: 0000000000007bc8 RSI: ffffffff83570519 RDI: 0000000000000007
> RBP: ffffc9001328f080 R08: ffff88803cf77000 R09: ffffed1006c3ff8d
> R10: ffffed1006c3ff8c R11: ffff8880361ffc67 R12: ffff8880361ff700
> R13: 4dc1477c1c2da268 R14: ffff8880361ff834 R15: ffff88801fe71c00
>  mptcp_data_acked+0x28/0x330 net/mptcp/protocol.c:312
>  update_una net/mptcp/options.c:778 [inline]
>  mptcp_incoming_options+0xdc0/0x14f0 net/mptcp/options.c:849
>  tcp_data_queue+0xe8a/0x4870 net/ipv4/tcp_input.c:4777
>  tcp_rcv_established+0x8d4/0x1d20 net/ipv4/tcp_input.c:5727
>  tcp_v4_do_rcv+0x60f/0x8c0 net/ipv4/tcp_ipv4.c:1621
>  sk_backlog_rcv include/net/sock.h:996 [inline]
>  __release_sock+0x1a6/0x310 net/core/sock.c:2448
>  release_sock+0x59/0x1b0 net/core/sock.c:2964
>  sk_stream_wait_memory+0x641/0xfc0 net/core/stream.c:145
>  do_tcp_sendpages+0x8fd/0x1e80 net/ipv4/tcp.c:1068
>  mptcp_sendmsg_frag+0x1418/0x1f00 net/mptcp/protocol.c:560
>  mptcp_sendmsg+0x541/0xe60 net/mptcp/protocol.c:739
>  inet_sendmsg+0x9e/0xe0 net/ipv4/af_inet.c:807
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  sock_write_iter+0x309/0x490 net/socket.c:1004
>  call_write_iter include/linux/fs.h:1901 [inline]
>  do_iter_readv_writev+0x57c/0x830 fs/read_write.c:693
>  do_iter_write fs/read_write.c:998 [inline]
>  do_iter_write+0x184/0x600 fs/read_write.c:979
>  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1071
>  do_writev+0x2ac/0x330 fs/read_write.c:1114
>  __do_sys_writev fs/read_write.c:1187 [inline]
>  __se_sys_writev fs/read_write.c:1184 [inline]
>  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1184
>  do_syscall_64+0xf3/0x570 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fdb995b3469
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007fdb99ca3dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 000000000066bf00 RCX: 00007fdb995b3469
> RDX: 0000000000000001 RSI: 00000000200001c0 RDI: 0000000000000003
> RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000d19
> R13: 000000000041c19f R14: 00007fdb99ca45c0 R15: 0000000000000003
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..
> =

> =

> C reproducer is attached.
> =

> This is on top of the export-branch, 624ef4177659 ("mptcp: re-check dsn b=
efore reading from subflow").

Thank you for the report!

This is the same issue we see on selftests with the '-m' option, as
reported by Florian, tracked here:

https://github.com/multipath-tcp/mptcp_net-next/issues/3

Looks like it's time to fix it for good ;)

/P

--===============5670710029127183030==--
