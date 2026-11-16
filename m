Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811152;
	b=5REpUtqC3gdAHUpL6C6IMmzdiZkd07E3bIQ4kMQ+fJ6rcSy2uxGKn2zcg2i50KR1qaPv
	 d5f7FBaZ/CNEi4B6kypp8yWcJuclb9VXIIQOnwPUInIDkGG0kO1XYGmacEUMXqv/X9qDc
	 BbNc6CSYGhDsQbCb0Tuxn3vbzQqDuH1IUQ0CIylN6/jso8jeGdhUQOSxYQJz31kWC2XVM
	 3NbeozIkGwrElqk/6aP3hghG8hsLVZ7YhL/PL3PPBxIAhVOUor7lQug7cex6PuHvVVETM
	 lt4YZ2wUH/2bqXn6if0h+hOEJPnjOd4/LPtZm2yeD2QXtjEqwhIALQhwCFmYV0pLPDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811152;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=gUfqiRTKSPDy5pl1kBCPI8esv7cuFcU8VFnUOQOI6JltNx2CpU1/4R9TyJDh94FUCMnT
	 ByQxumpRjJa032essFD69NBBWF2mFAhc6WzsD0oz7VMcGDn/C4AyQSiaAD13o3xSYL6dg
	 kElAPZz/elbGEku1k591IyhEwGX4yrwUQbor51h5oBeLvGY1A5KwwB9w6W+sxjJE0EcGV
	 IHzOD66Bl637ook4suHrdRm8GpcKOy/QBth7CjtPrvRsWn2z+1PUD2xjr8HaGycQM1qdY
	 7JeyolwwrsMQfy2ZZQvSTmr5J7yeJlSA7PisQUR6s6zAhKvzZPnu8YaZPLwZwfr7W1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDq5yzHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232DB606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDq5yzHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEEB1F000C8
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811152;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=NDq5yzHKp9VZsfepPsZo3PVzhGStPW7ArZg6grfMR1pmteuazvxKnqnLhWupF+R4v
	 /9Cf9G+YEF+16OjYepvWsj/gP4Q3+D8aQNeB1WNB9Y5hCMLxbz55E86zCTNvImPnMD
	 OeADPCHZA6VkP/Xjuj02r/1sF7Su0gIf0VdhWDSXKplAbRf7cSYdCapqxpgYGYly28
	 7GDXPD+TK1yT/ZRdgJpbWwAAE7AXn9aDikIUKWwQRVyTL+EOnXadlr5lu7GElRkZaJ
	 BAjTTfa0v1syoapwRBfnkXdKs3ExbfJLvbOhoI3Vs6NDU1z+QDmvawqaJXX2DU/iRG
	 2ECRnBtUed+rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v28 03/11] mptcp: fix fallback dummy mapping anchor
Date: Mon, 16 Nov 2026 14:38:56 +0800
Message-ID: <b68947ec4cd5282818c54039eb367d31b72bd7a3.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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
index 00677fb3efcd..6f07544bfe40 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1496,7 +1496,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
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

