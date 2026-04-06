Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C0883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477998; cv=none; b=OYsCXsW3YNElfK9f+ojxeVEX/NNxPmnpE8PHvlJlDw5g1YmqXujhryT0rc2IqfTIvzjefLlItSaRPnIW5RWY+fhcN0+X8aTldlFPr0fDdi9YUkimiwpoSNLSqFXlIaUge/qmJvJ9RqjPtLrpIIJtWClTV1Xi2CUbRy9V2PcbtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477998; c=relaxed/simple;
	bh=3FbhYextoWUp01aEfeOg8ynRfpdvuWDaQX56FbEz8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHOSisG9N7YIqTP65ATMm2nbgVIpnt3A8lkxnCoXU5ltndE8Jon9SDY8sFU4/MEjy+5zAAdvkXSPJHymtKOf+/yko6waXJ1TzUFSQWUCPzaNz/mDXsSiWISEdtxCgHsqf6KOUhNpxi4WAaTdhMwHrKABAmonwLRHFKg3O/lKg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXhfNzsO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXhfNzsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2760C2BCB0;
	Mon,  6 Apr 2026 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775477998;
	bh=3FbhYextoWUp01aEfeOg8ynRfpdvuWDaQX56FbEz8OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXhfNzsO5LDh8d+H/fTym6m9tWpmwKGhcCHHsv4leTt9acLdt25fAVX7GgdWEps8B
	 JYujLp5W06fwVnXyAQqS1TmhpRYKsetbzZ3emK3hhidq3k1Sb3eaejmB/PMTHVdmPA
	 TVVctKYdBmOJAS5HUXyhmsxm51YXezSlRJdb9PVRYfd+ZM2WQSxDMCo6IUR3osV5n3
	 F0OTO5v5gkOiuvvkrcuxnti3yK39qZdQNPoAAqU6dJhpM+C67xdFvBkXaE+rddQjCT
	 apeAmzxzmx1+s8J1Q93/z7VRXHzEEu1+OEbBjT1eHPiKt7FpzHjY+NIcIbOXWMbGku
	 X8mE/nfj8PmPw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 01/15] tls: add per-protocol cache to support mptcp
Date: Mon,  6 Apr 2026 20:18:41 +0800
Message-ID: <33b91ada6e91762026ddd59fc5c26f0049f37164.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  |  10 +++++
 net/tls/tls.h      |   3 +-
 net/tls/tls_main.c | 105 +++++++++++++++++++++++++++------------------
 3 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..f65604270932 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -220,6 +220,14 @@ struct tls_prot_info {
 	u16 tail_size;
 };
 
+struct tls_proto {
+	struct rcu_head			rcu;
+	struct list_head		list;
+	const struct proto		*prot;
+	struct proto prots[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+	struct proto_ops proto_ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+};
+
 struct tls_context {
 	/* read-only cache line */
 	struct tls_prot_info prot_info;
@@ -257,6 +265,8 @@ struct tls_context {
 	struct proto *sk_proto;
 	struct sock *sk;
 
+	struct tls_proto *proto;
+
 	void (*sk_destruct)(struct sock *sk);
 
 	union tls_crypto_context crypto_send;
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
index fd39acf41a61..8cd12614a12b 100644
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
@@ -119,23 +113,19 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
-static const struct proto *saved_tcpv6_prot;
-static DEFINE_MUTEX(tcpv6_prot_mutex);
-static const struct proto *saved_tcpv4_prot;
-static DEFINE_MUTEX(tcpv4_prot_mutex);
-static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
-static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+static LIST_HEAD(tls_proto_list);
+static DEFINE_MUTEX(tls_proto_mutex);
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
-	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+	struct tls_proto *proto = ctx->proto;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->prots[ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -910,7 +900,8 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +912,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,37 +960,64 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_proto *tls_proto_find(const struct proto *prot)
 {
-	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
-	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_proto *proto, *ret = NULL;
 
-	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
-	if (ip_ver == TLSV6 &&
-	    unlikely(prot != smp_load_acquire(&saved_tcpv6_prot))) {
-		mutex_lock(&tcpv6_prot_mutex);
-		if (likely(prot != saved_tcpv6_prot)) {
-			build_protos(tls_prots[TLSV6], prot);
-			build_proto_ops(tls_proto_ops[TLSV6],
-					sk->sk_socket->ops);
-			smp_store_release(&saved_tcpv6_prot, prot);
+	rcu_read_lock();
+	list_for_each_entry_rcu(proto, &tls_proto_list, list) {
+		if (proto->prot == prot) {
+			ret = proto;
+			break;
 		}
-		mutex_unlock(&tcpv6_prot_mutex);
 	}
+	rcu_read_unlock();
+	return ret;
+}
 
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
+static void tls_proto_cleanup(void)
+{
+	struct tls_proto *prot, *tmp;
+
+	list_for_each_entry_safe(prot, tmp, &tls_proto_list, list) {
+		list_del_rcu(&prot->list);
+		kfree_rcu(prot, rcu);
 	}
 }
 
+static struct tls_proto *tls_build_proto(struct sock *sk)
+{
+	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct tls_proto *proto;
+
+	proto = tls_proto_find(prot);
+	if (proto)
+		return proto;
+
+	mutex_lock(&tls_proto_mutex);
+	/* Re-check under lock */
+	proto = tls_proto_find(prot);
+	if (proto) {
+		mutex_unlock(&tls_proto_mutex);
+		return proto;
+	}
+
+	proto = kzalloc(sizeof(*proto), GFP_KERNEL);
+	if (!proto) {
+		mutex_unlock(&tls_proto_mutex);
+		return NULL;
+	}
+
+	proto->prot = prot;
+	build_protos(proto->prots, prot);
+	build_proto_ops(proto->proto_ops,
+			sk->sk_socket->ops);
+	list_add_rcu(&proto->list, &tls_proto_list);
+	mutex_unlock(&tls_proto_mutex);
+
+	return proto;
+}
+
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base)
 {
@@ -1046,10 +1065,13 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
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
 	if (tls_toe_bypass(sk))
@@ -1067,7 +1089,7 @@ static int tls_init(struct sock *sk)
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, proto);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
@@ -1264,6 +1286,7 @@ static int __init tls_register(void)
 
 static void __exit tls_unregister(void)
 {
+	tls_proto_cleanup();
 	tcp_unregister_ulp(&tcp_tls_ulp_ops);
 	tls_strp_dev_exit();
 	tls_device_cleanup();
-- 
2.51.0

