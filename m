Content-Type: multipart/mixed; boundary="===============6519875128452304654=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 11/14] mptcp: Don't take meta-lock when
 receiving third ACK
Date: Thu, 03 May 2018 14:04:55 -0700
Message-ID: <20180503210458.21524-12-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 611

--===============6519875128452304654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now everything is ready to do this in a lockless way.

Simply, in tcp_v4(6)_rcv, stop taking the meta-level lock.
When creating the initial subflow, we currently are also holding the
meta-level lock. We need to drop this one as soon as we handover control
to the subflow (aka., when exiting mptcp_check_req_master()).

Data-reception however still requires the meta-level lock. Thus, we need
to take it again in tcp_child_process().

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 4966859c2ad3309437caedcc78c948c78eb343f3)
---
 net/ipv4/tcp_ipv4.c      | 41 ++++-------------------------------------
 net/ipv4/tcp_minisocks.c |  9 +++++++--
 net/ipv6/tcp_ipv6.c      | 41 ++++-------------------------------------
 net/mptcp/mptcp_ctrl.c   | 13 +++++++++++++
 net/mptcp/mptcp_ipv4.c   |  5 ++++-
 net/mptcp/mptcp_ipv6.c   |  4 ++++
 6 files changed, 36 insertions(+), 77 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 31c757f862c0..3bec4f0c2c32 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1739,45 +1739,16 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;
 		}
+		if (unlikely(is_meta_sk(sk) && !mptcp_can_new_subflow(sk))) {
+			inet_csk_reqsk_queue_drop_and_put(sk, req);
+			goto lookup;
+		}
 		/* We own a reference on the listener, increase it again
 		 * as we might lose it too soon.
 		 */
 		sock_hold(sk);
 		refcounted =3D true;
 =

