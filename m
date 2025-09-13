Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2B38FB9
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723954; cv=none; b=e8bmIhVQBjcI0TnKPde+GithfbyyftDzcZUReYqCn5I3iuMzz2Ss/gx6dRu8DDGeFaaasU72OrMnkDqsxTPrY7Uxh9/l+P/bb82VxGyTdUWQqV/vQ3QIDki55BMWqukbAngQBCyDGJAJ4R2iEg8o7BeU9a4QMayiYSZlrxMh1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723954; c=relaxed/simple;
	bh=hVytNSo+mu0v8CingI4PDIDyZxovCRQMQAw5ri6gn20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/4CiYrxPbVEQK1PtiXHiyJb4xFn8suIJc3t4K/1yB81DhJYDYn/flKZF0mK4Fk6Kgax07TdyPJ93HPvvtv3/VN5tjjTsLasVQrlErQrCbSYbR42mRiSdPooZQ+/4fPDHUrKHFokgUY2wfPOlqgGNDprpRhMrKUDBJqCTOprKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSVyGA/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSVyGA/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D47C4CEF5;
	Sat, 13 Sep 2025 00:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723954;
	bh=hVytNSo+mu0v8CingI4PDIDyZxovCRQMQAw5ri6gn20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSVyGA/VGJM+VWJa33YFAJUs9Le0E5Mad7TsfEUkMeu+dSmsk2h3EbwYfHgnIOT39
	 ZhI23uXgJ4duXhxcsZRz9EzSYe70fOG3emjYgxmU4JM8D2m5U8/syQIPwsOHxlFimM
	 Wcxnxx9ctVhph6oiCt1+tLOq6pN2Bj8wyfM55wmE1WuUqm2Z1EGfxwFcCkCWvv9Rbf
	 0ql24640Uou9uqWyN15/CWSPXvDSnTpO6/J3KNcAv8F/A96KN/pXZBrEee4AluXI3Z
	 ioYhz3eXfvGWcVPii26WPOErkikkRLu2hocds+C1/s6/yopWb7Nnehj9ak7tYK8jYq
	 uhWz9bPDq1YRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 6/8] mptcp: implement .splice_read
Date: Sat, 13 Sep 2025 08:37:25 +0800
Message-ID: <206b6c3dfd40468128dc11b52620230af492d58c.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
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
sock_rps_record_flow() and __mptcp_move_skbs().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2288ceda45ce..8259cc74c7b2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4103,6 +4103,102 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
+		.pipe	= pipe,
+		.len	= len,
+		.flags	= flags,
+	};
+	struct sock *sk = sock->sk;
+	ssize_t spliced = 0;
+	int ret = 0, err;
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
+			if (spliced)
+				break;
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err == -ESHUTDOWN) {
+					if (__mptcp_move_skbs(sk))
+						continue;
+					break;
+				}
+				ret = err;
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
@@ -4124,6 +4220,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4229,6 +4326,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

