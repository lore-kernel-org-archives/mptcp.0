Content-Type: multipart/mixed; boundary="===============8812227613072194460=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 5/9] mptcp: add port number
 announced check
Date: Wed, 25 Nov 2020 21:33:44 +0100
Message-ID: <eb5561a3886cc75665b415acd619caedf8ab5554.camel@redhat.com>
In-Reply-To: 613bb9f26a3056cc637319c444aea9e93b8002f0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6939

--===============8812227613072194460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:06 +0100, Davide Caratti wrote:
> On Wed, 2020-11-25 at 10:54 +0100, Paolo Abeni wrote:
> > Note: I think this later change is actually an independed bug fix, I
> > fear a peer sending an MP_JOIN with an invalid token will get back an
> > MPJ_SYNACK, while the subflow_req->msk will be cleared. Later
> > in subflow_syn_recv_sock(), we will probably get a NULL ptr dereference
> > in mptcp_can_accept_new_subflow().
> > =

> > @Davide: can we somehow easily check the above with a packet drill?
> > =

> > Thanks!
> =

> yes I can try that. I'm now looking once again at the MP_JOIN script
> (issue #94) and trying to fix this in a way or another (the problem is
> apparently bad values of [s,c]addr[0,1] in the environment. But at least
> generation of an inbound MP_JOIN SYN should be under control.=C2=A0

last famous words :) the parsing of "sender_hmac" definetly needs some
"love".

> I do a
> quicjk tyest and let you know, ok?

the test was not quick, *but* with a slightly modified packetdrill,
and the following script,

--tolerance_usecs=3D100000
`../common/defaults.sh`

+0    `../common/server.sh`

+0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
+0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+0.0  fcntl(3, F_GETFL) =3D 0x2 (flags O_RDWR)
+0.0  fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0

+0    bind(3, ..., ...) =3D 0
+0    listen(3, 1) =3D 0

+0.0 < addr[caddr0] > addr[saddr0] S 0:0(0) win 65535 <mss 1460,sackOK,TS v=
al 4074410674 ecr 0,nop,wscale 8,mpcapable v1 flags[flag_h] nokey>
+0.0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 4074410674 ecr 4074410674,no=
p,wscale 8,mpcapable v1 flags[flag_h] key[skey]>
+0.0 < . 1:1(0) ack 1 win 256 <nop,nop,TS val 4074410674 ecr 4074410674,mpc=
apable v1 flags[flag_h] key[ckey=3D2,skey]>
+0    accept(3, ..., ...) =3D 4

+1.0 < P. 1:3(2) ack 1 win 256 <nop,nop,TS val 4074418292 ecr 4074410674,mp=
capable v1 flags[flag_h] key[skey,ckey] mpcdatalen 2,nop,nop>
+0.0 > . 1:1(0) ack 3 <nop,nop,TS val 4074418293 ecr 4074418292,add_address=
 addr[saddr1] hmac=3Dauto,dss dack8=3D3 dll=3D0 nocs>

// I'm a bad mp_join syn!
+0.0 < addr[caddr1] > addr[saddr1] S 0:0(0) win 65535 <mss 1460,sackOK,TS v=
al 448955294 ecr 0,nop,wscale 8,mp_join_syn backup=3D1 address_id=3D2 token=
=3D666 rand=3D0>
+0.0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 448955294 ecr 448955294,nop,=
wscale 8,mp_join_syn_ack backup=3D1 address_id=3D0 sender_hmac=3D0>
+0.0 < . 1:1(0) ack 1 win 256 <nop,nop,TS val 448955294 ecr 448955294,mp_jo=
in_ack sender_hmac=3Dauto>


 I was able to reproduce the NULL dereference:

[16663.161104] general protection fault, probably for non-canonical address=
 0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
