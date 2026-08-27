Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86743CE45
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828284; cv=none; b=pTNHtuUVHmvCv/UVCfz79DqIh0WHYIXh4cukmEAr2S09YFyy0RXhJSyyV/XqriZWfVkFWl6FBWBIDWgx6ROee+SuTfQOmrtv+cEntQS5VshOsh2ZX6JUvZRC0+/iiLVtF3thhyGvtqYnqx8TRt3/xt/zdiv8RRM0Iue1mLOPopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828284; c=relaxed/simple;
	bh=ffVFTrUfsZlBu+7f57tIMw5vGEsy2p9qvpS+U7osgI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNjVJ6NO9EWwJaaf9mojkooUsmhXnTKkXxelwtsr/PcN/shy193l63/P5mhMFhsn527cMgaKr42sscYGhETdFQAB4roYSLTOYTvDqG04vdfW8eBygT0GA/0hPfnvDOueK1Adtsto7L7sOzuX4qAotAuqJ6DGmQETRXrihapPTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtySw/3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtySw/3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3861F000E9;
	Thu, 27 Aug 2026 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828281;
	bh=7e0Fxutby6gNuDFUFxt7zOiDw2DodIWhnSmrkueQN/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtySw/3drcaZ9JC6yKkr8ZKzYVVXP7aOwXdyP2DBtYe3nZEgdyrXIHi7v82/wOh7/
	 nOfgPLcZQtE9hu48XvZh6wnKNKmXJinmoLOOYBQ1Hz1XksZHXvlEt/6YLU7BsKEOl3
	 BucJCpspURP6KvdKPTUHHFhXhWDs3WdfJdL4HKOYzwhyUZ5IIbeMQ6L24TsLU+mPWs
	 V/p1yyt9N5yUBLRVRfbZNSdYN5OXGaRrClYamTAS+/N0F8xvlAtu8r0BR6aAUT1xnm
	 XK1+F2Eus1rcLDGC1m8r+OdG0z43JpGPC4+jko1xQJmRHyj2Wqe13QWgOKe38WdFox
	 9UYpDu63SqDjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 08/11] mptcp: add sendmsg_locked to proto_ops
Date: Thu, 27 Aug 2026 18:57:32 +0800
Message-ID: <53da6278a6f3eb694c0cb288045b79e23a659423.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
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
index 9b9ace7cb977..98a1bfdfbdc4 100644
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
@@ -4868,6 +4876,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4993,6 +5002,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

