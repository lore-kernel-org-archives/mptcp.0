Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832E4D09E4
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968394; cv=none; b=MIicFhJsPlz+ZjMxF/QVbs3+tUa2iX0Kf7G0xBeowazPf9wunHtVzZZCQnH0XFebTqClsOp1zRjqShJJ+T++/rLq8iACXWd6nVsDu075D2c0XxJZFo2UJDxoFkKclknkXb5XK2bcxuj6L7/ohuEOBejt+KvHrxU2ufpv7QdGy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968394; c=relaxed/simple;
	bh=pV2EFKrhwH3ccCz0jbg2t/PlG8SRvN9O99MOWFt+Mg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c05/E8CL44ADn63qyO/CBUSF/ZoRjptJmIKpu7+5YdC5X3hypiM3yBybr7GoMXYTiwDVa0auL04UogRODySGAGs8VAzOIh8l9Ez1She27RGUkmYyXJx6645gHNruo0rq//dNrZX0m6ptaBZO3NYSOQzGp41f++H5OsFlsW/k5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdBd/pcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdBd/pcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB371F00893;
	Wed, 14 Oct 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968383;
	bh=qaU+1pPTN8tFI7Dg4CDmANYdYcJYA8PQKztjnHUkRfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdBd/pcfFSOrw7W5QzCj2iy1yPbudMLF8NuotPnmaxoEaYrw8WIGdY3dYUI1YQUgq
	 Q40p3kIst+6IVdueTvk0zdxva+A5/aIkdQ4URdrs429ZfIZSK371kre2Senjh4pwHo
	 ZiL9ml8xz+FnWuA08T6zgbP/XtDVU8VCxnZw/ZpoKu/5svEA7g7/0Kus3NYRVDwMu1
	 4BcnALdbIDp+8LFdaCVcf4aGQzOCvVjsIHNxYI01DNwnxS7/WTXyldzwzDrkZJE3UY
	 jOclVy4tyBM9VvChqzyJS5gAbGDCy/istxNI90sB01htATKMy7ADc6o7p49tiYtG4k
	 To3Ilvwh3Zysg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] tls: implement tls_disconnect
Date: Wed, 14 Oct 2026 16:59:35 +0800
Message-ID: <6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791967771.git.tanggeliang@kylinos.cn>
References: <cover.1791967771.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement disconnect support for TLS sockets via connect(AF_UNSPEC).
The handler invokes the underlying disconnect() first, then on success
cancels TX work (for TLS_SW), calls tls_sk_proto_free() to restore
original protocol operations and clear TLS state, cleans up RX context
and frees the TLS context. RX context uses kfree(), TLS context uses
kfree_rcu() for RCU safety.

tls_sk_proto_free() restores sk_prot, sk_socket->ops, sk_write_space,
and sk_destruct to their original values, clears icsk_ulp_data and
icsk_ulp_ops when free_ctx is true, and frees the TX sub-context. The
RX context and main TLS context are freed separately by tls_disconnect().

Add sk_proto_ops field to tls_context to save the original sk_socket->ops.
Unlike close() where the socket is destroyed, disconnect leaves the
socket alive for potential reconnection. sk_prot and sk_socket->ops are
restored inside tls_sk_proto_free() to prevent NULL pointer dereference
from concurrent poll/read/splice operations that dispatch through
sk_socket->ops.

After releasing the socket lock to cancel TX work, re-check the context
pointer to handle concurrent close(). Clear icsk_ulp_ops when freeing the
context to prevent tcp_set_ulp from failing with -EEXIST on reconnection.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  12 +++--
 net/tls/tls_main.c | 112 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..25ad76df97cb 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -193,6 +193,10 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
+	/* tls_disconnect() is in progress, prevent concurrent close() from
+	 * freeing resources while disconnect is using them.
+	 */
+	TLS_DISCONNECTING = 3,
 };
 
 struct cipher_context {
@@ -259,6 +263,7 @@ struct tls_context {
 
 	/* cache cold stuff */
 	struct proto *sk_proto;
+	const struct proto_ops *sk_proto_ops;
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
@@ -374,10 +379,11 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	/* Use RCU on icsk_ulp_data only for sock diag code,
-	 * TLS data path doesn't need rcu_dereference().
+	/* Use rcu_access_pointer() to safely read icsk_ulp_data,
+	 * as it can be cleared concurrently by tls_disconnect()
+	 * or tls_sk_proto_close().
 	 */
-	return (__force void *)icsk->icsk_ulp_data;
+	return (__force void *)rcu_access_pointer(icsk->icsk_ulp_data);
 }
 
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8bdb78718a8d..d00e56af628a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -358,32 +358,71 @@ static void tls_sk_proto_cleanup(struct sock *sk,
 	}
 }
 