[16663.162606] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000=
000000017]
[16663.163562] CPU: 1 PID: 4857 Comm: packetdrill Not tainted 5.10.0-rc4+ #=
295
[16663.164425] Hardware name: Red Hat KVM, BIOS 1.11.1-4.module+el8.1.0+406=
6+0f1aadab 04/01/2014
[16663.165562] RIP: 0010:subflow_syn_recv_sock+0x716/0x14d0
[16663.166243] Code: 48 c1 ee 03 80 3c 16 00 0f 85 f0 09 00 00 4c 8b 83 88 =
01 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 78 12 48 89 fe 48 c1 ee 03 <0f=
> b6 14 16 48 89 fe 83 e6 07 40 38 f2 7f 32 84 d2 74 2e 48 89 44
[16663.168579] RSP: 0018:ffff888114426f58 EFLAGS: 00010212
[16663.169237] RAX: ffff888114426ff8 RBX: ffff88810e7f5c20 RCX: ffff88810e7=
f5da8
[16663.170133] RDX: dffffc0000000000 RSI: 0000000000000002 RDI: 00000000000=
00012
[16663.171041] RBP: ffff8881144271b8 R08: 0000000000000000 R09: ffffed10228=
84e09
[16663.171926] R10: 0000000000000001 R11: ffffed1022884e08 R12: ffff8881216=
96000
[16663.172796] R13: ffff888108413cc0 R14: ffff8881129cee00 R15: 1ffff110228=
84df3
[16663.173674] FS:  00007f396bbc2100(0000) GS:ffff888145200000(0000) knlGS:=
0000000000000000
[16663.174682] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16663.175412] CR2: 0000000001bf0000 CR3: 0000000113cb6000 CR4: 00000000003=
50ee0
[16663.176283] Call Trace:
[16663.176626]  ? __lock_acquire+0xceb/0x3970
[16663.177150]  ? subflow_drop_ctx+0x330/0x330
[16663.177698]  ? kvm_sched_clock_read+0x14/0x30
[16663.178259]  ? sched_clock+0x5/0x10
[16663.178711]  ? find_held_lock+0x3a/0x1c0
[16663.179208]  ? lock_downgrade+0x700/0x700
[16663.179745]  tcp_check_req+0x3e2/0x14e0
[16663.180232]  ? tcp_create_openreq_child+0x14e0/0x14e0
[16663.180870]  ? tcp_v4_inbound_md5_hash+0xdf/0x3a0
[16663.181475]  ? bpf_skb_set_tunnel_opt+0x2d0/0x2d0
[16663.182080]  ? memmove+0x38/0x60
[16663.182498]  tcp_v4_rcv+0x1f90/0x3870
[16663.182972]  ? tcp_v4_early_demux+0x7b0/0x7b0
[16663.183532]  ? rcu_read_lock_sched_held+0x90/0xd0
[16663.184124]  ? rcu_read_lock_sched_held+0xd0/0xd0
[16663.184722]  ? rcu_read_unlock+0x40/0x40
[16663.185225]  ip_protocol_deliver_rcu+0x76/0x6b0
[16663.185809]  ip_local_deliver_finish+0x207/0x300
[16663.186394]  ip_local_deliver+0x19e/0x3f0
[16663.186908]  ? ip_local_deliver_finish+0x300/0x300
[16663.187518]  ? rcu_read_lock_sched_held+0xd0/0xd0
[16663.188112]  ip_rcv+0xce/0x2f0
[16663.188508]  ? ip_local_deliver+0x3f0/0x3f0
[16663.189035]  ? rcu_read_lock_sched_held+0xa1/0xd0
[16663.189632]  ? ip_local_deliver+0x3f0/0x3f0
[16663.190177]  __netif_receive_skb_one_core+0x16a/0x1b0
[16663.190816]  ? __netif_receive_skb_core+0x3380/0x3380
[16663.191464]  ? rcu_read_unlock+0x40/0x40
[16663.191959]  ? lockdep_hardirqs_on_prepare+0x12c/0x3d0
[16663.192610]  ? kvm_clock_get_cycles+0x14/0x20
[16663.193179]  ? ktime_get_with_offset+0xfb/0x1e0
[16663.193750]  netif_receive_skb+0x15b/0x760
[16663.194274]  ? __netif_receive_skb+0x1a0/0x1a0
[16663.194832]  ? lockdep_hardirqs_on_prepare+0x3d0/0x3d0
[16663.195507]  tun_rx_batched.isra.54+0x46f/0x7e0 [tun]
[16663.196148]  ? lock_acquire+0x1c8/0x7f0
[16663.196633]  ? tun_set_ebpf+0xe0/0xe0 [tun]
[16663.197160]  ? lock_downgrade+0x700/0x700
[16663.197681]  ? rcu_read_unlock+0x40/0x40
[16663.198187]  ? lockdep_hardirqs_on_prepare+0x27c/0x3d0
[16663.198842]  ? __local_bh_enable_ip+0xa5/0xf0
[16663.199397]  tun_get_user+0x256a/0x38a0 [tun]
[16663.199943]  ? print_usage_bug+0x1a0/0x1a0
[16663.200469]  ? tun_build_skb.isra.57+0x11a0/0x11a0 [tun]
[16663.201141]  ? kvm_sched_clock_read+0x14/0x30
[16663.201693]  ? sched_clock+0x5/0x10
[16663.202134]  ? sched_clock_cpu+0x18/0x170
[16663.202649]  ? find_held_lock+0x3a/0x1c0
[16663.203149]  ? lock_downgrade+0x700/0x700
[16663.203664]  ? rcu_read_lock_sched_held+0xd0/0xd0
[16663.204254]  tun_chr_write_iter+0xb5/0x150 [tun]
[16663.204853]  do_iter_readv_writev+0x433/0x6d0
[16663.205411]  ? new_sync_write+0x620/0x620
[16663.205911]  do_iter_write+0x135/0x600
[16663.206415]  ? import_iovec+0x43/0x80
[16663.206878]  vfs_writev+0x150/0x4f0
[16663.207337]  ? vfs_iter_write+0xc0/0xc0
[16663.207838]  ? __fget_files+0x1ce/0x2e0
[16663.208330]  ? do_writev+0x100/0x280
[16663.208778]  do_writev+0x100/0x280
[16663.209208]  ? vfs_writev+0x4f0/0x4f0
[16663.209682]  do_syscall_64+0x33/0x40
[16663.210148]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[16663.210786] RIP: 0033:0x7f396ae9499f
[16663.211241] Code: 00 00 00 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec =
10 e8 33 6c 01 00 44 89 e2 48 89 ee 89 df 41 89 c0 b8 14 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 6c 6c 01 00 48
[16663.213561] RSP: 002b:00007ffc691459b0 EFLAGS: 00000293 ORIG_RAX: 000000=
0000000014
[16663.214480] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f396ae=
9499f
[16663.215378] RDX: 0000000000000002 RSI: 00007ffc691459f0 RDI: 00000000000=
00004
[16663.216268] RBP: 00007ffc691459f0 R08: 0000000000000000 R09: 00007f396bb=
c2100
[16663.217148] R10: 000000007fffffff R11: 0000000000000293 R12: 00000000000=
00002
[16663.218044] R13: 00007ffc69145f80 R14: 0000000000000000 R15: 00000000000=
00000
[16663.218937] Modules linked in: tun rfkill iTCO_wdt iTCO_vendor_support j=
oydev pcspkr virtio_balloon i2c_i801 i2c_smbus lpc_ich ip_tables xfs libcrc=
32c crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci lib=
ahci serio_raw libata virtio_blk virtio_net net_failover virtio_console fai=
lover sunrpc dm_mirror dm_region_hash dm_log dm_mod
[16663.222886] ---[ end trace 7ff0b93e894b1e70 ]---
[16663.223524] RIP: 0010:subflow_syn_recv_sock+0x716/0x14d0
[16663.224199] Code: 48 c1 ee 03 80 3c 16 00 0f 85 f0 09 00 00 4c 8b 83 88 =
01 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 78 12 48 89 fe 48 c1 ee 03 <0f=
> b6 14 16 48 89 fe 83 e6 07 40 38 f2 7f 32 84 d2 74 2e 48 89 44
[16663.226546] RSP: 0018:ffff888114426f58 EFLAGS: 00010212
[16663.227204] RAX: ffff888114426ff8 RBX: ffff88810e7f5c20 RCX: ffff88810e7=
f5da8
[16663.228109] RDX: dffffc0000000000 RSI: 0000000000000002 RDI: 00000000000=
00012
[16663.229022] RBP: ffff8881144271b8 R08: 0000000000000000 R09: ffffed10228=
84e09
[16663.229911] R10: 0000000000000001 R11: ffffed1022884e08 R12: ffff8881216=
96000
[16663.230832] R13: ffff888108413cc0 R14: ffff8881129cee00 R15: 1ffff110228=
84df3
[16663.231754] FS:  00007f396bbc2100(0000) GS:ffff888145200000(0000) knlGS:=
0000000000000000
[16663.232776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16663.233498] CR2: 0000000001bf0000 CR3: 0000000113cb6000 CR4: 00000000003=
50ee0
[16663.234385] Kernel panic - not syncing: Fatal exception in interrupt
[16663.238356] Kernel Offset: 0x3a00000 from 0xffffffff81000000 (relocation=
 range: 0xffffffff80000000-0xffffffffbfffffff)
