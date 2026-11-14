Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664875;
	b=Ctnds6PqGELOMj6gByRKeWHIvxMkojtXyjD3jBBe0dZg3DEsCo9a5uJTG4RhrJT1EBjS
	 lnnB5C3VoK3+CIGpByEUEsbovYZKWIuOIlHSVOR+epo68AKNsog1z4w4UA3DWPq6ZKuoo
	 L3NNQB/CiZyR04wp5UDetrsGddj2JqEDW+0rzc0Zl9uvvgGa0TtpYjezwSFgWZDTW9cLK
	 /0XaE1FDjNi38XrdsrmFLEQxxdfwuKnSVSEHLgKBGhUnZT9J8t2DDLrImaJxQ+rRtnj+4
	 FowUSN3hCqOn2+EWWoqtNL8ZrTNF/RBP9SPAzAIMmSnkyn439hR5pp1jntIBR5lWR7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664875;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=X1KkFg6izvrQXu6ELgvQteFvePD35TLMpcH8fVomiwSbyF2yE9s56F5FOCXHg0QNabaR
	 nV8tii+zG/uMOHjtJw2MhouQQQCpwwDpjh0dzSqNX3wuPQx6TjbfjjRCp1uhDXY747a39
	 Fp/YFObGXmjR6gc+IjO/PduDuyT3MSROwdROmM/5MGzaVA0BpAmOzWQUID0MryCOnpMiB
	 hZUR2vovZU7Y/BqTjx6HWb3grYgRMQJCwjbK5nDj2qS0f905kV481c0i0i7SpWwT+Z8YV
	 wjPB+3XuyISTDrIPXAnlWCQWqtXuf6AFAvY2pIarbmaOfp8hOJ6TtXBaDJqX4NCFyVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHYE1cc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4909606A323
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHYE1cc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0DA1F000C5
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664875;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=nHYE1cc6GfhRjMrjGTWOfQTqCAuNw2BjdmwiRiimhYwjaAgeKBRhqhXMt0AudxoSf
	 WVlsJ+7FuC4rU4889gTUkkC8S4aRTYaPSey9kbK5hPwXEi5jML+B/8zMI/A4uO/afo
	 0TNr33NYjiC9T+n+P12J6n45ylJF+pigx3emzikDSkcDfqaHWKIQDN7G+22z9WI+JQ
	 qiJGk0SoWoJPtJLq2x/trCX7kgsDMRWqK39kgbK86uUqxjY6JBViGsRsvoURtOG//X
	 J+gFCciuWRVvFC/LGjFOV/83YW1gDNE5q4iFYeaqxpdHiEfaGIXXO144yNN3LcbbpJ
	 z9Jas7qrlpkOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v27 3/8] mptcp: fix fallback dummy mapping anchor
Date: Sat, 14 Nov 2026 22:00:59 +0800
Message-ID: <f955d85b9a69353dc6dc9bba2e8eb452a8dcc478.1794663678.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
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

