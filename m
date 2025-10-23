Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE623AE9A
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199024; cv=none; b=NGnsUj2euE8i5MwWjS5RHEJ1oLBs8+6M/KJmixFYYrdnJIrUttZq9Yonm1hgTzxbkAP/bHz/6UZ1bgMaVwLjOfB0wOSrH4/SS7q+H2V1zPJHK9vAVnZRsAe+mWKm2CrhvR1nzPzCEtD350h/ejyAu9EE5fvBDcy06j40BZeKvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199024; c=relaxed/simple;
	bh=EwwvYgLKyu/s1cosj1DWg11KfFZ1448EbuBdw9/Dl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndtoSRBXdZccWWUy1UhJlNUdOPwtlJr05lCcPqwBDviy8VbT7hDeO0dHSJxoLORuNL/mhIuqzUj4QxHltdKLnyjoZqkFyj+SwvBuBA2iTw+GepqbdQcLsLsoqqozlEMPHSPNorMBkeYpsdbuv7njty4U7bZ2uAC/W7Q+DmRhzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qucqZf5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qucqZf5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D23EC4CEE7;
	Thu, 23 Oct 2025 05:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199024;
	bh=EwwvYgLKyu/s1cosj1DWg11KfFZ1448EbuBdw9/Dl94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qucqZf5fd2551LJOahsCb1XQxDuDjsWF1lctutyc6p803JWIxMpUBzwS+JeYrEsTa
	 V+e99OI1C/yvCXixwrzspbI9HbO4r0BjRl2wOl9asbFeKISI4FG92sjHpJoKBmjC/I
	 WbkaWMcGDEYiFJapPj7M1874imFz2qYV2gl1SbXVEWeGt1dB75Px5sjE+3Jef4TwbH
	 1rPjJ7YRNFoQHe9SDhaCYICilMoN/OWJb7caU3ioR2/W8WXoIrAGb6v7ji3VLF/k7C
	 3TwoQEyjNipPXvSx8An3hGK/A7p712OXAu2iU4Z8POkzos+zHtoZPinaR5m5kG0sS9
	 TOMMZl05+7kRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 2/8] mptcp: implement .read_sock
Date: Thu, 23 Oct 2025 13:56:45 +0800
Message-ID: <e5b798aab8f0f031aa9d935abad47ad035a694bb.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
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
 net/mptcp/protocol.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 813d438bbea8..3f29236ce5fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4197,6 +4197,79 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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
@@ -4217,6 +4290,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4321,6 +4395,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

