Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC432F60A2
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975592; cv=none; b=rH5I8KRk+HuSRPEI+GIgFtxF6VcXDvU3nvvWvxvWUF4clPueXO347FFmVYmOhMJlADhBwwJ6CJH0Q0KWJb2elg2URQiBEDMbcg5CTq7qtt70HA2+dpoR+n9EX5McCNCgKqx1jiDwKNzjPT2AoSxqXYvsEUkOvqX5xqWp4en2ZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975592; c=relaxed/simple;
	bh=lW7TL3YbMDQC9E+b7AxqEXUPMLGATCiTqwVp1LcgWl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECzjWTQMZKAU2rmi5aGpKLAFRKGsRJwVXOBcQLil+l9gx1UP1ThcUeodz7N+TJWp/oO9Ba0lztpes6vcHNx99sewgPCD3ecxX6csPrwHWQQ7hTMo2T0Er9XXIzoUqiOfVTX5w37JhDU0M5XweV5mbavdHOy1idsEhTc+BIqaDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwpQvtlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwpQvtlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D0AC16AAE;
	Mon, 24 Nov 2025 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763975592;
	bh=lW7TL3YbMDQC9E+b7AxqEXUPMLGATCiTqwVp1LcgWl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwpQvtlbeuGU17CQvG5qHb/FSkAfM9uOX6MvnYmgcdzL7jrrp0+vUGf+JJkyVdLs+
	 2s5ilGouF5mUKZuN2ZCjxVP/iVLTgUfj5o88mQ+LfBxEAhTVtiABWfMLjmZoRsOZoI
	 Q4q/yBi2Br+VoAXn4tzgS1yyQU2FQY/cHomGELQj3tXnf+JkqdyqqVzNINT1y1XBRb
	 FnIpWXm1fDuSMscsvZgyF/0Hr9wX+ikDHkMcfifKp7MMLa5UQpbExM3djBkg8ufI0G
	 FHVmIM57al3Us+5s8dHI2uqyAGAP28bWl7MFIlPjr3bJAE1noOCLM5A9fJF5RB4LXo
	 07DRSq3l1EC4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 6/8] mptcp: implement .splice_read
Date: Mon, 24 Nov 2025 17:12:51 +0800
Message-ID: <cff194b2736d851c1ad28e2d6e38eb7e890de2a4.1763974740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9302b372910e..abd0f44ad63f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4355,6 +4355,100 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	return __mptcp_read_sock(sk, desc, recv_actor, false);
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
@@ -4376,6 +4470,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4481,6 +4576,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

