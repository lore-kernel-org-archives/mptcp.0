Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24E14EC73
	for <mptcp@lists.linux.dev>; Fri, 27 Jun 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040089; cv=none; b=gzUXFtjTyhdeQI5/ak+EwCUe9iC/eQEocROMZ5D0bxjKlbl1WK7CSZth/8fJTQfu4rYwECqIfBUr8unCPR9JrLtMZtlS7eWr5GLDyRXgV43EuMIOj2QE7azxu7hNf9IVCmwq0VZgs8PRTJts6EkQd8stUO8uIZsqV7wJ187LDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040089; c=relaxed/simple;
	bh=JWZpxu94DK1POxA2FzHwmvjhPCH0nATuXGwwzNgtbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRveEvZSh0oZ6Oo5Uks4exTQknZBd7wjixjIqoUP3E7fAEUgtYEDk/v2Y0YIUOTFYP5Zqyc7s//3YBtFGfSAF0mJr5DkLHC4kwKtijrV25pYNescHEiEL9NRDhHDQr0KnacWf/nfIwLZ/vXjBwbE3EA9aQwsrMv3jF2q2JtcqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxZGPYT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxZGPYT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354BC4CEEF;
	Fri, 27 Jun 2025 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751040089;
	bh=JWZpxu94DK1POxA2FzHwmvjhPCH0nATuXGwwzNgtbqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxZGPYT8pkyJoCaaZ/IVvdHTa4AWsxfIi888Gwd2F/ByXGIB8d6S7l+xCz6t8Lrir
	 eLLKHKl1WhbTTlieFTNfR45hWnEAyG/NliPrLAOmL3okkkSh2tKkEnWI4DEP2gj8wm
	 /sdnKPgChou07yvD/WpxzNQKjTjahg6I7KGr5yybVP46S4L4hXjPmSYalc/tpP85IZ
	 asH2UO7kWCnLAyYEXXmFQbpmFJ69aaDoHpwukfIJh21/EJmvd6doVZVeEf2pEJkGAL
	 piCcAy0J0xvdjBwa80zx8A8BCJ3dAglOH5iABt+bqyIO5tgLSTDVh79WE4DCZo7NKN
	 1dBIKk20s88ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/4] mptcp: implement .read_sock
Date: Fri, 27 Jun 2025 23:59:41 +0800
Message-ID: <886fea2d7d2d71ace157bacc1b38dc7ce2e4573a.1751039657.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751039657.git.tanggeliang@kylinos.cn>
References: <cover.1751039657.git.tanggeliang@kylinos.cn>
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

v3:
 - Use sk->sk_rcvbuf instead of INT_MAX as the max len.

v4:
 - invoke __mptcp_move_skbs.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f747ab730e5..10cc8756877e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3956,6 +3956,68 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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
+	if (copied > 0) {
+		if (skb_queue_empty(&sk->sk_receive_queue))
+			__mptcp_move_skbs(sk);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -3976,6 +4038,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4080,6 +4143,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

