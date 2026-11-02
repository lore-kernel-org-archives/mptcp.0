Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588350;
	b=CeLWXp8IWTo4Ch2rxjjjFJd4u+ix/hLvCNrpSrb1DhLCsCnsXD64rNUSMlHbJqbjsYjT
	 YxeNbs+AcSJm6c//FUGDIfWODq4+crJysovEKSgaKQq7RoQtHKZbhPImjK78/MuQ+KCyL
	 Mcpic5fq8/zZtJbnoeRsSKNTKqwSHd5JkB3Inw6/7MJ7Iw/nSmmlTeNFFOMzuFkFyK9Ow
	 SjIUPIIEAgFt16qTvoizc0u+sB4FmDo7YvMxQOLoJ2d3G+ATRq96Vwxr04lAe4OSLOHGa
	 gGezMTOfSrIrqM9rOLHyvYbxky9tdsLQLIjOZJzNFGOD7Ca8mRnkiF7LVcyy99JIqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GUNNsDmpVVGsIAqUboL6f4B6qj53zzxfZZxkPsKQpAs=;
	b=RD0z3Dl4cOWm/GZy5b5i8gxEMqzNij7VMRAl+V0/j4LbrmrzzdJ+7LmKzHM7MocgacU/
	 DWcwPGw5NR6kga3HMotdG6UeUqB8D0LlXl8d4vgQ33h9gnwsMD5/2vsqmHPQs3BFDduvw
	 hQu7Nq4ZFBdhTLPibaWYbYTtvpJgfqKiCpnE1hDySVkPwuXImJzQ6yJISdg5F8Hb7RiAo
	 hdxSyqsaGJ3YtzbcyCe7HFqYVgPZUYVcd0DJ6FrP62AG6A5Hbk5r8Jv3sVmyH3tVn2OoE
	 BO7AqTuNss9SzPKSNabOUysQQhZmJ0EYdub+Cy2oTgPjlIaIEJcQZkHuLGiKnVGRH/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhdprqcy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB1606A32C
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhdprqcy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027E1F00A15;
	Mon,  2 Nov 2026 02:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588349;
	bh=GUNNsDmpVVGsIAqUboL6f4B6qj53zzxfZZxkPsKQpAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FhdprqcyK5doqDWzkwsLkiYHjQ0BPlb6g4MFA4n/sGakBMw7nkJkE2wAdpHdUBIEJ
	 37mnKp2fIYl4AiVEi9DBtw7s3n41ZMls4iAuLUcKfnCyfS3RgHg1R7m4Ua90g/NUEW
	 r6K44HeFfY62E8yLyAgRldC6//IeAc5IMBjb+w+eoA8DB8d7aPlxd6sZ1fbj3vj5BR
	 SyQW+E4pfUeQC2iZ9Kypl/lSWIezMfGiNUGOf4Z1WdWqt7/QifWpvhdpXeQ9XULJY5
	 eKtKAB30+m+AryXQ8mPI28HgjvEg9R2cmGOr0Fw/9DS/FZvRxWp+a50Fx55KSWKaPM
	 gYv2ranCOonYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] mptcp: add sendmsg_locked to proto_ops
Date: Mon,  2 Nov 2026 10:58:56 +0800
Message-ID: <82703a59b6e23ff521082b1cfaa36b1ffb1e36a1.1793588257.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
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
index c6d354900e7d..7ccb1c7506a3 100644
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

