Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336D32C8B
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245365; cv=none; b=iWtqWEr/065XeExMI2gwGxKpOQYJY9r597KrHmJdUpmRbjLAeHknz3PLvOGdGah86qj2EbolccmpEk6tZYeXzjdqVCWE5axL7ZqI6jQ9xXZSi+Qr90QQ49S6PesABR5S8ZJVPWzPoo0kCmzwpPYoZZl6FBPBfkWkkN/qPVj4jVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245365; c=relaxed/simple;
	bh=Pu0H4YoOgtP1vxqDb3nVRZTX7V3SfwPE+YgP27XTeWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG+bB6p9SPgFeGUvaap1S1CBFXvGUM2QgQJjwu0EF4ceuiIesxnnRBkX++jJy9C3XWEqmonzMarQeh+u1UPva9tqd4sEuhmQM+UiZ4gIPsPFnfujZ/CdVtCD54rOPde3+sPkELbQMVcrwuqe14suRO90TsniBzljwU8ZIK6BSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfGud6Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfGud6Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5191F00A3E;
	Tue,  1 Sep 2026 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245364;
	bh=Qzn1i3/hPBE3pM91RubroaCo6J+LW8UwaACM+5eEKRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfGud6Cs6KT09h5lfj182Fy62mOf6cono4GROjaats1gZqZ0EcDVvKpLsqHG9Nh90
	 06w7p/a6O2IgT30GCQg+JhT7b142Gmvxur8RjzoWNI/jDjTo2iUhdaA5EoJ6nWODnM
	 uxiKZOgC6hrRKYrWdSJijacXr8QlmWCeplFRwkWxik9IG5FbIPON8sfNf4oQ2YxHgw
	 Po/3qZUQECQenfhIvjTuePvNJC2Vmmvtj8hw0Fvju88lDerdpgKbJ5Z8T52fjRS7+r
	 9WdXj3RkTSnP2aN8zNMbA46s5/e/HklV3ZBYC1zo9BYbPJJ9uYAy6UVzGN9TDd+gCV
	 p0i1cjYTJLC/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 08/10] mptcp: add sendmsg_locked to proto_ops
Date: Tue,  1 Sep 2026 14:49:01 +0800
Message-ID: <5cb5300425ba59afb6b3a99041659bc3908bdf6a.1788245079.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788245079.git.tanggeliang@kylinos.cn>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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

Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 45c05f896126..2f8ee18ba6fe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2056,7 +2056,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2068,8 +2068,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2185,7 +2183,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2196,6 +2193,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4877,6 +4885,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -5002,6 +5011,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

