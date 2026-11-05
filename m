Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860701;
	b=sMijyoNN2TQKwHtSHyxOkRPU1YbBSaPnTvyMayYRJvsRw157rZGRpzDjqlrZaeVYWNHQ
	 eSsGMCaGRTvMli9UVyTvoQtuQ13vyeB1BVE40Ai8vULOf+t6MkTtDn8kVLVMj6qlHdjru
	 KtrNwbJva3C5GPUBWgpKHkE6roTOVMZ6wD2eEvHHiSF4aOutq3F6VGOty/L4VjBnrhtB7
	 ASTXZCBZnwEWM/d0KuIZc/sGId6nu83viY8OktfOtXUectjHHHO9FZFL1TsiMeEXW+2C/
	 5/VGzBoxeeN15g7D4hIrWKU/iwZ9TgWvMF7ZoDs4XVsshWsxkNUoiCYZ409yfMvUmWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MORb8QvwzgTd1/sWVrspuwjFiYUddUFGamRCAieLgPs=;
	b=ZM2keP25P5H0GnBFYMfceGKWJ9l29SD/8Q98vg0TxbA2ioS3UYviST9Ajw8uGVnzzB/J
	 rOEQ7FaNJ2OpjSLgTSHQaRwYX/NLbpfAbKd/h71i7XW/1tUrtVCEr/qP/LbP9h91RcK51
	 LXN0e618OXn412q3kyYzlDN6HJBBDD2xvobrDKjBLm5a/opGxFKDyEraxj5TNbyUEKT+c
	 z5RPHUJsMErmnz9uOoqZhty8POcmiFExs+55N8w5eE3H+R2gxSPpX7mz83naB68IW3r/I
	 y6lImGR09hgOqj4MzJKofTZAjg8paF2PZ7H2Qk9PCqIxzSQrKXHcuKquP1LeHj3aJUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2hVYKou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7B606A328
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2hVYKou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BD01F00A16;
	Thu,  5 Nov 2026 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860700;
	bh=MORb8QvwzgTd1/sWVrspuwjFiYUddUFGamRCAieLgPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2hVYKoujOUI9yIvi/vS2Xi0+6Bf1ss1F3ISsP3r6KoY1NQ7i3Q9XNST97y9vDXC9
	 oeKmQp5OMp6xpBeWfb5MkiEISc2doCH0I4TlCrwfe9tGYTSIPkQVZaJ0953PVOrA1P
	 U3NejcWU8RQPlG+DVPQmntDS87aPJ6dpVow/QrRA8h9HvWm10aIj0HeZz+KF04KWLT
	 GbnlCJfgRxckCztndOhaXnhCHnJpknORpYJSryrHe+RuCTTM9I4JYNGGrnmTLvD0Br
	 om/QnajJQFD6VEbuXei+bmZM3U2Ps6Yi1wHIJg7ZO2e9vAifjxKRwY4y5LeeP9r8YR
	 RjIWvIVQ9rRzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/7] mptcp: add sendmsg_locked to proto_ops
Date: Thu,  5 Nov 2026 14:38:01 +0800
Message-ID: <591f2c2e1046f4a0537734a6c0db4d360a876010.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP currently provides a standard sendmsg() implementation which
acquires and releases the socket lock internally. However, certain
upper layers need to call the sendmsg method while the socket lock
is already held.

Split the existing mptcp_sendmsg() into mptcp_sendmsg_locked() which
assumes the caller holds the socket lock, and a tiny wrapper
mptcp_sendmsg() that acquires the lock and calls the locked version.
Add msk_owned_by_me() assertion to enforce the locking requirement.
Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

This prepares for upcoming kTLS and sockmap support.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aed25c901e4b..b9c7b0bb6f74 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,7 +2038,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2046,12 +2046,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int ret = 0;
 	long timeo;
 
+	msk_owned_by_me(msk);
+
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2167,7 +2167,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2180,6 +2179,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
@@ -4834,6 +4844,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4947,6 +4958,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

