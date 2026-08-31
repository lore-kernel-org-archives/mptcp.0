Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F12D781B
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172096; cv=none; b=hNQIdv5sZpAQvbCS4oRP3YrcYFvBRRbr3cz+LqbvdC+UeFlWX9Anl2PckBUjRaLL/tQrkWeZo/3TEltJeCWVsXVai3wzkfphrDmd0K5DjlOecfVoHSxWSMDV5fl3QlmZyUyCmEcIWr5JL9+SLeDJmBRMu5HOw2C8zyEqyqfz+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172096; c=relaxed/simple;
	bh=hvRx9bMuRoxhz/keUiRaCJf8zUGtYUDptSltocORyL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k99jGVCNlfabRs5c9D6xf0fJ7wgyxF79HaH0u8PJUWAbu74Cl7DrnBHw8RkmeyLMfhAmWS1DSu+Qa0sI7ktGl4kfwkkUFZ5aL3I7wIR/cCqFsqtsCz9iW9Nd3Bs5BVnYe1sqPfxCUhcqdvMqKFIV2QHX0b2GDLZEoglxizi7BXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7FYuJNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7FYuJNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54051F00A3D;
	Mon, 31 Aug 2026 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172095;
	bh=f7heJShyy9c+XoZtAoqVyooP+l266foHfv6KjQsz0Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7FYuJNEIcbmQKqwCiOBHR44yWP5KnrIe1zjabIYsCe3GoAeX54/fnrB8aPL3RR7S
	 AHLU7aXz2KpPAyjbiKw28/g1Yq+1W2/Iah0h6crrBG3NoxQ3tCIONPmL6dBfaNrpiB
	 403lS/CWJcMINFpfgH7MKk/3cKdGcElb7UvJyQE4fxCXStC14VXMHtQhA4Zxpj0Wlc
	 YncGGeJWGl2W7Ybk3ZvOP1qT4Mf45YBwzvQ7F/1u5H5ADwLMf52+kRAMQqpdybWHSQ
	 0MRikK8rYpEuMrPr4TvEvSU+hqFG2GBEnSXJsfC3IuptPxibwO5+Evlxb/sTJH49iF
	 61U0pE2ZGEBow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v12 07/10] mptcp: implement peek_len for proto_ops
Date: Mon, 31 Aug 2026 18:27:15 +0800
Message-ID: <e3b429fed0496799c65d0a14bd00383d2620ef4c.1788171508.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
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
index f970b9242972..d34c32fc1adf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4813,6 +4813,41 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
+		/* Pair with smp_mb in mptcp_check_data_fin(). */
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
@@ -4835,6 +4870,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4959,6 +4995,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

