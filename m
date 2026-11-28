Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864116;
	b=CcSIXh2cwwktKu8a7inFBZl7Fk04XGSoXpEPNO2OsllMXXrYSzRIZ/SnLCMrbNDumtPe
	 ZKhvc78jD1+E47Wu9fxfr+oDRfmCyfNpHzIrh7GErd7izw10gGaOFGSUiD46aW+w09336
	 dZLIVKvhLkk1B+xbKfJ52ffxoExl5yqAb7q8S+SvOz7TyaCOvixZ87tZf7i446EmIe4FD
	 lPujm90PYssh44HJ9KRL/OSDYrGv1BYcULboivXhc1jIVEBlm+Is6FOZfYIitIIiE78K7
	 um8c+MlE7PcspgifQhQZ7EffQHa3ooio362Y8H+0gXvYAAR8Q8wssYJHbvqqOD0b4fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GqInE4wMxUZWhPtgOtqvglCVrFsbXTYgCuPoRYxwLh4=;
	b=R87FzVvVBeAALsjuQ+MPPA+pjrs7ZulivyfnSjrBiULv29oz9Spd54JvrDlM4jd9xSBR
	 IKR4WjiixenaOVjbn+laXmjRXlLbIwsMunzV1cIR504IUwbLvyooX4mkNia35+GA/7LoX
	 AZHbB4RNrZZpyM5TaMRaCdvBGEw1KgXrJTEX0geWzGSblB+IfyhQAVV6LmMy1RoYjjXIQ
	 SQMQQNifOBAnHe9uV4BiPm0lW6gziwTm5f+TgOX9CxxjPad4zcK92UG/QGflsGTvci1cd
	 +D/HoNE9yPhBXp/kyHZKG8JJwJ2+CMPs2TOM3dHqxdVbZxTmzVcUa52PrFJk69xbDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfDqCFqH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5359606A327
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfDqCFqH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AA41F008A0;
	Sat, 28 Nov 2026 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864115;
	bh=GqInE4wMxUZWhPtgOtqvglCVrFsbXTYgCuPoRYxwLh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfDqCFqHEkMp1uiuKagJTY5uwBWUd027HByrSyBC/29DINhKJOP7PCq+axfaGy35d
	 kAVhtMdcs4CsySZqSpUmJZsd3C2bwbFcq9z2Xz2rsFgf/2OUGPnW9HWYPgp79tHL/C
	 wleNjjU2xtqwRdTnSHUEdbBBaPWjd1m4/EfNjG0sOlrk0v8fNHdG3HHO8aOpCCca10
	 RWkpKz22PRpMzvyKQl+2GAUFSeItPkhmHGS6D3IlXOSPMq3iIZBtCvm1PmE+qY8pKS
	 bO8pdNI4rkrjVm6jGjaM7FahzDQz+sLRxCkkdiY03L4yYd7LdrmDZzZ/2V20zfJNrV
	 mFKnvFc6p5C5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v4 3/4] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Sat, 28 Nov 2026 19:08:05 +0800
Message-ID: <36402c6a6c41fdd1c5c4a06edbe9f95f4657e573.1795863454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
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
 net/mptcp/protocol.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be08a0abd197..7d090ada5ebd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -565,6 +565,21 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 	}
 }
 
+static bool mptcp_data_fin(const struct mptcp_sock *msk, u64 *seq)
+{
+	u64 rcv_data_fin_seq;
+
+	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
+	rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+	if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
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
@@ -573,16 +588,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq;
-
-		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
-		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
-		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
-			if (seq)
-				*seq = rcv_data_fin_seq;
-
-			return true;
-		}
+		return mptcp_data_fin(msk, seq);
 	}
 
 	return false;
@@ -2629,22 +2635,16 @@ static bool mptcp_move_skbs(struct sock *sk)
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
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (READ_ONCE(msk->rcv_data_fin) && mptcp_data_fin(msk, NULL)))
+		hint_val += 1;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sock_flag(sk, SOCK_DONE))
-		return 1;
-
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -4065,6 +4065,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
 	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->rcv_data_fin_seq, 0);
 	WRITE_ONCE(msk->snd_data_fin_enable, false);
 	WRITE_ONCE(msk->rcv_fastclose, false);
 	WRITE_ONCE(msk->use_64bit_ack, false);
-- 
2.55.0

