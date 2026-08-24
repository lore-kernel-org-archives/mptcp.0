Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE93B38B8
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555397; cv=none; b=WyTZpqDF/6D3XE+W4TS5id+fQp+nVlgnSHGmQcD12rpY01WuLC2x/laSEq0sCwH4Rw5tNCyO7GztJ4M5Puyo480gWVqnDCMAYWgMzjos6oTr/AQC3XXlUmEC3BbGxekd+CLFJfq1SQUg0mAQF8Qt9MUu4CNT+XcZ9+IhYcCwCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555397; c=relaxed/simple;
	bh=MLPpCFnlVHdKH0YT4JNQqgaXXA/asFo2bBHJc9ZrGbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hge3TZ7W29jg5UEEzbRztRwsvE94dKo+BvrI5CFRD5xkkg6ZsmknlqjyAKVyp+ASa4Gn0GO1cwVlB+mjwo5we83PoMVUDt4m5D/gY0SLdLqiJJF2MD8GR4HNrVRSEyGiOgmy5+dP2bkWJZbfZtaZyvmHxZzh3Bo/bBurL/L0qwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDuYKo2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDuYKo2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847951F00A3A;
	Mon, 24 Aug 2026 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555396;
	bh=gnLT7DFSG0k5UFIBMm5gjr+AKwluIYqbAvHgDXeLbY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DDuYKo2CmcFVp1H7NVhlELVekm+e5PRhw6dAljZFxJK5Oz+TZfU99wE/Lxx+v494Z
	 ZvthNk2xsMrcrnlIfscmGBJ1SDRgcZhKvOesWINYrgu3jmcOgEF+S5TucEYgIuBHcV
	 tItaXKkW244EzeVCtYZdGCKKDev7VK7FqoExHHofpk/JaC4srmjY88NXrd+iVnT8SJ
	 uLLte10Fmd881pDzFkOw0f3XbG4lKi9wUa3poQgdUdRYcJAWPvDOWbPxxQbFtYrUPT
	 O7LtjLHoMRdRZVeLb38TpYeKQm+NXnGX6r+GhVbg+H21YJKwWHip3dSzkwoe3u82op
	 z4mVBBNBsaRHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] mptcp: implement read_skb for sockmap stream verdict
Date: Mon, 24 Aug 2026 15:09:37 +0800
Message-ID: <e785dea9d7ecfff7d8d49862833930cc742df5a4.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

BPF sockmap's stream verdict path (sk_psock_verdict_data_ready) calls
ops->read_skb() to dequeue skbs from the socket and pass them to the
verdict BPF program. MPTCP's proto_ops (mptcp_stream_ops and
mptcp_v6_stream_ops) did not define .read_skb, causing
sk_psock_verdict_data_ready() to return early without processing any
data. This made the stream verdict redirect completely non-functional
for MPTCP sockets.

Add mptcp_read_skb() as the skb_read_actor_t callback. It uses
mptcp_recv_skb() to peek skbs from the MPTCP receive queue with the
correct offset, adjusts the skb via skb_pull to skip already consumed
data, unlinks it, and passes it to the recv_actor. bytes_consumed is
updated after each skb is consumed.

This follows the same pattern as tcp_read_skb() in net/ipv4/tcp.c,
adapted for MPTCP's receive queue semantics.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 265a07e73a52..c1e26c6e5c17 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4780,6 +4780,36 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *skb;
+	int copied = 0;
+	u32 offset;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+
+	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
+		int used;
+
+		if (offset)
+			skb_pull(skb, offset);
+
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+		used = recv_actor(sk, skb);
+		if (used < 0) {
+			if (!copied)
+				copied = used;
+			break;
+		}
+		copied += used;
+		msk->bytes_consumed += used;
+	}
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4803,6 +4833,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.splice_eof	   = inet_splice_eof,
+	.read_skb	   = mptcp_read_skb,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4916,6 +4947,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.splice_eof	   = inet_splice_eof,
+	.read_skb	   = mptcp_read_skb,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

