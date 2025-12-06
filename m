Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FDDDC5
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024472; cv=none; b=lTCVJv8NQEsQ08O4AmvumXUUzjU2/faN4KcTOgqyHOWKJcXD07LufkpZJi4YjxO6yULkGIYl7wEVJaxwf71M9desh9AEkLrrlhBokPxN0nDw8IbATsEkFXnBxJL3SdOVtQZUUblNbkpbOyIUqtZtkhL9nSyD6DxVmMfxIVepng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024472; c=relaxed/simple;
	bh=49lsmvuuJEyPxMr0mre3SjmAsVnOoqyeVqmxKzVhCas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqsZd9b8G/lqbklt3EEk1nvL0QBZgXrKrKBv0Qt6Stev+f7HG33OXEVmd/hzuK3wr/Ygp3UCUOZHgUkghUGmREjqZhf3Y92+QmzCB7ImXtw9UkMQ/ni30nHUtSaZQT9r0uJymVoMvZrluUkFOCjw5lzIfqpI6L0RkzWBy0dav/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWn0lNJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWn0lNJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0B2C116C6;
	Sat,  6 Dec 2025 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024471;
	bh=49lsmvuuJEyPxMr0mre3SjmAsVnOoqyeVqmxKzVhCas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWn0lNJVZpMjEbIdnIH2M1BpA812y/VhJov8dWfDApvH2mdWDBjKi6daIjEGI/+zi
	 UUid9j9hCUyu4aXEXTDJ91cvKDf7kGoYgW//GoB/eBQiqqCDKJaTbjCUXLtfkyILQf
	 DNOX7poh5XX2d+/lDoqtZ63hkAiuOxtZ8bdAXzFSlcQ5B+GZxnT5na76wFYjmri/yl
	 bGkAlA5PjeyG373yBC1UrRIJSILLWgor2sZ1hyZvSVkZX78PvmLVa+Mw/URNryS76P
	 KnheZGs0fc/KjHOEIZz6ud5Fqxso6U2JIqcioK+B5dKc3KNOmunI2Su7i47m8IOvF9
	 /+C0qelDk3x0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH mptcp-next v15 2/6] mptcp: implement .read_sock
Date: Sat,  6 Dec 2025 20:33:52 +0800
Message-ID: <6d5470547063a740c0eb2f80655fafd7dc47716e.1765023923.git.tanggeliang@kylinos.cn>
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

nvme_tcp_try_recv() needs to call .read_sock interface of struct
proto_ops, but it's not implemented in MPTCP.

This patch implements it with reference to __tcp_read_sock() and
__mptcp_recvmsg_mskq().

Corresponding to tcp_recv_skb(), a new helper for MPTCP named
mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.

Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
sk->sk_rcvbuf as the max read length. The LISTEN status is checked
before the while loop, and mptcp_recv_skb() and mptcp_cleanup_rbuf()
are invoked after the loop. In the loop, all flags checks for
__mptcp_recvmsg_mskq() are removed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d67c751b7a9..01d602f0d556 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4322,6 +4322,86 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	u32 offset;
+
+	if (!list_empty(&msk->backlog_list))
+		mptcp_move_skbs(sk);
+
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		offset = MPTCP_SKB_CB(skb)->offset;
+		if (offset < skb->len) {
+			*off = offset;
+			return skb;
+		}
+		mptcp_eat_recv_skb(sk, skb);
+	}
+	return NULL;
+}
+
+/*
+ * Note:
+ *	- It is assumed that the socket was locked by the caller.
+ */
+static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			     sk_read_actor_t recv_actor, bool noack)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	msk_owned_by_me(msk);
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		u32 data_len = skb->len - offset;
+		int count;
+		u32 size;
+
+		size = min_t(size_t, data_len, INT_MAX);
+		count = recv_actor(desc, skb, offset, size);
+		if (count <= 0) {
+			if (!copied)
+				copied = count;
+			break;
+		}
+
+		copied += count;
+
+		msk->bytes_consumed += count;
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			break;
+		}
+
+		mptcp_eat_recv_skb(sk, skb);
+	}
+
+	if (noack)
+		goto out;
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+out:
+	return copied;
+}
+
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	return __mptcp_read_sock(sk, desc, recv_actor, false);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4342,6 +4422,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4446,6 +4527,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.51.0

