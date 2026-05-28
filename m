Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAD390CBE
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960449; cv=none; b=p4zWQPAuE1sTw4/oYjOR1M51lbPu8+5+nIeCtkVyvAw+/GMIKQxIPoXst6KjYUXoGH3BqUVCFZ57oXCXKcbWgaKhhDUd/knzjR6xWvak0R/QW0Pcj6V0tJt14hf0tgkuwEQO6CEP3+ImE4EC5bVS74p87NeMB3OZWa/xcfxezaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960449; c=relaxed/simple;
	bh=6nX6SJToyNKmEUrZFGmCPsbJrhIG0LjnaRKHVSYGxJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNHJSMxCrUMEyBCEAnYBbuLxi9M1CymG5uoY70xcfqff8Uc1iycW+m/4FBTc98n/HbmzGGMwqKkOhCTeO3CdscJzo7KJIOMEqEd9+IR9lDYYT1/O1NxiPOPilXmVkd1dua+SHBvXnA6H93J5Bj8J50DBu/j57JS0N8GQqVQLJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoijBE4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoijBE4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B341F00A3A;
	Thu, 28 May 2026 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960446;
	bh=+UZQJ9J/7I0LG7y1qkdwM3mNF4ONn+jRy1AoQn0X/v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoijBE4iyTP6QlTl9gtGCAhAnl2K9SfhFhlqMKtAKn3nILsG61vOwJIO74nMC6Hf5
	 kMnQz5fTbPGWYDt8+Z4rOXLfL8hkmYD9caL7M+nR7DzxuCiiur19hm2uqKCWPErvmN
	 NeiakNMbe9be8RBG7WLgqkLZ1WX4y1oFs9D2t8xDuw6fSPw57R1JhKmuu0uJ4yRpuW
	 b5D2Y5+pKs2Taof8K1sKxLyPkJ0tSFfJjA/RDmwk+Kggz8s0YPyDsx2xZItp4tuUcQ
	 h4dqzYNfScxiQdsUeAVaAqksD+OJb5/YdT3oVzQIICk5illoHdboUFagbzMLrAoLtN
	 gpzUKAJLUwQ0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 02/18] tls: add prot parameter to tls_ctx_create
Date: Thu, 28 May 2026 17:26:53 +0800
Message-ID: <05c29605c2c31008e99b3645241fdaf9d2e2d3bb.1779959644.git.tanggeliang@kylinos.cn>
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

Add a struct tls_prot *prot parameter to tls_ctx_create() and
tls_toe_bypass(), and store the pointer in tls_context. This allows
protocol-specific TLS operation tables (e.g., for MPTCP) to be passed
down.

Also add WRITE_ONCE(sk->sk_prot, ctx->sk_proto) in tls_toe_sk_destruct()
to restore the original socket protocol before freeing the TLS context.
This is necessary because the socket may have been switched to a TLS
protocol variant; on destruction we must revert it to avoid use-after-free
or stale function pointers..

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls_toe.h | 2 +-
 net/tls/tls.h         | 2 +-
 net/tls/tls_main.c    | 7 ++++---
 net/tls/tls_toe.c     | 6 ++++--
 4 files changed, 10 insertions(+), 7 deletions(-)

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
index e87e298ebd85..0778e2dc9f53 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -964,7 +964,7 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+struct tls_context *tls_ctx_create(struct sock *sk, struct tls_prot *prot)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
@@ -975,6 +975,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	ctx->prot = prot;
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
@@ -1108,7 +1109,7 @@ static int tls_init(struct sock *sk)
 		return -ENOMEM;
 
 #ifdef CONFIG_TLS_TOE
-	if (tls_toe_bypass(sk))
+	if (tls_toe_bypass(sk, prot))
 		return 0;
 #endif
 
@@ -1125,7 +1126,7 @@ static int tls_init(struct sock *sk)
 
 	/* allocate tls context */
 	write_lock_bh(&sk->sk_callback_lock);
-	ctx = tls_ctx_create(sk);
+	ctx = tls_ctx_create(sk, prot);
 	if (!ctx) {
 		tls_prot_put(prot);
 		rc = -ENOMEM;
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

