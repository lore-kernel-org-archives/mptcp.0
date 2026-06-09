Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1C264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971578; cv=none; b=AF/3SonJKr9JI+/m0+rix+75EYD/0TvdXYdGI/jBdD8jq146B2tcYdRoZtx88HdOLqLncNJsKPrfwSqt79MxaNa+xz7zculgchJwhlouddoJtk9ea93BUgBlRRURCiCJMyqq8Pi9qoI5k/0U80To+wIESjUGaelkEH/bpegdPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971578; c=relaxed/simple;
	bh=dK5bkQWmcwYzFedahPDli3P5vHzw5wtN+g4e4sNKPS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB88snVuZYLLK23VTFWVKvwXovV1doGyYItIq2ELWsyRjFxrJddanbFBPcrJLtGnbmWjuslKP4MFdbe9Vv8RJcUBxnDIzSj3vudPLgNu2mwc6yq7qUGIRj73TCGsKgErgkkwBssaC2VIPXMUl4BJ1I7mng33jGE+ob5q8EOixpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE6koEGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE6koEGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FBA1F00898;
	Tue,  9 Jun 2026 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971577;
	bh=3vFm9GQwDwSwewQUh0MJQII4fp8zHJrCLgpGMu2WeyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LE6koEGWi163u59/lKDQwxCeNI7BPbtZ2XiakR/Q3vrLzz0AYHGyNIvVji0qNNLjw
	 4FAQbYUDtgPPJ34j/pbqARLzCa1Jecjhsg994rglawH6IwoaXj4339UdTG91CIbj8h
	 cyhuEAEeSyA581tJywORToS/iqM7ZWLnXWxzOU/H7W3DJVKXFHk80C3XqrHsFMkhg3
	 g9TGIQTuUHk/+iS/N6Gcwtqjki9RB2+SXCMqGs99hrzktNYdahYtjv/fvbqZfalr/A
	 XdqwdFD9O1xZrwx8pnmNbZRFdXi8MwG0EQSwUyeL7Gu4qzhEUxnORFy7riIU9jGLNm
	 L80ZdXuqKe2xQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 07/22] tls: add per-protocol cache for mptcp support
Date: Tue,  9 Jun 2026 10:18:33 +0800
Message-ID: <0bfd6cfe092eb899cfc0692108dc7695ad41b731.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS ULP uses global static arrays to cache base protocol operations.
When MPTCP sockets enable TLS, they overwrite these global caches when
building for MPTCP, causing active TCP TLS sockets to use MPTCP-specific
ops. This leads to type confusion and kernel panics.

Fix by replacing the global caches with a per-protocol linked list. Each
protocol (TCP, MPTCP, etc.) now has its own cached operations, stored in
struct tls_prot and referenced from tls_context.

