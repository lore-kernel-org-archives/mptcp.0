Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B6440632
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828284; cv=none; b=ihCVd4zAKxNqNvtDvhL25REbtwFIY5hHN5G2Su0273y9pIWSGTCHXpdULrRhYa6sSHiT537YMAobDXlMrPnymrXLy3S94uRqJuWTIy0xyA4flZzCqeFbShINE3F0GAfAXkHrwWpjjM2HAOVdR5eeLIfajFqIu9y6gubk7sYNRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828284; c=relaxed/simple;
	bh=UsnK80bQxJ5CTpgzxMEMVTC0aOwOh0VuJFR5BF0el7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFkX0EPvHU+bcOMZ4n+zJ8p5jYjOHMEBH1EzM8tJldO9PxDQwFIUPA3hBLksf0wctc1qwPpekQJkiAkTTZ55tHEahlYLU/nwZ+A5d6d+knhzENwbR0mM/dg1pEV7q/3VirkG7PGSUbMDgIWXv5zzkDApH/F+Zc+pqB+3AB1se7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb1aqV+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb1aqV+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6588E1F00A3D;
	Thu, 27 Aug 2026 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787828280;
	bh=2QuhRmcTFWU1G0kzMePFR7sqAlX1+wct/Qya/fxafxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qb1aqV+sOk0GG2UNXpiIcvaiFEGIGCfg6w9fWkt7PhEGgx3Afxf9NjKha6tViB5H8
	 YC0f9AU5gjzciTEn3Oog7gRrNfcqGlAcdP3wZB51y9Q/yV/zdIoMq/HIAGGp4tVELA
	 g9yVHqTsmKPiMbCFDczKlxFB59+673XBawzDTJOie2AkFwoGXMQ9Fs4bqHNEOvk4/H
	 dlvNLKS6K5igIM5a3eJ6bcULcAwBAnrR3CuYRH0lRBe1acBX5kAlsZI9G3JaceTPmB
	 5TS/p/yP5DUIyiLeRZ01JTXnorBI3/ohUfKGvMmYEve9h8DVP2X0+YzJbIYzjvUZU6
	 vv2hbcwP1CL8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 07/11] mptcp: implement peek_len for proto_ops
Date: Thu, 27 Aug 2026 18:57:31 +0800
Message-ID: <72dfb12c36ea32e58f8f85f55c94101fca02702e.1787827525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute the number of readable bytes at the MPTCP
level. It derives the count from mptcp_inq_hint(), returns 0 while
the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), and
subtracts 1 once a FIN has been received, since the FIN consumes a
sequence number but carries no data. This keeps the reported count in
sync with the bytes actually queued, preventing upper layers from
trying to read data that has not yet arrived.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops, so upper layers get the
correct in-queue byte count for MPTCP connections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc8747162cca..9b9ace7cb977 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4814,6 +4814,37 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
+		u64 hint_val;
+
+		hint_val = atomic64_read(&msk->ack_seq) - msk->copied_seq;
+		if (hint_val >= INT_MAX)
+			hint_val = INT_MAX;
+
+		answ = (unsigned int)hint_val;
+		if (answ &&
+		    (sk->sk_state == TCP_CLOSE ||
+		     (sk->sk_shutdown & RCV_SHUTDOWN)))
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
@@ -4836,6 +4867,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4960,6 +4992,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

