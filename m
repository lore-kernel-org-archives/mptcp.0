Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676631;
	b=hdzcweLvkA4QQVSycLiQCZbtWFSQz6Lc8CBb69LNdgPMMPJdjrSZ3+vtFbgA5aEI7tmD
	 +hSpCMpGg75aiK6/j95ATwjxa4tv32ZalLvCMYMFF62bzBsUD9VAT7+dXXxA6sgpyzHrb
	 CXcT0rkN0tcP2xuBzou0XYKnEN9ERGMmgHpYJfzbvPQa2pehiJbAl0EhE0btiXpN2no3H
	 beBVwmk0kEgBUnih5nshennnYUl1684Om7XJbngQxPp4EiXIm/Dw7DstLWPh6/OxRHm2R
	 VqsT44UVOVtZtVsI9Tm3Hzsw+zLBr7rW1vLfkz7CHxfPPu9XMJ8RCA4e/ubHULcamCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676631;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MORb8QvwzgTd1/sWVrspuwjFiYUddUFGamRCAieLgPs=;
	b=A36MOR8SRzFhnbIVjD80kn3e5F478NS5z2Ik47lopU4sKyyXI2tJsicvXGlGfS7qrSwq
	 /xoSQWXwZJCDzwQYtQ1/eKK01keLgYy0M5xzxgF+/Ob3ZEMYLWaYa6+Iv1Czug4G+P+Fa
	 S7cUT9VTM4481AI55VfnPM4GPU+VJJToeQ+CA7M8HVVL4hcVDpn8G0zGu4jbpwgSjBzCz
	 /9gMn1CJFy7ZnmcNLmbiYy7AcTujIVNjoC0L8fdAy+xYGI3yWRZpynzpBorMN330ZuCl4
	 4mglUgpiQQtNk/OnR4HrrgVq6YdA+xBiC1/bIpNJjr0QfH/AuxTZ/7eXu5IBShGew5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UO981arL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C37606D803
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UO981arL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D71F00A1B;
	Tue,  3 Nov 2026 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676630;
	bh=MORb8QvwzgTd1/sWVrspuwjFiYUddUFGamRCAieLgPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UO981arLmeq2qkNzQGFuW5n/F9EO0SqByTscee1pbm+si6xnaEG3hPtDrOjiYKkUz
	 Tl96y0kCIRxqjzbi2Z8i5PgIL8FbIAlM7u8MZ4giM+kpG8KdwsoY2xvfGgz4wgs9i3
	 3TYC6DlGeYurki+XYLs8W1BmpF10JeIQmzjet6xFoDh9C7Q5wac7D/4w0AdqVQO7SG
	 FmoO1d4jGfh5r5JeDuX21VBhHlnPWEhHoRbTv6xIwG2objpaJKZi37CqQmKqyehC+C
	 NyI6cAK8j0xt1TxrH1CRzhAbn0T0BJSVdraN6qAzxt/4/U5rI60WannCK5iUZShzM4
	 W3InXv+Lf7Ufw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/7] mptcp: add sendmsg_locked to proto_ops
Date: Tue,  3 Nov 2026 11:29:54 +0800
Message-ID: <bce6e303623572613053422db4d9ae90fbe01123.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
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

