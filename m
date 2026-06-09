Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550C2EA480
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971571; cv=none; b=JgdTjlSDvr0e7iE+bNhN7B5bz5nsM6sj1lJWGc5KO5EC6YgPZapYcOnYy1fWsJyFCasRVyUV4LMo/M70j/yoe3irO3lv6rBNXYboYdykdAclFkvwnYYLX+L0hv7pqgOXOHK/Q9VOsGagxtwXlhSClfj7L7oL7jI0ehETVHIWFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971571; c=relaxed/simple;
	bh=I8YGT99KUh4vsZ0jKq6ZzPaN+cPgvmlVStkbtkjFmig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+gZOAMPVQFpSuzInF+Q8TPVInf7kPBDwT8sopjvYYYi84ge/4te3/qOWrtK0yYuYgxS8cTuHZ3fW77YgE2Bojc5kQkHMiUoyp98xo3in4X12/9lKiI1PXMdA5OdbuUFXxrcAwZF8adjTIB4z6cva9sIrEmD0s/uWOGQt/1RAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwr39CzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwr39CzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845301F00893;
	Tue,  9 Jun 2026 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971570;
	bh=9b5LYQM9Eu8oY2x7fGoUDDTDqwgoORyFl8ciKIpzf8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwr39CzAvFN5U8P1fHaeItE3MpRbfSFyVeRvYrtkQa/hegciUsN39jW/mP8rGlQeF
	 akOaDUX4sgRFmIiqutkMRqpMhZXn0mT+hm2hhQbCTHPh+e/6qwSl9HZTybiPsX5Roa
	 RvoNDGm5PV3O/m6mw/+fUIOhYgTo0xjF2rCeQ9EBwgDlirPcf3waaVCk4KOf6vG1FO
	 IBNqyOr+dZUfAbDL2AzYSZ1Iw5vn9oarRle041xozEb92RXXdwFz1Tpl52Cn+3HU3c
	 ANxHhBFOVTIkCrfuLT3ZSvQQICvj0GELpImCvSDipWlG8tfaMrnnkfgjXBHw4zqldX
	 WNdLkuSTUoi7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 06/22] tls: store original read_sock for non-TCP sockets
Date: Tue,  9 Jun 2026 10:18:32 +0800
Message-ID: <bb2b68ae09d35d42097b7d14efcf1eae2beb4b58.1780970284.git.tanggeliang@kylinos.cn>
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

TLS strparser uses tcp_read_sock() to copy data from the underlying
socket. This assumes the socket is always TCP, which fails when TLS
is used over MPTCP.

Store the original socket's read_sock method (sk->sk_socket->ops->
read_sock) in a new .sk_read_sock callback inside struct tls_context.
Then in tls_strp_read_copyin(), call this stored callback instead of
the hard-coded tcp_read_sock().

With this change, TLS strparser works transparently over any socket
that implements .read_sock (including MPTCP, which already provides
mptcp_read_sock). Behavior for plain TCP remains unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  | 2 ++
 net/tls/tls_main.c | 1 +
 net/tls/tls_strp.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 87f78a2a7d48..6520fd3b5fb0 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -260,6 +260,8 @@ struct tls_context {
 	void (*sk_destruct)(struct sock *sk);
 	__poll_t (*sk_poll)(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait);
+	int (*sk_read_sock)(struct sock *sk, read_descriptor_t *desc,
+			    sk_read_actor_t recv_actor);
 
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index a306371dd777..c2d131aeac48 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1080,6 +1080,7 @@ static int tls_init(struct sock *sk)
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	ctx->sk_poll = sk->sk_socket->ops->poll;
+	ctx->sk_read_sock = sk->sk_socket->ops->read_sock;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c14dab13edf3..36ab5d221eed 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -376,6 +376,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	read_descriptor_t desc;
 
 	desc.arg.data = strp;
@@ -383,7 +384,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
+	ctx->sk_read_sock(strp->sk, &desc, tls_strp_copyin);
 
 	return desc.error;
 }
-- 
2.43.0

