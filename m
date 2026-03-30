Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925C37F8A2
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848800; cv=none; b=EDh7rPbyzMNu9+Zqba+cNzUXMrhc8RYQKnQ5KQwH2nIKvxoZePNPW9Ce+5N+X9x3P95WsaGwYxIG6gMJAauGL2Nn6yqWLzvvcufluHaxB2yKhNdIo+Sl/L1UvBTlz/W9SIhv/Zjdpokgr5UrS5LHkiZAJOCnz43mwRkh6aE2qoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848800; c=relaxed/simple;
	bh=ys1LYOCxjkmlSm/3bTmNwB+Od2iFUJqldBEHdfCjAvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UycSwdFfIcG2oIi4hcPhbiyIsXLWEAOZWkWybjDxtUG4dJBXk0nFiXATe3yv2vyKrap5V39pys0fe3+oQy8hJTzb89k9ajwylpPhFQEy5QDCjEF/tauGTaQdzFuyR76WuPnovB/f4BeOESqFWiZIj4sTCR3O95v4tA4gQUCmC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CNISR1mK; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CNISR1mK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boc++GcyEtCsXLwFDSOaXQkpg4hTrQfawgcm43IUzP4=;
	b=CNISR1mKkdqZpzbgNYGmieVr10FJ+jWg4Rykc9UriXS3mNpH7S+2QCY/7wCRKAYgx1rRMM
	8TBrLN20kOXojG8oE4+rxbW1IeoLDz5fErFiFggOQLa64R/d4kXm82Wftx9K4Tc19HlcHY
	zxmpMAkJu0DkScaWFYISX0xYJx4r9Hs=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v4 2/5] mptcp: fix the stall problems using backlog_queue
Date: Mon, 30 Mar 2026 13:32:57 +0800
Message-ID: <20260330053300.15717-3-gang.yan@linux.dev>
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
index 03eaa92badd5..01d04cbea53d 100644
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

