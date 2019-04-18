Content-Type: multipart/mixed; boundary="===============3780518137802174837=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix oops on accept
Date: Thu, 18 Apr 2019 15:25:19 +0200
Message-ID: <b1afba00fa51ded07cdfabed76b28bd2ccb7cc8c.1555593820.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1076

--===============3780518137802174837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

while running the self-test on a multi core VM, with a standard (non
debug) kernel config, I hit the following oops:

[  234.587877] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000020
[  234.591567] #PF error: [normal kernel read fault]
[  234.593862] PGD 800000013a8ec067 P4D 800000013a8ec067 PUD 13a2ad067 PMD 0
[  234.596616] Oops: 0000 [#1] SMP PTI
[  234.597173] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.1.0-rc4.mptcp_xm=
it_07723d4+ #2139
[  234.598363] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[  234.599847] RIP: 0010:mptcp_finish_connect+0x2a/0x160
[  234.600464] Code: 0f 1f 44 00 00 41 54 41 89 f4 55 53 48 89 fb 48 83 ec =
10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8b 87 80 05 00 00 <48=
> 8b 40 20 48 8b a8 88 04 00 00 0f 1f 44 00 00 45 85 e4 0f 84 ad
[  234.602646] RSP: 0018:ffffa014fbb03c78 EFLAGS: 00010246
[  234.603307] RAX: 0000000000000000 RBX: ffffa014fac92280 RCX: 00000000000=
00001
[  234.604158] RDX: ffffa014fa00c480 RSI: 0000000000000001 RDI: ffffa014fac=
92280
[  234.605010] RBP: ffffa014f9a48000 R08: ffffa014fa00c4c0 R09: 00000000000=
00000
[  234.605861] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00001
[  234.606701] R13: ffffa014f6c99424 R14: 0000000000000014 R15: ffffa014f6c=
99410
[  234.607555] FS:  0000000000000000(0000) GS:ffffa014fbb00000(0000) knlGS:=
0000000000000000
[  234.608498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  234.609110] CR2: 0000000000000020 CR3: 0000000137e22004 CR4: 00000000001=
606e0
[  234.609863] Call Trace:
[  234.610152]  <IRQ>
[  234.610407]  subflow_finish_connect+0x3d/0xc0
[  234.610883]  tcp_rcv_established+0x641/0x660
[  234.611353]  ? tcp_v4_inbound_md5_hash+0x64/0x1d0
[  234.611862]  tcp_v4_do_rcv+0xf4/0x1e0
[  234.612269]  tcp_v4_rcv+0x99c/0xaa0
[  234.612665]  ip_protocol_deliver_rcu+0x4b/0x180
[  234.613159]  ip_local_deliver_finish+0x40/0x50
[  234.613647]  ip_local_deliver+0x6b/0xe0
[  234.614071]  ? ip_rcv_finish+0x62/0xa0
[  234.614495]  ip_rcv+0x52/0xd0
[  234.614841]  __netif_receive_skb_one_core+0x52/0x70
[  234.615403]  process_backlog+0x97/0x130
[  234.615897]  net_rx_action+0x299/0x3d0
[  234.616319]  __do_softirq+0xd8/0x2b7
[  234.616730]  irq_exit+0xd5/0xe0
[  234.617089]  smp_apic_timer_interrupt+0x74/0x140
[  234.617933]  apic_timer_interrupt+0xf/0x20
[  234.618623]  </IRQ>
[  234.619003] RIP: 0010:default_idle+0x17/0x140
[  234.619635] Code: ff 4c 89 e7 e8 7a ca c9 ff fb eb 98 90 90 90 90 90 90 =
90 0f 1f 44 00 00 41 54 55 53 65 8b 2d 00 95 f6 56 0f 1f 44 00 00 fb f4 <65=
> 8b 2d f2 94 f6 56 0f 1f 44 00 00 5b 5d 41 5c c3 65 8b 05 e1 94

The problem is in mptcp_accept(): the newly created subflow is
already added to the mptcp subflow list, but conn_finished is not set.

On next rx dst cache update we enter subflow_finish_connect()/mptcp_finish_=
connect()
and hit the crash due to NULL msk->subflow de-referncing.

Fix the above properly initializing the subflow at accept() time.

Fixes: a36080381c36 ("mptcp: Create SUBFLOW socket for incoming connections=
")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

---
Note: I'm ok with swashing this change in the commit referenced by the
'fixes' tag.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55a39ec748b5..fcfb74818c30 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -639,6 +639,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
 		subflow->conn =3D new_mptcp_sock->sk;
+		subflow->conn_finished =3D 1;
 	} else {
 		msk->subflow =3D new_sock;
 	}
-- =

2.20.1


--===============3780518137802174837==--
