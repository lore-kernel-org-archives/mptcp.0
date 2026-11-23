Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397244;
	b=q5tWAajuFjmPEaZAfyc+Kx3pf6RSGvluBPIVxSwAcDekM3XgfTjDg8gEz7FUFO0670g0
	 zyj/bNtEl5WPjnO9fIys9JPutSxN8LT6MeUQWgqQ5rFmWkDG/SOXO2fnehPCBTvVTeFGu
	 0Xqmc1/e2WrK+okui6g4jUydCWOISmUZ80W9A609dURTsXUIrbi0NtowNH4v6T+wbU4FA
	 5hs7j8ZkmbpdPGru1rCfuiC8h0dXOh6B58pYGzvME6cG0iQFwKFlsVq+O+ibtEZZtlC/e
	 3Q6xyaCF3mEYpiCSg39kJg+BecZXdSLolGui/aqdT35gOAeSB9GIZZr9AlOgJLmVvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397244;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FDJSnz9ieSvS5vSKrpcMcJ4hb7SXL0sKUEHtg0CzHvQ=;
	b=WiaY+l9TO1yCuXAAocwoI0vAYuKB6A+SRE9O0jxOFyBLhAmKIYe0hmuVbrnqxt1JIRa+
	 8h0J/p3qE0UQ+jF7SjZa9Iyg7KC1thJppJN9eQmm8YgxcZra0YJAwvYkA+MBAN4GWKx/f
	 xYgH4/QJoTlLtKT+gP0E0Xdc/MSuqpVdYJ9Rwn7bV9R3D6tznBwB9r6EzNVFzEXAhzr/2
	 DJQsiuB0AZEGtvP0+1Z7IJKeZFo/czQmqGGnLWrurG8FAKe7MGtwzbsqMf69I7XoEbSuJ
	 iRD3JYItfhY+d8Ncrbwi2flAsWzTi1uN8dSP9X93YOwB2BHryQR8Ov09FGviVB43psg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX6sOxsN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52177606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX6sOxsN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF3E1F000D0
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397243;
	bh=FDJSnz9ieSvS5vSKrpcMcJ4hb7SXL0sKUEHtg0CzHvQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=EX6sOxsN8XjJLLLCahErm87nwt/qxTPQX8cXcBEXreRyEv46GiYb2R+6Rr+ytAaiZ
	 Cfd41cL1bCjOcvUSNQf+tIHcY5KO+AoJ6BL6GXD0qZZjW06l7swowF5SPDmHMuErmT
	 OmYhsRX9yiDz7vKh8WwW4gprxV4vXkDFJA3LLrcFm1JPV2TMd5W6P09HvsoJvkvh2V
	 Rd+M6Wq0V14qYLqLCrjlkOu+xalbgje6InZBu2nEq9HUOvEtnbS06HogOrhmKRbJvE
	 r0soBvPG2YxtZLB+SLmq/xk310aUewLBqIxWtW/Cw89xIH2RGhp/1VOPtYwflo1oi2
	 QvTMW1GKqeLjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 3/4] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Mon, 23 Nov 2026 09:27:13 +0800
Message-ID: <d0fb9716397cd64ea82aa674e8314a7225a26ceb.1795396910.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795396910.git.tanggeliang@kylinos.cn>
References: <cover.1795396910.git.tanggeliang@kylinos.cn>
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
a mptcp_data_fin() helper to check if ack_seq has passed rcv_data_fin_seq.
The FIN byte (+1) is added for TCP_CLOSE or RCV_SHUTDOWN (excluding
MP_FASTCLOSE), or for DATA_FIN when rcv_data_fin is set and ack_seq has
caught up. Also reset rcv_data_fin_seq to 0 in mptcp_disconnect().

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac7ee8deedc7..543be0856742 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -559,6 +559,21 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 	}
 }
 
+static bool mptcp_data_fin(const struct mptcp_sock *msk, u64 *seq)
+{
+	u64 rcv_data_fin_seq;
+
+	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
+	rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+	if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
+		if (seq)
+			*seq = rcv_data_fin_seq;
+
+		return true;
+	}
+	return false;
+}
+
 /* can be called with no lock acquired */
 static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 {
@@ -567,16 +582,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq;
-
-		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
-		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
-		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
-			if (seq)
-				*seq = rcv_data_fin_seq;
-
-			return true;
-		}
+		return mptcp_data_fin(msk, seq);
 	}
 
 	return false;
@@ -2407,22 +2413,17 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	if (((sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) &&
+	     !READ_ONCE(msk->rcv_fastclose)) ||
+	    (READ_ONCE(msk->rcv_data_fin) && mptcp_data_fin(msk, NULL)))
+		hint_val += 1;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
-
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -3682,6 +3683,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
 	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->rcv_data_fin_seq, 0);
 	WRITE_ONCE(msk->snd_data_fin_enable, false);
 	WRITE_ONCE(msk->rcv_fastclose, false);
 	WRITE_ONCE(msk->use_64bit_ack, false);
-- 
2.55.0

