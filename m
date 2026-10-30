Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324667;
	b=EJiyuvERmU6ytl/RY5J/oeBStU3mjSrunAZF4AZs+Q5p5stKwaloC6slb+PRr4qHO8Dy
	 51OYBOt2IZFsDM+7axiaubTiBDiUJ8Ym3Cbu3Ux308ijT0x/jCKDmwiGepzNNHHtxU5kU
	 qp/6nrP+TBGKzy9VJ9VezTvKE9UPdIEoterqyLgLvw7Vyz7iMR1fua5dpFs9VUGm6fRvR
	 /+ETZvyxpx22b3MLRnTYkdvmE+tlGbwf9jjTaqrUiuvBOVkYM65HHEIwPgJtCwCr8TJfZ
	 TxREdbVpFqjPMO+MtRMp4W2T2XWD14G7Id+jfqtOYoEzERW3AkdUUjrZK3h4tm3qIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DQljSdbExFwljTSduEPl/pm0/Xm5/pNnDOFFk/H1X1c=;
	b=sDO+joKvHLwkvn1qifzVRzmpEtfMAnkYEb6jqn4rBvV1q9kzS4iM+GCwK9Jm2LGX/Enw
	 M8kfNpnCpOEA4e0zPbqivV7k08i3HTFF8amRehGMYhsLCWXreaUHwgI6XzO1IEESmYT+g
	 KKI3BQpqoRv6V8O25fkEfsjFg4cula4y71qDVQg7ovXv3ybhmM4vot23Xl/fjGz8D9ARn
	 PM926iC2eFdc3JSUYUMNMweO/bvYc/AJQLkRIz0/ExzRo0kiuZjf4Wbz8mbfd/Y28AG8N
	 sY4wckYBY+M5AQ1NeIuoy8QKOReG1XxsPd2eizpFy4oTFSaEOuZL1AYoHWDbCcfNuNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv1TBrhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37067606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv1TBrhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F31F00A16;
	Fri, 30 Oct 2026 01:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324666;
	bh=DQljSdbExFwljTSduEPl/pm0/Xm5/pNnDOFFk/H1X1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iv1TBrhGZGFMBOAXx9NxhdneBJbKNpiAcceEJCaj4lwMJTYizA7UaYaq+IJug9Jo3
	 tULj/14EjkpjVe0uS+KxvOb6yv+ZWqKGluX3VhGKQmGijT9QWzI40ftARC4PJd+BBN
	 YJVdGkntE9UfOv+GkFcttlaT91t42qrN1MA8oua60ED3fa0yCG1xPM123k976tfSEQ
	 zUjAuoIp7SYWAAePk8ZH5lcLwyyIIld7Gwp0TjfOaakluzzSXdWKJVde1MZf6hhofE
	 e6EuSBTiocVOmZI04rz9xO2RUyupx2ZoKSbid89NK605+pet03ABSonXVhZTxT7ZRs
	 l/ETe+HB835rQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] mptcp: add sendmsg_locked to proto_ops
Date: Fri, 30 Oct 2026 09:44:15 +0800
Message-ID: <17cd2f5615f886f0ec82d99cb1312fec99e797f0.1793324316.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
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
index dbd6275963b8..696cdba76bc9 100644
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
@@ -4840,6 +4850,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4953,6 +4964,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.peek_len	   = mptcp_peek_len,
+	.sendmsg_locked	   = mptcp_sendmsg_locked,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

