Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871849;
	b=p3M/JyS/bFPNzXUgEoVensuHqeeZZL6PN+CG7mQ+QNV/4N7W0qTUfABA82mdCLcM4A8x
	 mDocjZQ2QtRQZ4KNjux8LaPx9ib3l9PiuRmj00GQA+YplPl1+yUPt9idbRRMCKnEjJHJc
	 KzDxok6iIVDatnfm5A/ra1Jr+xn0fnIkTK+G3PfiuDb0g6+dNQOwb5JOrtaBf+f4myUTp
	 8H0dQXkJT7wp0XZqZnJm+lR4BURiUYPi/lmc5un7ReSQOvd18LPjpPL/TTw7+HrmUpyjz
	 aMNCYqoXTqr98HNItvDDOqLafR43v3In7UQPLfWLACy2fJKT+MlEQMxcMltiTRlEihQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e5ZMETdLqZsi1LMDFhPJkufwvHoF6pfOfyu4vsGMgKM=;
	b=m+e3G2HwIgoG5PEzCvxHQekVULN1+oxW2P/e2fS2MfTTCFO8N4f8z0IxoenTE+vARQSn
	 VT7b9PIt3nLvoY/w6GzhK0HAXcfYGS7PRtC7hDqNTLBKJ7A+e3EB9HL6+qjRLPhI/4LZH
	 qQJCqvREA4744XpxG5kIegooNohNoAB4bhdd1vYGm1BGynwQlW8xaPmRaWrPi+ohw/nUE
	 RLJd++AsL1MviXyiPp1nLNVVX/UeOViYnUBPmU5bUg/c2WsXJBKj4DHWuJ2QQd0VcXk4N
	 gWENKa+lPS0ygbGHN+1UkROxcdzwjnNyYIBUmQVdeVfDpcxeZ2BV31YJNmW0crZ+khA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox9sWQ5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFB606D803
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ox9sWQ5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97AC1F00919;
	Thu,  5 Nov 2026 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871843;
	bh=e5ZMETdLqZsi1LMDFhPJkufwvHoF6pfOfyu4vsGMgKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ox9sWQ5eyWx9N55f5TE5AXh6iA3RNYUgzVELrUmrIXdNi5H8BvsaACahpwEvy1eZq
	 Unf1PrOGWTYlz+bZgjpo5yHAH+K046dvixJZG8hXekXncJtR2Vn41s8UUsLBM8qbRJ
	 fwKMu6YUc9sSbyBWsqf5UvkHKunYCax8HdZnwmL0vXT0UMu2GNdaHpFnEG6wdIX/V0
	 4EGuDV1p/FJy0oGTFSicu6qjrGkpYhKd0605MkzO2mIUjV2zAOSJzvOOv61+pPitsk
	 OTQfBIaBBmvdzVF4WUJtwW+hTc8ZAupK6HFaAHg9yt4lZNrzJyLgNPx1nyX0SyfUr9
	 wNhqacu0EBI8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v21 1/9] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Thu,  5 Nov 2026 17:43:44 +0800
Message-ID: <51891fd171100f37f87178ab753337140e462941.1793870710.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
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

On passive TFO connections, the TFO skb has map_seq set to -skb->len
(representing data before IASN). When the third ACK arrives,
subflow_set_remote_key() sets msk->ack_seq to subflow->iasn. Before
commit f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()"),
that function adjusted the TFO skb's map_seq. Since then, mptcp_inq_hint()
computes ack_seq - map_seq = iasn + len, which is almost always >= INT_MAX,
causing the function to return INT_MAX.

As a result, SIOCINQ/FIONREAD through mptcp_ioctl() and the TCP_CM_INQ
cmsg in mptcp_recvmsg() report INT_MAX instead of the actual byte count,
and mptcp_rcv_space_adjust() subtracts INT_MAX from copied. This lasts
until the TFO skb is fully consumed.

Using mptcp_data_avail() avoids this regression by tracking bytes directly
without depending on map_seq.

The EOF hint behavior (returning 1 when socket is closed with no data)
is preserved.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..fc4ffa326317 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
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
-
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

