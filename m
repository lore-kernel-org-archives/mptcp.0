Content-Type: multipart/mixed; boundary="===============7373295411819208401=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 mptcp-net-next 07/12] mptcp: Remove support for TCP
 SYN-cookies
Date: Fri, 21 Dec 2018 08:13:33 -0800
Message-ID: <20181221161338.72325-8-cpaasch@apple.com>
In-Reply-To: 20181221161338.72325-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 966

--===============7373295411819208401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v3: * More cleanup removing further cookie-things

 include/net/mptcp.h      | 14 ++------
 include/net/tcp.h        | 13 +++----
 net/ipv4/syncookies.c    | 47 ++++---------------------
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/syncookies.c    | 32 ++++-------------
 net/mptcp/mptcp_ctrl.c   | 92 +++-----------------------------------------=
----
 net/mptcp/mptcp_ipv4.c   | 29 ++++-----------
 net/mptcp/mptcp_ipv6.c   | 29 ++++-----------
 9 files changed, 40 insertions(+), 220 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5e3fc3e7adba..32b1fecb70bc 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -739,8 +739,7 @@ int mptcp_create_master_sk(struct sock *meta_sk, __u64 =
remote_key,
 			   __u8 mptcp_ver, u32 window);
 int mptcp_check_req_fastopen(struct sock *child, struct request_sock *req);
 int mptcp_check_req_master(struct sock *sk, struct sock *child,
-			   struct request_sock *req, const struct sk_buff *skb,
-			   int drop);
+			   struct request_sock *req, const struct sk_buff *skb);
 struct sock *mptcp_check_req_child(struct sock *meta_sk,
 				   struct sock *child,
 				   struct request_sock *req,
@@ -802,14 +801,11 @@ void mptcp_join_reqsk_init(const struct mptcp_cb *mpc=
b,
 			   const struct request_sock *req,
 			   struct sk_buff *skb);
 void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
-		      const struct sk_buff *skb, bool want_cookie);
+		      const struct sk_buff *skb);
 int mptcp_conn_request(struct sock *sk, struct sk_buff *skb);
 void mptcp_enable_sock(struct sock *sk);
 void mptcp_disable_sock(struct sock *sk);
 void mptcp_disable_static_key(void);
-void mptcp_cookies_reqsk_init(struct request_sock *req,
-			      struct mptcp_options_received *mopt,
-			      struct sk_buff *skb);
 void mptcp_sock_destruct(struct sock *sk);
 int mptcp_finish_handshake(struct sock *child, struct sk_buff *skb);
 int mptcp_get_info(const struct sock *meta_sk, char __user *optval, int op=
tlen);
@@ -1285,8 +1281,7 @@ static inline int mptcp_check_req_fastopen(struct soc=
k *child,
 static inline int mptcp_check_req_master(const struct sock *sk,
 					 const struct sock *child,
 					 const struct request_sock *req,
-					 const struct sk_buff *skb,
-					 int drop)
+					 const struct sk_buff *skb)
 {
 	return 1;
 }
@@ -1357,9 +1352,6 @@ static inline void mptcp_remove_shortcuts(const struc=
t mptcp_cb *mpcb,
 					  const struct sk_buff *skb) {}
 static inline void mptcp_init_tcp_sock(struct sock *sk) {}
 static inline void mptcp_disable_static_key(void) {}
-static inline void mptcp_cookies_reqsk_init(struct request_sock *req,
-					    struct mptcp_options_received *mopt,
-					    struct sk_buff *skb) {}
 static inline void mptcp_fin(struct sock *meta_sk) {}
 static inline bool mptcp_can_new_subflow(const struct sock *meta_sk)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index c4a9297da7a0..f206ea426018 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -644,8 +644,7 @@ static inline u32 tcp_cookie_time(void)
 =

 u32 __cookie_v4_init_sequence(const struct iphdr *iph, const struct tcphdr=
 *th,
 			      u16 *mssp);
-__u32 cookie_v4_init_sequence(struct request_sock *req, const struct sock =
*sk,
-			      const struct sk_buff *skb, __u16 *mss);
+__u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mss);
 u64 cookie_init_timestamp(struct request_sock *req);
 bool cookie_timestamp_decode(const struct net *net,
 			     struct tcp_options_received *opt);
@@ -659,8 +658,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb);
 =

 u32 __cookie_v6_init_sequence(const struct ipv6hdr *iph,
 			      const struct tcphdr *th, u16 *mssp);
