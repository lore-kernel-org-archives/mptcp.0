Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216264;
	b=hftLdq24FagoBClgHhLyvotivR7TaoicBoiuzF6iHMcjXPXlpROWg587rVI7ChHm+MoD
	 KIWtCCtY3nUKW/kIq5gVdbkO5CplOBw9UvAT458n/jKidvUQzPzPbRcv7nEYJYt7m46Bo
	 aUZ60C8XRziIy+VrUOJvn0ShxABcQXeLU7pz8sQpczRvcskWYmmIcetAUAAYZ0DCSnSrW
	 cQihLSMkSZ1VUNQt6hG4yp6iLGY/XkodpxUOUJ9zc7DF4Sh0yZb26IWDGdO/yPsXNNsWg
	 buifYPqxhga737QYFSMlzfsLL7P6UDxXeptnMYWfxLi8QEFD7neqWTRNE1yKZgNybSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216264;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	b=JeTxYQeTHPvr/q8e3iGlQ+BkRdvwRe1JIqjDshiB8HteUcv3gbEzDCQYtYdcKjnuRt9P
	 P+QLP+Wk6z5XxTfmuD5Ltz1pjUwWBbJI7ooE0npWQSbKHmnbQaEY/fuWQuRDpW9Xy2t7U
	 W67maj8kkcmYrMcdDKb5kMZZ7Hhfrj4UZTdNaqYzMk6ADBBvZoeibg8Obvr8EUntCE6oS
	 BH/cWgtCLarVB+I8YoDrZEiJo3sc/lNJZedEDAaWcZGB6+/rScu0qgt9lzp1qXk3lAUlO
	 wr12hpRzSCZW5F7qcoc0RscRvuyCESH+6xd3eSgxNlLErACFyeIKR4FzFxyq4hh3clQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmqCKNhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CF606EEBF
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmqCKNhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA2E1F008A3
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216263;
	bh=K0ucOvjIjrcBa4o4gYqu3rYj0YatnSeO8vFYHsOpG+k=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=mmqCKNhV9H36LsNGL7WvVWjTwIzyLq2W1uzy0bctN6psCmT0PFQY1eS6OHspTEXup
	 NdE7p70J/2KbKVleD+vxVIDRIGk33L+iTnK//tW+PwKi3lSRjI8KQUhMPOM4GKpbLr
	 xUiOcWYpP65jfo8n6jJPlAwkX7Fc4od/S4MJNg1GGJjbGLsa3IblshzmtM3l7jAQr8
	 GST5ubpd1hCoN9k5xKszRa7HHfb+41UvykcQ5RknDTsK/iNbSxnGHPAL86ylCZvtX+
	 P8vrWDNh4MNHIvPeQirMHvcChRmHsPzYz6+fTqJuPj5CbfGasXc9u6PDMwrfTBxPfx
	 3z54CPkxl5akQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v24 3/8] mptcp: fix fallback dummy mapping anchor
Date: Mon,  9 Nov 2026 17:24:05 +0800
Message-ID: <e435ea3e016f626c2738cfd9d5172c198ceb5b65.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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

