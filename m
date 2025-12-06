Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B12F362D
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024478; cv=none; b=h3ggEn80ccVD93Z5zOV5/Urwq5k5ydXn/N+0PwRIGI8itRa4VxzhcvVLzwXjNjtW+p26ll+vCpEXWbAd1f1gEtQwkAGQ3xK1pQWsvu4r9ktwN2P896AKdIGP0Om2fxf1gMig+jvnptTWgX9DkCchm/weygWR4mW8+KfuDjSbSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024478; c=relaxed/simple;
	bh=E1XqA4fai0Wx3ZysMUZJKwmMyGhAm3RF0vAtKKLLG/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e87bWFNkkIO4ozagpEju/ZEWRsoZ67rkTDqQj3jK16Xsbi+bUTvQKVyJEozXWvtueVoEAy5GJ/lQO2YAWcl5dMmQBFvY3GZ9LZpT4fy7GkXdTaL5Gq4XMbKN79w9BcpiUd6o1MFud8dBp/sORHI9+VW/OskoFweSv19PyEoTuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF9rPrWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF9rPrWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5870C4CEF5;
	Sat,  6 Dec 2025 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024477;
	bh=E1XqA4fai0Wx3ZysMUZJKwmMyGhAm3RF0vAtKKLLG/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MF9rPrWMMNDRV3DxgswXkSFRlEXzy1QZ7XVjJm0rTVHlb3dCugcgGQz3BshPCUGuP
	 ijsUDhYiSECI6O0fACHEAGT9Q35TzaOz86i48QFOqLBmge8ozvJB3epeqBQy0HR2cC
	 K3wGsOVM5beZuJb39Q91XQKdQZ/FDRHOwycYbE38rHbyX4mwi3/NKusSVMZ76oZIsv
	 x94B79YyaNPVYieoHjf52yTrglSmhmfWBRsF42SlWKcBFN8cHMslXexJ2GTeyDJwrS
	 JldRfjPBY3twMKbr9X+J6CWzIcnd7jg6tFjIVzi8gi0I/QGDyYSjbXu2jbTCpyzwN3
	 LwzsajMgIl5ag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 4/6] mptcp: implement .splice_read
Date: Sat,  6 Dec 2025 20:33:54 +0800
Message-ID: <eb8faceedfba8da224fa5467dd80d0c7f99cfd3f.1765023923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 114 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01d602f0d556..334fdb10fdf3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4402,6 +4402,118 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
+			if (spliced)
+				break;
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+			if (sk->sk_err) {
+				ret = sock_error(sk);
+				break;
+			}
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
+				break;
+			if (sk->sk_state == TCP_CLOSE) {
+				/*
+				 * This occurs when user tries to read
+				 * from never connected socket.
+				 */
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
@@ -4423,6 +4535,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4528,6 +4641,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
+	.splice_read	   = mptcp_splice_read,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.51.0

