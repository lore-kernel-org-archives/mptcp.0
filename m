Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1D2C0303
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245365; cv=none; b=JxSYJ517Znv/kyp5KYEZglCq1MCW6tZbH/CHvjTIm67SaR2ilnc8JOPxJ8Qj3scQY8b/Fd7azVYJb6CKATruSrS0XCxRCa2AEqSSXHTlTVHw7CZhkD8+FYY8ozNzIOdap72Ou4Gk3QKkhvSOtxh6FzRbaEI+COZs2nbsEN/Red0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245365; c=relaxed/simple;
	bh=61ly/NtZSVe8jUrEZ5W6PUqEc7SHyDrvkUUD0f7w6wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr7hjzcH/yRozRb6VNL88ETMmBpi78ug5y0flnff6y2RY90ldoQtZAoyfPfddLr1RGH5Sq9cuMS/pxSivjPNNo6agVKvlEd0eIJNnJPypNJRGOOLnmoav1QzV0Q+DupynE2YZUMpGQD2J53PGDUPOmympQSkQ/0vLPAt5NEO0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NauutG5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NauutG5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81091F00A3D;
	Tue,  1 Sep 2026 06:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245362;
	bh=cSpx4PAOfJB27zRYipeFrX9v4SDJpQo8KvZLe6G46N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NauutG5ueyHetrevL3n+myMV1iHeJ/GvuqjOB80JjI8nFcstnNyql0FR90hSuVCQu
	 lmf3t8CRpIiiN+HFZV0x4u1hSdyYOPlEdXrWvLZURhVgWNbkt7JlhhP6Ofi32Ge1XU
	 yB8sjNkcgwKXwcmeyy69ZuHb2Ay4l8/3T9SI9QS5J6xMxLDMCznJDBIMBqzmxJqEy8
	 W77JdRxksPnmnYRYcR0gpqZSH3avtyJRRMBJA5BfSR7GLcjPFWBzagoFBt62WtPEJ9
	 CCY9CE1i/ei3+TIRXvpDd92of46yOewYZqnZ54fAUfI1uYWI7ew4KwUvrAGB656dV0
	 2MUlhtBEpg5wg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v13 07/10] mptcp: implement peek_len for proto_ops
Date: Tue,  1 Sep 2026 14:49:00 +0800
Message-ID: <14c573054c1427a0cb78cd24290b1c13b74ce9ef.1788245079.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788245079.git.tanggeliang@kylinos.cn>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
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
index f627270042c5..45c05f896126 100644
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

