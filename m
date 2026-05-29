Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604262E7384
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053265; cv=none; b=fLdJJj7KSsGRWCfCInFQDRHoLxKDmrSXKfSerIvM9krwH1y7/5xIc3ErBjHIcYHkinTAX34AeuGW1K7m9t6wiRQWhoh+3POEU2ZinhkjP/IwIK9n2fX/NMZkiO14H0pwRph6TBML0EEHLGD7WO8/9tLL33kyww5NVLnjma4IOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053265; c=relaxed/simple;
	bh=SSMXDGbZCoDbYyyST7bczri5n98h7tiuS8ZBXRNpC/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORN4XCjlvjDxUb4N0lgVruWRFo2O2B8GaMSZlQ7b4xZk9+u1hDGtvacVj2tcMyilQ3d6Eeb2O+atqiYCtGQLFnqNgZHz/Ev0+8dbwafgEoDVLEyCBX0taTg5Awn/K4OoqM5uCtW5HJs+CAdsXNnr+xTjJhmPFXI5rDwNkkgNAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUBBDoX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUBBDoX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0441F00898;
	Fri, 29 May 2026 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053263;
	bh=QSjauhyI5bZJ3xN2qC1c6qqEg9tbCDdC4EPA9p2j9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QUBBDoX2TcM2jvbEAXsYw7ki+3HhbT5CA+eN0pda6ou7fJCeyAzwjfU8w9Q53ASAP
	 fL+j/8gxLegrtQwVhj3J8KTU6/la4pR0GKSMagScrMn1fU7EpkTbERe0rGoAivTGpI
	 q3fZ1D+Ahbj0sb57qI1F02M/DU6S2hbmTkFSv45O+xA3I5t0i/PWJbcg/InfpVE8aN
	 VrWQ7yHV1FJJb5nHbbxqXxroMJOl3HAZFCSk3W/zbkqzxbssBbXcAuAFN7d9PqqSEc
	 JE8/eWABvrnLgGIUuHVHfPeWUO+tQEUGBCOVxSLpCZJTJO5NdLVgG8ygDyIbAk75Qa
	 aP5Ug1D+LNWZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 05/20] tls: add per-protocol cache for MPTCP support
Date: Fri, 29 May 2026 19:13:47 +0800
Message-ID: <32ce386e58606ecda19a84319f9a0795c98dc796.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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

Also add WRITE_ONCE(sk->sk_prot, ctx->sk_proto) in tls_toe_sk_destruct()
to restore the original socket protocol before freeing the TLS context.
This is necessary because the socket may have been switched to a TLS
protocol variant; on destruction we must revert it to avoid use-after-free
or stale function pointers.

Add smp_rmb() barriers in tls_sk_poll() and tls_sw_sock_is_readable()
to ensure proper ordering when reading the TLS context. These pair with
the smp_store_release() in update_sk_prot().

Also add a NULL check for tls_ctx in tls_sw_sock_is_readable() to safely
return false when the context is not yet initialized.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h     |  12 ++++
 include/net/tls_toe.h |   2 +-
 net/tls/tls.h         |   2 +-
 net/tls/tls_main.c    | 158 +++++++++++++++++++++++++++++++-----------
 net/tls/tls_sw.c      |  18 ++++-
 net/tls/tls_toe.c     |   6 +-
 6 files changed, 151 insertions(+), 47 deletions(-)

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
index 8809b056290a..cdf0fb05fc99 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,66 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
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
 
-	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
-	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+	/* Ensure sk->sk_prot is not visible before icsk_ulp_data.
+	 * Pairs with the rcu_assign_pointer() release in tls_ctx_create()
+	 * and with smp_rmb() in tls_sw_sock_is_readable().
+	 */
+	smp_store_release(&sk->sk_prot,
+			  &prot->prots[ctx->tx_conf][ctx->rx_conf]);
+	/* Ensure sk->sk_socket->ops is not visible before icsk_ulp_data.
+	 * Pairs with smp_rmb() in tls_sk_poll().
+	 */
+	smp_store_release(&sk->sk_socket->ops,
+			  &prot->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -314,6 +357,16 @@ static void tls_write_space(struct sock *sk)
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
@@ -327,6 +380,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
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
@@ -409,6 +467,14 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
+	/* Paired with smp_store_release() in update_sk_prot().
+	 * Orders the read of tls_ctx (icsk_ulp_data) to ensure
+	 * we see a fully initialized context after the new socket
+	 * operations are installed. Without this barrier, we might
+	 * observe a stale or NULL tls_ctx.
+	 */
+	smp_rmb();
+
 	mask = tcp_poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
@@ -910,7 +976,7 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk, struct tls_prot *prot)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +987,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->prot = prot;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -971,35 +1038,37 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
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
+	if (!sk->sk_socket)
+		return NULL;
+
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
@@ -1054,10 +1123,13 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
 static int tls_init(struct sock *sk)
 {
+	struct tls_prot *prot;
 	struct tls_context *ctx;
 	int rc = 0;
 
-	tls_build_proto(sk);
+	prot = tls_build_proto(sk);
+	if (!prot)
+		return -ENOMEM;
 
 	/* The TLS ulp is currently supported only for TCP sockets
 	 * in ESTABLISHED state.
@@ -1065,18 +1137,21 @@ static int tls_init(struct sock *sk)
 	 * to modify the accept implementation to clone rather then
 	 * share the ulp context.
 	 */
-	if (sk->sk_state != TCP_ESTABLISHED)
+	if (sk->sk_state != TCP_ESTABLISHED) {
+		tls_prot_put(prot);
 		return -ENOTCONN;
+	}
 
 #ifdef CONFIG_TLS_TOE
-	if (tls_toe_bypass(sk))
+	if (tls_toe_bypass(sk, prot))
 		return 0;
 #endif
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, prot);
 	if (!ctx) {
+		tls_prot_put(prot);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -1280,6 +1355,7 @@ static int __init tls_register(void)
 static void __exit tls_unregister(void)
 {
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
+	tls_prot_cleanup();
 	tls_strp_dev_exit();
 	tls_device_cleanup();
 	unregister_pernet_subsys(&tls_proc_ops);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..8c5eeb92d017 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2450,11 +2450,25 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 bool tls_sw_sock_is_readable(struct sock *sk)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_sw_context_rx *ctx;
+	struct tls_context *tls_ctx;
 	bool ingress_empty = true;
 	struct sk_psock *psock;
 
+	/* Paired with smp_store_release() in update_sk_prot()
+	 * for sk->sk_prot. Orders the read of icsk_ulp_data
+	 * after the read of sk->sk_prot in sk_is_readable().
+	 * Prevents seeing a new sk->sk_prot but a stale
+	 * icsk_ulp_data.
+	 */
+	smp_rmb();
+
+	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx)
+		return false;
+
+	ctx = tls_sw_ctx_rx(tls_ctx);
+
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock)
diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..e92853c106da 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -48,13 +48,15 @@ static void tls_toe_sk_destruct(struct sock *sk)
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
+int tls_toe_bypass(struct sock *sk, struct tls_prot *prot)
 {
 	struct tls_toe_device *dev;
 	struct tls_context *ctx;
@@ -63,7 +65,7 @@ int tls_toe_bypass(struct sock *sk)
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->feature && dev->feature(dev)) {
-			ctx = tls_ctx_create(sk);
+			ctx = tls_ctx_create(sk, prot);
 			if (!ctx)
 				goto out;
 
-- 
2.53.0

