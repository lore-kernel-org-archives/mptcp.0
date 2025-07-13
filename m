Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E692225779
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399837; cv=none; b=cnII9wFamB6tXhXqiJNBL5deSyHrWlwkcHPqENvf6qj2b6hXhoCWhwhLUvGTWbd0GZm7RN97GXxMPBOc/iPXrH1X8t78JAf1pkgy3rYoE2YgjU5a/1CJZLKelCQmjfnYFX0DNrB4saie5NA4dn/W7EAhZMYjRdKbEcpZBb9M2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399837; c=relaxed/simple;
	bh=ztJ5v23SP8lHnncz0rUEiEDmaOQASV5sx52Y3nV4qog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtpHVQ8TqKW3GfMyMpsgS+XgXSz8XeiOTJEp8ZivWNu7t+jX6bblHeUOA8G25YRfSANTlW8bpE3MDlU8t0PUy17AmZEvqJ2JmUryFlBU+wBmfHnkBU/DvATlw99IsK6weGVdNSFc+g/tuOrtYmJ1yxZjYR5hWuMxLEeyk3ndo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKmaIZpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKmaIZpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3994AC4CEF6;
	Sun, 13 Jul 2025 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399837;
	bh=ztJ5v23SP8lHnncz0rUEiEDmaOQASV5sx52Y3nV4qog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKmaIZpGdHX4p4fuQZM2mlttXSNWYBZ0rnGRFa1+iQdInapre6CJDkmzqAcUAjuqv
	 K26S0JKk0qonE4b84VayIOL7BZyxXgxf76S4HCaY/c7RMe3Yy3JLIMY8eHFH7uXavP
	 zfHIof5Ohk2CQQHpcVhdK1Udxb2o0vGIyBTBw6gHeRHpwSh80i03NULXUNUXgJVfQI
	 MVgv6Oq9NttiEnFVJudeTpRRqznmYs7zuL5Ssc4y5pYd1imcag1GP3alZ/cWUQN6Dw
	 V5L+1Ff8CssvxZQCjQAzdKAXbqOsRthdaHogVmagQpBpDURMBAzBBjy0GuFAFjr4iA
	 c9F+XM5V+Kn+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 2/9] mptcp: implement .read_sock
Date: Sun, 13 Jul 2025 17:43:42 +0800
Message-ID: <3a2ccde3aab3a874a4c6738615053f0e7734a047.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2233802b7a1..288f989ab078 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4017,6 +4017,66 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk)
+{
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
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
@@ -4037,6 +4097,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4141,6 +4202,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

