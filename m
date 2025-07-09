Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510226B955
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045950; cv=none; b=gi2dnyicJ6NE6hlZ3KxBozDmbwPv2hR+Lr/2+d/lX2Fe72VQbSfIxbmKuRS0EayRdFmLmpHqwqCTjYNqllt2pquk+NWrpZTtyd/uYwi90PANnUG2WASrqbKZzF1xq2sRGm4vOYqdy4+Jp6cF43Z4qGbbQ0F7P64CGy3JJ6m89MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045950; c=relaxed/simple;
	bh=8n62puhLgGmvz7HLSvNtW2zCtRBzAwcgEE++VU0F8JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6zz+kRqICZ7JYmeDqEa+aqBUspVDWAE+kXbKOxaU0jj1iHqNcz6A2EiLIz6wRzL7hxtO8hO5aUanTRgf3BdnVTe/pq+r5COv85bft5GSkppR26Q7DmTpQ+M2wafmRZ7jqQ3PbShyXgjbYTHsNkuoNoBJHBFBoiW0+7Tp5K+2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUR9RLkc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUR9RLkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE696C4CEF5;
	Wed,  9 Jul 2025 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045950;
	bh=8n62puhLgGmvz7HLSvNtW2zCtRBzAwcgEE++VU0F8JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUR9RLkckiQeNMnyYwm4UPgSE+VDC44Nf4iYxxEhGuYtdTOvQg0UCrU1IPPvBmrMv
	 yFY75iJUI1+x7Atds1EixHJGTv6OO40G9ikuyNoQvNS7Z2OJb512oJ211TZT4VSk5S
	 lJsBsG/ZSpt1VMJMRsK1cRsWESdF3U2gzKRAVThcJ1/qS40HGCCsA+2VUBY8Xw9E1V
	 RsoWaqMONPuYVpxqwgjeSwKE2w1lBVSSueIx7A/+kn9jgC+P60GxYI+ekud7Z9ubI7
	 t9ee3t1VaKSvTgaAD4wC7Qr5NUV5ZT4YvhmRWlJixs0BZEYi9rCSrzT0w8+/qQEHtM
	 OrAn682/vW9dQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 2/7] mptcp: implement .read_sock
Date: Wed,  9 Jul 2025 15:25:29 +0800
Message-ID: <6d748c65b678c6040448eae87f4daf264b2ed023.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
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
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48365d54bc06..fc429d175ede 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3962,6 +3962,67 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
+static struct sk_buff *mptcp_recv_skb(struct sock *sk)
+{
+	if (skb_queue_empty(&sk->sk_receive_queue))
+		__mptcp_move_skbs(sk);
+
+	return skb_peek(&sk->sk_receive_queue);
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
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+	while ((skb = mptcp_recv_skb(sk)) != NULL) {
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
@@ -3982,6 +4043,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4086,6 +4148,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
+	.read_sock	   = mptcp_read_sock,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.48.1

