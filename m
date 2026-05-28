Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468063ACF0B
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960448; cv=none; b=BguXMre2PZYclt3gxcrd1M6QUj/dIEIohTzMBHwAF+PwpZlg/n0VgQKQTLDVVDbVvpYSGmT6K+mdMmUBk+Rl4a8k+oV++lQOEbcbfnv0VzmifwouhX5EwJnh8fZQ64GnHKgldef5RxFtkYIV5GiUGQG7Jjb22ApiaxYRhoEDytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960448; c=relaxed/simple;
	bh=6SzUhpZrI1alAQGT/031hNzjvGXJpkxD2WzZEx9xbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDQNsGu3C5wLodfZPbMEJ2BPP5zaDZYuhU9SlfwWztvGWtaHoBwaDP3ign6iA1EQ0P23gk5NU9hW7Xalp4pA5X+O4n6k24EUWPUjgS1dJH2LaYSpDTVTIbwk40t0Iu/Sj8sQHnDPVupIeWrsmkMraQI4NUqVYHfWSbqdrAY++OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7f86oC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7f86oC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777C21F000E9;
	Thu, 28 May 2026 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960445;
	bh=gOb91N4Qy444MyWW0x8lkp6+QPELrR8g796Py5qXNJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7f86oC475o9u45ZF6MtnsMAE91xCgEP/4U5NthTRYtq1b+GOc0iSmV2/WY55iOj4
	 Eq5Bct41dXoLS1PwYoA7+jo4iRHX7v52ObJ5e0nGGm2VjwO0yxFfxasgOlWO0wxpYm
	 N3T3m+uGDSwzClclkvNYzjdeZBlW327aQ7sVFBnsS/0t6J/cV8W8/rUEQH0D1Ap3Bl
	 cMWKZQTNyOqLtTrJRDDFvvgx2HW5HPy+A4P3oiFnJ3N8EYTFdlsnBdk49D3sCVSam3
	 m+/nMnmZ/40OrP5LeTmF+18Pe3IOov+QDk3vVwuSZ/aWfZwMTeK3Rk5MmL9XtVjXTu
	 NUMmLaUVPJ6og==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 01/18] tls: add per-protocol cache for MPTCP support
Date: Thu, 28 May 2026 17:26:52 +0800
Message-ID: <675c4178ee70ee93daf1a00e372abd066766c72f.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  12 ++++
 net/tls/tls_main.c | 134 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 37 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..7ff4d4566d41 100644
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
 
 	union tls_crypto_context crypto_send;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..e87e298ebd85 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,62 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
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
 
+	if (!prot)
+		return;
+
+	/* Ensure sk->sk_socket->ops is not visible before icsk_ulp_data.
+	 * Pairs with the rcu_assign_pointer() release in tls_ctx_create().
+	 */
+	smp_store_release(&sk->sk_socket->ops,
+			  &prot->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
-	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &prot->prots[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -314,6 +353,16 @@ static void tls_write_space(struct sock *sk)
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
@@ -327,6 +376,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
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
@@ -968,35 +1022,34 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_prot *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
-	struct proto *prot = READ_ONCE(sk->sk_prot);
-
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
+	struct proto *proto = READ_ONCE(sk->sk_prot);
+	struct tls_prot *prot, *cache;
 
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
+	prot = kzalloc_obj(*prot, GFP_KERNEL);
+	if (!prot)
+		return NULL;
+
+	spin_lock_bh(&tls_prot_lock);
+	cache = tls_prot_find(proto, ip_ver);
+	if (cache) {
+		spin_unlock_bh(&tls_prot_lock);
+		kfree(prot);
+		return cache;
 	}
+
+	prot->ip_ver = ip_ver;
+	prot->prot = proto;
+	refcount_set(&prot->refcnt, 1);
+	build_protos(prot->prots, proto);
+	build_proto_ops(prot->proto_ops,
+			sk->sk_socket->ops);
+	list_add_rcu(&prot->list, &tls_prot_list);
+
+	spin_unlock_bh(&tls_prot_lock);
+	return prot;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,10 +1099,13 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
 static int tls_init(struct sock *sk)
 {
+	struct tls_prot *prot;
 	struct tls_context *ctx;
 	int rc = 0;
 
-	tls_build_proto(sk);
+	prot = tls_build_proto(sk);
+	if (!prot)
+		return -ENOMEM;
 
 #ifdef CONFIG_TLS_TOE
 	if (tls_toe_bypass(sk))
@@ -1062,13 +1118,16 @@ static int tls_init(struct sock *sk)
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
 	ctx = tls_ctx_create(sk);
 	if (!ctx) {
+		tls_prot_put(prot);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -1265,6 +1324,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_prot_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
 	unregister_pernet_subsys(&tls_proc_ops);
-- 
2.53.0

