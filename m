Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969836;
	b=LaWvuYuBvW9NTlWPwVtc6Yi7Laijes5I1LRGr/clUuEA/jP/bFKSZrW7s1XgRXau9UzH
	 d0ZaOlMl15qaEbJeqq/o+mr5rD/SbsDi+BxWmOmnUWKSoqOL+m20WsmBcC4lYMlARPNwT
	 9pkq90MxZyhFni21YLOCn9gZcdw8Gkv1B7NzwJY6qu60GA1VhIAMKb6p+M1FcKo4HywVy
	 x4XFNy3BZSRn9wLxxG4NU93uKMtRGPOWRnsvAxpe2/vBaSIsvbD9RPT0oB5nfbE6p5vYS
	 6GZE8Da3HKUX0UCUQiLlDWrOMBbuAXTE/HnlgJjeijlBaMRG7f63RP0jbeMM7+Q+Bcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	b=VjL7eeyWBjAHh07IxDYTMpRk/x7TS+h+MtbWuNljq6JYjFtyZEzQQ+PLaweqjxZgOZpB
	 4aieGRQjzddnrgEcldhCjyL4akVLeZDP/B9/+MQ3sx1Vzi16mHwA6G7zHb7vIzHmFXfWD
	 SdtG1NXvsdzZZX186WLziEFiDjgAwBnJ05TnN17Q+tFRg10Pm+ABEC2y1GBIemctacFwQ
	 7WibGIATBKMG7FfYQLmlp+pFmKRM38r/0EgjHDnIRF5scJs+zAralKRuLc2Jnvbj6xCXU
	 xtN2lpxM2mG+Uri5MPClBbWI0+UfbEgI6xvrI2vPlGdtlKyEeuYwXR+8oOcENVbFvFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvrN27ft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4778606A339
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvrN27ft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB361F008A2;
	Fri,  6 Nov 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969835;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvrN27ftFBUoOWzX16o29SwHIWSbDy9FdVkP7C/PKwq+pI8Rofr95L0w567aKb+kd
	 BL8otRbDpYMTKKIZbreyLeTyV3+5hxUXTkvx1AZcH1LN8VzgYynYAlrT/qyzMDsmlR
	 0/EE7VxRPBWslrxnx1pBWSXPS7w4+stzvAZh6wZDKFF7vkWZLpnzSzuWNloWUzoc4c
	 GhtEMydTU2QECyFM1YdsCFduHVHgchcKRJDicoQsK4FHBsFnZMKmvFCpABveBCarkz
	 RNoN+PItEObgG2P/OBdZ5BqH13b8bITPx+sRza6Vp9Pj/Wl/r8MSySiZRi99TgwnJD
	 jWzK1imK3Qwhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v23 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Fri,  6 Nov 2026 20:57:03 +0800
Message-ID: <751f1c0ccc0c0de2dadaf9bcb52bed01a7515ed2.1793969127.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
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
report INT_MAX.

Using mptcp_data_avail() avoids this by tracking bytes directly. When
RCV_SHUTDOWN is set (DATA_FIN received), add 1 to include the FIN byte,
matching the previous ack_seq - map_seq behavior.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..421df3af1ef9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,22 +2402,18 @@ static bool mptcp_move_skbs(struct sock *sk)
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
+	if (sk->sk_shutdown & RCV_SHUTDOWN)
+		hint_val++;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val && sk->sk_state == TCP_CLOSE)
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