-__u32 cookie_v6_init_sequence(struct request_sock *req, const struct sock =
*sk,
-			      const struct sk_buff *skb, __u16 *mss);
+__u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mss);
 #endif
 /* tcp_output.c */
 =

@@ -2086,8 +2084,8 @@ struct tcp_request_sock_ops {
 			struct sk_buff *skb,
 			bool want_cookie);
 #ifdef CONFIG_SYN_COOKIES
-	__u32 (*cookie_init_seq)(struct request_sock *req, const struct sock *sk,
-				 const struct sk_buff *skb, __u16 *mss);
+	__u32 (*cookie_init_seq)(const struct sk_buff *skb,
+				 __u16 *mss);
 #endif
 	struct dst_entry *(*route_req)(const struct sock *sk, struct flowi *fl,
 				       const struct request_sock *req);
@@ -2101,13 +2099,12 @@ struct tcp_request_sock_ops {
 =

 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops=
 *ops,
-					 struct request_sock *req,
 					 const struct sock *sk, struct sk_buff *skb,
 					 __u16 *mss)
 {
 	tcp_synq_overflow(sk);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
-	return ops->cookie_init_seq(req, sk, skb, mss);
+	return ops->cookie_init_seq(skb, mss);
 }
 #else
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops=
 *ops,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 514a37a63c24..5f2236d8d54a 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -16,8 +16,6 @@
 #include <linux/siphash.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
-#include <net/mptcp.h>
-#include <net/mptcp_v4.h>
 #include <net/secure_seq.h>
 #include <net/tcp.h>
 #include <net/route.h>
@@ -181,8 +179,7 @@ u32 __cookie_v4_init_sequence(const struct iphdr *iph, =
const struct tcphdr *th,
 }
 EXPORT_SYMBOL_GPL(__cookie_v4_init_sequence);
 =

-__u32 cookie_v4_init_sequence(struct request_sock *req, const struct sock =
*sk,
-			      const struct sk_buff *skb, __u16 *mssp)
+__u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mssp)
 {
 	const struct iphdr *iph =3D ip_hdr(skb);
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -212,27 +209,9 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, stru=
ct sk_buff *skb,
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	struct sock *child;
 	bool own_req;
-#ifdef CONFIG_MPTCP
-	int ret;
-#endif
 =

 	child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req);
-
-#ifdef CONFIG_MPTCP
-	if (!child)
-		goto listen_overflow;
-
-	ret =3D mptcp_check_req_master(sk, child, req, skb, 0);
-	if (ret < 0)
-		return NULL;
-
-	if (!ret)
-		return tcp_sk(child)->mpcb->master_sk;
-
-listen_overflow:
-#endif
-
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset =3D tsoff;
@@ -305,7 +284,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 {
 	struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
 	struct tcp_options_received tcp_opt;
-	struct mptcp_options_received mopt;
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -335,8 +313,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	mptcp_init_mp_opt(&mopt);
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, &mopt, 0, NULL, NULL);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, NULL, 0, NULL, NULL);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcp_ts_off(sock_net(sk),
@@ -349,12 +326,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct s=
k_buff *skb)
 		goto out;
 =

 	ret =3D NULL;
-#ifdef CONFIG_MPTCP
-	if (mopt.saw_mpc)
-		req =3D inet_reqsk_alloc(&mptcp_request_sock_ops, sk, false); /* for saf=
ety */
-	else
-#endif
-		req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safet=
y */
+	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for safety=
 */
 	if (!req)
 		goto out;
 =

@@ -374,8 +346,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 	ireq->sack_ok		=3D tcp_opt.sack_ok;
 	ireq->wscale_ok		=3D tcp_opt.wscale_ok;
 	ireq->tstamp_ok		=3D tcp_opt.saw_tstamp;
-	ireq->mptcp_rqsk	=3D 0;
-	ireq->saw_mpc		=3D 0;
 	req->ts_recent		=3D tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 	treq->snt_synack	=3D 0;
 	treq->tfo_listener	=3D false;
@@ -384,9 +354,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	ireq->ir_iif =3D inet_request_bound_dev_if(sk, skb);
 =

-	if (mopt.saw_mpc)
-		mptcp_cookies_reqsk_init(req, &mopt, skb);
-
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
@@ -420,10 +387,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->dst, RTAX_W=
INDOW);
 =

