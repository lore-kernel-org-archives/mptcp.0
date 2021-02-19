Content-Type: multipart/mixed; boundary="===============5175691498024662741=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: fix memory accounting on allocation
 error
Date: Fri, 19 Feb 2021 19:42:06 +0100
Message-ID: <f3643a261e8467e56de23145f48b28fb641f5686.1613760037.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7867

--===============5175691498024662741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of memory pressure the MPTCP xmit path keeps
at most a single skb in the tx cache, eventually freeing
additional ones.

The associated counter for forward memory is not update
accordingly, and that causes the following splat:

WARNING: CPU: 0 PID: 12 at net/core/stream.c:208 sk_stream_kill_queues+0x3c=
a/0x530 net/core/stream.c:208
Modules linked in:
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.11.0-rc2 #59
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf=
21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:sk_stream_kill_queues+0x3ca/0x530 net/core/stream.c:208
Code: 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 63 01 00 00 8b ab 00 01 00 00 =
e9 60 ff ff ff e8 2f 24 d3 fe 0f 0b eb 97 e8 26 24 d3 fe <0f> 0b eb a0 e8 1=
d 24 d3 fe 0f 0b e9 a5 fe ff ff 4c 89 e7 e8 0e d0
RSP: 0018:ffffc900000c7bc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810030ac40 RSI: ffffffff8262ca4a RDI: 0000000000000003
RBP: 0000000000000d00 R08: 0000000000000000 R09: ffffffff85095aa7
R10: ffffffff8262c9ea R11: 0000000000000001 R12: ffff888108908100
R13: ffffffff85095aa0 R14: ffffc900000c7c48 R15: 1ffff92000018f85
FS:  0000000000000000(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7444baef8 CR3: 0000000035ee9005 CR4: 0000000000170ef0
Call Trace:
 __mptcp_destroy_sock+0x4a7/0x6c0 net/mptcp/protocol.c:2547
 mptcp_worker+0x7dd/0x1610 net/mptcp/protocol.c:2272
 process_one_work+0x896/0x1170 kernel/workqueue.c:2275
 worker_thread+0x605/0x1350 kernel/workqueue.c:2421
 kthread+0x344/0x410 kernel/kthread.c:292
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296

At close time, as reported by syzkaller/Christoph.

This change address the issue properly updating the fwd
allocated memory counter in the error path.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/136
Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
@Christoph: could you please give this one a spin in your
testbed vs the repro?
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3eacd22665bcc..615fd81faa9a3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1189,6 +1189,7 @@ static bool mptcp_tx_cache_refill(struct sock *sk, in=
t size,
 			 */
 			while (skbs->qlen > 1) {
 				skb =3D __skb_dequeue_tail(skbs);
+				*total_ts -=3D skb->truesize;
 				__kfree_skb(skb);
 			}
 			return skbs->qlen > 0;
-- =

2.26.2

--===============5175691498024662741==--
