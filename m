Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E526CE32
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971563; cv=none; b=orq3DPIoQawrkN4GQEitS/oKdztuX+K8BplI2+fABoRF/KEt0EDlaTB0GYA8U5Vok6+wxgahBCPsTrUlvI7Q/16n5sKXV6wq37Wimi7diwrWP+KrnY+yjs/ZUbKpF+9PRCmi77gpVT+ggiutnWfh6Xu43EaXsTpDqz6JXy9F9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971563; c=relaxed/simple;
	bh=8OcwG1w3JD2kkjVs4gyvVCgMQIzZ3LgHLy2RSK3ithU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiJNUY5VBPiS2nWUcDG1MY0xAEo/uTCrr1QxKxrBFTyVFhWGq7OuvAnon+ZfebF8HNsHu1KR05uP3zYUUnSIn03NmMRx/pIJhVL4qvBryGbn44wp8geqJnMNULKA5xT0qu6tZIBxNqXo0YeropmfQDbSr5xKxgcqNNfUYE76jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1yYygIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1yYygIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0498B1F00898;
	Tue,  9 Jun 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971562;
	bh=BNWUb5CXXfh5aHD+Fkqba6f/U6vQMRu8EU0v+Z5kXiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e1yYygIzpeErLpDR3+eHTQOIXx12HOe/8hgci3IJel9agnSyofc/8eeBuU94yusKc
	 +nX43B+UPlfMaQcz7tWVfcYrCWxYTlaS/kDEUfpEo3KmkXGVgdmarD57eOb6OIdYa0
	 ymZ4jBOYJuiY/ZL71Tk7FOy8BlR7NE/7UzgUzFRIL42RhHji/GEoDSdBcedAtvoVx5
	 /mgoYAxyvljTmdgvHLxBF1JhyToqQqDITx65ofY8HtEUORa/dQGdGCeyxhql2BT+zP
	 56M8MOZZp+3WYo+yUR6sojMOytQtIpItyrkVL6G6JNi6CdPrJQalXdhkKlSDSZherT
	 z5XC9oP1Q54Dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 03/22] mptcp: implement peek_len for proto_ops
Date: Tue,  9 Jun 2026 10:18:29 +0800
Message-ID: <b17eb93495413decd9e4f5f1f02dec677d749663.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS stack uses tcp_inq() to query the amount of data available
in the receive queue without consuming it. For MPTCP sockets, this
information is not directly available from a TCP subflow; it must be
computed from the MPTCP receive queue and the current mapping.

Introduce mptcp_peek_len() which returns the number of bytes that
can be peeked from the MPTCP socket. It reuses the existing
mptcp_inq() helper (used by ioctl SIOCINQ). The implementation
considers the first skb in the receive queue, the current ack_seq,
and handles the FIN case.

Assign .peek_len in both mptcp_stream_ops and mptcp_v6_stream_ops
so that upper layers (e.g., TLS) can obtain the correct in-queue
byte count for an MPTCP connection.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7f0c560f6b7e..18c8b6c64c3f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4689,6 +4689,38 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	skb = skb_peek(&sk->sk_receive_queue);
+	if (skb) {
+		u64 answ = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+
+		if (answ >= INT_MAX)
+			answ = INT_MAX;
+
+		/* Subtract 1, if FIN was received */
+		if (answ &&
+		    (sk->sk_state == TCP_CLOSE ||
+		     (sk->sk_shutdown & RCV_SHUTDOWN)))
+			answ--;
+
+		return (int)answ;
+	}
+
+	return 0;
+}
+
+static int mptcp_peek_len(struct socket *sock)
+{
+	return mptcp_inq(sock->sk);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4712,6 +4744,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4825,6 +4858,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