-	tp->ops->select_initial_window(sk, tcp_full_space(sk), req->mss,
-				       &req->rsk_rcv_wnd, &req->rsk_window_clamp,
-				       ireq->wscale_ok, &rcv_wscale,
-				       dst_metric(&rt->dst, RTAX_INITRWND));
+	tcp_select_initial_window(sk, tcp_full_space(sk), req->mss,
+				  &req->rsk_rcv_wnd, &req->rsk_window_clamp,
+				  ireq->wscale_ok, &rcv_wscale,
+				  dst_metric(&rt->dst, RTAX_INITRWND));
 =

 	ireq->rcv_wscale  =3D rcv_wscale;
 	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, sock_net(sk), &rt->dst);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c2d5fa27ee8d..ea36a23267cf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6674,7 +6674,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_ecn_create_request(req, skb, sk, dst);
 =

 	if (want_cookie) {
-		isn =3D cookie_init_sequence(af_ops, req, sk, skb, &req->mss);
+		isn =3D cookie_init_sequence(af_ops, sk, skb, &req->mss);
 		req->cookie_ts =3D tmp_opt.tstamp_ok;
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok =3D 0;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 90912094135b..987316e23f45 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -838,7 +838,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_b=
uff *skb,
 		goto listen_overflow;
 =

 	if (own_req && !is_meta_sk(sk)) {
-		int ret =3D mptcp_check_req_master(sk, child, req, skb, 1);
+		int ret =3D mptcp_check_req_master(sk, child, req, skb);
 		if (ret < 0)
 			goto listen_overflow;
 =

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index bb86437a7003..fa3739f6de48 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -20,8 +20,6 @@
 #include <linux/kernel.h>
 #include <net/secure_seq.h>
 #include <net/ipv6.h>
-#include <net/mptcp.h>
-#include <net/mptcp_v6.h>
 #include <net/tcp.h>
 =

 #define COOKIEBITS 24	/* Upper bits store count */
@@ -113,8 +111,7 @@ u32 __cookie_v6_init_sequence(const struct ipv6hdr *iph,
 }
 EXPORT_SYMBOL_GPL(__cookie_v6_init_sequence);
 =

-__u32 cookie_v6_init_sequence(struct request_sock *req, const struct sock =
*sk,
-			      const struct sk_buff *skb, __u16 *mssp)
+__u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mssp)
 {
 	const struct ipv6hdr *iph =3D ipv6_hdr(skb);
 	const struct tcphdr *th =3D tcp_hdr(skb);
@@ -136,7 +133,6 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_options_received tcp_opt;
-	struct mptcp_options_received mopt;
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
@@ -166,8 +162,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk=
_buff *skb)
 =

 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	mptcp_init_mp_opt(&mopt);
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, &mopt, 0, NULL, NULL);
+	tcp_parse_options(sock_net(sk), skb, &tcp_opt, NULL, 0, NULL, NULL);
 =

 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
@@ -180,27 +175,14 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
 		goto out;
 =

 	ret =3D NULL;
-#ifdef CONFIG_MPTCP
-	if (mopt.saw_mpc)
-		req =3D inet_reqsk_alloc(&mptcp6_request_sock_ops, sk, false);
-	else
-#endif
-		req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
+	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
 	if (!req)
 		goto out;
 =

 	ireq =3D inet_rsk(req);
-	ireq->mptcp_rqsk =3D 0;
-	ireq->saw_mpc =3D 0;
 	treq =3D tcp_rsk(req);
 	treq->tfo_listener =3D false;
 =

-	/* Must be done before anything else, as it initializes
-	 * hash_entry of the MPTCP request-sock.
-	 */
-	if (mopt.saw_mpc)
-		mptcp_cookies_reqsk_init(req, &mopt, skb);
-
 	if (security_inet_conn_request(sk, skb, req))
 		goto out_free;
 =

@@ -264,10 +246,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
 	}
 =

 	req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW=
);
-	tp->ops->select_initial_window(sk, tcp_full_space(sk), req->mss,
-				       &req->rsk_rcv_wnd, &req->rsk_window_clamp,
-				       ireq->wscale_ok, &rcv_wscale,
-				       dst_metric(dst, RTAX_INITRWND));
+	tcp_select_initial_window(sk, tcp_full_space(sk), req->mss,
+				  &req->rsk_rcv_wnd, &req->rsk_window_clamp,
+				  ireq->wscale_ok, &rcv_wscale,
+				  dst_metric(dst, RTAX_INITRWND));
 =

 	ireq->rcv_wscale =3D rcv_wscale;
 	ireq->ecn_ok =3D cookie_ecn_ok(&tcp_opt, sock_net(sk), dst);
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 92c2bf6e6431..02a3ffc6c2fd 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -307,41 +307,6 @@ static void mptcp_reqsk_new_mptcp(struct request_sock =
*req,
 	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
 }
 =

