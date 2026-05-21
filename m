Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE149372B2B
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355813; cv=none; b=ftA37url+MIgb5ohyWKOkCq9oR/asOw6T6OQhGiNRvabv/1sfgfJOOj4wT/y3cDHLJyovOuvGHl6TYJ2sJS5o0jYzqiLTgLlte0fyHW3kfwEn5cjquC+mJpejZFY2OnnICeC0ayMDfUKXS3eL8OGz283W2IZBklN9M8pobE0R0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355813; c=relaxed/simple;
	bh=SK7o0RKpah/74MrovwlBpx/5nq1PfO4MHGCKDZ+h76k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IppTwek3QcV28jn21pLRtkNzzkTAbc/hKjuIQghjwTB88wOD+IXWu3o4NWUOwBn4LHaoJeuaHq3w5+ZxjI8PS0B0lp4iEw3tjQGsq1fGvjMNUGHTBFB8XJRqDL350HLiWCYEASXlAgkIzerJOwoBatmQfNRTV96frB1T7aqgukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTGbXah1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTGbXah1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF731F00A3B;
	Thu, 21 May 2026 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355811;
	bh=is5KJMg9mMegWAjEy4+61Xe+MY4/re5fvurQyThmxno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTGbXah1EaOAsmd4PrIPZuovthgV6HpJ0TIzC330DmdcqEj3TzEy83sL3znsciIry
	 LXVztnC3QiGlxoU4VHbqlH08and0m8FR3Y/FrUFn2v1ZtF9JbLC3BlRnpEpeDbZ3oq
	 5AjHSDjwYoLsi5eynS4u5KHK3FdBZ9TnwQaX2N8o5V8dChZ/yDSsjZdvS4to120P4M
	 PsiCU8NvujFr0I4Twd/Oe0kmb8eosPrURkv4bwMRxxdDUWFIQEV0iy6EoO3QbWc0mV
	 YDP/WniGd2Ak86lYtSu+XTcQsJMePOQrniL3oHm7k5+EJkeSYh9jy1h8RJAPksL5fT
	 qcB/wKSb/q0+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 01/15] tls: add per-protocol cache to support mptcp
Date: Thu, 21 May 2026 17:29:39 +0800
Message-ID: <2fb57d7b3cdd2dcd88b3eb95516fa4a4467d939f.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS ULP uses a single global array to cache base protocol operations.
When MPTCP sockets enable TLS, they overwrite this global cache with
mptcp_prot, causing active TCP TLS sockets to use MPTCP-specific ops.
This leads to type confusion and kernel panics.

