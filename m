Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318680;
	b=tA//w1ORxmH625uWCly0OQHeHqbExOJVIXMjoxAWcXHnC2BfsV1inUGvwPi1cnYjjZnI
	 PWY2oLC8wy25OO9RjSplmt+F7Ry1aLJKYa3EUiBkpHlj+D3nQyPXFrwWTZ7OC17VW0Nr0
	 v7N7FZgO3i1jyGEoip1Rzt2+uOJBbpdWHZCXhM7g8+JXFMcLTTN5uQsaT87tIT9aoVj9K
	 QS6b1zSq3/m4nyGnOELOaPQMswg7QHPhzd/KVGsrIqAvx1UOOw/Xv2u0Te3hVpdDLZ5yk
	 P73gBPuy6HoKr8xxuVlMBf9dA1MC9y5UaauvxHTXx5nrcA51RwKYjQGmoDTabxv0QlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318680;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vbVB5aUwkZ+lJlBXCShl4aR6Rd+HzCyALAPHe1B+0Jg=;
	b=Ticz0du2w8Rv0cn10MV9cpVq142hR1a2/iN6vOqeIu4iKBaaVYl3V3YAclew987/sUFu
	 GD9w945tHClxR9b0Up/5aAt+erhNErWvVmUcJe3ewxfrDNkDCDuZc4OlRgvuZsudrHzUl
	 x7U/gTsQMl9Sq+wMTGgafqrTfS6p7MLFJrnJ5pek595KrHaed816tCy/wVFmGjf5rsmUB
	 dqupglz3+W3xwiQ8bftusZT5jgB6t/XCeIdGqVKbfd6aAIj8YRs/8kKYY2O+DPiey9mS/
	 xYqRCGhHJZbcYMCyeIbiDlzXQBnNXFqSlWuPgQEVixjvIcD+NiLVcbNdD9AiHmJm4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D791xmvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1C606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D791xmvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A976D1F000D0
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318679;
	bh=vbVB5aUwkZ+lJlBXCShl4aR6Rd+HzCyALAPHe1B+0Jg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=D791xmvL/6iE2W9VsWRuPOTmu1lOMQJlizyBp7Rk4O0GAQZZHY7h9PWM3K+xCAFOw
	 c7ROz90630Gw2RlyR6CeO9BBdURoULbu6JLd4XdQ+zqfmInnGruSUoMR8scBd4l3LV
	 FFCk3ZyZTIBMLR/bb8T23xZ142c+p4mCL20TvyixNIT+TD1A2fVQZnQpXh03VZoSjM
	 dxKXPmIzh41F3x9OPQhJCtfZ0PXaF7ZNhyMSVk+UiUikvvqK29of0kKJGzRB9QNYG9
	 1Pwzoxjli1LYkJC5pZ7QRWzH+H1M86jGl/ZaAghFojwnTqP2ApMsqzhGPsh1SvhWv5
	 Pb+bJm267OVTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/4] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Sun, 22 Nov 2026 11:37:48 +0800
Message-ID: <05dcaa680dcd6cdf91aa1204a20c2c754aa28cc5.1795318567.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
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

Fix mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

On passive TFO connections, the TFO skb has map_seq set to -skb->len.
Without the removed __mptcp_fastopen_gen_msk_ackseq() to adjust the TFO
skb's map_seq, mptcp_inq_hint() computes "ack_seq - map_seq = iasn + len",
almost always >= INT_MAX, causing SIOCINQ/FIONREAD and TCP_CM_INQ to
report INT_MAX. This also breaks receive buffer autotuning, as
mptcp_rcv_space_adjust() uses mptcp_inq_hint() to measure consumed data.
The bogus hint prevents mptcp_rcvbuf_grow() from being called until the
entire TFO skb has been read.

Using mptcp_data_avail() avoids this by tracking bytes directly. Introduce
a mptcp_data_fin_seq() helper. The FIN byte (+1) is now guarded by it, so
the hint only counts a FIN when a DATA_FIN was actually received. Without
this guard, local shutdown(SHUT_RD) and MP_FASTCLOSE (which set
RCV_SHUTDOWN or TCP_CLOSE without a DATA_FIN) would incorrectly inflate
the hint by 1. This means with N bytes unread after DATA_FIN, both
SIOCINQ and TCP_CM_INQ report N+1 when rcv_data_fin_seq is set, or N
otherwise. This differs from TCP, which always reports N+1 after FIN
because the FIN consumes a sequence number.

Also reset rcv_data_fin_seq to 0 in mptcp_disconnect().

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac7ee8deedc7..ca660afae071 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2196,6 +2196,18 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 	skb_attempt_defer_free(skb);
 }
 
+static u64 mptcp_data_fin_seq(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (!(READ_ONCE(msk->rcv_data_fin) ||
+	      sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+		return 0;
+
+	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
+	return READ_ONCE(msk->rcv_data_fin_seq);
+}
+
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
@@ -2407,22 +2419,15 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
-
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	u64 hint_val = mptcp_data_avail(msk);
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		return (unsigned int)hint_val;
-	}
+	if (mptcp_data_fin_seq(sk))
+		hint_val += 1;
 
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
-
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -3682,6 +3687,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
 	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->rcv_data_fin_seq, 0);
 	WRITE_ONCE(msk->snd_data_fin_enable, false);
 	WRITE_ONCE(msk->rcv_fastclose, false);
 	WRITE_ONCE(msk->use_64bit_ack, false);
-- 
2.55.0

