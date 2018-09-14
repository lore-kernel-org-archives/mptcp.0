Content-Type: multipart/mixed; boundary="===============7185627046381605532=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 12/20] mptcp: Make mptcp_do_join_short and
 mptcp_lookup_join lockless
Date: Fri, 14 Sep 2018 10:25:16 -0700
Message-ID: <20180914172524.67961-15-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 738

--===============7185627046381605532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now we can also make the subflow-SYN+MP_JOIN reception lockless.

In mptcp_lookup_join and mptcp_do_join_short, we were checking for
mptcp_can_new_subflow(), because it is not possible to call
tcp_v4_send_reset() while holding two locks (the listener lock and the
meta-lock when coming from mptcp_do_join_short) when in mptcp_v4_do_rcv.
Now that we remove the locking, we can remove the check for
mptcp_can_new_subflow().

The remaining changes simply skip taking the meta-level lock which also
implies that we don't have to check for sock_owned_by_user().

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 005d56c200a227f04f41891e0a22b8fe4cff0889)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_input.c | 70 +++++++--------------------------------------=
----
 1 file changed, 9 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 2a34b3e0e349..8a3f8dd764e6 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -1151,7 +1151,6 @@ struct mp_join *mptcp_find_join(const struct sk_buff =
*skb)
 =

 int mptcp_lookup_join(struct sk_buff *skb, struct inet_timewait_sock *tw)
 {
-	const struct mptcp_cb *mpcb;
 	struct sock *meta_sk;
 	u32 token;
 	bool meta_v4;
@@ -1184,16 +1183,6 @@ int mptcp_lookup_join(struct sk_buff *skb, struct in=
et_timewait_sock *tw)
 		return -1;
 	}
 =

-	mpcb =3D tcp_sk(meta_sk)->mpcb;
-	if (!mptcp_can_new_subflow(meta_sk)) {
-		/* We are in fallback-mode on the reception-side -
-		 * no new subflows!
-		 */
-		sock_put(meta_sk); /* Taken by mptcp_hash_find */
-		MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
-		return -1;
-	}
-
 	/* Coming from time-wait-sock processing in tcp_v4_rcv.
 	 * We have to deschedule it before continuing, because otherwise
 	 * mptcp_v4_do_rcv will hit again on it inside tcp_v4_hnd_req.
@@ -1204,26 +1193,13 @@ int mptcp_lookup_join(struct sk_buff *skb, struct i=
net_timewait_sock *tw)
 	/* OK, this is a new syn/join, let's create a new open request and
 	 * send syn+ack
 	 */
-	bh_lock_sock_nested(meta_sk);
-	if (sock_owned_by_user(meta_sk)) {
-		skb->sk =3D meta_sk;
-		if (unlikely(sk_add_backlog(meta_sk, skb,
-					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
-			bh_unlock_sock(meta_sk);
-			__NET_INC_STATS(sock_net(meta_sk),
-					 LINUX_MIB_TCPBACKLOGDROP);
-			sock_put(meta_sk); /* Taken by mptcp_hash_find */
-			kfree_skb(skb);
-			return 1;
-		}
-	} else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
 		tcp_v4_do_rcv(meta_sk, skb);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		tcp_v6_do_rcv(meta_sk, skb);
 #endif /* CONFIG_IPV6 */
 	}
-	bh_unlock_sock(meta_sk);
 	sock_put(meta_sk); /* Taken by mptcp_hash_find */
 	return 1;
 }
@@ -1260,48 +1236,20 @@ int mptcp_do_join_short(struct sk_buff *skb,
 	/* OK, this is a new syn/join, let's create a new open request and
 	 * send syn+ack
 	 */
-	bh_lock_sock(meta_sk);
 =

-	/* This check is also done in mptcp_vX_do_rcv. But, there we cannot
-	 * call tcp_vX_send_reset, because we hold already two socket-locks.
-	 * (the listener and the meta from above)
-	 *
-	 * And the send-reset will try to take yet another one (ip_send_reply).
-	 * Thus, we propagate the reset up to tcp_rcv_state_process.
+	/* mptcp_v4_do_rcv tries to free the skb - we prevent this, as
+	 * the skb will finally be freed by tcp_v4_do_rcv (where we are
+	 * coming from)
 	 */
-	if (!mptcp_can_new_subflow(meta_sk)) {
-		MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
-		bh_unlock_sock(meta_sk);
-		sock_put(meta_sk); /* Taken by mptcp_hash_find */
-		return -1;
-	}
-
-	if (sock_owned_by_user(meta_sk)) {
-		skb->sk =3D meta_sk;
-		if (unlikely(sk_add_backlog(meta_sk, skb,
-					    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf)))
-			__NET_INC_STATS(net, LINUX_MIB_TCPBACKLOGDROP);
-		else
-			/* Must make sure that upper layers won't free the
-			 * skb if it is added to the backlog-queue.
-			 */
-			skb_get(skb);
-	} else {
-		/* mptcp_v4_do_rcv tries to free the skb - we prevent this, as
-		 * the skb will finally be freed by tcp_v4_do_rcv (where we are
-		 * coming from)
-		 */
-		skb_get(skb);
-		if (skb->protocol =3D=3D htons(ETH_P_IP)) {
-			tcp_v4_do_rcv(meta_sk, skb);
+	skb_get(skb);
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		tcp_v4_do_rcv(meta_sk, skb);
 #if IS_ENABLED(CONFIG_IPV6)
-		} else { /* IPv6 */
-			tcp_v6_do_rcv(meta_sk, skb);
+	} else { /* IPv6 */
+		tcp_v6_do_rcv(meta_sk, skb);
 #endif /* CONFIG_IPV6 */
-		}
 	}
 =

-	bh_unlock_sock(meta_sk);
 	sock_put(meta_sk); /* Taken by mptcp_hash_find */
 	return 0;
 }
-- =

2.16.2


--===============7185627046381605532==--
