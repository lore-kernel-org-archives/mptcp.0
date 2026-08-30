Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453223B9610
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100399; cv=none; b=JVmY7FzB3q+UHvwi4DLxVZufWSAeBcaOIYfPDmkVmGg3GWsJfzbRh1KPJenENmEJyu7j/n+YwQbooqyArfcZDDceZ6OUBy/G8UiShmqlLN1gU6kuMq+tdqTdEHge9ZqbbK6JncolLBLrKy3M1Q53im8XWaqQzfMKUHDC1j6Chiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100399; c=relaxed/simple;
	bh=ZOqxFBY0cx/BEyDbP2H7Wj7weCbjrFLQwHFMsdpQai4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IblvJYLHo4ic+LKABzCD4ZVqewrNDwTiKtNgJIlJ3VzqFlY+dBxNMioAjuFctjfA3d/BNeN13clPYfLLTOUTR8Ya1IDt4kdNIZ64FCTpUWXbzmh+/JPf6N1jRQykPaupW6JAoeg0zATXYbDJUAh1Q9TlbDFxK/tuy00aEG6HgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyYGz/4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyYGz/4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C014B1F00A3D;
	Sun, 30 Aug 2026 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100396;
	bh=Ns+6tVmuG32ZLXgwde5rQl1EGM31GgzqekK3WMGKgVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KyYGz/4h0pUu27rR5eo3EDFDhH9OdO+JLv6xIb4/lJ7BVUdysNa4vdyRg2GtzJTC9
	 lZDhoOv3+iOSyNAcDobSfr9UmIJzAzplKdsMi6rM5kTdeVuQv+stC873lPaEaCtDu9
	 42jYBl8JMqJnC/ex7doIVXzF64KQCIrhzb1XBS6oNBs63k49W7T0hWU2BxluZuuiB3
	 DAv8BHw0ieSKV4aicUP/5B0RWTOQpAq7+MBp40wwHmU07D2C6wNKJCY5uSuUGrpbnU
	 sRw5uL1BsrfYVzyI4ZZ7cF9JzW6WtzZ5fUq5hbDx6ScosX2ujeZar4P2uXb0gYTwm4
	 CRhe2u91zeMAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 08/10] mptcp: add sendmsg_locked to proto_ops
Date: Sun, 30 Aug 2026 22:32:51 +0800
Message-ID: <e2e44723f3864133362e169f5b004482eea46b2c.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
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
index 81452a2b6fd0..cd97d6604767 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2049,7 +2049,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2061,8 +2061,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2178,7 +2176,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2189,6 +2186,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4863,6 +4871,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4988,6 +4997,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

