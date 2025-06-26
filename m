Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053625BF08
	for <mptcp@lists.linux.dev>; Thu, 26 Jun 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927327; cv=none; b=XE4Bql4S64AsJ0OVPKphYNS/ec0yUmgxf46/PWvxX8cMy+bpSoYHEijm1OEmP3c/aggEjYqj0HNse3uBdRsKxsI7bAczCQvEvJr5lcVAhGZp51v9kiR7/bq7WGd/1NIcsC8IoHq4jv2U2pe8WksJ+Up4sOH47IUzzsIUVDc5QZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927327; c=relaxed/simple;
	bh=CmcjnRV2h9bswc/VZ0U852+Jdm+rShc+0jP8f4GZ6+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov2y0L+18lc1i2FX3RYZnC3ZJaY1tiIRnfoK1ifxK+RphSu21bYcuw1xJeXgVV/6Wnaje/R1S1Ut5eNc3+b4WjkJSDgGQmwtWwyFaUbbkzvTSObIY7Lb7IysCKRw8YO8YCdwAkDDEE0luN1ZztT7eGwx0qgj5Nr8AWnB6MTWMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw6ViJhU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw6ViJhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C4C4CEF3;
	Thu, 26 Jun 2025 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750927327;
	bh=CmcjnRV2h9bswc/VZ0U852+Jdm+rShc+0jP8f4GZ6+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw6ViJhUZ47gBol+I6AqFjQ6aMbVGhbvgSLOTYG0hDSglRr4KbjIWlrC606Yf/qx9
	 80+3W10/92a01kUS3ASJ3WitgDuBqEckg+FxJu5ONqMmNcLd68akGClPcereIC21IS
	 ABjVHCaSIvR9bH+ItT+pOAJY0kWziqptJ4A9JhCS7M2pih/aAg3yyQ7EpuPOGIkG1/
	 3pBFVR6udcKMH9od2VhZz30EGWXbi3kNetIwu7ZAAbFKXtRobrmVxwo/CGo0dZJ2nu
	 nZTBHMKn+SzeziU3avpIQ8Alezlocz7kUjNnO3XvVg58flG/x7tFPsZ+4bRO4K4slY
	 2tGyCIkfn+V8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/4] mptcp: implement .read_sock
Date: Thu, 26 Jun 2025 16:41:51 +0800
Message-ID: <c78b5e449f84bd04c94add52dd6b69d84ecdce71.1750926916.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1750926916.git.geliang@kernel.org>
References: <cover.1750926916.git.geliang@kernel.org>
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

This patch implements it with reference to __mptcp_recvmsg_mskq().

v3:
 - Use sk->sk_rcvbuf instead of INT_MAX as the max len.

v2:
 - first check the sk_state (Matt), but not look for the end of the
end of a connection like TCP in __tcp_read_sock():

	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
		break;

This will cause a use-after-free error:

	BUG: KASAN: slab-use-after-free in mptcp_read_sock.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f747ab730e5..488a673f4da3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3956,6 +3956,65 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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
+	size_t len = sk->sk_rcvbuf;
+	struct sk_buff *skb, *tmp;
+	int copied = 0;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
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
+		if (MPTCP_SKB_CB(skb)->has_rxtstamp)
+			tcp_update_recv_tstamps(skb, &tss);
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
+		/* avoid the indirect call, we know the destructor is sock_wfree */
+		skb->destructor = NULL;
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, skb->truesize);
+		sk_eat_skb(sk, skb);
+		msk->bytes_consumed += count;
+
+		if (copied >= len)
+			break;
+	}
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0)
+		mptcp_cleanup_rbuf(msk, copied);
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -3976,6 +4035,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4080,6 +4140,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

