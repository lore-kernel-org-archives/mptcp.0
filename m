Content-Type: multipart/mixed; boundary="===============0663929490546051811=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] WARNING: CPU: 0 PID: 9 at
 net/mptcp/protocol.c:200 __mptcp_move_skbs_from_subflow+0x371/0x4a0
 net/mptcp/protocol.c:200
Date: Thu, 26 Mar 2020 17:53:12 +0100
Message-ID: <68770c06490c93d448c0fbc1794bc76e4712fead.camel@redhat.com>
In-Reply-To: 20200325013943.GC3854@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4082

--===============0663929490546051811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-24 at 18:39 -0700, Christoph Paasch wrote:
> Hello,
> =

> yet another one:
> =

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at net/mptcp/protocol.c:200 __mptcp_move_skbs_from=
_subflow+0x371/0x4a0 net/mptcp/protocol.c:200
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.6.0-rc5 #62
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-=
ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xda/0x116 lib/dump_stack.c:118
>  panic+0x1ae/0x509 kernel/panic.c:221
>  __warn.cold+0x2a/0x2e kernel/panic.c:582
>  report_bug+0x1a9/0x1e0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
>  do_error_trap+0x97/0xc0 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>  invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:__mptcp_move_skbs_from_subflow+0x371/0x4a0 net/mptcp/protocol.c=
:200
> Code: 00 01 41 89 44 24 28 8b 45 b8 03 45 a8 41 01 c7 44 2b 7d ac 44 89 f=
e e8 ad d5 2e ff 44 39 fb 0f 86 0c fe ff ff e8 9f d4 2e ff <0f> 0b e9 51 fe=
 ff ff e8 93 d4 2e ff 49 83 be c8 00 00 00 00 0f 85
> RSP: 0018:ffffc900000679e0 EFLAGS: 00010206
> RAX: ffff88807d525040 RBX: 0000000000007fc9 RCX: ffffffff81faa183
> RDX: 0000000000000100 RSI: ffffffff81faa191 RDI: 0000000000000004
> RBP: ffffc90000067a48 R08: ffff88807d525040 R09: 000000006215a4a4
> R10: 0000000036cc3e18 R11: 00000000f697ff28 R12: ffff888052c6ad18
> R13: ffff8880539a06c0 R14: ffff888055e98080 R15: 0000000000007fc8
>  move_skbs_to_msk+0xe6/0xf0 net/mptcp/protocol.c:238
>  mptcp_data_ready+0xa8/0x150 net/mptcp/protocol.c:252
>  subflow_data_ready+0x8a/0xa0 net/mptcp/subflow.c:774
>  tcp_data_ready net/ipv4/tcp_input.c:4767 [inline]
>  tcp_data_queue+0x692/0x15b0 net/ipv4/tcp_input.c:4833
>  tcp_rcv_established+0x302/0xae0 net/ipv4/tcp_input.c:5727
>  tcp_v4_do_rcv+0x231/0x350 net/ipv4/tcp_ipv4.c:1621
>  tcp_v4_rcv+0x10da/0x1220 net/ipv4/tcp_ipv4.c:2003
>  ip_protocol_deliver_rcu+0x20/0x130 net/ipv4/ip_input.c:204
>  ip_local_deliver_finish net/ipv4/ip_input.c:231 [inline]
>  NF_HOOK include/linux/netfilter.h:421 [inline]
>  ip_local_deliver+0xe0/0x100 net/ipv4/ip_input.c:252
>  dst_input include/net/dst.h:442 [inline]
>  ip_rcv_finish net/ipv4/ip_input.c:428 [inline]
>  ip_rcv_finish net/ipv4/ip_input.c:414 [inline]
>  NF_HOOK include/linux/netfilter.h:421 [inline]
>  ip_rcv+0x70/0xa0 net/ipv4/ip_input.c:538
>  __netif_receive_skb_one_core+0x68/0xa0 net/core/dev.c:5187
>  __netif_receive_skb+0x2a/0xa0 net/core/dev.c:5301
>  process_backlog+0x104/0x250 net/core/dev.c:6133
>  napi_poll net/core/dev.c:6571 [inline]
>  net_rx_action+0x14a/0x520 net/core/dev.c:6639
>  __do_softirq+0x115/0x33f kernel/softirq.c:292
>  run_ksoftirqd+0x46/0x60 kernel/softirq.c:603
>  smpboot_thread_fn+0x297/0x390 kernel/smpboot.c:165
>  kthread+0x153/0x180 kernel/kthread.c:255
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 1 seconds..
> =

