Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969840;
	b=DiqgFZvgnZrYgXROLZYYfVcCNYj+SzCbnlCeSshxPN11xEuSlhSknNkDiKGvyTE7Dfu/
	 wqaS8GIL0AVql/aaCDmUBMpctUWdUbF6XZ0G07f7C2Lj6n7bxODZh0BEs4gGGjiceumKd
	 uK7h6jlrkVH9FYp7yu8FeYqeNMp53b+7Q/BaE0aOy3msK63eDXW0JQcIYnn+oRIDEgCYe
	 TovDVbiR+miidPeC0D4ZYqM+mI5Rv2Mwu+Yc7BXJFiTnDrh16B0L0EjVKxGO5HKCbiIHP
	 QRtcnlRwHSrOFz1GpeizE3ZDQIEMfEoyLRxpT2jKPoTFhxpsgwu2gq58nNuPX9KSRCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=vm7M39MtJRZ62ZrA5pIT2bZj6rVh0sVKVNV26ODDgSyZdEhrbXs1/+Elb/HhvmeLGsDU
	 GOWZFPaEvlO+e4bOpt5xpvBkFe+BpeDXGz8zkHYQWuBXJfw3IGjaNcQK4JInC7eGa0kp1
	 VCJjsRd1iHp4z+qGMqyRLfPkROmduUJF1GtyVNel8MywSdEzT8K97BIsXOiACcyMIII4G
	 yzqgqdsDDTkhdICjhec/A935FjrMv41vnNR7qXTvrtJrT2H29w2/lBKXSiyCgr3K9ScoG
	 K9C3vVFvJgca7UC0bkjWIYdkWM7Z/S/dDqCHDJG+FVJUljk0JNNUeQTOUTePilskV/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogHRPOx6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770A606A330
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogHRPOx6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD311F008A3;
	Fri,  6 Nov 2026 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969839;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogHRPOx6ubhcvBVriYZ2ZI3Q06VoRSJMv8iLxkMjByMmCCIuT/6BEw/tCJYMEx9K/
	 UyyLX8bonTI3k+hRBtn+PPhxqdlk9FQZ1jTpuR2TU16yu3w4S1yANcQ36sfBGHs/OL
	 C5SK6KAtQ/DrUbN8nsJikqcM2DKjWbN3GR2/HfW/528BrfEB/FTML6efvPYmi0eTpm
	 1ZxJCIqdD32H+WpzmTDITl/G5YE++PRkVo6ff+dl5YYCjvjLNfVEjSEulqKkw9Q77h
	 Hzgk3qjAQV0glL9ufBEjoSjouThz2asljtNJKB3tHYvx6tWXuyy5nsqqLOx1UXORuN
	 2SYq+cNzm22wQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v23 3/8] mptcp: fix fallback dummy mapping anchor
Date: Fri,  6 Nov 2026 20:57:05 +0800
Message-ID: <c16a38cd2bcba22c4a7eac338f3b151306e827f4.1793969127.git.tanggeliang@kylinos.cn>
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

