Content-Type: multipart/mixed; boundary="===============0292366866024333921=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 05/13] mptcp: introduce and use
 mptcp_try_coalesce()
Date: Fri, 11 Sep 2020 15:52:00 +0200
Message-ID: <24130f7d45c2a2e595b45b3d27b0290e9c0a1318.1599832097.git.pabeni@redhat.com>
In-Reply-To: cover.1599832097.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5811

--===============0292366866024333921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor-out existing code, will be re-used by the
next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f12a8ce0ddd..5a2ff333e426 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -110,6 +110,22 @@ static int __mptcp_socket_create(struct mptcp_sock *ms=
k)
 	return 0;
 }
 =

+static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+			       struct sk_buff *from)
+{
+	bool fragstolen;
+	int delta;
+
+	if (MPTCP_SKB_CB(from)->offset ||
+	    !skb_try_coalesce(to, from, &fragstolen, &delta))
+		return false;
+
+	kfree_skb_partial(from, fragstolen);
+	atomic_add(delta, &sk->sk_rmem_alloc);
+	sk_mem_charge(sk, delta);
+	return true;
+}
+
 static void __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 			     struct sk_buff *skb,
 			     unsigned int offset, size_t copy_len)
@@ -121,24 +137,15 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, =
struct sock *ssk,
 =

 	skb_ext_reset(skb);
 	skb_orphan(skb);
+	MPTCP_SKB_CB(skb)->offset =3D offset;
 	msk->ack_seq +=3D copy_len;
 =

 	tail =3D skb_peek_tail(&sk->sk_receive_queue);
-	if (offset =3D=3D 0 && tail) {
-		bool fragstolen;
-		int delta;
-
-		if (skb_try_coalesce(tail, skb, &fragstolen, &delta)) {
-			kfree_skb_partial(skb, fragstolen);
-			atomic_add(delta, &sk->sk_rmem_alloc);
-			sk_mem_charge(sk, delta);
-			return;
-		}
-	}
+	if (tail && mptcp_try_coalesce(sk, tail, skb))
+		return;
 =

 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	MPTCP_SKB_CB(skb)->offset =3D offset;
 }
 =

 static void mptcp_stop_timer(struct sock *sk)
-- =

2.26.2

--===============0292366866024333921==--
