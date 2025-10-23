Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8B219A7D
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199032; cv=none; b=VU7sjDCZciubk+QKQHW/AWZqoX3ZMQMEUDh72rQOZatXduLcIKDHjiGgYHpOl0WNYaholiEk7n05vYiUQ3UhloMMjtW2RCUMA5CO7jWCSRH3fCGrAfrJEvjca8n8DJf3PDqJ9GzkUaGc2eHXOBr0zHXVwsYeC3d6H41eycvcuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199032; c=relaxed/simple;
	bh=rAGUhChJa/qTPr6/TTSMvqLm774ReaCbFwtUBY4DhDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WM1H3ee0xrq4GtMokC3UWE1TYu26dssNulbt3lkz1IUVqNxm3+RngxqHWMZpqTIEzUpQFeNo8h9pIL2oTjEmRfGgl/gIYu8YyZvK9OmiD3b0rHU1oEsr+BD+jCAdaGyj+615+HarSagneDOsLcPnjNaZm1dg0Xy9VxndTLGmRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N40gnNN4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N40gnNN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D180C4CEFD;
	Thu, 23 Oct 2025 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199032;
	bh=rAGUhChJa/qTPr6/TTSMvqLm774ReaCbFwtUBY4DhDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N40gnNN4rw1t74c7GXnh2UMRYoTTb3TAH4B3VQwzHepNeXRYPDz/fAWX90pExYJrE
	 naN+yhY6Keyym8fjOoDnN/1kXp/G4VQiSTXLAviJpKUZ+LOsoEJn3ts6ehEZTPIblp
	 q5gmDlaIM9W6HmjxrUCGBUVkkAglRWqcca4ZSa/VTyGWbNTMbCn8dC4UursKyELX4u
	 EjwM3HMxRPVuLgAxU1Da/EcTw5k8oNf/CwTGjRb8KD47r4/Ba0UKMLh+zjGM9/++1E
	 ID45AK0KVxOe4wz4PGMqYMY88KVX1Q49Rcn3r+SbySmcHYtABm3PWncFMR5P8wgrru
	 ewSpEXUhAgxQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 6/8] mptcp: implement .splice_read
Date: Thu, 23 Oct 2025 13:56:49 +0800
Message-ID: <6388be6c73553a40fc8a60aa020cea0c10b40005.1761198660.git.geliang@kernel.org>
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

This patch implements .splice_read interface of mptcp struct proto_ops
as mptcp_splice_read() with reference to tcp_splice_read().

Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
invoking mptcp_read_sock() instead of tcp_read_sock().

mptcp_splice_read() is almost the same as tcp_splice_read(), except for
sock_rps_record_flow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 109 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1955717e7dfc..91d3bf5e6a75 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4245,6 +4245,113 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	return copied;
 }
 
+static int mptcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+				  unsigned int offset, size_t len)
+{
+	struct tcp_splice_state *tss = rd_desc->arg.data;
+	int ret;
+
+	ret = skb_splice_bits(skb, skb->sk, offset, tss->pipe,
+			      min(rd_desc->count, len), tss->flags);
+	if (ret > 0)
+		rd_desc->count -= ret;
+	return ret;
+}
+
+static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
+{
+	/* Store TCP splice context information in read_descriptor_t. */
+	read_descriptor_t rd_desc = {
+		.arg.data = tss,
+		.count	  = tss->len,
+	};
+
+	return mptcp_read_sock(sk, &rd_desc, mptcp_splice_data_recv);
+}
+
+/**
+ *  mptcp_splice_read - splice data from MPTCP socket to a pipe
+ * @sock:	socket to splice from
+ * @ppos:	position (not valid)
+ * @pipe:	pipe to splice to
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will read pages from given socket and fill them into a pipe.
+ *
+ **/
+static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags)
+{
+	struct tcp_splice_state tss = {
+		.pipe	= pipe,
+		.len	= len,
+		.flags	= flags,
+	};
+	struct sock *sk = sock->sk;
+	ssize_t spliced = 0;
+	int ret = 0;
+	long timeo;
+
+	/*
+	 * We can't seek on a socket input
+	 */
+	if (unlikely(*ppos))
+		return -ESPIPE;
+
+	lock_sock(sk);
+
+	mptcp_rps_record_subflows(mptcp_sk(sk));
+
+	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
+	while (tss.len) {
+		ret = __mptcp_splice_read(sk, &tss);
+		if (ret < 0) {
+			break;
+		} else if (!ret) {
+			int err;
+
+			if (spliced)
+				break;
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err != -ESHUTDOWN)
+					ret = err;
+				break;
+			}
+			/* if __mptcp_splice_read() got nothing while we have
+			 * an skb in receive queue, we do not want to loop.
+			 * This might happen with URG data.
+			 */
+			if (!skb_queue_empty(&sk->sk_receive_queue))
+				break;
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0)
+				break;
+			continue;
+		}
+		tss.len -= ret;
+		spliced += ret;
+
+		if (!tss.len || !timeo)
+			break;
+		release_sock(sk);
+		lock_sock(sk);
+
+		if (tcp_recv_should_stop(sk, timeo))
+			break;
+	}
+
+	release_sock(sk);
+
+	if (spliced)
+		return spliced;
+
+	return ret;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4266,6 +4373,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4371,6 +4479,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

