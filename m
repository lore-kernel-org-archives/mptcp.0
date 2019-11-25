Content-Type: multipart/mixed; boundary="===============0140311128522860784=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/7] subflow: fix join error handling
Date: Mon, 25 Nov 2019 03:15:02 +0100
Message-ID: <20191125021508.29153-2-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2673

--===============0140311128522860784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add key generation and token tree

Invalid join token gives this splat:

WARNING: CPU: 3 PID: 0 at net/ipv4/inet_connection_sock.c:833 inet_csk_dest=
roy_sock+0x367/0x460
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.4.0-rc7+ #1
RIP: 0010:inet_csk_destroy_sock+0x367/0x460
Code: 20 02 00 00 00 00 00 00 e9 dc fe ff ff e8 41 21 e7 fe 0f 0b e9 06 fd =
ff ff e8 35 21 e7 fe 0f 0b e9 45 fd ff ff e8 29 21 e7 fe <0f> 0b e9 6a fd f=
f ff e8 1d 21 e7 fe be 03 00 00 00 4c 89 f7 e8 f0
RSP: 0018:ffff88811b5893a0 EFLAGS: 00010206
RAX: ffff88811abddd40 RBX: 0000000000000001 RCX: ffffffff8250ca2f
RDX: 0000000000000100 RSI: ffffffff8250ccf7 RDI: ffff88810c2ccd30
RBP: ffff88811b5893c8 R08: ffff88811abddd40 R09: ffffed10218599a5
R10: ffffed10218599a4 R11: ffff88810c2ccd27 R12: ffff88810c2cccc0
R13: ffff88810c2ccd20 R14: ffff888114bf6840 R15: ffffffff8328f4a0
FS:  0000000000000000(0000) GS:ffff88811b580000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000731e24 CR3: 000000010aa04003 CR4: 0000000000160ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 subflow_syn_recv_sock+0x593/0x6c0
 tcp_check_req+0x6ae/0x19e0

The warn is caused by:
        /* It cannot be in hash table! */
        WARN_ON(!sk_unhashed(sk));

so handle this via tcp_done instead, it will call ->sk_unhash() before
calling inet_csk_destroy_sock() internally.

While at it, try to notify the peer immediately via reset.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 191d7bb0f0a9..ffbe0a4a04be 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -361,9 +361,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 =

 close_child:
 	pr_debug("closing child socket");
-	inet_sk_set_state(child, TCP_CLOSE);
-	sock_set_flag(child, SOCK_DEAD);
-	inet_csk_destroy_sock(child);
+	tcp_send_active_reset(child, GFP_ATOMIC);
+	inet_csk_prepare_forced_close(child);
+	tcp_done(child);
 	return NULL;
 }
 =

-- =

2.23.0

--===============0140311128522860784==--
