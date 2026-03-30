Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD537F8A2
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848803; cv=none; b=pYFtKRTBymBU2KQli4ptl36hRzuvNZ5x6Zu8jHmuGvy6OQM+EQyJ8xDjxJXm5Y29hOLRF0N8p8RUX4CfQ9mP3SKK5wCqwdsTZxXlsEwTTHdmbzxl31YCM2NqaN9jLmvnPfekGP9NkmCP8LMFpaK1HY7bnalAq9bqI6bcSfAS04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848803; c=relaxed/simple;
	bh=wWn6VVNcXsmnb/vhmyM5fBbC4kzU8P3iGORRIpzzWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saHiZd/brN0KlR9EYBoVrK8c+/phvi80pgfg3I9i2wOFOK6OGNNMtskt1OmzO2NsByfmjW3gaKiwR3fK0AuqnGBz/KmGe8qHOfi9z+AGTVO7G+7SWInZQpeLjq4Ia9uWGkDDZyi4z3pMEzhBQC38gkZhQTQh1yBy6P+fGSmLvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gmviIzJg; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gmviIzJg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLruUzx9XF0R4JXqMCokiTUQ2Dijphce5nGUyqIUaHA=;
	b=gmviIzJgRUvhbxUCMy1wuZlcCuo+b8iAN1jR2bA2eXIMSGqwc3yL+2Vplnwg7iPrStysHH
	CDnHNcQhEuKI4nxPnFHRJyG7O6jvZp4kMHXzIj7oMfV/V4yuH9PbSFIWtVwjkFmjb1NySc
	y2+ehefi71y0+I9RSCMSzQmW4a40HdE=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v4 3/5] mptcp: fix the stall problems with data_ready
Date: Mon, 30 Mar 2026 13:32:58 +0800
Message-ID: <20260330053300.15717-4-gang.yan@linux.dev>
In-Reply-To: <20260330053300.15717-1-gang.yan@linux.dev>
References: <20260330053300.15717-1-gang.yan@linux.dev>
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
 net/mptcp/protocol.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01d04cbea53d..16c5dcab8982 100644
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

