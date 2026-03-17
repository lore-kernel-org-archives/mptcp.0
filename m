Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBD38F234
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736681; cv=none; b=ovC1v0zWYzQoWumQ0Y35ihaZeoiXmd0YUSwiWhu9mSMCqxBQArDfWzqWqQ09HN+cYG4EedQU/0rM5MBxL1fTJp28T707FHnFa0SifCRzdvfXi0qk6Q8c7hn5lr3vMJ5pHDv50AsxHc+fijXSPn9ghwyQuxc5sIgEmVRHiprFGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736681; c=relaxed/simple;
	bh=zwxEt6aq0oLG7hppx4RMTev1PTirC6OKwquSxFTEhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3/Q3WV1kwK0po1VuaokRc1vCID/HH1MGr32rU9I6Pnrd9DaFk2EQO+ZhYVofgIjvyxrrp1Z/t4blH9HY9UF3I9rajwPTq/lmOnhrwbMgbIbyRO4gG/IOq0rGMEzWYR7bqTsHzVwSyCPT4fg//vfb74stJ/Yt3H2pRBI8drkTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eu2IwtJ4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eu2IwtJ4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773736678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HztwvsjAsgW+Fmp0twPmmbBy1jlXngyZ73ipUE/VWLo=;
	b=Eu2IwtJ4O20k3OCKkarCRbkxdyxRTa4DaRG6J6E6MOTj3mS6IvURTrFIgcKYMwlaeNdEvV
	SOpFE+K645dHH51LJX9lOiFNH2QKzQeyarftqR6xdq8NWZAJqFCK8J0i7XOH0ifFCL1SUI
	inMgeDgrwK+0gnNv98Hx5uvTf1NUJGw=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v3 1/3] mptcp: replace backlog_list with backlog_queue
Date: Tue, 17 Mar 2026 16:36:55 +0800
Message-ID: <d659c349f2f8e534117205a18460480542f351c1.1773735950.git.yangang@kylinos.cn>
In-Reply-To: <cover.1773735950.git.yangang@kylinos.cn>
References: <cover.1773735950.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch replaces the original list-based backlog_list with a
red-black tree (RB-tree) based backlog_queue for MPTCP.

Add key helper functions:
 - mptcp_queue_backlog: Insert skb into backlog_queue in order of
   map_seq via RB-tree
 - mptcp_backlog_queue_to_list: Convert RB-tree based backlog_queue to
   list_head
 - mptcp_backlog_list_to_queue: Convert list_head back to RB-tree based
   backlog_queue

Adapt existing backlog operation logic:
   - Update mptcp_can_spool_backlog to splice RB-tree backlog to list
     via new helper
   - Adjust mptcp_backlog_spooled to restore list skbs back to RB-tree
     backlog_queue
   - Modify mptcp_close_ssk and mptcp_recv_skb to check RB-tree emptiness
     instead of list
   - Update mptcp_backlog_purge to use RB-tree to list conversion for
     backlog cleanup

Furthermore, this patch also initialize the msk->backlog_unaccounted in
'__mptcp_init_sock'.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 72 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5676b37f8f4..759f0486c40b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -653,6 +653,33 @@ static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
+static int mptcp_queue_backlog(struct mptcp_sock *msk, struct sk_buff *skb)
+{
+	u64 seq = MPTCP_SKB_CB(skb)->map_seq;
+	struct rb_node **p, *parent = NULL;
+
+	p = &msk->backlog_queue.rb_node;
+	if (RB_EMPTY_ROOT(&msk->backlog_queue))
+		goto insert;
+
+	while (*p) {
+		struct sk_buff *s;
+
+		parent = *p;
+		s = rb_to_skb(parent);
+
+		if (before64(seq, MPTCP_SKB_CB(s)->map_seq))
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+
+insert:
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, &msk->backlog_queue);
+	return 0;
+}
+
 static void __mptcp_add_backlog(struct sock *sk,
 				struct mptcp_subflow_context *subflow,
 				struct sk_buff *skb)
@@ -669,8 +696,8 @@ static void __mptcp_add_backlog(struct sock *sk,
 	}
 
 	/* Try to coalesce with the last skb in our backlog */
-	if (!list_empty(&msk->backlog_list))
-		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
+	if (!RB_EMPTY_ROOT(&msk->backlog_queue))
+		tail = skb_rb_last(&msk->backlog_queue);
 
 	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
 	    ssk == tail->sk &&
@@ -681,7 +708,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 		goto account;
 	}
 
-	list_add_tail(&skb->list, &msk->backlog_list);
+	mptcp_queue_backlog(msk, skb);
 	mptcp_subflow_lend_fwdmem(subflow, skb);
 	delta = skb->truesize;
 
@@ -2197,6 +2224,29 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	return moved;
 }
 
+static void mptcp_backlog_queue_to_list(struct mptcp_sock *msk,
+					struct list_head *list)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_rb_first(&msk->backlog_queue)) != NULL) {
+		rb_erase(&skb->rbnode, &msk->backlog_queue);
+		RB_CLEAR_NODE(&skb->rbnode);
+		list_add_tail(&skb->list, list);
+	}
+}
+
+static void mptcp_backlog_list_to_queue(struct mptcp_sock *msk,
+					struct list_head *list)
+{
+	struct sk_buff *skb, *tmp;
+
+	list_for_each_entry_safe(skb, tmp, list, list) {
+		list_del(&skb->list);
+		mptcp_queue_backlog(msk, skb);
+	}
+}
+
 static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2208,12 +2258,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 			       mem_cgroup_from_sk(sk));
 
 	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
+	if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
 	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-	list_splice_init(&msk->backlog_list, skbs);
+	mptcp_backlog_queue_to_list(msk, skbs);
 	return true;
 }
 
@@ -2223,7 +2273,7 @@ static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
-	list_splice(skbs, &msk->backlog_list);
+	mptcp_backlog_list_to_queue(msk, skbs);
 }
 
 static bool mptcp_move_skbs(struct sock *sk)
@@ -2307,7 +2357,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
+		if (!RB_EMPTY_ROOT(&msk->backlog_queue) && mptcp_move_skbs(sk))
 			continue;
 
 		/* only the MPTCP socket status is relevant here. The exit
@@ -2636,7 +2686,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	/* Remove any reference from the backlog to this ssk; backlog skbs consume
 	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
 	 */
-	list_for_each_entry(skb, &msk->backlog_list, list) {
+	skb_rbtree_walk(skb, &msk->backlog_queue) {
 		if (skb->sk != ssk)
 			continue;
 
@@ -2892,7 +2942,7 @@ static void mptcp_backlog_purge(struct sock *sk)
 	LIST_HEAD(backlog);
 
 	mptcp_data_lock(sk);
-	list_splice_init(&msk->backlog_list, &backlog);
+	mptcp_backlog_queue_to_list(msk, &backlog);
 	msk->backlog_len = 0;
 	mptcp_data_unlock(sk);
 
@@ -2995,7 +3045,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
-	INIT_LIST_HEAD(&msk->backlog_list);
+	msk->backlog_queue = RB_ROOT;
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
@@ -4331,7 +4381,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (!RB_EMPTY_ROOT(&msk->backlog_queue))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..f0eaba2c61fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -372,7 +372,7 @@ struct mptcp_sock {
 					 * allow_join
 					 */
 
-	struct list_head backlog_list;	/* protected by the data lock */
+	struct rb_root	backlog_queue;	/* protected by the data lock */
 	u32		backlog_len;
 	u32		backlog_unaccounted;
 };
-- 
2.43.0

