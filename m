Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6401A3142
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714271; cv=none; b=uSlDo5RnjmU3lyDQWKmGNLIRP/zpLO3xzuYrwRlmGP9HoLUzcBPH80KGMROncoKEMZtcWlLf47lqeFEaxMypjMtbma3vb3Um7aFW8DFaUuYXWmaNRzaaVfRJRFvMTBhZ9XyxsC2LFrXVb9Ih67GevfX2NiRbFwVvWqcfurb46jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714271; c=relaxed/simple;
	bh=Pgx/Nua0LJOHCsmctJe/HQduKGLc+j6spESnB10SWiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlT9p8yYjEUJw2wOvPi+l0R9KY7qL8V6gNgcKSBCtQoEIWY/eaiPqc2Wr8t9GEl7DZCQGVaBzg/TF/oxFkQpMaEaq3C+ObqjZTQ2MRA7Bf5xemA5VHZdCiX0UfXlE0flWagl0bInzxodQCO1e0w6PQJnMPfL7sXW6CRs/R7HHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+uiSXDM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+uiSXDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E76C4CEE7;
	Sat,  5 Jul 2025 11:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714271;
	bh=Pgx/Nua0LJOHCsmctJe/HQduKGLc+j6spESnB10SWiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+uiSXDMO6jjz7sbsSo4EaPvmGkcIY6h75A+VvSGg1OQOIdyEoY0URZzNXkFR622U
	 AM7eub/HPSreICjIWUEvNOfVV62+COKtS1ojsQAXf3cndIFtMHSZiUR6Ro7zUPo0xN
	 YvHzzglR6aeH6Hs85YmjareigADzsImKIb2vTBoibuXw4s8AWWrpEK5XzIddODqIu2
	 PCgGY+tiekF2t/UkAyxcoEERgBuqGdMDtDyelNPFsxSu0beJUL2eesCUAHoJCYYHYO
	 CohQ7z4OqmatIxv5TOOB1zl1Fq5KIuBjPdFPfxCxXU+zYeqzjQDqDcaClqtN+6C8cz
	 qPfx+e8UbBhiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/4] mptcp: implement .read_sock
Date: Sat,  5 Jul 2025 19:17:40 +0800
Message-ID: <e2ca3f77c73a82f75b9e63f1d6476dd801a9bb79.1751714072.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d1e5f72a9d6a..7d58bb3f9fa3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3957,6 +3957,72 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static int mptcp_recv_skb(struct sock *sk)
+{
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
+
+	return 0;
+}
+
+/*
+ * Note:
+ *	- It is assumed that the socket was locked by the caller.
+ */
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
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
+		copied += count;
+		msk->bytes_consumed += count;
+
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			break;
+		}
+
+		/* avoid the indirect call, we know the destructor is sock_wfree */
+		skb->destructor = NULL;
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, skb->truesize);
+		sk_eat_skb(sk, skb);
+
+		mptcp_recv_skb(sk);
+
+		if (copied >= len)
+			break;
+	}
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -3977,6 +4043,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4081,6 +4148,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