-		if (is_meta_sk(sk)) {
-			bh_lock_sock(sk);
-
-			if (!mptcp_can_new_subflow(sk)) {
-				inet_csk_reqsk_queue_drop_and_put(sk, req);
-				bh_unlock_sock(sk);
-
-				goto discard_and_relse;
-			}
-
-			if (sock_owned_by_user(sk)) {
-				th =3D (const struct tcphdr *)skb->data;
-				iph =3D ip_hdr(skb);
-				tcp_v4_fill_cb(skb, iph, th);
-
-				skb->sk =3D sk;
-				if (unlikely(sk_add_backlog(sk, skb,
-							    sk->sk_rcvbuf + sk->sk_sndbuf))) {
-					reqsk_put(req);
-
-					bh_unlock_sock(sk);
-					__NET_INC_STATS(net, LINUX_MIB_TCPBACKLOGDROP);
-					goto discard_and_relse;
-				}
-
-				reqsk_put(req);
-				bh_unlock_sock(sk);
-				sock_put(sk);
-
-				return 0;
-			}
-		}
-
 		nsk =3D NULL;
 		if (!tcp_filter(sk, skb)) {
 			th =3D (const struct tcphdr *)skb->data;
@@ -1787,8 +1758,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 		if (!nsk) {
 			reqsk_put(req);
-			if (is_meta_sk(sk))
-				bh_unlock_sock(sk);
 			if (req_stolen) {
 				/* Another cpu got exclusive access to req
 				 * and created a full blown socket.
@@ -1804,8 +1773,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
 			tcp_v4_restore_cb(skb);
-			if (is_meta_sk(sk))
-				bh_unlock_sock(sk);
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v4_send_reset(nsk, skb);
 			goto discard_and_relse;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 94e7bfd8343a..1581b1991733 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -899,6 +899,11 @@ int tcp_child_process(struct sock *parent, struct sock=
 *child,
 	sk_mark_napi_id(child, skb);
 =

 	tcp_segs_in(tcp_sk(child), skb);
+	/* The following will be removed when we allow lockless data-reception
+	 * on the subflows.
+	 */
+	if (mptcp(tcp_sk(child)))
+		bh_lock_sock(meta_sk);
 	if (!sock_owned_by_user(meta_sk)) {
 		ret =3D tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
@@ -914,9 +919,9 @@ int tcp_child_process(struct sock *parent, struct sock =
*child,
 		__sk_add_backlog(meta_sk, skb);
 	}
 =

+	bh_unlock_sock(child);
 	if (mptcp(tcp_sk(child)))
-		bh_unlock_sock(child);
-	bh_unlock_sock(meta_sk);
+		bh_unlock_sock(meta_sk);
 	sock_put(child);
 	return ret;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1b2ce91839df..eea44f1c9084 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1537,42 +1537,13 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;
 		}
+		if (unlikely(is_meta_sk(sk) && !mptcp_can_new_subflow(sk))) {
+			inet_csk_reqsk_queue_drop_and_put(sk, req);
+			goto lookup;
+		}
 		sock_hold(sk);
 		refcounted =3D true;
 =

-		if (is_meta_sk(sk)) {
-			bh_lock_sock(sk);
-
-			if (!mptcp_can_new_subflow(sk)) {
-				inet_csk_reqsk_queue_drop_and_put(sk, req);
-				bh_unlock_sock(sk);
-
-				goto discard_and_relse;
-			}
-
-			if (sock_owned_by_user(sk)) {
-				th =3D (const struct tcphdr *)skb->data;
-				hdr =3D ipv6_hdr(skb);
-				tcp_v6_fill_cb(skb, hdr, th);
-
-				skb->sk =3D sk;
-				if (unlikely(sk_add_backlog(sk, skb,
-							    sk->sk_rcvbuf + sk->sk_sndbuf))) {
-					reqsk_put(req);
-
-					bh_unlock_sock(sk);
-					__NET_INC_STATS(net, LINUX_MIB_TCPBACKLOGDROP);
-					goto discard_and_relse;
-				}
-
-				reqsk_put(req);
-				bh_unlock_sock(sk);
-				sock_put(sk);
-
-				return 0;
-			}
-		}
-
 		nsk =3D NULL;
 		if (!tcp_filter(sk, skb)) {
 			th =3D (const struct tcphdr *)skb->data;
@@ -1582,8 +1553,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		}
 		if (!nsk) {
 			reqsk_put(req);
-			if (is_meta_sk(sk))
-				bh_unlock_sock(sk);
 			if (req_stolen) {
 				/* Another cpu got exclusive access to req
 				 * and created a full blown socket.
@@ -1598,8 +1567,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		}
 		if (nsk =3D=3D sk) {
 			reqsk_put(req);
-			if (is_meta_sk(sk))
-				bh_unlock_sock(sk);
 			tcp_v6_restore_cb(skb);
 		} else if (tcp_child_process(sk, nsk, skb)) {
 			tcp_v6_send_reset(nsk, skb);
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 925d05d673d8..4be0e5c063ca 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1333,6 +1333,7 @@ static u8 mptcp_set_new_pathindex(struct mptcp_cb *mp=
cb)
 	return i;
 }
 =

+/* May be called without holding the meta-level lock */
 int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 re=
m_id,
 		   gfp_t flags)
 {
@@ -2109,6 +2110,11 @@ int mptcp_check_req_fastopen(struct sock *child, str=
uct request_sock *req)
 	/* Handled by the master_sk */
 	tcp_sk(meta_sk)->fastopen_rsk =3D NULL;
 =

+	/* Subflow establishment is now lockless, drop the lock here it will
+	 * be taken again in tcp_child_process().
+	 */
+	bh_unlock_sock(meta_sk);
+
 	return 0;
 }
 =

@@ -2138,9 +2144,15 @@ int mptcp_check_req_master(struct sock *sk, struct s=
ock *child,
 		inet_csk_reqsk_queue_add(sk, req, meta_sk);
 	}
 =

+	/* Subflow establishment is now lockless, drop the lock here it will
+	 * be taken again in tcp_child_process().
+	 */
+	bh_unlock_sock(meta_sk);
+
 	return 0;
 }
 =

+/* May be called without holding the meta-level lock */
 struct sock *mptcp_check_req_child(struct sock *meta_sk,
 				   struct sock *child,
 				   struct request_sock *req,
@@ -2383,6 +2395,7 @@ void mptcp_tsq_sub_deferred(struct sock *meta_sk)
 	}
 }
 =

+/* May be called without holding the meta-level lock */
 void mptcp_join_reqsk_init(const struct mptcp_cb *mpcb,
 			   const struct request_sock *req,
 			   struct sk_buff *skb)
diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index 6fce833c6859..c808d10205f5 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -96,6 +96,7 @@ static u32 mptcp_v4_cookie_init_seq(struct request_sock *=
req, const struct sock
 }
 #endif
 =

+/* May be called without holding the meta-level lock */
 static int mptcp_v4_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
 {
@@ -141,7 +142,9 @@ struct request_sock_ops mptcp_request_sock_ops __read_m=
ostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

-/* Similar to: tcp_v4_conn_request */
+/* Similar to: tcp_v4_conn_request
+ * May be called without holding the meta-level lock
+ */
 static int mptcp_v4_join_request(struct sock *meta_sk, struct sk_buff *skb)
 {
 	return tcp_conn_request(&mptcp_request_sock_ops,
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index bd6b16becc49..2d730379d5ed 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -125,6 +125,7 @@ static u32 mptcp_v6_cookie_init_seq(struct request_sock=
 *req, const struct sock
 }
 #endif
 =

+/* May be called without holding the meta-level lock */
 static int mptcp_v6_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
 {
@@ -170,6 +171,9 @@ struct request_sock_ops mptcp6_request_sock_ops __read_=
mostly =3D {
 	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
 };
 =

+/* Similar to: tcp_v6_conn_request
+ * May be called without holding the meta-level lock
+ */
 static int mptcp_v6_join_request(struct sock *meta_sk, struct sk_buff *skb)
 {
 	return tcp_conn_request(&mptcp6_request_sock_ops,
-- =

2.16.2


--===============6519875128452304654==--
