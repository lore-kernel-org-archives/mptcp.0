Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FF12CDA5
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889004; cv=none; b=VZyy8BHXo7ZvsPjkKWZB/cKeh+RXKmIKuka083BQZvDxDeB/XHe+qPT3gMvMnERukmRHd2WKLyOnFHh5UER12PCUhJPKI5Ezc98lA1HY6JT2Jr4EdocWH7HU5QAmQu18iy20XlNgf7eyZOvV9Rp7qLrFEcVdo2CSvcZ8f17hBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889004; c=relaxed/simple;
	bh=Yr2rvvCPOEbX8lnjYcZWjShkrHHyeeRNOKtYSYi7eOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djbobuAgDxR6iBD68QbIRSrJBgugi7kTBqfqza/9q4lYGy8+OLW90YmSuUXTwCpCFxmmNRasVEt7fmSuSMttzb61ZUdAhQ8prs84iTyM6gLkXkw+4iKWqnLA3sFc+wRuZ0vNizHsr2PGfdMPyZ5kPdTXhlMm32dN07l2BBr1zrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UULEZ85F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UULEZ85F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77541F000E9;
	Fri, 28 Aug 2026 03:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889002;
	bh=vfE3RsbAv2c1Fr+CsaC79TsKvMlVA2REfohMpi3zKik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UULEZ85FEEBZg/Rk0AYl/+QrJVB+KPQQB5OGhrWSpABphBeReAfrkQzX+iLeCHNGc
	 RkjefebujE+uGXS4g/6T5KZQ/0nEAi2ZWCP7CaW00+qftE37bj3+qY6X4v1BHoV34S
	 qXcJ6gPg7Iu2wUFZjCXwVYtgxGkpBFpOQKkLkpWbkgtoBNVlzq8p2CCAieToDnYZI0
	 Hbzs9Nw/fv6DS5tS1ljzf5FX65cPU9B41MBu0ie2sM7sztE98PSx4M5Wv+Scs6rFba
	 z3HVg+TujQDRVG713/FHCi8+nbn+02PKs9eZ+DL5L2QQ+jFctW7MudSKqTPiYFqpt1
	 MbPotgBUctVKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 6/9] mptcp: implement peek_len for proto_ops
Date: Fri, 28 Aug 2026 11:49:41 +0800
Message-ID: <7b1fabcac57f36b0723d6ec1cac7b20dab1bbf86.1787888115.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fce85967b90e..639122b7845a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4797,6 +4797,39 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
+		hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
+		if (hint_val >= INT_MAX)
+			hint_val = INT_MAX;
+
+		answ = (unsigned int)hint_val;
+
+		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
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
@@ -4819,6 +4852,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4943,6 +4977,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