[16663.239699] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---


@Paolo, your analysis is correct: the server responds to the (d)evil
inbound "MP_JOIN syn" with a MP_JOIN synack having sender HMAC equal to
0; the 3rd packet triggers the NULL dereference.

$ ./scripts/faddr2line  vmlinux subflow_syn_recv_sock+0x716
subflow_syn_recv_sock+0x716/0x14d0:
inet_sk_state_load at include/net/inet_sock.h:312 (discriminator 1)
(inlined by) mptcp_is_fully_established at net/mptcp/protocol.h:495 (discri=
minator 1)
(inlined by) mptcp_can_accept_new_subflow at net/mptcp/subflow.c:59 (discri=
minator 1)
(inlined by) subflow_syn_recv_sock at net/mptcp/subflow.c:547 (discriminato=
r 1)

-- =

davide


--===============8812227613072194460==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="splat.txt"

W0FbMTY2NjMuMTYxMTA0XSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBu
b24tY2Fub25pY2FsIGFkZHJlc3MgMHhkZmZmZmMwMDAwMDAwMDAyOiAwMDAwIFsjMV0gU01QIEtB
U0FOIE5PUFRJClsxNjY2My4xNjI2MDZdIEtBU0FOOiBudWxsLXB0ci1kZXJlZiBpbiByYW5nZSBb
MHgwMDAwMDAwMDAwMDAwMDEwLTB4MDAwMDAwMDAwMDAwMDAxN10KWzE2NjYzLjE2MzU2Ml0gQ1BV
OiAxIFBJRDogNDg1NyBDb21tOiBwYWNrZXRkcmlsbCBOb3QgdGFpbnRlZCA1LjEwLjAtcmM0KyAj
Mjk1ClsxNjY2My4xNjQ0MjVdIEhhcmR3YXJlIG5hbWU6IFJlZCBIYXQgS1ZNLCBCSU9TIDEuMTEu
MS00Lm1vZHVsZStlbDguMS4wKzQwNjYrMGYxYWFkYWIgMDQvMDEvMjAxNApbMTY2NjMuMTY1NTYy
XSBSSVA6IDAwMTA6c3ViZmxvd19zeW5fcmVjdl9zb2NrKzB4NzE2LzB4MTRkMApbMTY2NjMuMTY2
MjQzXSBDb2RlOiA0OCBjMSBlZSAwMyA4MCAzYyAxNiAwMCAwZiA4NSBmMCAwOSAwMCAwMCA0YyA4
YiA4MyA4OCAwMSAwMCAwMCA0OCBiYSAwMCAwMCAwMCAwMCAwMCBmYyBmZiBkZiA0OSA4ZCA3OCAx
MiA0OCA4OSBmZSA0OCBjMSBlZSAwMyA8MGY+IGI2IDE0IDE2IDQ4IDg5IGZlIDgzIGU2IDA3IDQw
IDM4IGYyIDdmIDMyIDg0IGQyIDc0IDJlIDQ4IDg5IDQ0ClsxNjY2My4xNjg1NzldIFJTUDogMDAx
ODpmZmZmODg4MTE0NDI2ZjU4IEVGTEFHUzogMDAwMTAyMTIKWzE2NjYzLjE2OTIzN10gUkFYOiBm
ZmZmODg4MTE0NDI2ZmY4IFJCWDogZmZmZjg4ODEwZTdmNWMyMCBSQ1g6IGZmZmY4ODgxMGU3ZjVk
YTgKWzE2NjYzLjE3MDEzM10gUkRYOiBkZmZmZmMwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAw
MDAwMiBSREk6IDAwMDAwMDAwMDAwMDAwMTIKWzE2NjYzLjE3MTA0MV0gUkJQOiBmZmZmODg4MTE0
NDI3MWI4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmZmZlZDEwMjI4ODRlMDkKWzE2NjYz
LjE3MTkyNl0gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogZmZmZmVkMTAyMjg4NGUwOCBSMTI6
IGZmZmY4ODgxMjE2OTYwMDAKWzE2NjYzLjE3Mjc5Nl0gUjEzOiBmZmZmODg4MTA4NDEzY2MwIFIx
NDogZmZmZjg4ODExMjljZWUwMCBSMTU6IDFmZmZmMTEwMjI4ODRkZjMKWzE2NjYzLjE3MzY3NF0g
RlM6ICAwMDAwN2YzOTZiYmMyMTAwKDAwMDApIEdTOmZmZmY4ODgxNDUyMDAwMDAoMDAwMCkga25s
R1M6MDAwMDAwMDAwMDAwMDAwMApbMTY2NjMuMTc0NjgyXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsxNjY2My4xNzU0MTJdIENSMjogMDAwMDAwMDAw
MWJmMDAwMCBDUjM6IDAwMDAwMDAxMTNjYjYwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWUwClsxNjY2
My4xNzYyODNdIENhbGwgVHJhY2U6ClsxNjY2My4xNzY2MjZdICA/IF9fbG9ja19hY3F1aXJlKzB4
Y2ViLzB4Mzk3MApbMTY2NjMuMTc3MTUwXSAgPyBzdWJmbG93X2Ryb3BfY3R4KzB4MzMwLzB4MzMw
ClsxNjY2My4xNzc2OThdICA/IGt2bV9zY2hlZF9jbG9ja19yZWFkKzB4MTQvMHgzMApbMTY2NjMu
MTc4MjU5XSAgPyBzY2hlZF9jbG9jaysweDUvMHgxMApbMTY2NjMuMTc4NzExXSAgPyBmaW5kX2hl
bGRfbG9jaysweDNhLzB4MWMwClsxNjY2My4xNzkyMDhdICA/IGxvY2tfZG93bmdyYWRlKzB4NzAw
LzB4NzAwClsxNjY2My4xNzk3NDVdICB0Y3BfY2hlY2tfcmVxKzB4M2UyLzB4MTRlMApbMTY2NjMu
MTgwMjMyXSAgPyB0Y3BfY3JlYXRlX29wZW5yZXFfY2hpbGQrMHgxNGUwLzB4MTRlMApbMTY2NjMu
MTgwODcwXSAgPyB0Y3BfdjRfaW5ib3VuZF9tZDVfaGFzaCsweGRmLzB4M2EwClsxNjY2My4xODE0
NzVdICA/IGJwZl9za2Jfc2V0X3R1bm5lbF9vcHQrMHgyZDAvMHgyZDAKWzE2NjYzLjE4MjA4MF0g
ID8gbWVtbW92ZSsweDM4LzB4NjAKWzE2NjYzLjE4MjQ5OF0gIHRjcF92NF9yY3YrMHgxZjkwLzB4
Mzg3MApbMTY2NjMuMTgyOTcyXSAgPyB0Y3BfdjRfZWFybHlfZGVtdXgrMHg3YjAvMHg3YjAKWzE2
NjYzLjE4MzUzMl0gID8gcmN1X3JlYWRfbG9ja19zY2hlZF9oZWxkKzB4OTAvMHhkMApbMTY2NjMu
MTg0MTI0XSAgPyByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHhkMC8weGQwClsxNjY2My4xODQ3
MjJdICA/IHJjdV9yZWFkX3VubG9jaysweDQwLzB4NDAKWzE2NjYzLjE4NTIyNV0gIGlwX3Byb3Rv
Y29sX2RlbGl2ZXJfcmN1KzB4NzYvMHg2YjAKWzE2NjYzLjE4NTgwOV0gIGlwX2xvY2FsX2RlbGl2
ZXJfZmluaXNoKzB4MjA3LzB4MzAwClsxNjY2My4xODYzOTRdICBpcF9sb2NhbF9kZWxpdmVyKzB4
MTllLzB4M2YwClsxNjY2My4xODY5MDhdICA/IGlwX2xvY2FsX2RlbGl2ZXJfZmluaXNoKzB4MzAw
LzB4MzAwClsxNjY2My4xODc1MThdICA/IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweGQwLzB4
ZDAKWzE2NjYzLjE4ODExMl0gIGlwX3JjdisweGNlLzB4MmYwClsxNjY2My4xODg1MDhdICA/IGlw
X2xvY2FsX2RlbGl2ZXIrMHgzZjAvMHgzZjAKWzE2NjYzLjE4OTAzNV0gID8gcmN1X3JlYWRfbG9j
a19zY2hlZF9oZWxkKzB4YTEvMHhkMApbMTY2NjMuMTg5NjMyXSAgPyBpcF9sb2NhbF9kZWxpdmVy
KzB4M2YwLzB4M2YwClsxNjY2My4xOTAxNzddICBfX25ldGlmX3JlY2VpdmVfc2tiX29uZV9jb3Jl
KzB4MTZhLzB4MWIwClsxNjY2My4xOTA4MTZdICA/IF9fbmV0aWZfcmVjZWl2ZV9za2JfY29yZSsw
eDMzODAvMHgzMzgwClsxNjY2My4xOTE0NjRdICA/IHJjdV9yZWFkX3VubG9jaysweDQwLzB4NDAK
WzE2NjYzLjE5MTk1OV0gID8gbG9ja2RlcF9oYXJkaXJxc19vbl9wcmVwYXJlKzB4MTJjLzB4M2Qw
ClsxNjY2My4xOTI2MTBdICA/IGt2bV9jbG9ja19nZXRfY3ljbGVzKzB4MTQvMHgyMApbMTY2NjMu
MTkzMTc5XSAgPyBrdGltZV9nZXRfd2l0aF9vZmZzZXQrMHhmYi8weDFlMApbMTY2NjMuMTkzNzUw
XSAgbmV0aWZfcmVjZWl2ZV9za2IrMHgxNWIvMHg3NjAKWzE2NjYzLjE5NDI3NF0gID8gX19uZXRp
Zl9yZWNlaXZlX3NrYisweDFhMC8weDFhMApbMTY2NjMuMTk0ODMyXSAgPyBsb2NrZGVwX2hhcmRp
cnFzX29uX3ByZXBhcmUrMHgzZDAvMHgzZDAKWzE2NjYzLjE5NTUwN10gIHR1bl9yeF9iYXRjaGVk
LmlzcmEuNTQrMHg0NmYvMHg3ZTAgW3R1bl0KWzE2NjYzLjE5NjE0OF0gID8gbG9ja19hY3F1aXJl
KzB4MWM4LzB4N2YwClsxNjY2My4xOTY2MzNdICA/IHR1bl9zZXRfZWJwZisweGUwLzB4ZTAgW3R1
bl0KWzE2NjYzLjE5NzE2MF0gID8gbG9ja19kb3duZ3JhZGUrMHg3MDAvMHg3MDAKWzE2NjYzLjE5
NzY4MV0gID8gcmN1X3JlYWRfdW5sb2NrKzB4NDAvMHg0MApbMTY2NjMuMTk4MTg3XSAgPyBsb2Nr
ZGVwX2hhcmRpcnFzX29uX3ByZXBhcmUrMHgyN2MvMHgzZDAKWzE2NjYzLjE5ODg0Ml0gID8gX19s
b2NhbF9iaF9lbmFibGVfaXArMHhhNS8weGYwClsxNjY2My4xOTkzOTddICB0dW5fZ2V0X3VzZXIr
MHgyNTZhLzB4MzhhMCBbdHVuXQpbMTY2NjMuMTk5OTQzXSAgPyBwcmludF91c2FnZV9idWcrMHgx
YTAvMHgxYTAKWzE2NjYzLjIwMDQ2OV0gID8gdHVuX2J1aWxkX3NrYi5pc3JhLjU3KzB4MTFhMC8w
eDExYTAgW3R1bl0KWzE2NjYzLjIwMTE0MV0gID8ga3ZtX3NjaGVkX2Nsb2NrX3JlYWQrMHgxNC8w
eDMwClsxNjY2My4yMDE2OTNdICA/IHNjaGVkX2Nsb2NrKzB4NS8weDEwClsxNjY2My4yMDIxMzRd
ICA/IHNjaGVkX2Nsb2NrX2NwdSsweDE4LzB4MTcwClsxNjY2My4yMDI2NDldICA/IGZpbmRfaGVs
ZF9sb2NrKzB4M2EvMHgxYzAKWzE2NjYzLjIwMzE0OV0gID8gbG9ja19kb3duZ3JhZGUrMHg3MDAv
MHg3MDAKWzE2NjYzLjIwMzY2NF0gID8gcmN1X3JlYWRfbG9ja19zY2hlZF9oZWxkKzB4ZDAvMHhk
MApbMTY2NjMuMjA0MjU0XSAgdHVuX2Nocl93cml0ZV9pdGVyKzB4YjUvMHgxNTAgW3R1bl0KWzE2
NjYzLjIwNDg1M10gIGRvX2l0ZXJfcmVhZHZfd3JpdGV2KzB4NDMzLzB4NmQwClsxNjY2My4yMDU0
MTFdICA/IG5ld19zeW5jX3dyaXRlKzB4NjIwLzB4NjIwClsxNjY2My4yMDU5MTFdICBkb19pdGVy
X3dyaXRlKzB4MTM1LzB4NjAwClsxNjY2My4yMDY0MTVdICA/IGltcG9ydF9pb3ZlYysweDQzLzB4
ODAKWzE2NjYzLjIwNjg3OF0gIHZmc193cml0ZXYrMHgxNTAvMHg0ZjAKWzE2NjYzLjIwNzMzN10g
ID8gdmZzX2l0ZXJfd3JpdGUrMHhjMC8weGMwClsxNjY2My4yMDc4MzhdICA/IF9fZmdldF9maWxl
cysweDFjZS8weDJlMApbMTY2NjMuMjA4MzMwXSAgPyBkb193cml0ZXYrMHgxMDAvMHgyODAKWzE2
NjYzLjIwODc3OF0gIGRvX3dyaXRldisweDEwMC8weDI4MApbMTY2NjMuMjA5MjA4XSAgPyB2ZnNf
d3JpdGV2KzB4NGYwLzB4NGYwClsxNjY2My4yMDk2ODJdICBkb19zeXNjYWxsXzY0KzB4MzMvMHg0
MApbMTY2NjMuMjEwMTQ4XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhh
OQpbMTY2NjMuMjEwNzg2XSBSSVA6IDAwMzM6MHg3ZjM5NmFlOTQ5OWYKWzE2NjYzLjIxMTI0MV0g
Q29kZTogMDAgMDAgMDAgNDEgNTQgNDEgODkgZDQgNTUgNDggODkgZjUgNTMgODkgZmIgNDggODMg
ZWMgMTAgZTggMzMgNmMgMDEgMDAgNDQgODkgZTIgNDggODkgZWUgODkgZGYgNDEgODkgYzAgYjgg
MTQgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMCBmMCBmZiBmZiA3NyAzNSA0NCA4OSBjNyA0OCA4
OSA0NCAyNCAwOCBlOCA2YyA2YyAwMSAwMCA0OApbMTY2NjMuMjEzNTYxXSBSU1A6IDAwMmI6MDAw
MDdmZmM2OTE0NTliMCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDE0
ClsxNjY2My4yMTQ0ODBdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAw
MDQgUkNYOiAwMDAwN2YzOTZhZTk0OTlmClsxNjY2My4yMTUzNzhdIFJEWDogMDAwMDAwMDAwMDAw
MDAwMiBSU0k6IDAwMDA3ZmZjNjkxNDU5ZjAgUkRJOiAwMDAwMDAwMDAwMDAwMDA0ClsxNjY2My4y
MTYyNjhdIFJCUDogMDAwMDdmZmM2OTE0NTlmMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAw
MDAwN2YzOTZiYmMyMTAwClsxNjY2My4yMTcxNDhdIFIxMDogMDAwMDAwMDA3ZmZmZmZmZiBSMTE6
IDAwMDAwMDAwMDAwMDAyOTMgUjEyOiAwMDAwMDAwMDAwMDAwMDAyClsxNjY2My4yMTgwNDRdIFIx
MzogMDAwMDdmZmM2OTE0NWY4MCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAw
MDAwMDAwClsxNjY2My4yMTg5MzddIE1vZHVsZXMgbGlua2VkIGluOiB0dW4gcmZraWxsIGlUQ09f
d2R0IGlUQ09fdmVuZG9yX3N1cHBvcnQgam95ZGV2IHBjc3BrciB2aXJ0aW9fYmFsbG9vbiBpMmNf
aTgwMSBpMmNfc21idXMgbHBjX2ljaCBpcF90YWJsZXMgeGZzIGxpYmNyYzMyYyBjcmN0MTBkaWZf
cGNsbXVsIGNyYzMyX3BjbG11bCBjcmMzMmNfaW50ZWwgZ2hhc2hfY2xtdWxuaV9pbnRlbCBhaGNp
IGxpYmFoY2kgc2VyaW9fcmF3IGxpYmF0YSB2aXJ0aW9fYmxrIHZpcnRpb19uZXQgbmV0X2ZhaWxv
dmVyIHZpcnRpb19jb25zb2xlIGZhaWxvdmVyIHN1bnJwYyBkbV9taXJyb3IgZG1fcmVnaW9uX2hh
c2ggZG1fbG9nIGRtX21vZApbMTY2NjMuMjIyODg2XSAtLS1bIGVuZCB0cmFjZSA3ZmYwYjkzZTg5
NGIxZTcwIF0tLS0KWzE2NjYzLjIyMzUyNF0gUklQOiAwMDEwOnN1YmZsb3dfc3luX3JlY3Zfc29j
aysweDcxNi8weDE0ZDAKWzE2NjYzLjIyNDE5OV0gQ29kZTogNDggYzEgZWUgMDMgODAgM2MgMTYg
MDAgMGYgODUgZjAgMDkgMDAgMDAgNGMgOGIgODMgODggMDEgMDAgMDAgNDggYmEgMDAgMDAgMDAg
MDAgMDAgZmMgZmYgZGYgNDkgOGQgNzggMTIgNDggODkgZmUgNDggYzEgZWUgMDMgPDBmPiBiNiAx
NCAxNiA0OCA4OSBmZSA4MyBlNiAwNyA0MCAzOCBmMiA3ZiAzMiA4NCBkMiA3NCAyZSA0OCA4OSA0
NApbMTY2NjMuMjI2NTQ2XSBSU1A6IDAwMTg6ZmZmZjg4ODExNDQyNmY1OCBFRkxBR1M6IDAwMDEw
MjEyClsxNjY2My4yMjcyMDRdIFJBWDogZmZmZjg4ODExNDQyNmZmOCBSQlg6IGZmZmY4ODgxMGU3
ZjVjMjAgUkNYOiBmZmZmODg4MTBlN2Y1ZGE4ClsxNjY2My4yMjgxMDldIFJEWDogZGZmZmZjMDAw
MDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDIgUkRJOiAwMDAwMDAwMDAwMDAwMDEyClsxNjY2
My4yMjkwMjJdIFJCUDogZmZmZjg4ODExNDQyNzFiOCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5
OiBmZmZmZWQxMDIyODg0ZTA5ClsxNjY2My4yMjk5MTFdIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBS
MTE6IGZmZmZlZDEwMjI4ODRlMDggUjEyOiBmZmZmODg4MTIxNjk2MDAwClsxNjY2My4yMzA4MzJd
IFIxMzogZmZmZjg4ODEwODQxM2NjMCBSMTQ6IGZmZmY4ODgxMTI5Y2VlMDAgUjE1OiAxZmZmZjEx
MDIyODg0ZGYzClsxNjY2My4yMzE3NTRdIEZTOiAgMDAwMDdmMzk2YmJjMjEwMCgwMDAwKSBHUzpm
ZmZmODg4MTQ1MjAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWzE2NjYzLjIzMjc3
Nl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbMTY2
NjMuMjMzNDk4XSBDUjI6IDAwMDAwMDAwMDFiZjAwMDAgQ1IzOiAwMDAwMDAwMTEzY2I2MDAwIENS
NDogMDAwMDAwMDAwMDM1MGVlMApbMTY2NjMuMjM0Mzg1XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3lu
Y2luZzogRmF0YWwgZXhjZXB0aW9uIGluIGludGVycnVwdApbMTY2NjMuMjM4MzU2XSBLZXJuZWwg
T2Zmc2V0OiAweDNhMDAwMDAgZnJvbSAweGZmZmZmZmZmODEwMDAwMDAgKHJlbG9jYXRpb24gcmFu
Z2U6IDB4ZmZmZmZmZmY4MDAwMDAwMC0weGZmZmZmZmZmYmZmZmZmZmYpClsxNjY2My4yMzk2OTld
IC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4g
aW50ZXJydXB0IF0tLS0K

--===============8812227613072194460==--
