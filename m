Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5A2F5A2C
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975585; cv=none; b=JAfKLTQjwX5Ez6JY6KNQuY8UFMJcdsHQvnRFYPyoBuzAObF8GexQYd4ge3MXL/uW5wx6iJxidO2jeiA4FKNDrAgWmdIRKca03i0DGoeFR6flG97aRtEi8D5rbEejNzL9uGM+oavqibDjfylHwDy5S+RQNbcOEp/RpZ7lnGmHR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975585; c=relaxed/simple;
	bh=X5JB+ZXzC03c8XoPJmD6wp1M5H6ucogyNffBo9/1QkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHzDon97Au5gGFlLBabSHT1VClXH6E04ztp73JjkyhadiLZ8i7iXU6YFGNQ5dhNQyMWg7TNfRIepvpPbnMVNQxgHdWODt874Ql8qdzCMqj5rYlHVgXrT30NUj0ZuqNCw6KEuYcjXFDbkFshLt7h/cAYfscsnXZEHeUnej7EQc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUjvXRVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUjvXRVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472B2C4CEF1;
	Mon, 24 Nov 2025 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975584;
	bh=X5JB+ZXzC03c8XoPJmD6wp1M5H6ucogyNffBo9/1QkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUjvXRVjQgRsHp/jE3aOtPuYoTVt+RIKcsKrcuJ5pRcDmo2mz/2KXfb1viPG5jbKh
	 SdmSMOIG8+aM43k3WzyRBysQURitpHYHCMN+i0tyFaN3iUBgZkUePcAK0xfj/we03j
	 RWZaTTWzOLM8p7pXaBqS07W4Qs8qvMMmeyiwtkWevgx0d0C+suHZNc/6xUij/vLgEP
	 SqE4+6qm1x8QQ6Xnfi7ypazM3Fw1byHuI018Axd8XhKcUB/7CCNbRPVxsWOsAJrSwc
	 EIll80pMRidYseLiCrpBq+Y2naF2hVH/JT7kf6Z7eWdir8R+68zr7LwzEHOgn/N4gD
	 4FePpi1q4AYlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH mptcp-next v14 2/8] mptcp: implement .read_sock
Date: Mon, 24 Nov 2025 17:12:47 +0800
Message-ID: <0a5459b14005500ef92850ce375ee67eda063426.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

nvme_tcp_try_recv() needs to call .read_sock interface of struct
proto_ops, but it's not implemented in MPTCP.

This patch implements it with reference to __tcp_read_sock() and
__mptcp_recvmsg_mskq().

Corresponding to tcp_recv_skb(), a new helper for MPTCP named
mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.

Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
sk->sk_rcvbuf as the max read length. The LISTEN status is checked
before the while loop, and mptcp_recv_skb() and mptcp_cleanup_rbuf()
are invoked after the loop. In the loop, all flags checks for
__mptcp_recvmsg_mskq() are removed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b29790a7cea8..75f90f5fc2a3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4296,6 +4296,90 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	u32 offset;
+
+	if (!list_empty(&msk->backlog_list))
+		mptcp_move_skbs(sk);
+
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		offset = MPTCP_SKB_CB(skb)->offset;
+		if (offset < skb->len) {
+			*off = offset;
+			return skb;
+		}
+		mptcp_eat_recv_skb(sk, skb);
+	}
+	return NULL;
+}
+
+/*
+ * Note:
+ *	- It is assumed that the socket was locked by the caller.
+ */
+static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			     sk_read_actor_t recv_actor, bool noack)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	size_t len = sk->sk_rcvbuf;
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		u32 data_len = skb->len - offset;
+		int count;
+		u32 size;
+
+		size = min_t(size_t, len - copied, data_len);
+		count = recv_actor(desc, skb, offset, size);
+		if (count <= 0) {
+			if (!copied)
+				copied = count;
+			break;
+		}
+
+		copied += count;
+
+		msk->bytes_consumed += count;
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			break;
+		}
+
+		mptcp_eat_recv_skb(sk, skb);
+
+		if (copied >= len)
+			break;
+	}
+
+	if (noack)
+		goto out;
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+out:
+	return copied;
+}
+
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	return __mptcp_read_sock(sk, desc, recv_actor, false);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4316,6 +4400,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4420,6 +4505,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

