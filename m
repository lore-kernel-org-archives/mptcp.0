Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66F1A3142
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714274; cv=none; b=bR8ZwAdBnh+OHEmwbNSZ5s8sqi1Wt/KwCpbjtOXyaS8FO7toVT8bm2AtpcpYOvAZJdfxAnAvrYnecNymI6mk5qP35Ai5G/Yb7E5mnn9NQmfZRZgmzKnEkVOlFO5jQV9IWHvWOC5Wf0Hnuseljh0GKTRFdiY6aV1qPB0C1onNZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714274; c=relaxed/simple;
	bh=hRCUEhN08EMVpMX4kydKoNPiApXRv+3k63TEoFppVQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjm3edHat+4+/tb/4Kg13ulNZwOKpBMn6dic37GOHit7ks4BZ99eSuCtnQnzoGPuqsdz3F5XApa+rszeYazz/aApWfBMU7mEe90+dsr4Fgo0PoQLNwEhX+fDGaSW+5U7U8UPmmoPRWrrQpXopxjGtcfddrrbsPxGfPSuq3c1Imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh9aUNei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh9aUNei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B597C4CEED;
	Sat,  5 Jul 2025 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714273;
	bh=hRCUEhN08EMVpMX4kydKoNPiApXRv+3k63TEoFppVQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gh9aUNeiLR3Ohjk59R8RbgN65iEUzYKvYBw3z96SLrVm7I7LYxycwRY3BAe3pTsAv
	 2CNQVkJKMrX0jNQY6jtmYaTONBvHoCK4oObrHMR6TwPLCVWFFeCCrrGQ2QMT/OosqA
	 xizDVhBo3Ju+ffEtV+Q30J/04A++8kmrOHC0vP6+S4mMwM3IzKdk7oyC4FUOOn+3gq
	 5nj6244uUEfIJL8GMi8KcTKYI3YD0au2f1z52+OWML2TMzwiGYZ/Yuv207pmmVA5Li
	 ZX5RLInLSUEZb2T3Vx+ZFJ5JLKk31qvMacSjpmCG44tsmrJUDePlh03673jjKLFRTx
	 ksxRdXeTDpOmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/4] mptcp: implement .splice_read
Date: Sat,  5 Jul 2025 19:17:41 +0800
Message-ID: <6ff0966262c7da64718a61dcb514829099c59e04.1751714072.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751714072.git.tanggeliang@kylinos.cn>
References: <cover.1751714072.git.tanggeliang@kylinos.cn>
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
index 7d58bb3f9fa3..327281ba5629 100644
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

