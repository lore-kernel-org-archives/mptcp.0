Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720757;
	b=MMKslH0J9vV+YMg7KiYkKKsakJIDMQp7ZdCstFiiArcL4W5COiLOs/E1uttN3EtejXOm
	 /QDhW9IBc0G7Apl2N1IZxf1styZ3gRyaUJx6BbpT0Nb4OvMMymI6biL6T7S1gJahzkK+P
	 Fla3cJrvOtO3gxQ5m0xrJ2ZulHhI+3/vce+lltU8JkCqyIYvDJfxvVYj5R2c8fVsF043P
	 6T1CshrxHsNKlAbpHqwYtU+7tYlWOIA8EqKbmuqNlAaaawbI9aybHIJNO47nccK3iCb+0
	 CqOZMlhMoYovtJH072DPYxN5PEY8WuqFxveWE5DyWPHR8arZRt9cjeRlIaiCngRyKDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Yx5WagaV8PyPnOtOjjMRe5nurlPioUMn2siTOOgMAc=;
	b=5bOEJ5Bb/qa6tghwB+yNMd+7nWAM7iEZtRWuOwr/prXgnb0fOhzDd7xmHbETyEz2X6Nr
	 Emj/LjJHHX32a1K6TexSFyZTsIxqWAk3skvQgA1bXOZe+QJsE0gZSj4NVf3LQsUyMj3CJ
	 K1JittSfU7x6JVglzQDmw1odIX/bbYQmSCMhH9xYFnb1Jk5FFxN0rKfVcn16pkbR92Vl5
	 1LY7vmyOk3nfkVYqFo2BzspMP7nOHzqPL1LCxsHFq+jXzVdEQtOrauN/bvU9eRO+rKkJu
	 Bs5vgHa7b5LQG177EG8pnyFn8tCNSsdnt+N5BLUBSMd5XaSBNCx4ZOeq3/Ifdf+Lr3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhj6ZrIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758A606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhj6ZrIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE13B1F01828;
	Fri, 23 Oct 2026 01:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720756;
	bh=3Yx5WagaV8PyPnOtOjjMRe5nurlPioUMn2siTOOgMAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhj6ZrILerDUDaRFPzUpU5krleMXCf8c0w/00U8qf2Gxn++V5rP3Nc/G4AYscNMoy
	 bCyvSEZwvVAmJpjlVT/n1oxIqeY+t/Wg61NQl7cAWuwTCGhqSUGDefef1LWFDZNT3U
	 A17B5pZYV8yFhZBdFtjKQ2uI7SBIh1sJXkx1434aRwFfd+gAt2joW/N8AAYB3TC+jv
	 esKcn1vFOHDKUIrJ4N3Y7C8n+99eYSQ6lHbuX5hfJT6ucj8wykhcL1fVjuMvvAwZo+
	 tNdNhALla207fbkCA0OxuZx9GNbq/dPQxHCoy5lyS5MHruJt9MmmxyQEva2tEdN/Tk
	 ZgF6E5j/CbWAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 08/11] mptcp: add sendmsg_locked to proto_ops
Date: Fri, 23 Oct 2026 09:58:49 +0800
Message-ID: <3c3ead37362824e55e5b565dd678e61507f3fbc0.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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

Expose .sendmsg_locked in both mptcp_stream_ops and mptcp_v6_stream_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad11a96b83eb..086de4f3100e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2058,7 +2058,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2070,8 +2070,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			  MSG_FASTOPEN | MSG_EOR;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2187,7 +2185,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2200,6 +2197,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4908,6 +4916,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -5033,6 +5042,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

