Content-Type: multipart/mixed; boundary="===============5548968773102766128=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 15/15] tcp_md5: Use TCP extra-options on the input
 path
Date: Mon, 11 Dec 2017 13:42:18 -0800
Message-ID: <20171211214218.35868-16-cpaasch@apple.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 245

--===============5548968773102766128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The checks are now being done through the extra-option framework. For
TCP MD5 this means that the check happens a bit later than usual.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/linux/tcp_md5.h | 23 +----------------------
 net/ipv4/tcp_input.c    |  8 --------
 net/ipv4/tcp_ipv4.c     |  9 ---------
 net/ipv4/tcp_md5.c      | 29 ++++++++++++++++++++++++-----
 net/ipv6/tcp_ipv6.c     |  9 ---------
 5 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
index 509fc36335e7..bef277f55b36 100644
--- a/include/linux/tcp_md5.h
+++ b/include/linux/tcp_md5.h
@@ -31,30 +31,9 @@ struct tcp_md5sig_key {
 int tcp_md5_parse_keys(struct sock *sk, int optname, char __user *optval,
 		       int optlen);
 =

-bool tcp_v4_inbound_md5_hash(const struct sock *sk,
-			     const struct sk_buff *skb);
-
-bool tcp_v6_inbound_md5_hash(const struct sock *sk,
-			     const struct sk_buff *skb);
-
 int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buff *=
skb);
 =

 int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
 =

-#else
-
-static inline bool tcp_v4_inbound_md5_hash(const struct sock *sk,
-					   const struct sk_buff *skb)
-{
-	return false;
-}
-
-static inline bool tcp_v6_inbound_md5_hash(const struct sock *sk,
-					   const struct sk_buff *skb)
-{
-	return false;
-}
-
-#endif
-
+#endif /* CONFIG_TCP_MD5SIG */
 #endif /* _LINUX_TCP_MD5_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e89e22920c2b..e8ea79f479ae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3759,14 +3759,6 @@ void tcp_parse_options(const struct net *net,
 					TCP_SKB_CB(skb)->sacked =3D (ptr - 2) - (unsigned char *)th;
 				}
 				break;
-#ifdef CONFIG_TCP_MD5SIG
-			case TCPOPT_MD5SIG:
-				/*
-				 * The MD5 Hash has already been
-				 * checked (see tcp_v{4,6}_do_rcv()).
-				 */
-				break;
-#endif
 			case TCPOPT_FASTOPEN:
 				tcp_parse_fastopen_option(
 					opsize - TCPOLEN_FASTOPEN_BASE,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e01c9467f1ae..05bac32ad041 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,7 +62,6 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
-#include <linux/tcp_md5.h>
 =

 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -1242,11 +1241,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 =

 		sk =3D req->rsk_listener;
-		if (unlikely(tcp_v4_inbound_md5_hash(sk, skb))) {
-			sk_drops_add(sk, skb);
-			reqsk_put(req);
-			goto discard_it;
-		}
 		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;
@@ -1286,9 +1280,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_and_relse;
 =

-	if (tcp_v4_inbound_md5_hash(sk, skb))
-		goto discard_and_relse;
-
 	nf_reset(skb);
 =

 	if (tcp_filter(sk, skb))
diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
index c22113c0c553..a9c7833a39fe 100644
--- a/net/ipv4/tcp_md5.c
+++ b/net/ipv4/tcp_md5.c
@@ -29,6 +29,10 @@ static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md5sig=
_pool);
 static DEFINE_MUTEX(tcp_md5sig_mutex);
 static bool tcp_md5sig_pool_populated;
 =

+static bool tcp_inbound_md5_hash(struct sock *sk, const struct sk_buff *sk=
b,
+				 struct tcp_options_received *opt_rx,
+				 struct tcp_extopt_store *store);
+
 static unsigned int tcp_md5_extopt_prepare(struct sk_buff *skb, u8 flags,
 					   unsigned int remaining,
 					   struct tcp_out_options *opts,
@@ -76,6 +80,7 @@ struct tcp_md5_extopt {
 =

 static const struct tcp_extopt_ops tcp_md5_extra_ops =3D {
 	.option_kind		=3D TCPOPT_MD5SIG,
+	.check			=3D tcp_inbound_md5_hash,
 	.prepare		=3D tcp_md5_extopt_prepare,
 	.write			=3D tcp_md5_extopt_write,
 	.response_prepare	=3D tcp_md5_send_response_prepare,
@@ -843,8 +848,8 @@ static struct tcp_md5sig_key *tcp_v4_md5_lookup(const s=
truct sock *sk,
 }
 =

 /* Called with rcu_read_lock() */
-bool tcp_v4_inbound_md5_hash(const struct sock *sk,
-			     const struct sk_buff *skb)
+static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
+				    const struct sk_buff *skb)
 {
 	/* This gets called for each TCP segment that arrives
 	 * so we want to be efficient.
@@ -898,8 +903,8 @@ bool tcp_v4_inbound_md5_hash(const struct sock *sk,
 }
 =

 #if IS_ENABLED(CONFIG_IPV6)
-bool tcp_v6_inbound_md5_hash(const struct sock *sk,
-			     const struct sk_buff *skb)
+static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
+				    const struct sk_buff *skb)
 {
 	const __u8 *hash_location =3D NULL;
 	struct tcp_md5sig_key *hash_expected;
@@ -941,7 +946,6 @@ bool tcp_v6_inbound_md5_hash(const struct sock *sk,
 =

 	return false;
 }
-EXPORT_SYMBOL_GPL(tcp_v6_inbound_md5_hash);
 =

 static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
 						const struct sock *addr_sk)
@@ -951,6 +955,21 @@ static struct tcp_md5sig_key *tcp_v6_md5_lookup(const =
struct sock *sk,
 EXPORT_SYMBOL_GPL(tcp_v6_md5_lookup);
 #endif
 =

+static bool tcp_inbound_md5_hash(struct sock *sk, const struct sk_buff *sk=
b,
+				 struct tcp_options_received *opt_rx,
+				 struct tcp_extopt_store *store)
+{
+	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
+		return tcp_v4_inbound_md5_hash(sk, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else {
+		return tcp_v6_inbound_md5_hash(sk, skb);
+#endif
+	}
+
+	return false;
+}
+
 static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
 				 const struct tcp_md5sig_key *key)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b7344a55d25b..0bd7cd1777cc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -43,7 +43,6 @@
 #include <linux/ipv6.h>
 #include <linux/icmpv6.h>
 #include <linux/random.h>
-#include <linux/tcp_md5.h>
 =

 #include <net/tcp.h>
 #include <net/ndisc.h>
@@ -1169,11 +1168,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		struct sock *nsk;
 =

 		sk =3D req->rsk_listener;
-		if (tcp_v6_inbound_md5_hash(sk, skb)) {
-			sk_drops_add(sk, skb);
-			reqsk_put(req);
-			goto discard_it;
-		}
 		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;
@@ -1210,9 +1204,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_and_relse;
 =

-	if (tcp_v6_inbound_md5_hash(sk, skb))
-		goto discard_and_relse;
-
 	if (tcp_filter(sk, skb))
 		goto discard_and_relse;
 	th =3D (const struct tcphdr *)skb->data;
-- =

2.15.0


--===============5548968773102766128==--
