Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563937;
	b=YysNqfm5j+sOuFssezjvWHgE2OY4ec843UfVoSabXg/bCYksoFrevfOCSvxMTDG4jBUa
	 ZTCfmLuTqAE9qU0L3zVeuBVm839sOtAPDQEbsQkYGaVey+km4sbrnX3Lgl/5CYeQ7bPFw
	 JCV6vWZ5lo2repCosEdwc6S5s1T2Ds/SWNwEu4LHD85pJJ1FJhcuKrp8j8tQJezcjBiao
	 WKcDpTlbKcIifFpHQQN0EVyxvYzREb1XtY9+KunAXJqKkeRstqKspmXqSHYBkTrlpJbv1
	 iZ4un7i+IW3r4K0FnpLIgKuoDl+65hxbtPKe9MHbTOV/9EWJe2OIn4y3PxezsO3bcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563937;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=q5fXJ4w+LVcXlj9LtoAI8giE2jsXT/gU+zb90+kDLIdrKK448EQs0MQQrGU1W4/J3Ppg
	 DNR0mfULRDOlDjoodmvum6ZgsuQlES6bz4bMYlwaY145psk9zI3xX4+FjyZNt6ct+fqT4
	 cvC4dBk6GYDGxoD/oVSek/biZoBbNzYEB/xvi4T96UkvRn9bUpp4q97gkXFphDk+S3JT4
	 H0NJaHy0jgcNG/4hQg7oI/O97E6t1VCRESuwENmawJzN6q7CFBpSk7fVOiGFirIu06vyp
	 8WbxTmtDeYQR8tvSIiF779zEqy6tOHd+kcFS9ogWk9uZLf3nentuxV3H4zhnF+HtuYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxINSliE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC5606A323
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxINSliE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A441F000C5
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563937;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=AxINSliEsjagVr/y0NmDS2IVNrWuDbjJPEF/31sZaXsYSPXfegi2lNYKaDarV4/kP
	 Er0Ps2FdZONzXgjM/adYoqZTgqw/8+j/LciIiKE8RnMwFGmA/TMJI+KEOljsdaLHf/
	 d9v8bTmjyF54VGA/yJ+bgbkrKtiDJWuFxb+QDAvqtn7KL03nQMj22ULy7UQBujC6nz
	 mIMyHE+FVI8ANyyqstcq5qVBfgaZglwsuoewvfgM4EthoCw3i6aPWgcse2tOXop+gQ
	 zV7vtxwwY9p8Fkzg/u+cadDo/IpaO+vOGhzsRa/h4VLofGLIgdq6aPNV1kXkiLIGS7
	 G193Li9japlpQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v26 3/8] mptcp: fix fallback dummy mapping anchor
Date: Fri, 13 Nov 2026 17:58:42 +0800
Message-ID: <b6ec13e0cddacc0e81c09ef52b007c110d646f44.1794563432.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
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

