Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C481F1315
	for <mptcp@lists.linux.dev>; Sat,  7 Jun 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749286510; cv=none; b=nGr2wkPLES8DIvwgucA/GdNCHLVUBWUiw4VEptEg9zGL07H7WpmEuLUnrLQEDeOJ1jRrr2VvD/4Hnxoohh7npdrep84T8pZQ88zQXfupWWefP7+sd90M9outCIw4HGzSCwpWHkCc7yNjrJn3aj0Pc3UVxr2wAjHd3jFJO41cMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749286510; c=relaxed/simple;
	bh=iXP+eXD0Iko8Ej1JcFgDkE0uBeEgKk3crTkDqsVbG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT7VM84ijtCT66QqwhaqjYFH8Mwh0UZw8vusk3v34phq+A0uj1ZIJnQS3fAe9qzj3eTwvje6AKyO9fDy5JcceB6parmEtFmrAa1zVmjIGOefwqpxBUnLz/YcPYlSzocqpFjUT5TqSETBaQtXUCnQkPxOCC6SQB8NQzk7Ui5t/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3NinwLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3NinwLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD8C4CEE4;
	Sat,  7 Jun 2025 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749286510;
	bh=iXP+eXD0Iko8Ej1JcFgDkE0uBeEgKk3crTkDqsVbG1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3NinwLyuMsj6ECbVSjs41AvBYVBYIwV0K+/rZd1wZWpv588/QicEewOqftdHV1hu
	 NyTiegRQ+rNMUTrFXBmLjnOt/HRv95fMx65su32C4/O1/V8ROuND/9nS7Q27GEg/3V
	 goxtNxDgrAnTw3iGjbaCnT8zIeGeBBE8NUReNNiDk44Cw+Y/+eJSdjT3dDr1lCBi8e
	 a65qqNQuOUFMqfGwpmrNLOw6T6ub9BB4wZ7a3QDb35xWBX+VxVFrqj0nin9auaWGb1
	 9iFMwSNR+y9h09qPtAk6vXfOC8nUmxlwo9kz6Dbc/t+Ww5fBQH8u3UyHd9Do3lnzPs
	 UodoEFjN4V0wg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] mptcp: implement .read_sock
Date: Sat,  7 Jun 2025 08:54:17 +0000
Message-ID: <32cc946892d634a14cdf4373c1b9d47126162e5a.1749286212.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749286212.git.tanggeliang@kylinos.cn>
References: <cover.1749286212.git.tanggeliang@kylinos.cn>
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
index 7fc940a60b3d..da4242e48246 100644
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
+	struct sk_buff *skb, *tmp;
+	size_t len = INT_MAX;
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
2.43.0

