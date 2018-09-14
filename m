Content-Type: multipart/mixed; boundary="===============8313900986427545775=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 01/20] mptcp: Cleanup
Date: Fri, 14 Sep 2018 10:25:03 -0700
Message-ID: <20180914172524.67961-2-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 734

--===============8313900986427545775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just some basic cleanup, fixing some comments, renaming sk to
meta_sk, and moving mptcp_finish_handshake out of mptcp_ipv4.c to
mptcp_ctrl.c

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 1b95146829844c1c98471194cafd5d4d99fc682a)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h        |  8 ++++----
 net/mptcp/mptcp_ctrl.c     | 25 +++++++++++++++++++++----
 net/mptcp/mptcp_fullmesh.c |  2 +-
 net/mptcp/mptcp_input.c    |  7 ++-----
 net/mptcp/mptcp_ipv4.c     | 26 ++++----------------------
 net/mptcp/mptcp_ipv6.c     |  8 ++++----
 6 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 62266a6e0223..6032789b1097 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -660,10 +660,10 @@ extern int sysctl_mptcp_syn_retries;
 =

 extern struct workqueue_struct *mptcp_wq;
 =

-#define mptcp_debug(fmt, args...)					\
-	do {								\
-		if (unlikely(sysctl_mptcp_debug))			\
-			pr_err(fmt, ##args);	\
+#define mptcp_debug(fmt, args...)						\
+	do {									\
+		if (unlikely(sysctl_mptcp_debug))				\
+			pr_err(fmt, ##args);					\
 	} while (0)
 =

 /* Iterates over all subflows */
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 1e7b38911083..f178eb9db66c 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1337,8 +1337,8 @@ void mptcp_fallback_meta_sk(struct sock *meta_sk)
 int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 re=
m_id,
 		   gfp_t flags)
 {
-	struct mptcp_cb *mpcb	=3D tcp_sk(meta_sk)->mpcb;
-	struct tcp_sock *tp	=3D tcp_sk(sk);
+	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct tcp_sock *tp =3D tcp_sk(sk);
 =

 	tp->mptcp =3D kmem_cache_zalloc(mptcp_sock_cache, flags);
 	if (!tp->mptcp)
@@ -2146,9 +2146,9 @@ struct sock *mptcp_check_req_child(struct sock *meta_=
sk,
 				   struct sk_buff *skb,
 				   const struct mptcp_options_received *mopt)
 {
-	struct tcp_sock *child_tp =3D tcp_sk(child);
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
+	struct tcp_sock *child_tp =3D tcp_sk(child);
 	u8 hash_mac_check[20];
 =

 	child_tp->inside_tk_table =3D 0;
@@ -2514,6 +2514,23 @@ int mptcp_conn_request(struct sock *sk, struct sk_bu=
ff *skb)
 	return 0;
 }
 =

+int mptcp_finish_handshake(struct sock *child, struct sk_buff *skb)
+	__releases(&child->sk_lock.slock)
+{
+	int ret;
+
+	/* We don't call tcp_child_process here, because we hold
+	 * already the meta-sk-lock and are sure that it is not owned
+	 * by the user.
+	 */
+	tcp_sk(child)->segs_in +=3D max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+	ret =3D tcp_rcv_state_process(child, skb);
+	bh_unlock_sock(child);
+	sock_put(child);
+
+	return ret;
+}
+
 static void __mptcp_get_info(const struct sock *meta_sk,
 			     struct mptcp_meta_info *info)
 {
diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index 8197b045602b..6f10844d55a5 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -79,7 +79,7 @@ struct fullmesh_priv {
 	u8 rem4_bits;
 	u8 rem6_bits;
 =

-	/* Are we established the additional subflows for primary pair? */
+	/* Have we established the additional subflows for primary pair? */
 	u8 first_pair:1;
 };
 =

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index c4eb59c1438b..c7752f56d183 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -89,10 +89,7 @@ static inline int mptcp_tso_acked_reinject(const struct =
sock *meta_sk,
 	return packets_acked;
 }
 =

-/**
- * Cleans the meta-socket retransmission queue and the reinject-queue.
- * @sk must be the metasocket.
- */
+/* Cleans the meta-socket retransmission queue and the reinject-queue. */
 static void mptcp_clean_rtx_queue(struct sock *meta_sk, u32 prior_snd_una)
 {
 	struct sk_buff *skb, *tmp, *next;
@@ -350,7 +347,7 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 =

 	/* Now, checksum must be 0 */
 	if (unlikely(csum_fold(csum_tcp))) {
-		pr_err("%s csum is wrong: %#x data_seq %u dss_csum_added %d overflowed %=
d iterations %d\n",
+		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflowed %d=
 iterations %d\n",
 		       __func__, csum_fold(csum_tcp), TCP_SKB_CB(last)->seq,
 		       dss_csum_added, overflowed, iter);
 =

diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index 061377f79a18..f059117139be 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -96,11 +96,11 @@ static u32 mptcp_v4_cookie_init_seq(struct request_sock=
 *req, const struct sock
 }
 #endif
 =

-static int mptcp_v4_join_init_req(struct request_sock *req, const struct s=
ock *sk,
+static int mptcp_v4_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	union inet_addr addr;
 	int loc_id;
 	bool low_prio =3D false;
@@ -112,14 +112,14 @@ static int mptcp_v4_join_init_req(struct request_sock=
 *req, const struct sock *s
 	 */
 	mtreq->hash_entry.pprev =3D NULL;
 =

-	tcp_request_sock_ipv4_ops.init_req(req, sk, skb, want_cookie);
+	tcp_request_sock_ipv4_ops.init_req(req, meta_sk, skb, want_cookie);
 =

 	mtreq->mptcp_loc_nonce =3D mptcp_v4_get_nonce(ip_hdr(skb)->saddr,
 						    ip_hdr(skb)->daddr,
 						    tcp_hdr(skb)->source,
 						    tcp_hdr(skb)->dest);
 	addr.ip =3D inet_rsk(req)->ir_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(sk), &low_=
prio);
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(meta_sk), =
&low_prio);
 	if (loc_id =3D=3D -1)
 		return -1;
 	mtreq->loc_id =3D loc_id;
@@ -149,24 +149,6 @@ static int mptcp_v4_join_request(struct sock *meta_sk,=
 struct sk_buff *skb)
 				meta_sk, skb);
 }
 =

-int mptcp_finish_handshake(struct sock *child, struct sk_buff *skb)
-	__releases(&child->sk_lock.slock)
-{
-	int ret;
-
-	/* We don't call tcp_child_process here, because we hold
-	 * already the meta-sk-lock and are sure that it is not owned
-	 * by the user.
-	 */
-	tcp_sk(child)->segs_in +=3D max_t(u16, 1, skb_shinfo(skb)->gso_segs);
-	ret =3D tcp_rcv_state_process(child, skb);
-	bh_unlock_sock(child);
-	sock_put(child);
-
-	return ret;
-}
-
-
 /* Similar to: tcp_v4_do_rcv
  * We only process join requests here. (either the SYN or the final ACK)
  */
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index c968de95709e..a367f103e81a 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -125,11 +125,11 @@ static u32 mptcp_v6_cookie_init_seq(struct request_so=
ck *req, const struct sock
 }
 #endif
 =

-static int mptcp_v6_join_init_req(struct request_sock *req, const struct s=
ock *sk,
+static int mptcp_v6_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-	const struct mptcp_cb *mpcb =3D tcp_sk(sk)->mpcb;
+	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	union inet_addr addr;
 	int loc_id;
 	bool low_prio =3D false;
@@ -141,14 +141,14 @@ static int mptcp_v6_join_init_req(struct request_sock=
 *req, const struct sock *s
 	 */
 	mtreq->hash_entry.pprev =3D NULL;
 =

-	tcp_request_sock_ipv6_ops.init_req(req, sk, skb, want_cookie);
+	tcp_request_sock_ipv6_ops.init_req(req, meta_sk, skb, want_cookie);
 =

 	mtreq->mptcp_loc_nonce =3D mptcp_v6_get_nonce(ipv6_hdr(skb)->saddr.s6_add=
r32,
 						    ipv6_hdr(skb)->daddr.s6_addr32,
 						    tcp_hdr(skb)->source,
 						    tcp_hdr(skb)->dest);
 	addr.in6 =3D inet_rsk(req)->ir_v6_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(sk), &low=
_prio);
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(meta_sk),=
 &low_prio);
 	if (loc_id =3D=3D -1)
 		return -1;
 	mtreq->loc_id =3D loc_id;
-- =

2.16.2


--===============8313900986427545775==--
