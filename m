Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC1D28B516
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880905; cv=none; b=s7qhr+oEZzLSX5mizwwaT64cKJhb7Z0JEFkh1mZ/etH4SwVTZmyc1T/mvF9iq8rYnj2n4KQz7psEffHBgPcJwehlVIoiF70F9S5cHmf5jUqRyPg4o0VpgcGBeG0IvPiYmWvjgjpL1KGX+dqU01Yyed0766K2IWcS7d7Kka/uLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880905; c=relaxed/simple;
	bh=hTO0z4g3hOEzzhKSmV3p+jNfMKy6GuI8V08JOAQfGos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjQhY9z6Ct4Iuz7B4as4n1gwqzG8QRKOvMAXWPJV2iBW0pb/HX6O0nORjpgaSNWiwGIbez76AsRuTTqKwrHY7URY9NkhK6r9+hp+Q+4arHLmDu4IyBQvbsNetqRshYtrzalAcbzVzp15vo2hKx1Ksf6ChdbydcI36cypjVT9cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOyiA+3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOyiA+3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA304C4CEE3;
	Mon,  7 Jul 2025 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751880904;
	bh=hTO0z4g3hOEzzhKSmV3p+jNfMKy6GuI8V08JOAQfGos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOyiA+3EiGSELjDt+scsGs5ljhCwy0hjXnj38sz3mAttYSnhFpZPc8KyVZDcVTQDH
	 XPCqGM4+N+gRFEUpJJrjiftsGzPlBAGI3ImhClSN/aSezHkG5vACcg7mJb54yxToh6
	 ry/lvDbE6xj/iTQ6ajEVxY0zx3nb5Ei6QS0St+ARm7pbWJo5LioVYRoV015T/B7TNw
	 4b8UV+DAlBhDyp5+9vDW64egE0uuGEjOV13OYBEM4kbx/W4PFYthXrTKHoq23eq+ed
	 Bc8ssP1pKHSCNGOHFdtif3sZ2kbBu/jKBQyOdsQ++Fg0WCAlTo0BVhVcVZ2Oa0Ae5D
	 rh7k0pKX0g91g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/4] mptcp: implement .splice_read
Date: Mon,  7 Jul 2025 17:34:49 +0800
Message-ID: <7c269511e2ff8cf2a44934cb0f12554770c5c7c6.1751880561.git.tanggeliang@kylinos.cn>
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

This patch implements .splice_read interface of mptcp struct proto_ops
as mptcp_splice_read() with reference to tcp_splice_read().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 136 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc429d175ede..4638d4be2b98 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4023,6 +4023,140 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	return copied;
 }
 
+/*
+ * MPTCP splice context
+ */
+struct mptcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
+static int mptcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+				  unsigned int offset, size_t len)
+{
+	struct mptcp_splice_state *mss = rd_desc->arg.data;
+	int ret;
+
+	ret = skb_splice_bits(skb, skb->sk, offset, mss->pipe,
+			      min(rd_desc->count, len), mss->flags);
+	if (ret > 0)
+		rd_desc->count -= ret;
+	return ret;
+}
+
+static int __mptcp_splice_read(struct sock *sk, struct mptcp_splice_state *mss)
+{
+	/* Store MPTCP splice context information in read_descriptor_t. */
+	read_descriptor_t rd_desc = {
+		.arg.data = mss,
+		.count	  = mss->len,
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
+	struct mptcp_splice_state mss = {
+		.pipe = pipe,
+		.len = len,
+		.flags = flags,
+	};
+	struct sock *sk = sock->sk;
+	ssize_t spliced;
+	long timeo;
+	int ret;
+
+	/*
+	 * We can't seek on a socket input
+	 */
+	if (unlikely(*ppos))
+		return -ESPIPE;
+
+	spliced = 0;
+	ret = 0;
+
+	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
+	while (mss.len) {
+		ret = __mptcp_splice_read(sk, &mss);
+		if (ret < 0) {
+			break;
+		} else if (!ret) {
+			if (spliced)
+				break;
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+			if (sk->sk_err) {
+				ret = sock_error(sk);
+				break;
+			}
+			if (sk->sk_shutdown & RCV_SHUTDOWN) {
+				if (__mptcp_move_skbs(sk))
+					continue;
+				break;
+			}
+			if (sk->sk_state == TCP_CLOSE) {
+				ret = -ENOTCONN;
+				break;
+			}
+			if (!timeo) {
+				ret = -EAGAIN;
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
+			if (signal_pending(current)) {
+				ret = sock_intr_errno(timeo);
+				break;
+			}
+			continue;
+		}
+		mss.len -= ret;
+		spliced += ret;
+
+		if (!mss.len || !timeo)
+			break;
+		release_sock(sk);
+		lock_sock(sk);
+
+		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
+		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
+		    signal_pending(current))
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
@@ -4044,6 +4178,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4149,6 +4284,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

