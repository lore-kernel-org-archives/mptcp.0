Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E021CA03
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093884; cv=none; b=CtKoEM+2AFNci7bE2qoBy7y1cZ0gHnoBO7Q9qGmfcOlkgja+ECbkZq6g0dvh3LTI/kb9iviiZs49CdYSVPTewWsiWth5ncG3d1Y2lwEO8Qgcu7IeK4wESTXYHaXoCDlESyWp8QrLBcJKbNmQKjeqaIOozNmJggnSqdqaLvSjnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093884; c=relaxed/simple;
	bh=lE7qwDkioDbkRUHGKoyY63JeC7dhOFS9Z5U6KnVwmB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKyV9sAi7e65CVjYvkihZw09zL+LYZ+fgFDyiLnOJEIDJ33NUANdRWTA2DoiCJCMc7tzTt8/Lsc92IbilvcEofuaqwW4QaDTmVFAiUOszzf7fsRXUdPAHy4Jzib1TVESmPiHKZl88ic7a2pRQStKGNCLopZKw5F0ioi2ZhXKcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPWVwufx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPWVwufx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F8CC4CEEA;
	Sat, 28 Jun 2025 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093883;
	bh=lE7qwDkioDbkRUHGKoyY63JeC7dhOFS9Z5U6KnVwmB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPWVwufx62sKDaQe/qL4M5/JyXeGAJUGyMaDzcy5Kkt1GoiotJm/Fig8PRoMIIxUp
	 iwTW9L0mQcvgDKJbXxGtJo6oRfK4zbrvvI2evg9JUcsAaCKQTbZRyHmO+e4VTrTa3L
	 FdhcWAMSRfchRrJv3O46VT7cDB+iP7SJF6HhGZAYLcLF4y6h75j0Ig9aq8YlQ2eLQM
	 1rMgDQacDeJjQkZWTabJ9LWgF5TAO3wb5QEm6zjVhUG9ZH4i0HiuP5El5qrrbC/1KC
	 Symm4fDwd5AgIlIZkNrXqrEWS9cC+Z6Np22g7vbQYD0YdzXx9SfrGVZ32Y25yeVCaQ
	 WWlU6jM+U6STQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/5] mptcp: implement .read_sock
Date: Sat, 28 Jun 2025 14:57:11 +0800
Message-ID: <1beb923fbaa782f2ddd2f97c5028425641e244d8.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751093346.git.tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
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

This patch implements it using the newly added __mptcp_recvmsg_desc().

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

v5:
 - use the newly added __mptcp_recvmsg_desc.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ebdad6b233d..1a1cfa1ff376 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3985,6 +3985,33 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+/*
+ * Note:
+ *	- It is assumed that the socket was locked by the caller.
+ */
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct scm_timestamping_internal tss;
+	int flags = 0, cmsg_flags = 0;
+	size_t len = sk->sk_rcvbuf;
+	int copied = 0;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+
+	copied = __mptcp_recvmsg_desc(sk, desc, recv_actor,
+				      len, flags, &tss, &cmsg_flags);
+	if (copied > 0) {
+		if (skb_queue_empty(&sk->sk_receive_queue))
+			__mptcp_move_skbs(sk);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4005,6 +4032,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4109,6 +4137,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

