Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABA1DF26B
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399845; cv=none; b=XYrKNKj3b6+itMKdj/vui0C9pMbfJHOcNjIJeIq28FzwX/O1QCmAHJHSzfuAzM8/3hX63AeMR1qViHsq/ZM6EZdzMOxJ4HMFoRhyYgfKlhvMuJB3vfSZTdI+HxaKIZ0TbUGF4xjlFY7j4rCIS75Q1QUOgTi963CnaXtfGydmObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399845; c=relaxed/simple;
	bh=W1PYDgSHV/67L4CBTMCsD+tixyOfgYoukaVFQEHao9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNI1FcdWwNaYzQkufm9TdZQVSVMg1oDpLsdFBkBmBfw58kWLUBq0F9MAqrlXMeMlKdsChbvInGHcOEbXhcavWfGAkvC++IvFQxlw24SWV0kGfLI38gQ6E9ObzqUyK6DQ3T0LyFgx5hRkvQ4I61SbgLgZFqApCkMuFjnZnzPtSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuPCyWDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuPCyWDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F148C4CEE3;
	Sun, 13 Jul 2025 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399845;
	bh=W1PYDgSHV/67L4CBTMCsD+tixyOfgYoukaVFQEHao9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuPCyWDiTIXjoV7gJq7DJiYIXF4gOX2yMrVRBSo7EVXkm8o52FGt4QV7AzEVVlwf1
	 O3w2+02Bh/CKWGG4AUf8pj76p5f+fOHkGKGoRx6wV3WeqxMmEG8OeqtLv8zMc29M88
	 mQIOoZ8aApy8C4uHSNplF4Ss/2iICJiqK+Shb5gMFhOH+Iych7ZlYhae/UiwdmAiBP
	 /vIZa4cCrW+Jq6ZUfGVo1/04Mo0bjthBcIsFWP03OpoJ65Nj4+9Izd9VHpsg4P4rdT
	 6n6jWQHoAE6rIxop94zwPQHnW3blS5vMrnbabwzTbTQ75HhjK1qh2dG2583pcgGP2D
	 3TmPgvDSMuoYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 7/9] mptcp: implement .splice_read
Date: Sun, 13 Jul 2025 17:43:47 +0800
Message-ID: <0cc23eea2e5089d83de6c4916d781bce0df996aa.1752399661.git.tanggeliang@kylinos.cn>
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

This patch implements .splice_read interface of mptcp struct proto_ops
as mptcp_splice_read() with reference to tcp_splice_read().

Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
invoking mptcp_read_sock() instead of tcp_read_sock().

mptcp_splice_read() is almost the same as tcp_splice_read(), except for
sock_rps_record_flow() and __mptcp_move_skbs().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f94fdf5b164f..59e282348e48 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4057,6 +4057,98 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
+		if (!tss.len)
+			break;
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
@@ -4078,6 +4170,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4183,6 +4276,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

