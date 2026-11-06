Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965033;
	b=Z7GxyI+OZLpzxLu4mjbe5yOQcaCiQ5IsqOh6P46cFGD973DQ4j0ou+I1eP1my4Rss9PQ
	 gtJ5AuddMN+zOsdHVLN16cnDAVO/nBhM4qLQe4nHqOjL5v4EvY4fuQhrxgFnr17SxVGMP
	 5+vXHsK9B1bMpulQm7A+Fz2gOt3cF6Q/Ja1mrmEXQoy6ZxvKw0wF44vmPIrSVV1fzg/HA
	 0RCiYETNEt28J5X23CZeVMuw+U0TO7H7FIHzogmShDgP9cmQThQJo9vVUV2SfznwpnDwa
	 8RaAXMfPayH3sqjYTEFDi3an5iYKQoeYd1OAmTvWb7olGulZaFURb5jz8lbMarmLH8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	b=qcZUc3LvLo5LS/gNitiifeKtyN/M4xc+xCQRAWdo/vN71eGxrqXv41JTFMi2q0yO1TtU
	 DMgC67uDphBIpiKy/eMcJmLfvgKsF3/+sTcA0HAdOlk5zGoQgo8L38qjDy8++KU3ebZu9
	 doM5orTDq1VxHKz2HF57avXoGYnMkx0Xdzaj5MInCO3UUDhRwGET8K9xTJjVKgZXgE+Jj
	 u/ZOSDE0hwIMCFI1nPGgETVJDv4jlbs/HNZRhquN9UHj+BHaOEHjIfBVt1QKQYhIu0Z6G
	 CkB6mB5z/P3248k/HBzQxO2SyTcb3kPl9FjccCNIA4HUpiyKAYAUlWiCNgMy2RHCxow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRVxZAjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CC606C6F2
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRVxZAjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248C91F008A3;
	Fri,  6 Nov 2026 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965032;
	bh=ENsdALkfUX9tGdOXL4nELYO0+LVHl7DFp0e6QBEKZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRVxZAjb7DEr/R07vWpO/bfMRtxLYKk+FRaFFM/Fej58CxNEmdNQIU3Eg/ZGon4v7
	 mAcZYgsKtSBz+yQswAJKaGNHl0KIAuPsKvMY2nPCjCm/RE7j/x8J5LaytHZ5yLL/DW
	 WOcSBEbpJKyhSaa87mwMwCo6DNj05u4Mdvlpc3dTy3NapY9y0SgXnwTO16lUSVErOv
	 xhY1E1f2BH+GMhlvCGohw6KeX+0oFWv31iMDWB8l88CxBeMvyiMga1IZwWGp2o8pR4
	 dFBAkMv0tfFzDV1vKmkzrKB6vvkX0AtZ8nKXgP0kXaEItbvoZXzYjOQW00XuRKVD+t
	 yBPWyG+yExAmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v22 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Fri,  6 Nov 2026 19:36:57 +0800
Message-ID: <751f1c0ccc0c0de2dadaf9bcb52bed01a7515ed2.1793964796.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
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

