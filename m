Content-Type: multipart/mixed; boundary="===============5915658450389011730=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Thu, 26 Nov 2020 11:03:09 +0100
Message-ID: <ec6c4f757b368a4a22577d7d2de616ea530fbfd5.camel@redhat.com>
In-Reply-To: 0bbf33c70b937d1040921260647b364b22a8a21d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6945

--===============5915658450389011730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-26 at 10:56 +0100, Paolo Abeni wrote:
> On Wed, 2020-11-25 at 21:33 +0100, Davide Caratti wrote:
> > On Wed, 2020-11-25 at 11:06 +0100, Davide Caratti wrote:
> > > On Wed, 2020-11-25 at 10:54 +0100, Paolo Abeni wrote:
> > > > Note: I think this later change is actually an independed bug fix, I
> > > > fear a peer sending an MP_JOIN with an invalid token will get back =
an
> > > > MPJ_SYNACK, while the subflow_req->msk will be cleared. Later
> > > > in subflow_syn_recv_sock(), we will probably get a NULL ptr derefer=
ence
> > > > in mptcp_can_accept_new_subflow().
> > > > =

> > > > @Davide: can we somehow easily check the above with a packet drill?
> > > > =

> > > > Thanks!
> > > =

> > > yes I can try that. I'm now looking once again at the MP_JOIN script
> > > (issue #94) and trying to fix this in a way or another (the problem is
> > > apparently bad values of [s,c]addr[0,1] in the environment. But at le=
ast
> > > generation of an inbound MP_JOIN SYN should be under control. =

> > =

> > last famous words :) the parsing of "sender_hmac" definetly needs some
> > "love".
> > =

> > > I do a
> > > quicjk tyest and let you know, ok?
> > =

> > the test was not quick, *but* with a slightly modified packetdrill,
> > and the following script,
> > =

> > --tolerance_usecs=3D100000
> > `../common/defaults.sh`
> > =

> > +0    `../common/server.sh`
> > =

> > +0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0.0  fcntl(3, F_GETFL) =3D 0x2 (flags O_RDWR)
> > +0.0  fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> > =

> > +0    bind(3, ..., ...) =3D 0
> > +0    listen(3, 1) =3D 0
> > =

> > +0.0 < addr[caddr0] > addr[saddr0] S 0:0(0) win 65535 <mss 1460,sackOK,=
TS val 4074410674 ecr 0,nop,wscale 8,mpcapable v1 flags[flag_h] nokey>
> > +0.0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 4074410674 ecr 407441067=
4,nop,wscale 8,mpcapable v1 flags[flag_h] key[skey]>
> > +0.0 < . 1:1(0) ack 1 win 256 <nop,nop,TS val 4074410674 ecr 4074410674=
,mpcapable v1 flags[flag_h] key[ckey=3D2,skey]>
> > +0    accept(3, ..., ...) =3D 4
> > =

> > +1.0 < P. 1:3(2) ack 1 win 256 <nop,nop,TS val 4074418292 ecr 407441067=
4,mpcapable v1 flags[flag_h] key[skey,ckey] mpcdatalen 2,nop,nop>
> > +0.0 > . 1:1(0) ack 3 <nop,nop,TS val 4074418293 ecr 4074418292,add_add=
ress addr[saddr1] hmac=3Dauto,dss dack8=3D3 dll=3D0 nocs>
> > =

> > // I'm a bad mp_join syn!
> > +0.0 < addr[caddr1] > addr[saddr1] S 0:0(0) win 65535 <mss 1460,sackOK,=
TS val 448955294 ecr 0,nop,wscale 8,mp_join_syn backup=3D1 address_id=3D2 t=
oken=3D666 rand=3D0>
> > +0.0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 448955294 ecr 448955294,=
nop,wscale 8,mp_join_syn_ack backup=3D1 address_id=3D0 sender_hmac=3D0>
> > +0.0 < . 1:1(0) ack 1 win 256 <nop,nop,TS val 448955294 ecr 448955294,m=
p_join_ack sender_hmac=3Dauto>
> > =

