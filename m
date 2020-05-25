Content-Type: multipart/mixed; boundary="===============8199494577281323257=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: attempt skb coalescing when moving skbs to
 mptcp rx queue
Date: Mon, 25 May 2020 18:02:55 +0200
Message-ID: <20200525160255.20560-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4488

--===============8199494577281323257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can try to coalesce the skbs we take from the subflows rx queue
with the tail of the mptcp rx queue.

If successful, the skb head can be discarded early.

We can also free the skb extensions, we do not access them after
this so no need to hold on to them.

Only caveat: do not built too fat skbs. They are only free'd once
userspace has read all data.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d868b3d921fd..ab4a712b2529 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -144,12 +144,34 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, =
struct sock *ssk,
 			     unsigned int offset, size_t copy_len)
 {
 	struct sock *sk =3D (struct sock *)msk;
+	struct sk_buff *tail;
 =

 	__skb_unlink(skb, &ssk->sk_receive_queue);
-	skb_set_owner_r(skb, sk);
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
 =

+	skb_ext_reset(skb);
+	skb_orphan(skb);
 	msk->ack_seq +=3D copy_len;
+
+	tail =3D skb_peek_tail(&sk->sk_receive_queue);
+	if (offset =3D=3D 0 && tail) {
+		bool fragstolen;
+		int delta;
+
+		/* don't coalesce when tail is already fat.
+		 * skbs are only free'd once all of the data was
+		 * copied to userspace.
+		 */
+		if (tail->len < GSO_MAX_SIZE &&
+		    skb_try_coalesce(tail, skb, &fragstolen, &delta)) {
+			kfree_skb_partial(skb, fragstolen);
+			atomic_add(delta, &sk->sk_rmem_alloc);
+			sk_mem_charge(sk, delta);
+			return;
+		}
+	}
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	MPTCP_SKB_CB(skb)->offset =3D offset;
 }
 =

-- =

2.26.2

--===============8199494577281323257==--
