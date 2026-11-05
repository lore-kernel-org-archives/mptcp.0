Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871848;
	b=4+QLR1V2vaiGKxzPA4xpDUeb2d0fZXqwODnhvyhB+v16sZtfEqDxRoxwYCYKjcaIIWrV
	 uQGoSgeWsaui/jwb2plVrHHQ38YLuSns9FKtaaUYnYcxFW1zsfuBllg9kRu4tUZjM4h8a
	 YXrXDBgZrL/F6FqXJbCirHI1KuGkQqq3/38AJiirSuj4t7i0zKvIo8m+F7RPhCZ/Yp+Ww
	 hRUZVknI/tC9LVmkYbGcx6kue7Fx3gvmY9DWy+TZGY1HMF5OpiKdY1Ciw1HGPbMikbnbt
	 2HY9X8e5UcUy+YZPJ2Axwh2lZ37AXCaLSjz0uV4D35DBr47eLgjcVqvQ80MrN9IzkeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/xjJ+sUzAEd6VXxmGWwvwA8XgjejQ1yTMUq/gPOVOrs=;
	b=c+IyFEiz8+4jsCZhyC9CuCHXNI+uccOjle7tjMIjqvFNt0H1y6grOLY0qH4Yrg7s0l2S
	 tcn1rFCf0SSiHgKZlqWQJvPYl9UXkmoGfAu4j1oYlXzr7Xofc7RXSYtPkeIhABD3fH9pY
	 LcEjXhfOPZcZjf4VvekoRDxLyvUVyyVPiMVTpeBipaT7xW1XqLky6BQA8jUqU9fcgQvDV
	 gpr1Re0cCkTuWjhSgRMWeVvKxIhPYLNpQwifj+U8bsts6x1nKDstWfFCPKlTwQjUHmXa1
	 LKQESG+FdDInNY0+d1CJ2Mhr+Y9FEKY07LdycoEauRsNPBCxhCXVz5YhWDvqW5o5nig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrICX42Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7C606A32E
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrICX42Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA31F00A02;
	Thu,  5 Nov 2026 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871848;
	bh=/xjJ+sUzAEd6VXxmGWwvwA8XgjejQ1yTMUq/gPOVOrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrICX42YbtVVfxfUjgSxaaLVrDKU/zDkcu4OZUXVJVjJnwR2y9GX/5rSgFHOwJExS
	 h+mVyMs55ZHYJMk1GbURZNsetv7LFs22q9qvaTXYVCwA+gjRp2oxXB084v3l74HI8Z
	 86VS3ne3gxbH9IfPwShJjA0x0q5GxQxS79frjhGJvKQolaR+aGfp2o7h0fXcvOTfi7
	 YGS5L+04MOa/eU/u9ElIYQXV4CYUfM7/KnYLV/uLXmTGY52DwvKoPDeOnGzuhlZ96L
	 ltjVVPWWEZ2A+VkGjctPrS2mt7n8PnWqDOWm1uMD2au2U1hRnOWZaMUmtGILGVuInU
	 tcX5tcJKVgXRA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v21 4/9] mptcp: fix fallback dummy mapping anchor
Date: Thu,  5 Nov 2026 17:43:47 +0800
Message-ID: <5f90b29ed762b22905bc4c1969f8f072748f14d2.1793870710.git.tanggeliang@kylinos.cn>
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

Commit 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
anchored map_seq at the DSN of skb->seq but left map_subflow_seq
anchored at copied_seq. This caused mptcp_subflow_get_mapped_dsn() to
return the DSN at skb->seq instead of copied_seq.

When TCP queues a partially overlapping segment (seq < rcv_nxt), the skb
starts before copied_seq, giving offset > 0. mptcp_init_skb() then sets
map_seq to the wrong DSN, causing __mptcp_move_skb() to skip data or
drop the skb, leaving a hole in the stream.

Fix by anchoring map_subflow_seq at TCP_SKB_CB(skb)->seq, ensuring
mptcp_subflow_get_mapped_dsn() returns the correct DSN at copied_seq.

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..73417740074f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1485,7 +1485,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_data_len = skb->len;
-	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
 					      subflow->iasn +
 					      TCP_SKB_CB(skb)->seq -
-- 
2.55.0

