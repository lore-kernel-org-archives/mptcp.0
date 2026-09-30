Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62902343D7F
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735317; cv=none; b=RTJcl0hhX6JtxQX7Qi69YgWUZpGaCqwe+T76Ebw+8f/6R5E+S9YLGKwgY7njyndRowVh6acbWTMNOUSy2KmS4+9E5bx5OGxWwTJTCf9GaPVbODlnxx9m96++NzQhgcDfTSVs9IdFzILioNGL2EINQd8zFi8m96lf9cnQQFTbUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735317; c=relaxed/simple;
	bh=zGERlKiHo4mFFzIf9inBHN2WnV1pkCsrohv+OxB/API=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpkvmLARUokjgR6tNJq0CNcIfrGWVyhpC10wrR0O+Jkl6b45TjvC4mlFtRmJk7YuAlm+xIjn26VDAQZdwFNo/xMOaT3b0XKCmrLpXIhelgQYCIM+q62fI7SQoHwRdMFLVj5BaSLU1zgo712I8qsLrDDBOGP750vQF9JrYzNMEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw/V+m+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw/V+m+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DF91F00893;
	Wed, 30 Sep 2026 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735316;
	bh=fwPfJ4O2rdI2mGLvbd6W1LqHvu4M8E7KESGTc87qUpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jw/V+m+nQz/QK4tcZSr+Yh3RM+oZpf5l/qCRpVKFemDb7KusCgBpIBteLTotk42XN
	 SD+uUyCJT57bq3YiJmX+gTnK3PLXxQe4QSc6IUwTYKGA1vgP4aQw4V2iwMbCbAbcDO
	 5kU2gx3l8a7hffcZeanfXWoTUUzfOTcA3l7Kw/ZmQIQwjiPlZIFlZ3KUX6eoQs4VgE
	 iBvXOTFWIVCqe994uVK1ZkRKYyyVr21LX00uC+euQA3Gr3txjSalAsrXnVuwGTBRBG
	 tNwqydIBxIUpaW5YJ7fcB9cRoEB38LoQlrZbj8RHv5nLNc6rABORpD/4eAFZlvFii3
	 ToSJPWI6fQhBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v14 07/11] mptcp: implement peek_len for proto_ops
Date: Wed, 30 Sep 2026 10:23:41 +0800
Message-ID: <3ccb18c2210da287ff7c13b9d28d85310e2b671e.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute the number of readable bytes at the MPTCP
level. It derives the count from ack_seq - copied_seq, returns 0 while
the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), and
subtracts 1 once a FIN has been received, mirroring tcp_inq().

The subtraction is needed because MPTCP's ack_seq is incremented by 1
in mptcp_check_data_fin() when the DATA_FIN is processed, consuming a
sequence number without carrying any payload data. Without subtracting 1,
peek_len would over-report by one byte, causing upper layers to wait for
data that will never arrive.

READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
ack_seq and copied_seq because mptcp_inq() will be called from TLS
contexts with the socket lock held - taking the spinlock would deadlock.
On 32-bit systems a torn read can produce a wrapped subtraction (close to
2^64), which is caught by the INT_MAX clamp. TLS callers use mptcp_inq()
conservatively: over-reporting defers work to the next iteration, where
recvmsg() provides the actual byte count.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops, so upper layers get the
correct in-queue byte count for MPTCP connections.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7eafe904dbc6..84478bace0ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4819,6 +4819,41 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	int answ;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
+		answ = 0;
+	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		answ = 0;
+	} else {
+		bool sock_done = sock_flag(sk, SOCK_DONE);
+		u64 hint_val;
+
+		/* Pair with smp_mb() in mptcp_check_data_fin(). */
+		smp_rmb();
+
+		hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
+		if (hint_val >= INT_MAX)
+			hint_val = INT_MAX;
+
+		answ = (unsigned int)hint_val;
+
+		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
+		if (answ && sock_done)
+			answ--;
+	}
+
+	return answ;
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
@@ -4841,6 +4876,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4965,6 +5001,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

