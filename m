Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2927A900
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976300; cv=none; b=FXwaB1Z+a4cMZFlC6g00lzp+zV0LXsMzD238g71J2CFr22Zpjf7P7qGTtJc52JNE/DHF8J1YrSK98ILcq1uFp1S6LpgSx4AK+nOzYthwUzA+QZVCC04RLNy3z58jO4atkzm+teOKle6eD33lqt0Wt7X4lfEHl+ZqQWlT1X8lkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976300; c=relaxed/simple;
	bh=kAO0rb/tHrkcMFGp2LhqpXQkx7OXrBt5JdXbJn8olhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvO44uMp7Y8UkS/wEVHNz1Qqr2EqmfM+hUI4+ivL03OLW19/nTw/PSbV75Mana90J3dYVGYzDlQy5T/V//YcqEyKXrbxm97qZzSdW3AiQSeb3TPUQ8eaZ66TJkavf7H/dzRArn95S6tyfm42DJubrvWIsGoCjh/PKXBrs5X14C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXkqMGVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXkqMGVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A729C4CEE7;
	Sat, 27 Sep 2025 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976298;
	bh=kAO0rb/tHrkcMFGp2LhqpXQkx7OXrBt5JdXbJn8olhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXkqMGVYvlm09i9tQ18MvUgaNVgi6gfl+pNPDaDhcVV6QDx9+/crGvqxCld6sSy45
	 hCTxkyrSoNpPJCS/aBIZTHLztPQ+nLqLzdyCRN0jtCam/XF0aRWiqPzKkwUqhGMvx6
	 cgcj82XaITE5h7x4r8RWl9h0iBnssrqmYxrrW+UNmdFkpDIQdB8Dv4EbDYTsV/GQ9W
	 56lDgaZlXa7ijfgtVT8cEe7DfRfHNrZQku9XnA+HuPjPQ1RrpceScdJemPk1L1rvMQ
	 ZqZkqVPALjI1ap3TD+h3tl2EI5L7oqGmnBjS3QF9W2Ji7ndvp62OJLA/u4qouFMLa2
	 itbooh/WFHkyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH mptcp-next v12 2/8] mptcp: implement .read_sock
Date: Sat, 27 Sep 2025 20:30:19 +0800
Message-ID: <2f159972f4aac7002a46ebc03b9d3898ece4c081.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e12dad700a58..dda16dbae9fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4055,6 +4055,78 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	struct sk_buff *skb;
+	u32 offset;
+
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
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
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	size_t len = sk->sk_rcvbuf;
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		u32 data_len = skb->len - offset;
+		u32 size = min_t(size_t, len - copied, data_len);
+		int count;
+
+		count = recv_actor(desc, skb, offset, size);
+		if (count <= 0) {
+			if (!copied)
+				copied = count;
+			break;
+		}
+
+		copied += count;
+
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			msk->bytes_consumed += count;
+			break;
+		}
+
+		mptcp_eat_recv_skb(sk, skb);
+		msk->bytes_consumed += count;
+
+		if (copied >= len)
+			break;
+	}
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4075,6 +4147,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4179,6 +4252,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

