Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA137F75C
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033707; cv=none; b=rmKj5aXKm1CB8xVH53xq39MNbi5yeF3O59YslQ46rcp3Ei2+VS/SvM0cQnkQvFFRhBLLaJ8ZdUB2aNfof/ifZeBwsIUHfc4/lLts7LV6XrQMZKaALC6i6KQmrNhpVW6gq0hj4Msfd9FyrcKvgK7WtYT3UjOMjbyeHbUvYw2cOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033707; c=relaxed/simple;
	bh=Lr1s7ZLkI/XDPVh7/wKTn3RESvq1UEZmJK8QHLuFSoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtmOTFc5N0YoIuXz/ClBL1V8qZ3rnqt1YAsVhwOpJ/PgHHyc2elkx+y+vpo2MV8G3PvEHEjBWLK2kcY3is+W41MObaEL1p5dDw7TmBhu1V+ItrFYm1nfQSCqG+/3/7rboQE5Rb3h1W9ZyrO+T6IyLAitW3xh2F/JaEcZbQXqkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQdABZ23; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQdABZ23"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775033704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/msZfESx84wCk8lnvJfwgExNIyHqrNMgsk420211UM=;
	b=mQdABZ23VQ9EiKTiLheoZFM6yNgbBSQ56NScApPIHT7o0snvxPA1/UX6EPQV0djYUN9wIZ
	p87yxSbVC1Tqm9KaWckexc9uBsxQpbsRn+Azfc/ZM3CY+SQRWNd7gYkze1WskNcVNNZecb
	p4nnY/AkmMhnVel23YlbXdYzP/hWoOQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v5 3/5] mptcp: fix the stall problems with data_ready
Date: Wed,  1 Apr 2026 16:54:16 +0800
Message-ID: <d1ca4e7377b9414404018c51580e67f0baa5113c.1775033340.git.yangang@kylinos.cn>
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

There exists a stall caused by unprocessed backlog_queue in
'move_skbs_to_msk'.

This patch adds a check for backlog_queue and move skbs to receive
queue when no skbs were moved from subflow but backlog_queue is not
empty.

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Notes:

Hi Matt, Paolo:

Here is the response to the AI review for this patch:
- Potential dead-lock problems:
    I've fixed this in the next patch. Keeping it as a separate patch
    should make the review easier. Should I squash it into this one?

- The question of the short-circuiting logical OR (||):
    In fact, the short-circuiting is intentional: if 'move_skbs_to_msk()'
    returns true, there is already data in the receive queue, which
    should not cause the stall problems. In that case moving more data
    from the backlog isn't necessary. Using '||' avoids redundant work
    and matches the intended logic.

Thanks
Gang

---
 net/mptcp/protocol.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f1afd90290e..326b5d4d79e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -49,6 +49,11 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
 
 static void __mptcp_destroy_sock(struct sock *sk);
 static void mptcp_check_send_data_fin(struct sock *sk);
+static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs);
+static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
+				  struct list_head *skbs);
+static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs,
+			      u32 *delta);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
@@ -906,6 +911,19 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
+static bool move_skbs_from_backlog(struct sock *sk)
+{
+	struct list_head skbs;
+	bool enqueued = false;
+	u32 moved;
+
+	while (mptcp_can_spool_backlog(sk, &skbs)) {
+		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
+		mptcp_backlog_spooled(sk, moved, &skbs);
+	}
+	return enqueued;
+}
+
 static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
 				 struct mptcp_subflow_context *subflow)
 {
@@ -948,7 +966,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
-		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+		if ((move_skbs_to_msk(msk, ssk) ||
+		     move_skbs_from_backlog(sk)) &&
+		    mptcp_epollin_ready(sk))
 			sk->sk_data_ready(sk);
 	} else {
 		__mptcp_move_skbs_from_subflow(msk, ssk, false);
-- 
2.43.0

