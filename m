Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707728642A
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905803; cv=none; b=RTKq5Nm51n430Ng1duNk1YgH+7Jl99iDQ+ud/kqSLfDixTE00emHJ3xo811CKA721167ErUmyE+0/DMZ71XvG6bF9nipQvd7ud8q6+H/BCT+rhbTTnuPYuXrSKi/4JAPACn6zzF+hamLuIKPwJvbbglgQ4ZpbaiTjCecT41+wNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905803; c=relaxed/simple;
	bh=e3QZcKAhKjjHqiT35zOEq8pO76m3DlLR6k5jneXZZGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0x3Q6BFq7UYQyBusprfrHkhTM4x9KgOquVb8YHsP8dvHswNM0ly4dMdrT7Zf4FjYGOLEiy6p4TEPwN7Mww0v7C0ln0cvQHjCwYHbvE3WDejS03YgPAht4VznOp3h5saFfOpb2FhVmCzP8p6LUdrXMfcQIkvI0wy8ZWKOl2DC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQaqUm62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQaqUm62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2F2C4CEEF;
	Thu, 22 May 2025 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747905802;
	bh=e3QZcKAhKjjHqiT35zOEq8pO76m3DlLR6k5jneXZZGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQaqUm6211V5DTpM41n7KZcQQghHF908plIjrL35EHRQpGNqocbqcem0D3s7tBkWN
	 aW00Hu11ereiL0cqtUspl8gPaQwAi7k8XnQsDH9WZYBTVO/9I8cGaF1Us0Ym2CR4Ee
	 FIgxdPUgW2CD6b8rQ+uk7AB04Ln3cSlEmXjpDSheusxpfcNQ01ZZ/zg8A6ZKnX46NQ
	 ZI9YQaMMIY6Ol1+7u3BVhRhns3poARJfpAYnezkDsSmwjTAWvoCV5K1+o8RqMvMwVD
	 nuCj0xRI2N6w6LvHvSv4w1J6ZBp/dGF05XSz3bSzaLWVVKp5CauI0WT3ORx4iCha1n
	 nNAqDhaIkoAzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: hare@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: implement .read_sock
Date: Thu, 22 May 2025 17:21:33 +0800
Message-ID: <1f7ebd44d183d92aa891d99b2192bd812eeaeb00.1747904572.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747904572.git.tanggeliang@kylinos.cn>
References: <cover.1747904572.git.tanggeliang@kylinos.cn>
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

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9094cd8bcd0..e5c69b13dbf7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3956,6 +3956,58 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct scm_timestamping_internal tss;
+	struct sk_buff *skb, *tmp;
+	size_t len = INT_MAX;
+	int copied = 0;
+
+	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
+		u32 offset = MPTCP_SKB_CB(skb)->offset;
+		u32 data_len = skb->len - offset;
+		u32 count = min_t(size_t, len - copied, data_len);
+		int used;
+
+		used = recv_actor(desc, skb, offset, count);
+		if (used <= 0) {
+			if (!copied)
+				copied = used;
+			break;
+		}
+
+		if (MPTCP_SKB_CB(skb)->has_rxtstamp)
+			tcp_update_recv_tstamps(skb, &tss);
+
+		copied += used;
+
+		if (used < data_len) {
+			MPTCP_SKB_CB(skb)->offset += used;
+			MPTCP_SKB_CB(skb)->map_seq += used;
+			msk->bytes_consumed += used;
+			break;
+		}
+
+		skb->destructor = NULL;
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, skb->truesize);
+		sk_eat_skb(sk, skb);
+		msk->bytes_consumed += used;
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
@@ -3976,6 +4028,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4080,6 +4133,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

