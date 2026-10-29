Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259514;
	b=wRzAIoKWLLGfAc309mYTWP/feulob5U9ywqJft/mScrfLXFKYfZ+QPPj4LUyInYmOEpo
	 6mYU3uXWXNi87OMm4phEk7OVFSrCQgPII/sJ7MiVzhWwsykqICm4ZrHM8j3+QJ4MHa2sD
	 r/gXjFjUqYN/SMgLPAG7+ISIuFdTVMUddCF++l3ds7A9aayb5Bt4Dz0Bd0uX6a/b8S2H+
	 nitgqPiJJWTmsJFRauP0wXoq1+NnKuT9n5AppvXVAuvnj3btNf2JcIbeJrHkVQJBhG+IF
	 uuqdaVWHshTrz81ewfQwMVpIAAo2tH6pHO1lvP0Vt2zDTxJ63r6dF7dwdDgb9ud5cIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HvIJNrDFcfi7s7fRmb/2onkqR3mlzc+IgEvmstGmyMQ=;
	b=a8SpJxADArEs41kS0tnYi2l2l4LitBulAiGT8Xrf9fQkSYbO7Gvjyorzq//kZIG1w9fy
	 8Yhkg/iEu9pnH5+3Cl2nnLmOvzxZSe8/EzW57ncT7jTH/dRhauyaVEami7eZUf8jP5lhW
	 5OHLhAu3b487pzTAsa32nAjblAVzgNNN/C/bnhzmuqYnWm/3rnaGJn2lhfiM7rXMdsC74
	 iJQMBMDVy+wGYie+Gj03OMQ7VfOnCc6eaW8sILCEdgeVyKDaA/8gBZ+YeR/tjhsyffvqA
	 z9DFvH7U/kHzGNhiaayIQg5Fs2+OxEWN1zpUlmkfKUaB+uZ6iGuqUUSjKmUy5DLfQ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb9dgDTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AD606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb9dgDTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2859A1F01828;
	Thu, 29 Oct 2026 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259514;
	bh=HvIJNrDFcfi7s7fRmb/2onkqR3mlzc+IgEvmstGmyMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vb9dgDTz5E+VamNWcoTPlR2jYEr7huWsM5XqHvji9606NmwBDrVZ3HIyyw3LWLkZS
	 nwDQILxK+99uvimAhVeCN2obh5yzkIudX3XwcFNtxzDWLaxNIoDdnQSvoYXBXPS5ov
	 b2ysXTVUXMsAYHLiqHNSpHtl1IsbbVByTVY4vsZWoXT+8dp7jGpqtO6CL6GW6BXNN9
	 zxZzfSaQCzjMrK9xAbhKujNfO4YtiYZi4xx4OrrUYUb5+usPKf10qqSvzIt2KZKlo9
	 9GtTA+Lcq6ptXGEBKz9wVDfFvb2bbhCscASwUy2Z3tRJQ8uHsjipHBV6pNG8+ooWDY
	 kI3VrxdCR2MWw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/5] mptcp: add sendmsg_locked to proto_ops
Date: Thu, 29 Oct 2026 15:38:15 +0800
Message-ID: <481909c1d5f71b2cca9ab692f251a6213c7cebf7.1793258749.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
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
index 6f34e3459e8a..63d83d4b188b 100644
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
@@ -4847,6 +4857,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4960,6 +4971,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

