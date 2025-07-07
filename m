Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D928A72A
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880902; cv=none; b=P3QDCe/sHCZ+le882WotOs2JoCdfnpuX4oyJ2sXKBRk9GZqOMV5DkX0twXp2G09SYpAjj/Rl/d+e9wbzSkeebj05SbDqdD322m2apy9ykx/kmDJGcgc2cV7vvesB3FdgxlXXC+3OwYy3obeYHgPZg37g6PS/1WMaCavDInET8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880902; c=relaxed/simple;
	bh=2X3dMBO+yR9gL2rXIkzL7FioXZ0KkhbeJ5nUg8Lkoog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pynl6BceiA7M3d0JSJW35treHGzj/g48azzqstZUj3TDDmZhfwCDS7Tu46zOmM/l4rQ5SWLAuXyIta1/kw4MX3b7988TixhXGSyksH76+lA95yFvDsnQ00aTpzyjMkrqQ4c3kL3QkqDplMT1JlB2VIEADE3qGixjx5Kh89+GOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVGPBe+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVGPBe+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8D3C4CEE3;
	Mon,  7 Jul 2025 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751880902;
	bh=2X3dMBO+yR9gL2rXIkzL7FioXZ0KkhbeJ5nUg8Lkoog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVGPBe+1d+Wfw8DJjSHoIGUDfsqn/qsfA0WVquAyPfxmq72nT/b5joFy09Zu4MVlB
	 rL0LLHdIpdheo3ibISYPsdayCr9HdHi9bnKw0n259M3cujuZqtxGcVCrnGXGD0ZDNT
	 baATSJRO7scNcEZfQ63aDb+ej7sQ4/ZdqWjI7CXNU136RBLH7anSrhAXyI6Pu4AQ8Z
	 he4KP7aCH7d2sNdjjzAD1gfh9iEe32Bcecw7ZRtzsWNY/nvFaI540rJ5vEiCLOGhtL
	 ONEJQwZKx/Cb44nvK6mgB1nZ2DnrbaIrrM8bXMpoxcBfRFpc8QDU3OTzQyzon5uw1q
	 kqObdBAxcE7rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/4] mptcp: implement .read_sock
Date: Mon,  7 Jul 2025 17:34:48 +0800
Message-ID: <5cbb736addab5da388d5a43d3ad147ad50ff282f.1751880561.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751880561.git.tanggeliang@kylinos.cn>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

nvme_tcp_try_recv() needs to call .read_sock interface of struct
proto_ops, but it is not implemented in MPTCP.

This patch implements it with reference to __mptcp_recvmsg_mskq().

v2:
 - first check the sk_state (Matt), but not look for the end of the
end of a connection like TCP in __tcp_read_sock():

	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
		break;

This will cause a use-after-free error:

	BUG: KASAN: slab-use-after-free in mptcp_read_sock.

v3:
 - Use sk->sk_rcvbuf instead of INT_MAX as the max len.

v4:
 - invoke __mptcp_move_skbs.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48365d54bc06..fc429d175ede 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3962,6 +3962,67 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk)
+{
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
+
+	return skb_peek(&sk->sk_receive_queue);
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
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk)) != NULL) {
+		u32 offset = MPTCP_SKB_CB(skb)->offset;
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
+		mptcp_recv_skb(sk);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -3982,6 +4043,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4086,6 +4148,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

