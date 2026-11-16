Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826676;
	b=OiptJlPFxTppAOIl4NZhqGm/JhXI5UvSVoDg/GLlO9eGQak0It02qPTD1ZtKD46iSYdO
	 O8Qn2q6pg8Zrx3nsKKD5Txqw+02SmTTqnAh4gxDPvwYijmYeVgc58lnPZXODddlhFXktS
	 EuZcNyiNdaEUAmhZ2xXiS4R2IEzpj6INqAl0Gww/8nG00zuXhw0eF6V0Ml4DpucwMTXk/
	 2K7QzssOOD2sEDPBtruCyNQuHTXMESGKRQx5A6dPONJKnoPeLUVbOimGUFTnRYSvZIriM
	 JrouVE++6KrARKuAbski+MN3TvdDCBi0MFb4Hx/YMhz7++wp5TTqs5LZq88MyswA9IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826676;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EwyQgA2pfhNyVOdG5LH4t5/hsEtxBL9S7xTid2vwNyg=;
	b=PdIBtzSKFUR4bzorXnBwc7mbuyehV4Oppbm0yVfxPTlkfz9dYam0ShsSTY0ZXcxGXsR5
	 iuVihrsKsObGhhIKBwH+keMEgMnTD1rhoDEd5f71Ia2FjEifzcRLGQtqQDZZkE3AzvLPs
	 jpxqsdo8fpyXiByuCvZa+hsHLdweqVl36HZ++yIJeQLQD2dovzuWDDi8Kcbto1AlCsEMx
	 jJ9NfqXvvFJQ9cjHkQ70Iv0dQCxhbRLvpd2OBQuf9cuBB47cwyK1o5eFDdP61KPGGWIla
	 hHse7zKk0X5fByhskJ0Ok4jPODX99jBwHT651dQmTD0eR/8NJA4WuPpz3oIOp6QHeXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFeuekBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEB606A333
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFeuekBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE81F000C6
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826676;
	bh=EwyQgA2pfhNyVOdG5LH4t5/hsEtxBL9S7xTid2vwNyg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jFeuekBMnpuIYuQel7XDXTDaD6lSsEc7BjnNCtm0jo4QIR/pvzlJL8XtU7Ev053EW
	 ZCwXENfAPMfZJL59QtlmFvg4VOKERplk7S5gTMtCrZlm3sVOb0Py3kNthf0YKWBhha
	 4Y2aNnDzB/vbka3wwplDVduwhMivKox5T9VgDNQd4dhhwGJvp02hLeMwthyvQKdjcT
	 wcBdPVQkwti4gWDfn49de6bFC9OiVfrgbc6rdQk6a+GSZ10mbxyaYSgThEPUvm3hMK
	 2vKq1EhvbNprAvU+dZ3NE94bp6KSDQSxQEnUmZfdLeVq179oTubLad5jAOFcQfwo2A
	 KxPPFG1uZK6IQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 4/7] mptcp: add sendmsg_locked to proto_ops
Date: Mon, 16 Nov 2026 18:57:42 +0800
Message-ID: <2d180799564c49dc62ab876fbcb358670ece3a29.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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

Unlike tcp_sendmsg_locked(), mptcp_sendmsg_locked() drops the
MSG_SPLICE_PAGES flag from the mask. Future kTLS and sockmap support
will require additional changes to call through proto_ops->sendmsg_locked
instead of tcp_sendmsg_locked() directly.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a0ad28f5a385..83abdf39c4e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2039,7 +2039,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -2047,12 +2047,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -2168,7 +2168,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2181,6 +2180,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -4832,6 +4842,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4945,6 +4956,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

