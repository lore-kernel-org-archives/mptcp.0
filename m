Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5629D29F
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913545; cv=none; b=ahXztbQwyVe4LaNdSmY/Tc+dvTHNOKhTuVGgVUbscZYzRrIfAu3EJbQ7W9sNh67P+VLIFjQfAwt4GHnPzYabsN2Y6IyjGfr7SZhcKR8LqiJnfXdLPU8bqA/6EPOUy4OewenHeLPZP58zAhXcvddBMQbbs8L5jnm2sy9biGkfeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913545; c=relaxed/simple;
	bh=jME7UwAhFGdpy0DC+LD1XLRwwMwYlVOX++7xseGcuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5/JLJiddpCIHOb3ZklBFKGL+YJHTkrXeTu1jDIksKRRTqvToLvToYeF9Vaxo/mfJ6MTJdgoSncYWpGPTfbdGM03SUw7Yxvqx/WXNs/BXvyD6hO/5+WlbogDaaBv65psrn6/iZ23G+ALnv88ln0PmsFkriwBXKqa/PeFdlzPqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoDjj4wR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoDjj4wR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB9A1F00A3A;
	Mon, 13 Jul 2026 03:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913543;
	bh=EYeyAMGYwgrEvRqPliDbY8/sG7cAJUpla97WO7oBIDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoDjj4wRDk247KmD8b8yMQ6Y+DRupetutrEhSdLqBGcoCsyXd0Dg/LSqv3cT+r5+T
	 W1AIhEbP/ZoU+ZE9XNC0zzC/gu68cqDeRQt1LEEu9H/mjb2SWb/dUeeL4LApZqli+z
	 acforAajqtCBR6ksk8GswG2w8rP3z29Keun+g6ltBKCerkDe72hbOCJxRDyPnCeASV
	 5kvZpwP/9PpVoDph+u6/QT0UTb4JxO6CfmvpikiEyENWWd++W/oVobJE6HBYWtdCzu
	 UWB8DczshyWm2UcNIN/foD80+jJ58nqLHrwq2NvZT9Q1URXUhVKCxpQ117wGZqoleI
	 F3rrtmq6nWkRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v3 1/5] mptcp: use local variable tp in sendmsg_frag
Date: Mon, 13 Jul 2026 11:32:09 +0800
Message-ID: <e6a13a0f7be0f1b536fbe690bf41b1c62305707e.1783913332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913332.git.tanggeliang@kylinos.cn>
References: <cover.1783913332.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
Introduce a local variable 'tp' to hold the tcp_sock pointer and
use it throughout the function. This avoids repeated dereferencing
and improves code readability, with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..1cab07b1b9b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1375,6 +1375,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1410,14 +1411,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
@@ -1471,7 +1472,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.53.0

