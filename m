Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050ED22689C
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459639; cv=none; b=fbDIH9v1OfXvXMe69mv1zHtGNY6eBfK975HFz1VrM1wiClzEjLdGbRGm9G7rn6dKuhIeXQys7D4MVcxtdHdKOLCCXzGK1418wQCZEeKMNInp+JveDm3GE1esIq7+m+WUZ2DOkGif0zkL0avdfPH9CjvcdrhbPZpDL9pl28xBSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459639; c=relaxed/simple;
	bh=Umf7dEr3O8paI001b/KBe22R/zAt3WcjGL/01HTIN/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ7LLoSCLS70PaHBxrQW2fmqVpkeXEjA2IclvXtsVUZgZ1B77IT9Y6BcX3sXmUvQCUR02SLwZ6hTx+oqIwsfwpjmF1F2QW/0spEHe2pHGvX0Uvv7CBBi638aEdWtS8LOuo0aTW85QcBOcBRPYBOE/Mhafcs7EJtdUF3oyALkjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE8Nzge3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE8Nzge3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1904DC2BCB3;
	Wed, 29 Apr 2026 10:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459638;
	bh=Umf7dEr3O8paI001b/KBe22R/zAt3WcjGL/01HTIN/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lE8Nzge3NYsPdGOSbFBDownzHq/ZdAdthfcDhTcBZZiKNKiyhBKESFVQUZf6IxhiT
	 sAST9NusPt13pgD+PDCOC3C01L/fwVPded7a/kA+v6QVcAMz/niKPNXjGpFTVTCXQG
	 QarfQ/0LD7N1hzy7gMJDt1hM9H4VHx+pxtjzfc4VCtq4ovI1Vrmcp3a4xKJ4MDFVmj
	 vcIr+28yZAU5jYi0rTNFzOGnUT8dFT8iH+eX0UPRJ0rtvrotT0sV/Dn6gSiJQ2pZJ0
	 CWZfeuh2w0tx5gtHxgaposSoGlAWkgs3JBeVqomvBjqffStqCsywZhNGtUa+Zdy2Wl
	 yXqiM+Qo/DB2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 01/15] tls: add per-protocol cache to support mptcp
Date: Wed, 29 Apr 2026 18:44:49 +0800
Message-ID: <8ad45d639a417dde664d86f8dae6711b20ee6b4d.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h     |  18 ++++++
 include/net/tls_toe.h |   3 +-
 net/tls/tls.h         |   3 +-
 net/tls/tls_main.c    | 144 +++++++++++++++++++++++++++++-------------
 net/tls/tls_toe.c     |   5 +-
 5 files changed, 126 insertions(+), 47 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..baedee91d648 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -81,6 +81,12 @@ struct tls_rec;
 #define TLS_AES_CCM_IV_B0_BYTE		2
 #define TLS_SM4_CCM_IV_B0_BYTE		2
 
+enum {
+	TLSV4,
+	TLSV6,
+	TLS_NUM_PROTS,
+};
+
 enum {
 	TLS_BASE,
 	TLS_SW,
@@ -220,6 +226,16 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_proto {
+	struct rcu_head			rcu;
+	refcount_t			refcnt;
+	struct list_head		list;
+	int				ip_ver;
+	const struct proto		*prot;
+	struct proto prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+	struct proto_ops proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
@@ -257,6 +273,8 @@ struct tls_context {
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
index e8f81a006520..c9e839642c31 100644
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
index fd39acf41a61..ade124a8731f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -52,12 +52,6 @@ MODULE_DESCRIPTION("Transport Layer Security Support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_TCP_ULP("tls");
 
-enum {
-	TLSV4,
-	TLSV6,
-	TLS_NUM_PROTS,
-};
-
 #define CHECK_CIPHER_DESC(cipher,ci)				\
 	static_assert(cipher ## _IV_SIZE <= TLS_MAX_IV_SIZE);		\
 	static_assert(cipher ## _SALT_SIZE <= TLS_MAX_SALT_SIZE);		\
@@ -119,23 +113,64 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
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
+	rcu_read_lock();
+	list_for_each_entry_rcu(proto, &tls_proto_list, list) {
+		if (proto->prot == prot && proto->ip_ver == ip_ver) {
+			if (refcount_inc_not_zero(&proto->refcnt))
+				ret = proto;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void tls_proto_free(struct rcu_head *rcu)
+{
+	struct tls_proto *proto = container_of(rcu,
+					       struct tls_proto,
+					       rcu);
+
+	kfree(proto);
+}
+
+static void tls_proto_cleanup(void)
+{
+	struct tls_proto *prot, *tmp;
+
+	spin_lock_bh(&tls_proto_lock);
+	list_for_each_entry_safe(prot, tmp, &tls_proto_list, list) {
+		list_del_rcu(&prot->list);
+		call_rcu(&prot->rcu, tls_proto_free);
+	}
+	spin_unlock_bh(&tls_proto_lock);
+
+	synchronize_rcu();
+	rcu_barrier();
+}
+
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+	struct tls_proto *proto = ctx->proto;
+
+	if (!proto)
+		return;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -314,6 +349,20 @@ static void tls_write_space(struct sock *sk)
 	ctx->sk_write_space(sk);
 }
 
+static bool tls_proto_put(struct tls_proto *proto)
+{
+	if (refcount_dec_and_test(&proto->refcnt)) {
+		spin_lock(&tls_proto_lock);
+		list_del_rcu(&proto->list);
+		spin_unlock(&tls_proto_lock);
+
+		call_rcu(&proto->rcu, tls_proto_free);
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * tls_ctx_free() - free TLS ULP context
  * @sk:  socket to with @ctx is attached
@@ -327,6 +376,9 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
 	if (!ctx)
 		return;
 
+	if (ctx->proto && tls_proto_put(ctx->proto))
+		ctx->proto = NULL;
+
 	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
 	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
 	mutex_destroy(&ctx->tx_lock);
@@ -910,7 +962,8 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +974,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,35 +1022,32 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
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
+	spin_lock_bh(&tls_proto_lock);
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
+	proto = kzalloc_obj(*proto, GFP_ATOMIC);
+	if (!proto)
+		goto out;
+
+	proto->ip_ver = ip_ver;
+	proto->prot = prot;
+	refcount_set(&proto->refcnt, 1);
+	build_protos(proto->prots[ip_ver], prot);
+	build_proto_ops(proto->proto_ops[ip_ver],
+			sk->sk_socket->ops);
+	list_add_rcu(&proto->list, &tls_proto_list);
+
+out:
+	spin_unlock_bh(&tls_proto_lock);
+	return proto;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,13 +1097,16 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
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
 
@@ -1062,13 +1116,16 @@ static int tls_init(struct sock *sk)
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
+		tls_proto_put(proto);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -1264,6 +1321,7 @@ static int __init tls_register(void)
 
 static void __exit tls_unregister(void)
 {
+	tls_proto_cleanup();
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..3c63f9b4c8af 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -54,7 +54,8 @@ static void tls_toe_sk_destruct(struct sock *sk)
 	tls_ctx_free(sk, ctx);
 }
 
-int tls_toe_bypass(struct sock *sk)
+int tls_toe_bypass(struct sock *sk,
+		   struct tls_proto *proto)
 {
 	struct tls_toe_device *dev;
 	struct tls_context *ctx;
@@ -63,7 +64,7 @@ int tls_toe_bypass(struct sock *sk)
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->feature && dev->feature(dev)) {
-			ctx = tls_ctx_create(sk);
+			ctx = tls_ctx_create(sk, proto);
 			if (!ctx)
 				goto out;
 
-- 
2.53.0

