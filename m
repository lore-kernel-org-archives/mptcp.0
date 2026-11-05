Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860697;
	b=45MfEpCj+bcEvclVRsINFBRtBbohuakgOaywKd1+7pHZ/xKN5xamUCEaQGnM4p95sBi9
	 rAKwqsJIoJal2wSzYiz3JO//4lUrhVpbDipeW6ZquUN54f6rVKFT0PjkMIM8uH6q2/vST
	 MSN4DcnEH5xSOX0qMDSqhru/aSOwJBZnVFdK3iqd8HzOd5kni0XtWW3Hx4TAXHGE1yNu4
	 7dG99drA4VV89z9mjBq6QbA7yq9A6QaIExvMhwAs68etnMXk5z9H6wQlSNbPzpPFp5zA+
	 /1pUhwc72+DL5Wch5K3tJykIvebPbExYtpnX1EDdZFnOnL9RZzAZcmISG53KJ3AcBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BT2H3AwvlOxV/NjMDugv3TJakxSEpI35PB+owd5wmnY=;
	b=YRtdxTzFe4vF6qNlrh85EFn444kIMCiqusPC1yjqijMcY1v2ZekN7sGlnhbet4n8SkCI
	 C0PwWHg1EaoxBPIbgcXzYdqrNWxJSEeXjXnbabWsfXptlHiYIfcYnAnqGGPZbGdxjpbYJ
	 87Gz6RhQEWrpI1jXEvPbg33slsfqz3hWxeD72yIgxiY3TKHJCW0IKnsPV3I4k7AuPQDNt
	 q2V8ywEVD/XyH+2m9OHECc9/SnVL8o6BzjW4Tld5g7sZnZkc0AkPXB0BuIq50mH//MhZ0
	 VYUqrD6mI+gu5cIU81wslLQOQ2sHYhzwzEHyAXfVSFdxDSu2RMEaV+oZBrmldW5lFdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heDCvH3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F38606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heDCvH3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E891F000C1;
	Thu,  5 Nov 2026 06:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860696;
	bh=BT2H3AwvlOxV/NjMDugv3TJakxSEpI35PB+owd5wmnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=heDCvH3r1vTyHfdKcPa4E361R0VghWtcDkjOYpxskqQHNQt9zWtGvvPCtzYSCFQWK
	 m1YFg/xxnfHfsZkRncjPliclS7M5Na2sZwz6eUK1F1A1wQhmfusVsV/QYMC/SSmKEU
	 DpZSBT0apGm9xX9mi2GB03iv37CC8GeCG1/8dbIuDuJ1SQs59beV2Y94Edodkd9Dq7
	 SDMCadYkd1zEcNAy8pAuvrhY8VrLxDaV3C3bA2WADTNzPm9CCsHviho42GqKNKGOE9
	 cdNqTZ2dbAXqn6BZHhDyx10Qd9ry3GIV8pxECfeZGP4WUFqSvspZxNG9DmUe3lrlnd
	 Srh52IOvAS9WQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v6 2/7] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Thu,  5 Nov 2026 14:37:58 +0800
Message-ID: <be320c98076afd0dc17be24a8ad89b6ca9a59a09.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
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
index 0caa31525b90..1704e689bc93 100644
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