> =

> On top of 402d1b0dc2e1 ("mptcp: re-check dsn before reading from subflow")
> =

> syzkaller-repro:
> # {Threaded:true Collide:false Repeat:true RepeatTimes:0 Procs:1 Sandbox:=
none Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:true NetDe=
vices:true NetReset:false Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:=
false DevlinkPCI:false UseTmpDir:true HandleSegv:false Repro:false Trace:fa=
lse}
> r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
> bind$inet(r1, &(0x7f00000013c0)=3D{0x2, 0x4e20, @multicast2}, 0x10)
> connect$inet(r1, &(0x7f0000000040)=3D{0x2, 0x0, @loopback}, 0x10)
> listen(r1, 0x3)
> r2 =3D socket$inet6_tcp(0xa, 0x1, 0x0)
> ioctl$sock_SIOCGIFVLAN_SET_VLAN_NAME_TYPE_CMD(r2, 0x8982, 0x0)
> connect$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e20, @loopback}, 0x4d)
> sendmsg$inet(r0, &(0x7f0000000280)=3D{0x0, 0x0, &(0x7f0000000000)=3D[{&(0=
x7f0000000080)=3D"ff", 0xff3e}], 0x1}, 0x0)
> =

> =

> C-repro is attached.

Thanks!

This is unfortunatelly ugly :(

Running the repro in a loop, without panic_on_warn I see a few
additional issues:

* at socket destroy time:
"""
IPv4: Attempt to release TCP socket in state 1 0000000000ac3381
"""

this is alreay tracked by:

https://github.com/multipath-tcp/mptcp_net-next/issues/9

* WARN_ON_ONCE(subflow->can_ack) in check_fully_established()

Adding more debug, looks like this is on client side, and the server is
sending an MPC over an established TCP connection !?!

* a final oops:

[ 3957.373087] general protection fault, probably for non-canonical address=
 0xdffffc000000008d: 0000 [#1] SMP KASAN PTI
[ 3957.375782] KASAN: null-ptr-deref in range [0x0000000000000468-0x0000000=
00000046f]
[ 3957.379704] CPU: 2 PID: 21 Comm: ksoftirqd/2 Tainted: G        W        =
 5.6.0-rc5.mptcp_bf07a8137067+ #32
[ 3957.381619] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-2.fc30 04/01/2014
[ 3957.383363] RIP: 0010:subflow_state_change (/home/pabeni/devel/linux-mpt=
cp/net/mptcp/subflow.c:994) =

[ 3957.388117] RSP: 0018:ffff888103d0f658 EFLAGS: 00010206
[ 3957.389131] RAX: dffffc0000000000 RBX: ffff88809209be80 RCX: 00000000000=
00000
[ 3957.390383] RDX: 000000000000008d RSI: 1ffff11020b04922 RDI: 00000000000=
0046a
[ 3957.391851] RBP: ffff88803630fe00 R08: 0000000000000001 R09: 00000000000=
00004
[ 3957.393163] R10: fffffbfff78bcae0 R11: ffffffffbc5e5707 R12: ffff8880363=
0fe48
[ 3957.394484] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880b0a=
9a000
[ 3957.395726] FS:  0000000000000000(0000) GS:ffff888105800000(0000) knlGS:=
0000000000000000
[ 3957.397281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3957.398502] CR2: 0000000000000000 CR3: 0000000092ca8001 CR4: 00000000001=
60ee0
[ 3957.399863] Call Trace:
[ 3957.400601] tcp_rcv_state_process (/home/pabeni/devel/linux-mptcp/net/ip=
v4/tcp_input.c:6268) =

[ 3957.402776] tcp_child_process (/home/pabeni/devel/linux-mptcp/net/ipv4/t=
cp_minisocks.c:838) =

[ 3957.407542] tcp_v4_rcv (/home/pabeni/devel/linux-mptcp/net/ipv4/tcp_ipv4=
.c:1961) =

[ 3957.410859] ip_protocol_deliver_rcu (/home/pabeni/devel/linux-mptcp/net/=
ipv4/ip_input.c:204 (discriminator 1)) =


So it looks like subflow->conn can still be NULL due to some race

I think we should track the above with individual github issues.

/P

--===============0663929490546051811==--
