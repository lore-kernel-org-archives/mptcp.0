Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808326B778
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045965; cv=none; b=paXsGql6j6ndCUq6bNB+MCLY3pZ4Mru/JF2ShTCJWCNVI9JrMbRakoR/hCrrOCpHYaSz8hUUWyn9wBqvIRsp17yS2UiMDM2toBtb4vYFyRl91ezCOgQt55vxkeaDhij0ob5uA9AZBtwn0J4JJ5k/BkyquRORPToCxDuB5UswG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045965; c=relaxed/simple;
	bh=NGwUigIslDVPImgvx0xZtp7aDWmdqnQcgVhNgltA91k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOd9pS0eK9lokHPrxktCIW02fbHnZr29MPwPrKp27GiGv2NrkvnQ1i3G8wglqKyROIWOW/95p534uJ1qZAOn4B65oIfqFmm/pyjOosenV7eCSonlX/k49IULNQfO7l1PQ7V97oGo/rGCPDapr2+WFHwj699sSkdm6H5ywk4NEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBDEHRvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBDEHRvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A0FC4CEF1;
	Wed,  9 Jul 2025 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045965;
	bh=NGwUigIslDVPImgvx0xZtp7aDWmdqnQcgVhNgltA91k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBDEHRvR87JcIGPOWAmu3QTOHnQeR9bY4+5b298eVrxYF2Ckz1w9ikrq+IIvwvaAC
	 EPTPWSoeHKBq0kmKLc2kp/4G0HJpBfQ1dg4Eagjf9NaUA4NG32pGoaGJ7i1eRY3Pcy
	 zU29gXgPHVaueAcP3g/AAULoUWl/YaJZ6RC2ib8fZPwkhMwDEcN1yoSDIzbofwhygW
	 +WlIe5ARRQjK59606AyHFYy3CxXDSbSwLCThRNtfjxGWoc8/LWo4fxM8HgW2nA6bjw
	 UaLQF9IWnT8p/SMeidIs27onxhK5keczOFflElZtZqvrSBCyUn7Xu/6DO2b3uRQflo
	 HdBIqarMwrHKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 5/7] mptcp: implement .splice_read
Date: Wed,  9 Jul 2025 15:25:32 +0800
Message-ID: <e7ff57038380e19205b8c4f633fc36c410fec4f6.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
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
sock_rps_record_flow() and mptcp_recv_should_stop().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1fe04ec05ebd..6b3be1d0668d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4028,6 +4028,103 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	return copied;
 }
 
+static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
+{
+	/* Store TCP splice context information in read_descriptor_t. */
+	read_descriptor_t rd_desc = {
+		.arg.data = tss,
+		.count	  = tss->len,
+	};
+
+	return mptcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
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
+		.pipe = pipe,
+		.len = len,
+		.flags = flags,
+	};
+	struct sock *sk = sock->sk;
+	int shutdown = -1;
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
+	while (tss.len) {
+		ret = __mptcp_splice_read(sk, &tss);
+		if (ret < 0) {
+			break;
+		} else if (!ret) {
+			if (spliced)
+				break;
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+			ret = mptcp_recv_should_stop(sk, timeo, &shutdown);
+			if (ret < 0 || shutdown == 1)
+				break;
+			if (shutdown == 0)
+				continue;
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
@@ -4049,6 +4146,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4154,6 +4252,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