Fix by replacing the global cache with a per-protocol linked list.
Each protocol (TCP, MPTCP, etc.) now has its own cached operations,
stored in struct tls_proto and referenced from tls_context.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h     |  11 ++++
 include/net/tls_toe.h |   3 +-
 net/tls/tls.h         |   3 +-
 net/tls/tls_main.c    | 136 +++++++++++++++++++++++++++++-------------
 net/tls/tls_toe.c     |   7 ++-
 5 files changed, 116 insertions(+), 44 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..d8a7fbda4fec 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,15 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_proto {
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
@@ -257,6 +266,8 @@ struct tls_context {
 	struct proto *sk_proto;
 	struct sock *sk;
 
+	struct tls_proto *proto;
+
 	void (*sk_destruct)(struct sock *sk);
 
 	union tls_crypto_context crypto_send;
diff --git a/include/net/tls_toe.h b/include/net/tls_toe.h
index b3aa7593ce2c..b73029364b2c 100644
--- a/include/net/tls_toe.h
+++ b/include/net/tls_toe.h
@@ -69,7 +69,8 @@ struct tls_toe_device {
 	struct kref kref;
 };
 
-int tls_toe_bypass(struct sock *sk);
+int tls_toe_bypass(struct sock *sk,
+		   struct tls_proto *proto);
 int tls_toe_hash(struct sock *sk);
 void tls_toe_unhash(struct sock *sk);
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..3a16047c3a8f 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -136,7 +136,8 @@ struct tls_rec {
 int __net_init tls_proc_init(struct net *net);
 void __net_exit tls_proc_fini(struct net *net);
 
-struct tls_context *tls_ctx_create(struct sock *sk);
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto);
 void tls_ctx_free(struct sock *sk, struct tls_context *ctx);
 void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..30dd95fff53e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,54 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
-static const struct proto *saved_tcpv6_prot;
-static DEFINE_MUTEX(tcpv6_prot_mutex);
-static const struct proto *saved_tcpv4_prot;
-static DEFINE_MUTEX(tcpv4_prot_mutex);
-static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
-static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+static LIST_HEAD(tls_proto_list);
+static DEFINE_SPINLOCK(tls_proto_lock);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
+static struct tls_proto *tls_proto_find(const struct proto *prot,
+					int ip_ver)
+{
+	struct tls_proto *proto, *ret = NULL;
+
+	spin_lock_bh(&tls_proto_lock);
+	list_for_each_entry(proto, &tls_proto_list, list) {
+		if (proto->prot == prot && proto->ip_ver == ip_ver) {
+			if (refcount_inc_not_zero(&proto->refcnt))
+				ret = proto;
+			break;
+		}
+	}
+	spin_unlock_bh(&tls_proto_lock);
+	return ret;
+}
+
+static void tls_proto_cleanup(void)
+{
+	struct tls_proto *prot, *tmp;
+
+	spin_lock_bh(&tls_proto_lock);
+	list_for_each_entry_safe(prot, tmp, &tls_proto_list, list) {
+		list_del(&prot->list);
+		kfree(prot);
+	}
+	spin_unlock_bh(&tls_proto_lock);
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
-	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+	struct tls_proto *proto = ctx->proto;
+
+	if (!proto)
+		return;
 
+	/* Ensure sk->sk_socket->ops is not visible before icsk_ulp_data.
+	 * Pairs with the rcu_assign_pointer() release in tls_ctx_create().
+	 */
+	smp_store_release(&sk->sk_socket->ops,
+			  &proto->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
-	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->prots[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -314,6 +345,16 @@ static void tls_write_space(struct sock *sk)
 	ctx->sk_write_space(sk);
 }
 
+static void tls_proto_put(struct tls_proto *proto)
+{
+	if (refcount_dec_and_test(&proto->refcnt)) {
+		spin_lock_bh(&tls_proto_lock);
+		list_del(&proto->list);
+		spin_unlock_bh(&tls_proto_lock);
+		kfree(proto);
+	}
+}
+
 /**
  * tls_ctx_free() - free TLS ULP context
  * @sk:  socket to with @ctx is attached
@@ -327,6 +368,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
 	if (!ctx)
 		return;
 
+	if (ctx->proto) {
+		tls_proto_put(ctx->proto);
+		ctx->proto = NULL;
+	}
+
 	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
 	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
 	mutex_destroy(&ctx->tx_lock);
@@ -910,17 +956,24 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
 
+	if (!refcount_inc_not_zero(&proto->refcnt))
+		return NULL;
+
 	ctx = kzalloc_obj(*ctx, GFP_ATOMIC);
-	if (!ctx)
+	if (!ctx) {
+		tls_proto_put(proto);
 		return NULL;
+	}
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,35 +1021,32 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_proto *proto;
 
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
+	proto = tls_proto_find(prot, ip_ver);
+	if (proto)
+		goto out;
 
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
-	}
+	proto = kzalloc_obj(*proto, GFP_KERNEL);
+	if (!proto)
+		goto out;
+
+	spin_lock_bh(&tls_proto_lock);
+	proto->ip_ver = ip_ver;
+	proto->prot = prot;
+	refcount_set(&proto->refcnt, 1);
+	build_protos(proto->prots, prot);
+	build_proto_ops(proto->proto_ops,
+			sk->sk_socket->ops);
+	list_add(&proto->list, &tls_proto_list);
+
+	spin_unlock_bh(&tls_proto_lock);
+out:
+	return proto;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,13 +1096,16 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
 static int tls_init(struct sock *sk)
 {
+	struct tls_proto *proto;
 	struct tls_context *ctx;
 	int rc = 0;
 
-	tls_build_proto(sk);
+	proto = tls_build_proto(sk);
+	if (!proto)
+		return -ENOMEM;
 
 #ifdef CONFIG_TLS_TOE
-	if (tls_toe_bypass(sk))
+	if (tls_toe_bypass(sk, proto))
 		return 0;
 #endif
 
@@ -1062,12 +1115,14 @@ static int tls_init(struct sock *sk)
 	 * to modify the accept implementation to clone rather then
 	 * share the ulp context.
 	 */
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (sk->sk_state != TCP_ESTABLISHED) {
+		tls_proto_put(proto);
 		return -ENOTCONN;
+	}
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, proto);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
@@ -1265,6 +1320,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_proto_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
 	unregister_pernet_subsys(&tls_proc_ops);
diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..d4cd3974414a 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -48,13 +48,16 @@ static void tls_toe_sk_destruct(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx = tls_get_ctx(sk);
 
+	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
+
 	ctx->sk_destruct(sk);
 	/* Free ctx */
 	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
 	tls_ctx_free(sk, ctx);
 }
 
-int tls_toe_bypass(struct sock *sk)
+int tls_toe_bypass(struct sock *sk,
+		   struct tls_proto *proto)
 {
 	struct tls_toe_device *dev;
 	struct tls_context *ctx;
@@ -63,7 +66,7 @@ int tls_toe_bypass(struct sock *sk)
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->feature && dev->feature(dev)) {
-			ctx = tls_ctx_create(sk);
+			ctx = tls_ctx_create(sk, proto);
 			if (!ctx)
 				goto out;
 
-- 
2.53.0

