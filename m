Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187C37FF78
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736684; cv=none; b=AVUEPDky6IXqZ+m9cD3N5TP+rdkyf37wWrDCi/FKR6WvOTUSxlOMOU8y0EqoNGw7GTi1gnDN41Q0PdYkKoAxLL7apDo5KQsAzHGTUr8GOuCA9ruUB13u2jg/ypKgxj6f/GSj+FmQ2WhkOviIO75s3iwtOUYe0jSkxcxbtqlmsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736684; c=relaxed/simple;
	bh=bm1ZVRLsdS11cVaGGB7GcDaC+TJeTlng3Z7IW4B1BTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6MdtJYfTyKavok9MlzAm7Ab4DH0ZB8kvRizwo4DgSmIMRBg5vdy5cAkKggaC8uEXEfaGauQld9alpAwJy0vy+3dKSvK2jrDTAR4MWqB0nZ3yBubFfmjf2ZJxXsNeD/+IFUvjD3dtY1GlSuuuLQeasAr6abraE4vq6P0OXwtpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYCHlWdf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYCHlWdf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773736681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6iyn65WlbKceIDMk1WyXp73F8sE6Kf1Sf5MuRT0/+0=;
	b=MYCHlWdfw00rFlQi+wZ0hkKoK/my4dMujU8jQLNR8ITlGChLC/RBmkFcmSObrkoXMqY9Z8
	aGg+Gc7ZXKmx1fWmnxmaf6LxNMaZaUsS+VoUakGvUTWMPaGaVa9nYrlMTkE7wrWSwQkJIs
	U29SsWXNBwUaEUT9vbroDfwnJmua/Ks=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v3 2/3] mptcp: fix the stall problems using backlog_queue
Date: Tue, 17 Mar 2026 16:36:56 +0800
Message-ID: <2cfa46433a6dd3c4b8c0f75e9c37430fad08f6d8.1773735950.git.yangang@kylinos.cn>
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
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 759f0486c40b..b1915eef4dcf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2204,7 +2204,8 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	*delta = 0;
 	while (1) {
 		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+		    !skb_queue_empty(&sk->sk_receive_queue))
 			break;
 
 		prefetch(skb->next);
@@ -2259,7 +2260,8 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 
 	/* Don't spool the backlog if the rcvbuf is full. */
 	if (RB_EMPTY_ROOT(&msk->backlog_queue) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	    (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
+	     !skb_queue_empty(&sk->sk_receive_queue)))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.43.0