-static void tls_sk_proto_close(struct sock *sk, long timeout)
+static void tls_sk_proto_free(struct sock *sk,
+			      struct tls_context *ctx,
+			      bool free_ctx)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct tls_context *ctx = tls_get_ctx(sk);
 	long timeo = sock_sndtimeo(sk, 0);
-	bool free_ctx;
-
-	if (ctx->tx_conf == TLS_SW)
-		tls_sw_cancel_work_tx(ctx);
-
-	lock_sock(sk);
-	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
 
 	if (ctx->tx_conf != TLS_BASE || ctx->rx_conf != TLS_BASE)
 		tls_sk_proto_cleanup(sk, ctx, timeo);
 
 	write_lock_bh(&sk->sk_callback_lock);
-	if (free_ctx)
-		rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
 	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
+	if (sk->sk_socket)
+		WRITE_ONCE(sk->sk_socket->ops, ctx->sk_proto_ops);
 	if (sk->sk_write_space == tls_write_space)
 		sk->sk_write_space = ctx->sk_write_space;
+	if (sk->sk_destruct == tls_device_sk_destruct)
+		sk->sk_destruct = ctx->sk_destruct;
+	if (free_ctx) {
+		rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
+		if (icsk->icsk_ulp_ops) {
+			/* Balance try_module_get in __tcp_ulp_find_autoload */
+			module_put(icsk->icsk_ulp_ops->owner);
+			icsk->icsk_ulp_ops = NULL;
+		}
+	}
 	write_unlock_bh(&sk->sk_callback_lock);
-	release_sock(sk);
 	if (ctx->tx_conf == TLS_SW)
 		tls_sw_free_ctx_tx(ctx);
+}
+
+static void tls_sk_proto_close(struct sock *sk, long timeout)
+{
+	struct tls_context *ctx;
+	bool free_ctx;
+
+	ctx = tls_get_ctx(sk);
+	if (!ctx) {
+		sk->sk_prot->close(sk, timeout);
+		return;
+	}
+
+	if (ctx->tx_conf == TLS_SW)
+		tls_sw_cancel_work_tx(ctx);
+
+	lock_sock(sk);
+	/* Re-read ctx under lock, as it may have been cleared by disconnect */
+	ctx = tls_get_ctx(sk);
+	if (!ctx) {
+		release_sock(sk);
+		sk->sk_prot->close(sk, timeout);
+		return;
+	}
+
+	/* Check if disconnect is in progress after acquiring lock */
+	if (test_bit(TLS_DISCONNECTING, &ctx->flags)) {
+		release_sock(sk);
+		ctx->sk_proto->close(sk, timeout);
+		return;
+	}
+
+	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
+	tls_sk_proto_free(sk, ctx, free_ctx);
+	release_sock(sk);
+
 	if (ctx->rx_conf == TLS_SW || ctx->rx_conf == TLS_HW)
 		tls_sw_strparser_done(ctx);
 	if (ctx->rx_conf == TLS_SW)
@@ -904,7 +943,52 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 
 static int tls_disconnect(struct sock *sk, int flags)
 {
-	return -EOPNOTSUPP;
+	struct tls_context *ctx;
+	bool free_ctx;
+	int rc;
+
+	ctx = tls_get_ctx(sk);
+	if (!ctx)
+		return 0;
+
+	if (!ctx->sk_proto->disconnect)
+		return -EOPNOTSUPP;
+
+	set_bit(TLS_DISCONNECTING, &ctx->flags);
+
+	rc = ctx->sk_proto->disconnect(sk, flags);
+	if (rc) {
+		clear_bit(TLS_DISCONNECTING, &ctx->flags);
+		return rc;
+	}
+
+	if (ctx->tx_conf == TLS_SW) {
+		struct tls_sw_context_tx *sw_ctx_tx = tls_sw_ctx_tx(ctx);
+
+		set_bit(BIT_TX_CLOSING, &sw_ctx_tx->tx_bitmask);
+		set_bit(BIT_TX_SCHEDULED, &sw_ctx_tx->tx_bitmask);
+
+		release_sock(sk);
+		disable_delayed_work_sync(&sw_ctx_tx->tx_work.work);
+		lock_sock(sk);
+	}
+
+	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
+	tls_sk_proto_free(sk, ctx, free_ctx);
+
+	if (ctx->rx_conf == TLS_SW) {
+		struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
+
+		release_sock(sk);
+		tls_strp_done(&sw_ctx->strp);
+		tls_sw_free_ctx_rx(ctx);
+		lock_sock(sk);
+	}
+
+	if (free_ctx)
+		tls_ctx_free(sk, ctx);
+
+	return 0;
 }
 
 struct tls_context *tls_ctx_create(struct sock *sk)
@@ -918,6 +1002,8 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 
 	mutex_init(&ctx->tx_lock);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
+	if (sk->sk_socket)
+		ctx->sk_proto_ops = READ_ONCE(sk->sk_socket->ops);
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
 	 * ctx->sk_proto is visible before changing sk->sk_prot in
-- 
2.55.0

