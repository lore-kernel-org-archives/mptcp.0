Content-Type: multipart/mixed; boundary="===============5596920352696213765=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] squashto: mptcp: protect the rx path with the
 msk socket spinlock
Date: Fri, 20 Nov 2020 00:47:14 +0100
Message-ID: <20201119234714.8519-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6853

--===============5596920352696213765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Looks like the arguments are inverted.  Intention seems to move
the msk rx queue to the sk one so it can be purged from the destroy
function.

This avoids:
unreferenced object 0xffff888105cd3800 (size 512):
  comm "packetdrill", pid 1648, jiffies 4294677515 (age 433.463s)
  hex dump (first 32 bytes):
    3c 33 30 3e 4e 6f 76 20 32 30 20 30 30 3a 32 33  <30>Nov 20 00:23
    3a 34 38 20 73 79 73 74 65 6d 64 5b 31 5d 3a 20  :48 systemd[1]:
  backtrace:
    [<00000000b794d231>] __kmalloc_reserve.isra.0+0x2d/0x90
    [<000000000421e158>] __alloc_skb+0x90/0x260
    [<00000000d46c1201>] alloc_skb_with_frags+0x5e/0x250
    [<00000000357464a5>] sock_alloc_send_pskb+0x265/0x2a0
    [<00000000a73deb72>] tun_get_user+0x4dc/0x1840
    [<00000000ba538b49>] tun_chr_write_iter+0x51/0x80
    [<000000004f72fd7e>] do_iter_readv_writev+0x1c6/0x2b0
    [<00000000c606f908>] do_iter_write+0xb1/0x230
    [<0000000088092c0e>] vfs_writev+0xcb/0x130
    [<00000000f9881e25>] do_writev+0x8c/0x150
    [<00000000dc31e12e>] do_syscall_64+0x2d/0x40
    [<0000000019b09572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

plus WARN()s from nonzero sk_forward_alloc.
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 92236a2ccbea..e62d34034d9e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2707,7 +2707,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 =

 	__mptcp_clear_xmit(sk);
 =

-	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
+	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
+	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
+
 	skb_rbtree_purge(&msk->out_of_order_queue);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-- =

2.26.2

--===============5596920352696213765==--
