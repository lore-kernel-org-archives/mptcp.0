Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B534DB6D
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469702; cv=none; b=kOf9MkfYWV7RDaqPPNi7jL6Yq9Rv64nFRakqeugPEPKrexS/sftKXYYoTSNemaowe3bmY5hQJUbL4vXp0UuO0qCxjAA0SYRNeYT3txSKJRdwJt0Z/b+2HClMy+jyfxNx3oQSDpfXAftw5J6Wl0U+iPJu6sdPirFM1ZhMN8gT1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469702; c=relaxed/simple;
	bh=50ia+68fzV0DZXMHDK4jzmnCLZprcI7EoCgCZ0/k3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB0RwgC30tFLYX951vcdLUc+DaX+m9Pia5u9CNp8/BbgNsVjgERSD4G8KFgEb41HuXcZvD8XXRsDMDBb3ztn1kpG1t8cl+ZVtg3LfqPPZ5KwjZ92G5F0wVdCqKYr3GD1AHqHYKyrZAa7ULxZE512ioMB96l7KOFMNIyNE5nTKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeUzowsZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeUzowsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0948C2BCB3;
	Fri, 17 Apr 2026 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469701;
	bh=50ia+68fzV0DZXMHDK4jzmnCLZprcI7EoCgCZ0/k3z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeUzowsZVKO3TpEWFjDIByct0ZvkO54mE8jEfwE2TCL6kusmAOfsf482UxoeVueBg
	 eRGbfGdvaI6F/mCPIDvRa4Y38zv9D6XKc49Gj1qkdKaomYi5XfeD8TWMRh2fpJDQIM
	 tw6idqMOjGftcC8XEscaAbfdxp/cuzfg6Myb36Yx96/bmNh9AuQYWolw/HJlmDXd1e
	 uHKNM5IP6aub0fisGNVBHZXyYynzRTO7EuZPA1VB97V5QRp9u2wkXWZc/BAQejI1st
	 PrUWO71l9bBF1xZ1hXhf5WlJ3fsG5azbYB6Mvn5/fXyRlg9f7BDGl+j7Vf8Q+jU3Mp
	 WJf1ALRCZfHBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 01/15] tls: add per-protocol cache to support mptcp
Date: Sat, 18 Apr 2026 07:47:40 +0800
Message-ID: <9723c2d0f8b059c9d295545983920a9c428cf3db.1776469068.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
 include/net/tls.h     |  10 ++++
 include/net/tls_toe.h |   3 +-
 net/tls/tls.h         |   3 +-
 net/tls/tls_main.c    | 112 ++++++++++++++++++++++++++----------------
 net/tls/tls_toe.c     |   5 +-
 5 files changed, 87 insertions(+), 46 deletions(-)

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
index fd39acf41a61..b7d59448b0a8 100644
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
@@ -119,23 +113,22 @@ CHECK_CIPHER_DESC(TLS_CIPHER_SM4_CCM, tls12_crypto_info_sm4_ccm);
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
+
+	if (!proto)
+		return;
 
 	WRITE_ONCE(sk->sk_prot,
-		   &tls_prots[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->prots[ctx->tx_conf][ctx->rx_conf]);
 	WRITE_ONCE(sk->sk_socket->ops,
-		   &tls_proto_ops[ip_ver][ctx->tx_conf][ctx->rx_conf]);
+		   &proto->proto_ops[ctx->tx_conf][ctx->rx_conf]);
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -910,7 +903,8 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk,
+				   struct tls_proto *proto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -921,6 +915,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->proto = proto;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -968,35 +963,64 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
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
+	mutex_lock(&tls_proto_mutex);
+	list_for_each_entry_safe(prot, tmp, &tls_proto_list, list) {
+		list_del_rcu(&prot->list);
+		kfree_rcu(prot, rcu);
 	}
+	mutex_unlock(&tls_proto_mutex);
+}
+
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
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
@@ -1046,13 +1070,16 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 
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
 
@@ -1067,7 +1094,7 @@ static int tls_init(struct sock *sk)
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, proto);
 	if (!ctx) {
 		rc = -ENOMEM;
 		goto out;
@@ -1264,6 +1291,7 @@ static int __init tls_register(void)
 
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
2.51.0

