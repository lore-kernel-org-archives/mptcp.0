Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349259;
	b=W8fKzU14nrovP4VvvNy6DQE/ng78HiPY3Wqp3A1Bo96L6kHHzaf2nV5WNm18VCIZlyGc
	 aWNiopoab79kmNLGQl+KU3jODesGnj2DJrfD+BGNWI/+QJbSzqd2pQNsrmDOh/NnZmcK9
	 FaXe0Ohxw3nEuRYq2bhT6p+UIlvrcQ8aMbO0cPSwQZlqF8Sl/Tg+R47d4m6EjaKPsKF0K
	 NBROldA4yBrFYD2oumjWoI2fJv/MLqpzISeEMdgX1KXtPRjSXzPxHqSVtE/xOq4kSCDG1
	 apCadBAGFhQK53pTFPsoFjLx+cR9QQ06fVTl2KrZxMEQaQRCmY3cVUsfMSFPLnAyA3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349259;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iQMjcctNUG+A8H7VmGn2gEZGJF02qAlZqZTFdPpDdTA=;
	b=1Ly49vbBlEvyCPt0Buzpg5aKhe0Xic60kA40cS6BTX6B0CVdPSiotytgT/qbXgVRnt+U
	 aEmMPYiwAZ2AOd2vELyXF+PALQuG9zLLrNloErOS0QXJ0pJVy1hXPXoqp0Mm3e+k5UzIs
	 ZVEdxJm7e9e5Xf19es2sJHNkfm439rpjjRXuBE0CvRo4bB6PDkCzOrBtegQZT1vC8MKhQ
	 21MVfJ45Itg6NkMms6T0bEc96mlhHuFkMNmgM83e6XQcjGRRui4bqRjYCjXZdbZxkvtse
	 vVwRphNQ6tr6p0t1nLMOgmzih4iXQaRII9/VRO5b3B8vPwovKRBgsz290BG43YWscag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuTsleXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0217606A32C
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuTsleXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62BC1F000C0
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349258;
	bh=iQMjcctNUG+A8H7VmGn2gEZGJF02qAlZqZTFdPpDdTA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=MuTsleXy9ia70d0NJbIKcq+rvhgfjd3Aby4weI51SV1oWuVRaDx+3i8UjmsL5XEZg
	 zu/K642dqAnV5C7eriHHUzGevEp7KUzdJDrqdw9M6tasrANjUIszY808tN180a0sq6
	 Y9GYOgET1ES3fqJz6duE/Bl6WJlLIgODTyBCO7GcStRAgLYxnQfHot0YfgCWGR+gx1
	 Q3VM7GzdkOOsyEqy1lPNel6Ili42oC4H8vlBBcc2NJZltmIMSTmhR9U0gpF1acQcS8
	 edbEa20DJT3+iOyPGvxYjZ1GRUm00yVIsIHn7jhI2Pe1ZSLXd6YU6h0zaaxzF5qZjf
	 ixlpvY91GqDKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 3/4] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Sun, 22 Nov 2026 20:07:28 +0800
Message-ID: <692168c4f75bdb59bc8a9ec9ed116674747c3898.1795348666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
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
The FIN byte (+1) is guarded by checking rcv_data_fin, TCP_CLOSE, or
RCV_SHUTDOWN before calling mptcp_data_fin(). Also reset rcv_data_fin_seq
to 0 in mptcp_disconnect().

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 47 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac7ee8deedc7..846b6ab9d6eb 100644
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
@@ -2407,22 +2413,18 @@ static bool mptcp_move_skbs(struct sock *sk)
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
+	if (READ_ONCE(msk->rcv_data_fin) ||
+	    sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) {
+		if (mptcp_data_fin(msk, NULL))
+			hint_val += 1;
 	}
 
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
-
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -3682,6 +3684,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
 	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->rcv_data_fin_seq, 0);
 	WRITE_ONCE(msk->snd_data_fin_enable, false);
 	WRITE_ONCE(msk->rcv_fastclose, false);
 	WRITE_ONCE(msk->use_64bit_ack, false);
-- 
2.55.0

