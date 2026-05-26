Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E83D75B6
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788812; cv=none; b=OaPOwUycKO7fVQopAwRS5Atgd0cfMPWIuARI17OWGx3JAFF67YZBD+SM6IgdHfx68U3hRvM8C9QcXr/kOYxFFUwp4hFdsfIgQ1FrErbsROZVxTtjbiv9ULIa3/iSaIeHjEGXpx0vEOAMtmo/T053N3Obw7UpPRDhVUthPu2sc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788812; c=relaxed/simple;
	bh=CywEEnK57B3sBrH7kOnwUEB6lt8QLHAUP0Kx/KoojhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbobFbDebCvZjHBfBlwMoDYmbEpRxmyD8FJwcZlljh5DQdkxXUdRvnPq7G4t8FEgvWSr2tZlZfq+NEXOMVaqnLGxINInZdE9sHs+N0iVeD6LcER+WAWy89FScyVKaVmKbJ5obUEK6xjkRiT/Ogwy255MZ6xCBbyBfxoxxcqk7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L70Qh3+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L70Qh3+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD11F00A3A;
	Tue, 26 May 2026 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788808;
	bh=ovz43LSwj6d3nF8Mt26jElkJorLSFNqqx2G69JZ3W20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L70Qh3+QJgOo0NHOJ14UdH12n40KSVPAN0VTKojHPQMwO6RLAwp1BDiV5H5+z48/M
	 CkCQL31hFrkja8rRaqb8Wt1GcqqUf/DAKWllJbkNzeVbPokXLRea5NNkhSkb48u/o7
	 IszWeJV5fmF35TJoSPBYyXGAM2EZ4pzmrzxKpSrkGJI+xn3kbQA+kiEw6iJ4HsWtYC
	 P77Lj9O4WwPv3KeN9YxmfW3vIIttRCzq3Gd7CGrCRe2kch/V+uOc6P0U1fY6S1wrA1
	 Ds0exDZGcLsJiEdO1TKBMs7o5/r+29/Cj1fBkD0NjTWr7pU2mp23uV4UqHymqI6Ksv
	 LNlTQUT6LuOng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 01/15] tls: add per-protocol cache to support mptcp
Date: Tue, 26 May 2026 17:46:19 +0800
Message-ID: <a1e635491a73ddb08a2ef6521c6c1952a751c027.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h     |  12 ++++
 include/net/tls_toe.h |   3 +-
 net/tls/tls.h         |   3 +-
 net/tls/tls_main.c    | 137 ++++++++++++++++++++++++++++++------------
 net/tls/tls_toe.c     |   7 ++-
 5 files changed, 120 insertions(+), 42 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..65c4c2c72e06 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,16 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_proto {
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
index fd39acf41a61..30b50ea708ee 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,61 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
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
+		if (proto->prot == prot && proto->ip_ver == ip_ver &&
+		    refcount_inc_not_zero(&proto->refcnt)) {
+			ret = proto;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static void tls_proto_free(struct rcu_head *rcu)
+{
+	struct tls_proto *proto = container_of(rcu, struct tls_proto, rcu);
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
@@ -314,6 +352,16 @@ static void tls_write_space(struct sock *sk)
 	ctx->sk_write_space(sk);
 }
 
+static void tls_proto_put(struct tls_proto *proto)
+{
+	if (refcount_dec_and_test(&proto->refcnt)) {
+		spin_lock_bh(&tls_proto_lock);
+		list_del_rcu(&proto->list);
+		spin_unlock_bh(&tls_proto_lock);
+		call_rcu(&proto->rcu, tls_proto_free);
+	}
+}
+
 /**
  * tls_ctx_free() - free TLS ULP context
  * @sk:  socket to with @ctx is attached
@@ -327,6 +375,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
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
@@ -910,7 +963,8 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +975,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,35 +1023,34 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_proto *proto, *cache;
 
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
+	proto = kzalloc_obj(*proto, GFP_KERNEL);
+	if (!proto)
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
+	spin_lock_bh(&tls_proto_lock);
+	cache = tls_proto_find(prot, ip_ver);
+	if (cache) {
+		spin_unlock_bh(&tls_proto_lock);
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
+	list_add_rcu(&proto->list, &tls_proto_list);
+
+	spin_unlock_bh(&tls_proto_lock);
+	return proto;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,13 +1100,16 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
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
 
@@ -1062,13 +1119,16 @@ static int tls_init(struct sock *sk)
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
@@ -1265,6 +1325,7 @@ static int __init tls_register(void)
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

