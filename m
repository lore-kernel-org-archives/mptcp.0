Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720756;
	b=17fUTzr+mDJhUeSeGUmIOatxaTivWYsPw8p9qmBWINeLH9Pw59wEPrEQ93IkczYwS+ge
	 +AEfdir+yMGq234sQmII5pfB8sSGhchK/9ttnZCc8NjzkDB25F4lJcGrkxWld2MzSvUSE
	 q+KOaZWIIrcJNspCODuAvaVnhhbQ3OPCiwIni7xXDIL+u8M9AmqKQf5QkHqbmP9AFFJJO
	 Bq03FnJIeuNXXkPHNkDOxpML4Kft1Sx3cjSUbV9l4U+EI5bXG4EBoNrtRk9ADgzHe4Rai
	 TlqZwfFYk/Fa+WUnPyThqpf28oiWk/+3Mcb9vo2LlPnYamDo209OcBCujwXHjIYjuLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720756;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fZ7uK5stCwqc0Zb8Gqg439vzOzK3ptSq1zLHsqPr/NM=;
	b=ptmk8WTNxvt5/Fm1vs+A69h5BuD5xwPHUfJT5tvTl8Jk05TFZcYdXyeZ6NNf5tvaObFQ
	 6/syql4VLLQYmhzlQJamWUakEvgQp5GKljhcjU364X+9fDhBOXBLZcqjoHQYOi+Cz9g84
	 a4z8HRjgYmARz/UNdK0EMAVPed00Jtm3nB3/8g6dx2dUP6ePFsY/562Xe2tUspXSbGwKD
	 XAax+sQQqRaM3/cAxUb4GRXDKC442XJJ7sQF8S0M3bRx2MqvnlrSw4IIpuGM3STzutg4L
	 oNvbiQpl9sOJ4MuzQB8WU/BgnLppucoezDNh7CzxnyYA1naWuIFhiAqzb24+bnJAC6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EUqVwl1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE7606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUqVwl1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A521F031E4;
	Fri, 23 Oct 2026 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720755;
	bh=fZ7uK5stCwqc0Zb8Gqg439vzOzK3ptSq1zLHsqPr/NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUqVwl1/+zJaaBs9e36n/gaRxgO5QBiTpquVmNhNKzi+nVNMZ+1abIMHRM6ciMJYW
	 W23Ri0Qxa4jO9XdXvUqIcoKexImI8MOlhmpHRSEDzqQhxMqWYW1UcAmEjTXb6+uP/4
	 81ZiqvlmgJK4FHyyHkjKpv468aCudtfdJo7PDvxB+YNQRizF7Cn+tLZmlNl5FqDMet
	 llxvDysGJZKS+w+Ohc5PHL0ROBh+sAr8tTmS0mpOnHYOud1FqYK9vUz06u97wfzOEB
	 s0gvYm8l43GT08/BJsNfWxF1q8R5FKAUWfJsLmfcvZ1inWWkp2xNWpAx59bte05i0g
	 L2qg3tOIwvwPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v15 07/11] mptcp: implement peek_len for proto_ops
Date: Fri, 23 Oct 2026 09:58:48 +0800
Message-ID: <7f915090708935804fe0b5a61b50e24fcd232a40.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute the number of readable bytes at the MPTCP
level. It derives the count from ack_seq - copied_seq, returns 0 while
the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), and
subtracts 1 once a FIN has been received, mirroring tcp_inq().

The subtraction is needed because MPTCP's ack_seq is incremented by 1
in mptcp_check_datafin() when the DATA_FIN is processed, consuming a
sequence number without carrying any payload data. Without subtracting 1,
peek_len would over-report by one byte after DATA_FIN.

READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
ack_seq and copied_seq because mptcp_inq() will be called from TLS
contexts with the socket lock held - taking the spinlock would deadlock.
On 32-bit systems a torn read can produce a wrapped subtraction (close to
2^64), which is caught by the INT_MAX clamp.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops. This is preparatory work for
an upcoming kTLS-over-MPTCP series: no in-tree consumer currently
reaches ->peek_len on an MPTCP socket (the only caller, strp_peek_len(),
cannot attach strparser to MPTCP; the existing TLS receive path calls
tcp_inq() directly rather than going through ->peek_len).

Note: mptcp_inq() intentionally differs from mptcp_inq_hint() when the
calculated value is 0 and SOCK_DONE is set. mptcp_inq_hint() returns 1
in this case to signal EOF to ioctl/cmsg users (mirroring tcp_inq_hint()),
while mptcp_inq() returns 0 because peek_len should report the actual
readable byte count (mirroring tcp_inq()).

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7b0005d47bea..ad11a96b83eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4848,6 +4848,43 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
+		/* Ensure we see updated ack_seq and copied_seq after
+		 * checking MPTCP_SYNC_SEQ flag.
+		 */
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
@@ -4870,6 +4907,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4994,6 +5032,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

