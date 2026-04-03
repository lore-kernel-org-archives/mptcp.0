Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CB39FCD1
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227966; cv=none; b=fYTp8EqsM4CZ1y1Ghrobv1F+OygeeHtzi7TL2A3HvM82F3T9foFuSxEyXSP7Dn3PqtFMOPdDUZP1vbTJzN9xLMEm/RkdcAO/oJ8Pn48W1kp9ZmFsAVvWHRA3G8/ohHHlUCoKxchFHDG9KPpn3tli6QsxAFY6lCw0SNeiHHcrIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227966; c=relaxed/simple;
	bh=tcnhml0a9fsJcAAITiuQS5950vUoztt3/6rUYFkdkko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CedWzn+nOKU8gSASqFUb7gRu0tTbYQu9qkNOnsG6l9hkbYuz71c2OxuZaUuFmgfWtPlVi7uswZIwqLYHMlYUZLolVFkwtLtM2WHRXAhGiLJ1YtSFppdcMg5+QUa5BC0qaOZxcRn76OP8dPtHT3+BqvukImlbEfC1pxCQqnT8rtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfWqNCOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfWqNCOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E532CC4CEF7;
	Fri,  3 Apr 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227965;
	bh=tcnhml0a9fsJcAAITiuQS5950vUoztt3/6rUYFkdkko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfWqNCOwkTsx2nYCt4sCXbFhljfq9wlEu45sI1qQS9tDwsdhndEff7OIpoDw7pKQc
	 d4ITf2/MbU5nIZc4QwWRY/HKUO+FioONeMyB29q2fZeHSDJ7JAF284ANEyZ4Qce0a+
	 pbAQqViA8b8MOGKHi8Vf7ZS//NfZvkja/D4ll4Ef4Ml5L/hLlKtDjupB9UUXUWnSe/
	 NVuwzOAoYjB52UiPIQdTpQ76++XOtnk4/H2h0ahinfCoIFo311qTBy61fI+FQcmo3X
	 cpGQmIkhwNg0LMt8twmFLAvoyAkObxByXznkuc1qgE9HySIsK29+ZUjJsjVGn2/HgI
	 S80ARKPEiP28w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 01/16] tls: add per-protocol cache to support mptcp
Date: Fri,  3 Apr 2026 22:51:19 +0800
Message-ID: <df134ebfe84dbf3bdf0ea8ee54f50e34c070981f.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h  |  1 +
 net/tls/tls.h      |  3 +-
 net/tls/tls_main.c | 91 +++++++++++++++++++++++++++++-----------------
 3 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..fbd3979d718b 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -255,6 +255,7 @@ struct tls_context {
 
 	/* cache cold stuff */
 	struct proto *sk_proto;
+	struct tls_proto *proto;
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
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
index fd39acf41a61..7ee76e60a15e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -119,23 +119,27 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_128, tls12_crypto_info_aria_gcm_128);
 CHECK_CIPHER_DESC(TLS_CIPHER_ARIA_GCM_256, tls12_crypto_info_aria_gcm_256);
 
-static const struct proto *saved_tcpv6_prot;
-static DEFINE_MUTEX(tcpv6_prot_mutex);
-static const struct proto *saved_tcpv4_prot;
-static DEFINE_MUTEX(tcpv4_prot_mutex);
-static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
-static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+struct tls_proto {
+	struct list_head list;
+	const struct proto *prot;
+	struct proto prots[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+	struct proto_ops proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CONFIG];
+};
+static LIST_HEAD(tls_proto_list);
+static DEFINE_MUTEX(tls_proto_mutex);
+
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
 void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+	struct tls_proto *proto = ctx->proto;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -910,7 +914,8 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +926,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,35 +974,49 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static struct tls_proto *tls_proto_find(const struct proto *prot)
+{
+	struct tls_proto *proto;
+
+	list_for_each_entry(proto, &tls_proto_list, list) {
+		if (proto->prot == prot)
+			return proto;
+	}
+	return NULL;
+}
+
+static struct tls_proto *tls_build_proto(struct sock *sk)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
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
 	}
 
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
+	proto = kzalloc(sizeof(*proto), GFP_KERNEL);
+	if (!proto) {
+		mutex_unlock(&tls_proto_mutex);
+		return NULL;
 	}
+
+	proto->prot = prot;
+	build_protos(proto->prots[ip_ver], prot);
+	build_proto_ops(proto->proto_ops[ip_ver],
+			sk->sk_socket->ops);
+	list_add(&proto->list, &tls_proto_list);
+	mutex_unlock(&tls_proto_mutex);
+
+	return proto;
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,10 +1066,13 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
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
@@ -1067,7 +1090,7 @@ static int tls_init(struct sock *sk)
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, proto);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
-- 
2.51.0

