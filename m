Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305513;
	b=ltUeUsT95Y0eu0a4744TgpzCL4YVHmvsStfMO8lKiY+Y8VgcDcWjLlSfXE7T/fJnKjiE
	 9+kegUx3lLVZYaqaoHpKC8WMisjUv+IV4oMQdr+fnNu1V4qJ2Qa+mvhFjU+QtGoNChdIR
	 dQxuT+qAfm/dlqxtCBxmOKovwI8J7FlbA1/Y8FtKB0KXwFFA/kBtQ4DhmJSOtLSCc0P77
	 toCZPkMqkpbvBQsbdnrRIqCVFshZOlMUxMbK6jVET8FVKikBlgSnyPvsJaQ8zD73GphBt
	 FrNDf8WEfbSBn2hJukBHvSyxcgktH7H3pBtCJfuO3adndFsglt831OBupw0qJUadG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305513;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=OVXeWMnM4M3mg0ghGEbENrsk75oNAr9P2yUnItOMBgV+YFGHocBwvB9O31Uj9dyyGABt
	 dAc+KVs+yJ6b6DWxzHTjUl6Urx9kTac9sDsgxTyG0P3dt6XJ2A6ojZGAu3gk4vY0qEgmZ
	 IhVEX3jALzzMHfPIZy1j28Wta4wGuARa+dHS8rGx5hkFJz9mtb1/cQaDWuOVp7S2jZEq5
	 REL8zAV4mmlmXrWjkvDFboiymv6A2Byy5M97S1jVpgAYFpQ1jxFe4wD3OoOmHSCyZa350
	 0wJAAqC7S0s6Q2/i4f7wvC8VqbQ7m+1NRrhi5LGFRj/gtRjfcBw4rbqKmE1RZu/qwxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLpdokXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD3606A33C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLpdokXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D03B1F008A1
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305513;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=bLpdokXnwfgK8fLtTXs6AmWbW5uibliSq8h2OKPmXww57QVI1mGVYdqWTRCiMG+42
	 W245mRpMmWrnJ+9wtVoleqsc+N+aoWiuNyRBTCr5vo0LEv+Hq7Y83/OM9Vpz8h+92q
	 YD8bat7mnJkZzegEKdjH1x3dg0mSWL30/y5pGPQOOq5b4OuLqaiRt7+9dQh6d/Bur3
	 FLseNcch4vcPKo1e1fos8SmAYg1b7uVTQeZhIkQHFRJA74EbZ6MjC9WVKIfFNRQhZS
	 Ba+NJPBymzDsNtj5nkpEAqzpokq2yEcUEbCb2QU9mXZeRsYacKGwARiElsDWE/bvPg
	 P+wgYkIj2FvSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v25 3/8] mptcp: fix fallback dummy mapping anchor
Date: Tue, 10 Nov 2026 18:11:42 +0800
Message-ID: <4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
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