-static int mptcp_reqsk_new_cookie(struct request_sock *req,
-				  const struct sock *sk,
-				  const struct mptcp_options_received *mopt,
-				  const struct sk_buff *skb)
-{
-	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-
-	/* MPTCP version agreement */
-	if (mopt->mptcp_ver >=3D tcp_sk(sk)->mptcp_ver)
-		mtreq->mptcp_ver =3D tcp_sk(sk)->mptcp_ver;
-	else
-		mtreq->mptcp_ver =3D mopt->mptcp_ver;
-
-	rcu_read_lock_bh();
-	spin_lock(&mptcp_tk_hashlock);
-
-	mptcp_set_key_reqsk(req, skb, tcp_rsk(req)->snt_isn);
-
-	if (mptcp_reqsk_find_tk(mtreq->mptcp_loc_token) ||
-	    mptcp_find_token(mtreq->mptcp_loc_token)) {
-		spin_unlock(&mptcp_tk_hashlock);
-		rcu_read_unlock_bh();
-		return false;
-	}
-
-	inet_rsk(req)->saw_mpc =3D 1;
-
-	spin_unlock(&mptcp_tk_hashlock);
-	rcu_read_unlock_bh();
-
-	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
-
-	return true;
-}
-
 static void mptcp_set_key_sk(const struct sock *sk)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
@@ -2128,8 +2093,7 @@ int mptcp_check_req_fastopen(struct sock *child, stru=
ct request_sock *req)
 }
 =

 int mptcp_check_req_master(struct sock *sk, struct sock *child,
-			   struct request_sock *req, const struct sk_buff *skb,
-			   int drop)
+			   struct request_sock *req, const struct sk_buff *skb)
 {
 	struct sock *meta_sk =3D child;
 	int ret;
@@ -2139,17 +2103,8 @@ int mptcp_check_req_master(struct sock *sk, struct s=
ock *child,
 		return ret;
 	child =3D tcp_sk(child)->mpcb->master_sk;
 =

-	/* drop indicates that we come from tcp_check_req and thus need to
-	 * handle the request-socket fully.
-	 */
-	if (drop) {
-		tcp_synack_rtt_meas(child, req);
-		inet_csk_complete_hashdance(sk, meta_sk, req, true);
-	} else {
-		/* Thus, we come from syn-cookies */
-		refcount_set(&req->rsk_refcnt, 1);
-		inet_csk_reqsk_queue_add(sk, req, meta_sk);
-	}
+	tcp_synack_rtt_meas(child, req);
+	inet_csk_complete_hashdance(sk, meta_sk, req, true);
 =

 	/* Subflow establishment is now lockless, drop the lock here it will
 	 * be taken again in tcp_child_process().
@@ -2427,55 +2382,16 @@ void mptcp_join_reqsk_init(const struct mptcp_cb *m=
pcb,
 }
 =

 void mptcp_reqsk_init(struct request_sock *req, const struct sock *sk,
-		      const struct sk_buff *skb, bool want_cookie)
+		      const struct sk_buff *skb)
 {
 	struct mptcp_options_received mopt;
 =

 	mptcp_init_mp_opt(&mopt);
 	tcp_parse_mptcp_options(skb, &mopt);
 =

-	if (want_cookie) {
-		if (!mptcp_reqsk_new_cookie(req, sk, &mopt, skb))
-			/* No key available - back to regular TCP */
-			inet_rsk(req)->mptcp_rqsk =3D 0;
-		return;
-	}
-
 	mptcp_reqsk_new_mptcp(req, sk, &mopt, skb);
 }
 =

-void mptcp_cookies_reqsk_init(struct request_sock *req,
-			      struct mptcp_options_received *mopt,
-			      struct sk_buff *skb)
-{
-	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
-
-	/* Absolutely need to always initialize this. */
-	mtreq->hash_entry.pprev =3D NULL;
-
-	mtreq->mptcp_rem_key =3D mopt->mptcp_sender_key;
-	mtreq->mptcp_loc_key =3D mopt->mptcp_receiver_key;
-
-	/* Generate the token */
-	mptcp_key_sha1(mtreq->mptcp_loc_key, &mtreq->mptcp_loc_token, NULL);
-
-	rcu_read_lock_bh();
-	spin_lock(&mptcp_tk_hashlock);
-
-	/* Check, if the key is still free */
-	if (mptcp_reqsk_find_tk(mtreq->mptcp_loc_token) ||
-	    mptcp_find_token(mtreq->mptcp_loc_token))
-		goto out;
-
-	inet_rsk(req)->saw_mpc =3D 1;
-	mtreq->is_sub =3D 0;
-	inet_rsk(req)->mptcp_rqsk =3D 1;
-
-out:
-	spin_unlock(&mptcp_tk_hashlock);
-	rcu_read_unlock_bh();
-}
-
 int mptcp_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_options_received mopt;
diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index 00c54f421ba7..1f09cba6dc51 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -71,31 +71,17 @@ static int mptcp_v4_init_req(struct request_sock *req, =
const struct sock *sk,
 =

 	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
 	mptcp_rsk(req)->is_sub =3D 0;
-	inet_rsk(req)->mptcp_rqsk =3D 1;
+	inet_rsk(req)->mptcp_rqsk =3D 0;
 =

-	/* In case of SYN-cookies, we wait for the isn to be generated - it is
-	 * input to the key-generation.
-	 */
-	if (!want_cookie)
-		mptcp_reqsk_init(req, sk, skb, false);
+	/* SYN-cookies are not supported */
+	if (!want_cookie) {
+		inet_rsk(req)->mptcp_rqsk =3D 1;
+		mptcp_reqsk_init(req, sk, skb);
+	}
 =

 	return 0;
 }
 =

-#ifdef CONFIG_SYN_COOKIES
-static u32 mptcp_v4_cookie_init_seq(struct request_sock *req, const struct=
 sock *sk,
-				    const struct sk_buff *skb, __u16 *mssp)
-{
-	__u32 isn =3D cookie_v4_init_sequence(req, sk, skb, mssp);
-
-	tcp_rsk(req)->snt_isn =3D isn;
-
-	mptcp_reqsk_init(req, sk, skb, true);
-
-	return isn;
-}
-#endif
-
 /* May be called without holding the meta-level lock */
 static int mptcp_v4_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
@@ -381,9 +367,6 @@ int mptcp_pm_v4_init(void)
 =

 	mptcp_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	mptcp_request_sock_ipv4_ops.init_req =3D mptcp_v4_init_req;
-#ifdef CONFIG_SYN_COOKIES
-	mptcp_request_sock_ipv4_ops.cookie_init_seq =3D mptcp_v4_cookie_init_seq;
-#endif
 	mptcp_join_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 	mptcp_join_request_sock_ipv4_ops.init_req =3D mptcp_v4_join_init_req;
 =

diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 7249d171c9ef..d138560572ad 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -100,31 +100,17 @@ static int mptcp_v6_init_req(struct request_sock *req=
, const struct sock *sk,
 =

 	mptcp_rsk(req)->hash_entry.pprev =3D NULL;
 	mptcp_rsk(req)->is_sub =3D 0;
-	inet_rsk(req)->mptcp_rqsk =3D 1;
+	inet_rsk(req)->mptcp_rqsk =3D 0;
 =

-	/* In case of SYN-cookies, we wait for the isn to be generated - it is
-	 * input to the key-generation.
-	 */
-	if (!want_cookie)
-		mptcp_reqsk_init(req, sk, skb, false);
+	/* SYN-cookies are not supported */
+	if (!want_cookie) {
+		inet_rsk(req)->mptcp_rqsk =3D 1;
+		mptcp_reqsk_init(req, sk, skb);
+	}
 =

 	return 0;
 }
 =

-#ifdef CONFIG_SYN_COOKIES
-static u32 mptcp_v6_cookie_init_seq(struct request_sock *req, const struct=
 sock *sk,
-				    const struct sk_buff *skb, __u16 *mssp)
-{
-	__u32 isn =3D cookie_v6_init_sequence(req, sk, skb, mssp);
-
-	tcp_rsk(req)->snt_isn =3D isn;
-
-	mptcp_reqsk_init(req, sk, skb, true);
-
-	return isn;
-}
-#endif
-
 /* May be called without holding the meta-level lock */
 static int mptcp_v6_join_init_req(struct request_sock *req, const struct s=
ock *meta_sk,
 				  struct sk_buff *skb, bool want_cookie)
@@ -427,9 +413,6 @@ int mptcp_pm_v6_init(void)
 =

 	mptcp_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 	mptcp_request_sock_ipv6_ops.init_req =3D mptcp_v6_init_req;
-#ifdef CONFIG_SYN_COOKIES
-	mptcp_request_sock_ipv6_ops.cookie_init_seq =3D mptcp_v6_cookie_init_seq;
-#endif
 =

 	mptcp_join_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 	mptcp_join_request_sock_ipv6_ops.init_req =3D mptcp_v6_join_init_req;
-- =

2.16.2


--===============7373295411819208401==--