Add a struct tls_prot *prot parameter to tls_ctx_create() and
tls_toe_bypass(), and store the pointer in tls_context. This allows
protocol-specific TLS operation tables (e.g., for MPTCP) to be passed
down.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h     |  12 ++++
 include/net/tls_toe.h |   2 +-
 net/tls/tls.h         |   2 +-
 net/tls/tls_main.c    | 139 +++++++++++++++++++++++++++++++-----------
 net/tls/tls_toe.c     |   4 +-
 5 files changed, 118 insertions(+), 41 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 6520fd3b5fb0..a22a417002cf 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,16 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_prot {
+	struct rcu_head			rcu;
+	refcount_t			refcnt;
+	struct list_head		list;
+	int				ip_ver;
+	const struct proto		*prot;
+	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
@@ -257,6 +267,8 @@ struct tls_context {
 	struct proto *sk_proto;
 	struct sock *sk;
 
+	struct tls_prot *prot;
+
 	void (*sk_destruct)(struct sock *sk);
 	__poll_t (*sk_poll)(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait);
diff --git a/include/net/tls_toe.h b/include/net/tls_toe.h
index b3aa7593ce2c..f1de7d2498cf 100644
--- a/include/net/tls_toe.h
+++ b/include/net/tls_toe.h
@@ -69,7 +69,7 @@ struct tls_toe_device {
 	struct kref kref;
 };
 
-int tls_toe_bypass(struct sock *sk);
+int tls_toe_bypass(struct sock *sk, struct tls_prot *prot);
 int tls_toe_hash(struct sock *sk);
 void tls_toe_unhash(struct sock *sk);
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..b9a41e1b8f8c 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -136,7 +136,7 @@ struct tls_rec {
 int __net_init tls_proc_init(struct net *net);
 void __net_exit tls_proc_fini(struct net *net);
 
-struct tls_context *tls_ctx_create(struct sock *sk);
+struct tls_context *tls_ctx_create(struct sock *sk, struct tls_prot *prot);
 void tls_ctx_free(struct sock *sk, struct tls_context *ctx);
 void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index c2d131aeac48..d583e50bb5b9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,59 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
-static const struct proto *saved_tcpv6_prot;
-static DEFINE_MUTEX(tcpv6_prot_mutex);
-static const struct proto *saved_tcpv4_prot;
-static DEFINE_MUTEX(tcpv4_prot_mutex);
-static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
-static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+static LIST_HEAD(tls_prot_list);
+static DEFINE_SPINLOCK(tls_prot_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
+static struct tls_prot *tls_prot_find(const struct proto *proto,
+				      int ip_ver)
+{
+	struct tls_prot *prot, *ret = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(prot, &tls_prot_list, list) {
+		if (prot->prot == proto && prot->ip_ver == ip_ver &&
+		    refcount_inc_not_zero(&prot->refcnt)) {
+			ret = prot;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void tls_prot_free(struct rcu_head *rcu)
+{
+	struct tls_prot *prot = container_of(rcu, struct tls_prot, rcu);
+
+	kfree(prot);
+}
+
+static void tls_prot_cleanup(void)
+{
+	struct tls_prot *prot, *tmp;
+
+	spin_lock_bh(&tls_prot_lock);
+	list_for_each_entry_safe(prot, tmp, &tls_prot_list, list) {
+		list_del_rcu(&prot->list);
+		call_rcu(&prot->rcu, tls_prot_free);
+	}
+	spin_unlock_bh(&tls_prot_lock);
+	rcu_barrier();
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
-	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+	struct tls_prot *prot = ctx->prot;
+
+	if (!prot)
+		return;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &prot->prots[ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &prot->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -314,6 +350,16 @@ static void tls_write_space(struct sock *sk)
 	ctx->sk_write_space(sk);
 }
 
+static void tls_prot_put(struct tls_prot *prot)
+{
+	if (refcount_dec_and_test(&prot->refcnt)) {
+		spin_lock_bh(&tls_prot_lock);
+		list_del_rcu(&prot->list);
+		spin_unlock_bh(&tls_prot_lock);
+		call_rcu(&prot->rcu, tls_prot_free);
+	}
+}
+
 /**
  * tls_ctx_free() - free TLS ULP context
  * @sk:  socket to with @ctx is attached
@@ -327,6 +373,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
 	if (!ctx)
 		return;
 
+	if (ctx->prot) {
+		tls_prot_put(ctx->prot);
+		ctx->prot = NULL;
+	}
+
 	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
 	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
 	mutex_destroy(&ctx->tx_lock);
@@ -913,7 +964,7 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk, struct tls_prot *prot)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -924,6 +975,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->prot = prot;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -971,35 +1023,41 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_prot *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_prot *proto, *cache;
 
-	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
-	if (ip_ver == TLSV6 &&
-	    unlikely(prot != smp_load_acquire(&saved_tcpv6_prot))) {
-		mutex_lock(&tcpv6_prot_mutex);
-		if (likely(prot != saved_tcpv6_prot)) {
-			build_protos(tls_prots[TLSV6], prot);
-			build_proto_ops(tls_proto_ops[TLSV6],
-					sk->sk_socket->ops);
-			smp_store_release(&saved_tcpv6_prot, prot);
-		}
-		mutex_unlock(&tcpv6_prot_mutex);
-	}
+	if (!sk->sk_socket)
+		return NULL;
 
-	if (ip_ver == TLSV4 &&
-	    unlikely(prot != smp_load_acquire(&saved_tcpv4_prot))) {
-		mutex_lock(&tcpv4_prot_mutex);
-		if (likely(prot != saved_tcpv4_prot)) {
-			build_protos(tls_prots[TLSV4], prot);
-			build_proto_ops(tls_proto_ops[TLSV4],
-					sk->sk_socket->ops);
-			smp_store_release(&saved_tcpv4_prot, prot);
-		}
-		mutex_unlock(&tcpv4_prot_mutex);
+	cache = tls_prot_find(prot, ip_ver);
+	if (cache)
+		return cache;
+
+	proto = kzalloc_obj(*proto, GFP_KERNEL);
+	if (!proto)
+		return NULL;
+
+	spin_lock_bh(&tls_prot_lock);
+	cache = tls_prot_find(prot, ip_ver);
+	if (cache) {
+		spin_unlock_bh(&tls_prot_lock);
+		kfree(proto);
+		return cache;
 	}
+
+	proto->ip_ver = ip_ver;
+	proto->prot = prot;
+	refcount_set(&proto->refcnt, 1);
+	build_protos(proto->prots, prot);
+	build_proto_ops(proto->proto_ops,
+			sk->sk_socket->ops);
+	list_add_rcu(&proto->list, &tls_prot_list);
+	spin_unlock_bh(&tls_prot_lock);
+
+	return proto;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1050,12 +1108,15 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
+	struct tls_prot *prot;
 	int rc = 0;
 
-	tls_build_proto(sk);
+	prot = tls_build_proto(sk);
+	if (!prot)
+		return -ENOMEM;
 
 #ifdef CONFIG_TLS_TOE
-	if (tls_toe_bypass(sk))
+	if (tls_toe_bypass(sk, prot))
 		return 0;
 #endif
 
@@ -1065,13 +1126,16 @@ static int tls_init(struct sock *sk)
 	 * to modify the accept implementation to clone rather then
 	 * share the ulp context.
 	 */
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (sk->sk_state != TCP_ESTABLISHED) {
+		tls_prot_put(prot);
 		return -ENOTCONN;
+	}
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, prot);
 	if (!ctx) {
+		tls_prot_put(prot);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -1270,6 +1334,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_prot_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
 	unregister_pernet_subsys(&tls_proc_ops);
diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..68085a28a58c 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -54,7 +54,7 @@ static void tls_toe_sk_destruct(struct sock *sk)
 	tls_ctx_free(sk, ctx);
 }
 
-int tls_toe_bypass(struct sock *sk)
+int tls_toe_bypass(struct sock *sk, struct tls_prot *prot)
 {
 	struct tls_toe_device *dev;
 	struct tls_context *ctx;
@@ -63,7 +63,7 @@ int tls_toe_bypass(struct sock *sk)
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->feature && dev->feature(dev)) {
-			ctx = tls_ctx_create(sk);
+			ctx = tls_ctx_create(sk, prot);
 			if (!ctx)
 				goto out;
 
-- 
2.43.0