> > =

> > =C2=A0I was able to reproduce the NULL dereference:
> =

> > =

> > [16663.161104] general protection fault, probably for non-canonical add=
ress 0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
> > [16663.162606] KASAN: null-ptr-deref in range [0x0000000000000010-0x000=
0000000000017]
> > [16663.163562] CPU: 1 PID: 4857 Comm: packetdrill Not tainted 5.10.0-rc=
4+ #295
> > [16663.164425] Hardware name: Red Hat KVM, BIOS 1.11.1-4.module+el8.1.0=
+4066+0f1aadab 04/01/2014
> > [16663.165562] RIP: 0010:subflow_syn_recv_sock+0x716/0x14d0
> > [16663.166243] Code: 48 c1 ee 03 80 3c 16 00 0f 85 f0 09 00 00 4c 8b 83=
 88 01 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 78 12 48 89 fe 48 c1 ee 03=
 <0f> b6 14 16 48 89 fe 83 e6 07 40 38 f2 7f 32 84 d2 74 2e 48 89 44
> > [16663.168579] RSP: 0018:ffff888114426f58 EFLAGS: 00010212
> > [16663.169237] RAX: ffff888114426ff8 RBX: ffff88810e7f5c20 RCX: ffff888=
10e7f5da8
> > [16663.170133] RDX: dffffc0000000000 RSI: 0000000000000002 RDI: 0000000=
000000012
> > [16663.171041] RBP: ffff8881144271b8 R08: 0000000000000000 R09: ffffed1=
022884e09
> > [16663.171926] R10: 0000000000000001 R11: ffffed1022884e08 R12: ffff888=
121696000
> > [16663.172796] R13: ffff888108413cc0 R14: ffff8881129cee00 R15: 1ffff11=
022884df3
> > [16663.173674] FS:  00007f396bbc2100(0000) GS:ffff888145200000(0000) kn=
lGS:0000000000000000
> > [16663.174682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [16663.175412] CR2: 0000000001bf0000 CR3: 0000000113cb6000 CR4: 0000000=
000350ee0
> > [16663.176283] Call Trace:
> > [16663.176626]  ? __lock_acquire+0xceb/0x3970
> > [16663.177150]  ? subflow_drop_ctx+0x330/0x330
> > [16663.177698]  ? kvm_sched_clock_read+0x14/0x30
> > [16663.178259]  ? sched_clock+0x5/0x10
> > [16663.178711]  ? find_held_lock+0x3a/0x1c0
> > [16663.179208]  ? lock_downgrade+0x700/0x700
> > [16663.179745]  tcp_check_req+0x3e2/0x14e0
> > [16663.180232]  ? tcp_create_openreq_child+0x14e0/0x14e0
> > [16663.180870]  ? tcp_v4_inbound_md5_hash+0xdf/0x3a0
> > [16663.181475]  ? bpf_skb_set_tunnel_opt+0x2d0/0x2d0
> > [16663.182080]  ? memmove+0x38/0x60
> > [16663.182498]  tcp_v4_rcv+0x1f90/0x3870
> > [16663.182972]  ? tcp_v4_early_demux+0x7b0/0x7b0
> > [16663.183532]  ? rcu_read_lock_sched_held+0x90/0xd0
> > [16663.184124]  ? rcu_read_lock_sched_held+0xd0/0xd0
> > [16663.184722]  ? rcu_read_unlock+0x40/0x40
> > [16663.185225]  ip_protocol_deliver_rcu+0x76/0x6b0
> > [16663.185809]  ip_local_deliver_finish+0x207/0x300
> > [16663.186394]  ip_local_deliver+0x19e/0x3f0
> > [16663.186908]  ? ip_local_deliver_finish+0x300/0x300
> > [16663.187518]  ? rcu_read_lock_sched_held+0xd0/0xd0
> > [16663.188112]  ip_rcv+0xce/0x2f0
> > [16663.188508]  ? ip_local_deliver+0x3f0/0x3f0
> > [16663.189035]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > [16663.189632]  ? ip_local_deliver+0x3f0/0x3f0
> > [16663.190177]  __netif_receive_skb_one_core+0x16a/0x1b0
> > [16663.190816]  ? __netif_receive_skb_core+0x3380/0x3380
> > [16663.191464]  ? rcu_read_unlock+0x40/0x40
> > [16663.191959]  ? lockdep_hardirqs_on_prepare+0x12c/0x3d0
> > [16663.192610]  ? kvm_clock_get_cycles+0x14/0x20
> > [16663.193179]  ? ktime_get_with_offset+0xfb/0x1e0
> > [16663.193750]  netif_receive_skb+0x15b/0x760
> > [16663.194274]  ? __netif_receive_skb+0x1a0/0x1a0
> > [16663.194832]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
> > [16663.195507]  tun_rx_batched.isra.54+0x46f/0x7e0 [tun]
> > [16663.196148]  ? lock_acquire+0x1c8/0x7f0
> > [16663.196633]  ? tun_set_ebpf+0xe0/0xe0 [tun]
> > [16663.197160]  ? lock_downgrade+0x700/0x700
> > [16663.197681]  ? rcu_read_unlock+0x40/0x40
> > [16663.198187]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
> > [16663.198842]  ? __local_bh_enable_ip+0xa5/0xf0
> > [16663.199397]  tun_get_user+0x256a/0x38a0 [tun]
> > [16663.199943]  ? print_usage_bug+0x1a0/0x1a0
> > [16663.200469]  ? tun_build_skb.isra.57+0x11a0/0x11a0 [tun]
> > [16663.201141]  ? kvm_sched_clock_read+0x14/0x30
> > [16663.201693]  ? sched_clock+0x5/0x10
> > [16663.202134]  ? sched_clock_cpu+0x18/0x170
> > [16663.202649]  ? find_held_lock+0x3a/0x1c0
> > [16663.203149]  ? lock_downgrade+0x700/0x700
> > [16663.203664]  ? rcu_read_lock_sched_held+0xd0/0xd0
> > [16663.204254]  tun_chr_write_iter+0xb5/0x150 [tun]
> > [16663.204853]  do_iter_readv_writev+0x433/0x6d0
> > [16663.205411]  ? new_sync_write+0x620/0x620
> > [16663.205911]  do_iter_write+0x135/0x600
> > [16663.206415]  ? import_iovec+0x43/0x80
> > [16663.206878]  vfs_writev+0x150/0x4f0
> > [16663.207337]  ? vfs_iter_write+0xc0/0xc0
> > [16663.207838]  ? __fget_files+0x1ce/0x2e0
> > [16663.208330]  ? do_writev+0x100/0x280
> > [16663.208778]  do_writev+0x100/0x280
> > [16663.209208]  ? vfs_writev+0x4f0/0x4f0
> > [16663.209682]  do_syscall_64+0x33/0x40
> > [16663.210148]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [16663.210786] RIP: 0033:0x7f396ae9499f
> > [16663.211241] Code: 00 00 00 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83=
 ec 10 e8 33 6c 01 00 44 89 e2 48 89 ee 89 df 41 89 c0 b8 14 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 6c 6c 01 00 48
> > [16663.213561] RSP: 002b:00007ffc691459b0 EFLAGS: 00000293 ORIG_RAX: 00=
00000000000014
> > [16663.214480] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3=
96ae9499f
> > [16663.215378] RDX: 0000000000000002 RSI: 00007ffc691459f0 RDI: 0000000=
000000004
> > [16663.216268] RBP: 00007ffc691459f0 R08: 0000000000000000 R09: 00007f3=
96bbc2100
> > [16663.217148] R10: 000000007fffffff R11: 0000000000000293 R12: 0000000=
000000002
> > [16663.218044] R13: 00007ffc69145f80 R14: 0000000000000000 R15: 0000000=
000000000
> > [16663.218937] Modules linked in: tun rfkill iTCO_wdt iTCO_vendor_suppo=
rt joydev pcspkr virtio_balloon i2c_i801 i2c_smbus lpc_ich ip_tables xfs li=
bcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci=
 libahci serio_raw libata virtio_blk virtio_net net_failover virtio_console=
 failover sunrpc dm_mirror dm_region_hash dm_log dm_mod
> > [16663.222886] ---[ end trace 7ff0b93e894b1e70 ]---
> > [16663.223524] RIP: 0010:subflow_syn_recv_sock+0x716/0x14d0
> > [16663.224199] Code: 48 c1 ee 03 80 3c 16 00 0f 85 f0 09 00 00 4c 8b 83=
 88 01 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 78 12 48 89 fe 48 c1 ee 03=
 <0f> b6 14 16 48 89 fe 83 e6 07 40 38 f2 7f 32 84 d2 74 2e 48 89 44
> > [16663.226546] RSP: 0018:ffff888114426f58 EFLAGS: 00010212
> > [16663.227204] RAX: ffff888114426ff8 RBX: ffff88810e7f5c20 RCX: ffff888=
10e7f5da8
> > [16663.228109] RDX: dffffc0000000000 RSI: 0000000000000002 RDI: 0000000=
000000012
> > [16663.229022] RBP: ffff8881144271b8 R08: 0000000000000000 R09: ffffed1=
022884e09
> > [16663.229911] R10: 0000000000000001 R11: ffffed1022884e08 R12: ffff888=
121696000
> > [16663.230832] R13: ffff888108413cc0 R14: ffff8881129cee00 R15: 1ffff11=
022884df3
> > [16663.231754] FS:  00007f396bbc2100(0000) GS:ffff888145200000(0000) kn=
lGS:0000000000000000
> > [16663.232776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [16663.233498] CR2: 0000000001bf0000 CR3: 0000000113cb6000 CR4: 0000000=
000350ee0
> > [16663.234385] Kernel panic - not syncing: Fatal exception in interrupt
> > [16663.238356] Kernel Offset: 0x3a00000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xffffffffbfffffff)
> > [16663.239699] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---
> > =

> > =

> > @Paolo, your analysis is correct: the server responds to the (d)evil
> > inbound "MP_JOIN syn" with a MP_JOIN synack having sender HMAC equal to
> > 0; the 3rd packet triggers the NULL dereference.
> > =

> > $ ./scripts/faddr2line  vmlinux subflow_syn_recv_sock+0x716
> > subflow_syn_recv_sock+0x716/0x14d0:
> > inet_sk_state_load at include/net/inet_sock.h:312 (discriminator 1)
> > (inlined by) mptcp_is_fully_established at net/mptcp/protocol.h:495 (di=
scriminator 1)
> > (inlined by) mptcp_can_accept_new_subflow at net/mptcp/subflow.c:59 (di=
scriminator 1)
> > (inlined by) subflow_syn_recv_sock at net/mptcp/subflow.c:547 (discrimi=
nator 1)
> =

> Thank you Davide, great work! Could you please additionally merge the
> above drill in the packetdrill repo?

the above script will probably generate a test failure on the outbound
MP_JOIN synack as long as a patched kernel does not crash anymore. What
we can do is to add a scenario that verifies the correct behavior _
according to  RFC =C2=A7 3.2:

<< If the token is unknown or the host wants to refuse subflow
establishment (for example, due to a limit on the number of subflows it
will permit), the receiver will send back a reset (RST) signal,
analogous to an unknown port in TCP, containing an MP_TCPRST option
(Section 3.6) with an "MPTCP specific error" reason code. >>

> I'll cook a patch - that deserve a -net target.

makes sense, thanks!
-- =

davide

--===============5915658450389011730==--
