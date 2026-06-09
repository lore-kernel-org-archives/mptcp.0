Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C572EA480
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971569; cv=none; b=GIXuRv7RkDp1bpEVOtLIcvG0XWOPwcTFYPh89iB97NklfkztYZcwj0EsgHXrr8Ur8PgGI9/LXfIgYw75DdlDIbYf8F04Io4kwnTa2mYEMBahLcXYGzdPdsTodvKUj4Qf6zGiPMaWwvOej0uPGuSnGt07ZIjTNdFtsRPCp8gXciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971569; c=relaxed/simple;
	bh=Vi6DGplYF22ZuD4RyEasfcJLV3CdVwD/U197egFGz8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR+rYtdrQeRIcaN1LQSBl9K1zlZWaGloMJTteG0I3Z0+M94xHTA0MEfCBdlNm+ONLFpvtzhfBjt3IbopukSEgwohD+WqaFI8zdijTLjKZz1GgHTmPzZIopxHT/eB3XZbYtvl00gipVLbSouBmy1QZvSlM/G+iksXnOjVDRPMTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9k8qi7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9k8qi7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95C31F00898;
	Tue,  9 Jun 2026 02:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971568;
	bh=e/po5YpBmyH1b0uSU8kV9evCGSArI7pRUYEE9NwQuFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T9k8qi7mawACB17qUdj6n6gxsJ5q3ztgkEyETRhixJxP+yQdnhJT7ZSARn6hVTvE6
	 8i89nmUPyrMdVky/rq683Euhlpff9w98wSs2259UjFYPfhzOEld5AbM2q0d+MHzYcV
	 tdEg/odDXhEeinvnqrnOWdy6wUC41mT/CAtQuAL4R/rfQ3KyKIrxvg2e5uceNUmMJQ
	 /GcaeOVawgw6YMcY+BSytTLMQt2r1MacM6bfR4onN94tgCfcZ0BO7rA+KbFlrI5/ve
	 lG6TDJS2+7Pr2peRZFkROEn8LAmJFpy0tKddvCKY1qO1odVWF+wuXFj8i2XsZNzMkg
	 zYFLdTnJDzgbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 05/22] tls: store original poll for non-TCP sockets
Date: Tue,  9 Jun 2026 10:18:31 +0800
Message-ID: <d626b8f7717bc22b38b3b941e4846603398a1c12.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS layer currently calls tcp_poll() directly from its own poll
handler (tls_sk_poll). This breaks when the underlying socket is not
TCP, for example when TLS is used over MPTCP.

Store the original socket's poll method (sk->sk_socket->ops->poll)
in a new .sk_poll callback inside struct tls_context during TLS
initialization. Then modify tls_sk_poll() to invoke this stored
callback instead of hard-coded tcp_poll().

This allows TLS to correctly poll on any socket type that implements
the standard poll interface, including MPTCP. No functional change
for plain TCP sockets because they already use tcp_poll (which is
the same as the stored method).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  | 2 ++
 net/tls/tls_main.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..87f78a2a7d48 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -258,6 +258,8 @@ struct tls_context {
 	struct sock *sk;
 
 	void (*sk_destruct)(struct sock *sk);
+	__poll_t (*sk_poll)(struct file *file, struct socket *sock,
+			    struct poll_table_struct *wait);
 
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 15605ac45ba2..a306371dd777 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -409,14 +409,17 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	tls_ctx = tls_get_ctx(sk);
+	if (!tls_ctx)
+		return EPOLLHUP | EPOLLERR;
+
+	mask = tls_ctx->sk_poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
 	if (unlikely(state != TCP_ESTABLISHED || shutdown & RCV_SHUTDOWN))
 		return mask;
 
-	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
@@ -1076,6 +1079,7 @@ static int tls_init(struct sock *sk)
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
+	ctx->sk_poll = sk->sk_socket->ops->poll;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
-- 
2.43.0

