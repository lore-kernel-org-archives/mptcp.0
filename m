Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC833596D
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723948; cv=none; b=tbmrqFcF4626t7xpCjv0ViDlaXd87FjaqvqkSQ8Yj9LIBK2L3Y8hMvXfvDlmz5igDsLLGvytM5zoo6acl/ZS9rxWl8tvrgJGo92uEsGzUO88iZIDPJvUIs2MR1lHiTbb3PgKXhVzu4sJTuAP4ReBju72qHEHrR8aom31ztB9H9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723948; c=relaxed/simple;
	bh=rFYQHttFTVLHAoAm6UzMtZ9AKpPh6ODCCqM7lEMAy/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT910EOgLsWk4vEtP2QnUbGXROqSph1mIgWnf1EdQSHX6EQi8HuxoXMbzNYITOY3Mz8fUJ7a0oW8TcnnFPYt62UrgSn3L2L4ap2Z4ZVbhmqi+r4cKtZehABVN5xEYZxOYnrFq8SbPy5mEcCdzhsSY43xXV9N5KPKf09m/1Nwfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOaidova; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOaidova"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC44DC4CEF5;
	Sat, 13 Sep 2025 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723947;
	bh=rFYQHttFTVLHAoAm6UzMtZ9AKpPh6ODCCqM7lEMAy/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOaidovaHXlkiNtMtHTv3MKCzkWSN2SPVuTRNiVI4BUKe3C2EzoK8CkojNGzRD8Bs
	 XkBmcLuRkjt9AnGa9aRW36PHuAG2Whi83iv63ObSqFrdooYzDO1cn9D/8XAjWsMwwP
	 dAfwULp6R+pHW3gdiGVqV6lp1x8gsi3ydWhyfInF77wkKUhpccUhXq3HNVuwW/t0UZ
	 NQIfA0HzddDRSJd99WtxQXoS4AwBKsBb+K4srOkO6M1OuygzxoX5Rq/xNVRXMI8775
	 THjhHYXZDpDjkTq6g0rmgMiNmWilnteu3awn1A7zPpP8fR7EQxavbYqoTA3l6niCAE
	 7WEdbmKtbPfPw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 2/8] mptcp: implement .read_sock
Date: Sat, 13 Sep 2025 08:37:21 +0800
Message-ID: <9158471b0d4fcdd7f9e66a8c1995a8bc997f4b68.1757723270.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 882b68a02fb9..00fe7531ba8d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4051,6 +4051,78 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	struct sk_buff *skb;
+	u32 offset;
+
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
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
+static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	size_t len = sk->sk_rcvbuf;
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
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
+
+		if (count < data_len) {
+			MPTCP_SKB_CB(skb)->offset += count;
+			MPTCP_SKB_CB(skb)->map_seq += count;
+			msk->bytes_consumed += count;
+			break;
+		}
+
+		mptcp_eat_recv_skb(sk, skb);
+		msk->bytes_consumed += count;
+
+		if (copied >= len)
+			break;
+	}
+
+	mptcp_rcv_space_adjust(msk, copied);
+
+	if (copied > 0) {
+		mptcp_recv_skb(sk, &offset);
+		mptcp_cleanup_rbuf(msk, copied);
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4071,6 +4143,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4175,6 +4248,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

