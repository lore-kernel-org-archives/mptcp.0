Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C137F75C
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033703; cv=none; b=bpKvfvuHvlp1NkP8m9ii4/nJzBEAo2U0J26rReXQ/gk/O7pSailuJU8DPnFR2xtFYlROblP5YnriErhjP0o4GyNoJAvCDH3Pn2LPi8cYqNw1KOTE9SqHeGzmynZht3JO9KKAbJVRFJ+zT2wJE3kXD4uuZa361NSjJ+3eIyD82Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033703; c=relaxed/simple;
	bh=njNTy9C76gduAOexrMacZqZpsQ8MZrhzbQ3u9z/AXyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icFx+jMasif6P7rM8Q3oT8+CSRchXDSmKzGQT2Womf5RVY60FAkf7C7JUMPKB5bW972KHQUsU0wFiK6NcUGg74qWk7WIlWvznSmC+RHd7Rhce+ndlDKdjEO4u5WWGXLtPnhpXRuwn9SRhS5TYRH75PheeSwnou8qI1WkYgGyZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=joBjFcja; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="joBjFcja"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775033700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnalBT7hKUL2Zroxnfr5zg2O1eLhrrb7pOKP2OukUeE=;
	b=joBjFcjawnCQEY1v41+isonGlsFbpvczsIwLXTjjeMct9lE1fJfmdVxBd0HeQKKde2h9Si
	tGvO2Cp7aaZE5hRUHcFpmWDYdAxBM+9oG2DrVbHhqxAg0vtZCQyDMKIWcC8X6PRjTNcBpc
	BNfaajjiz7OwyqTpc/V4EB7soPmHqHU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v5 2/5] mptcp: fix the stall problems using backlog_queue
Date: Wed,  1 Apr 2026 16:54:15 +0800
Message-ID: <8a42c73a392f336155b27e0691c3b7459276149c.1775033340.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775033340.git.yangang@kylinos.cn>
References: <cover.1775033340.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

The original condition would stop moving skbs or spooling backlog even
when the receive queue is empty, leading to receive stall.

Modify the condition in __mptcp_move_skbs() and mptcp_can_spool_backlog()
to only treat rcvbuf as full when:
  sk_rmem_alloc_get(sk) > sk->sk_rcvbuf && !skb_queue_empty(&sk->sk_receive_queue)

This ensures the backlog can still be moved to the receive queue when
the queue is empty, avoiding stall problems.

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6f83c8afc76..8f1afd90290e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2197,6 +2197,12 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
+static bool mptcp_can_dequeue_from_backlog(struct sock *sk)
+{
+	return sk_rmem_alloc_get(sk) <= sk->sk_rcvbuf ||
+	       skb_queue_empty(&sk->sk_receive_queue);
+}
+
 static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
 {
 	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
@@ -2206,7 +2212,7 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	*delta = 0;
 	while (1) {
 		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		if (!mptcp_can_dequeue_from_backlog(sk))
 			break;
 
 		prefetch(skb->next);
@@ -2261,7 +2267,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 
 	/* Don't spool the backlog if the rcvbuf is full. */
 	if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	    !mptcp_can_dequeue_from_backlog(sk))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.43.0

