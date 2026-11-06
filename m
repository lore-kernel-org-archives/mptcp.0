Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965035;
	b=wgaIbZq5PgkLJyY7zLDtUkqez+OKU4lsL+Wqz3Jbn3NYqaOn2EUVlV/WgM80v81D+mWS
	 PzyLusXweQWHIwpWrcO5lUyS9fEoVd+M9tHxqk607xsbJDXwyEv+bngckVdq0QH/Y5wlQ
	 kd2aHmrMVrWAFp5ggQAWX1jwdSpUAA1fbvI79EYDkSFWpBylLZJXdWA+MQbclf8mp3YPI
	 yCME55rbayFu2GVde5zIZvoTP3f2XG22e4hKUXq7cftRnNjIwve/WaJNwpVmhthh92aAQ
	 yj6r8vrdT9AwEUzy1c5kMFMfOMUx520D0UE7Q7J7bjWO8Q9W2CFqmQufVzMDJsUp27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=hS3mISkhgy55OA4nv0+bxp+vEbs36VUx2L0xMfYVo4U07s1mogT41wEVy8QhVS+ynNNH
	 nEzA7XeXR8ZdjOCDE10n8PyufHKiBI3oGM1siOrQ976SZJuo3HoJLKWZbb8J01yAxA2+D
	 TZf8lOdyX97x9C6JXLJj5Z/K0aMCIiIdPEo92BpMi+7ggL2r1QHpds0C9h9+GQzvSKmAx
	 Q7sAP56cDnzmuZWb3cyCI0cD4bWWkmGubIOMzp06hW4BWQp/8c09JBJzJzwT7G9LONJKH
	 gxxW82TcGbhLBB2Y3GqDNiO0AV1JbamPF9jDLEo68F3Mkf58IAc24EvTbNghM4HZHUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blsPHWGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E362606C6C9
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blsPHWGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95FB1F008A3;
	Fri,  6 Nov 2026 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965035;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=blsPHWGQiwFSIJVLjN568aBhuNHolyxDXWpJbK+froq4Mg2iEb8nsJEUROnUCGi11
	 YCQjs5DWfB6e0IG+4UKCZBsC1WHO0TeD/TsqlqHuubMjep+KD9K8diUu7igaCLmOwS
	 hMBWo73kzBh/9nhzr2Ae++YvylEGFoyZseVPLIIAAhI+9kYrqNeZ7q8ktWQGiijoM7
	 dmaAuzwWgBRKET3Dq6y6Bs6Z8tekvDyJE30JkyOFsCHhuytKFzKJwzG/jI19G1sniB
	 yuDPeUuSYupQw0ZDscX6SHXRpvb0KjWPT9O3VNwecs+QIuQAKquOj6yaNtvlYrwtlC
	 0ZNDKVK/5Brjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v22 3/8] mptcp: fix fallback dummy mapping anchor
Date: Fri,  6 Nov 2026 19:36:59 +0800
Message-ID: <978cce15c0b5e46acfcdcad736d4bb7fc3367eaf.1793964796.git.tanggeliang@kylinos.cn>
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

