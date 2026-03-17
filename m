Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AD37FF78
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736687; cv=none; b=k6dDcRzzm9wKM2wLO67XT+yT9+UgRveRecyvmrkxau+zB/lIZCg98idjCV/56nLlY1WiWM6ygHg4rA110u9jrpz5wXo4b9reWhZ0S4VhsCYNNRYSUK/jFhHpqomkypSnuqfrVd4wYsGDYZQ5END48fdRTyhfssLwAEA2sIIxA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736687; c=relaxed/simple;
	bh=2SwIzlipmsPxfg/8ClMgnZqp4IM6UnYkS2wtK8DQlg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkBFOoHL4AYfldhFynsm5i7X9o3Yg2vbrEA5sSGkrwEJkl0vnR2XeKYFjIIUNoWrICjaLtLYZOZ53SdCuR6q2qmx7Tj/2F0v8RaBOP4RilkB+FflzqCKIKxk3xa/b7us8u1JWKWNIHrej8coTJfxxGmCVy2Cf4N4EUyR97UDUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfStd3uO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfStd3uO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773736684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHMGdq3HkhVNqtdQd2+IcJoGkTfCwNqwTqzwUpJVoKo=;
	b=dfStd3uO3l1WY8/AH7t6LNVz7Xiu/QBME88q+Itdv8G/GjojSqk3ep5p/27NJDMbUQAOSw
	72YYKR3bc0bPrlP2VhBJJsx7PAknzWT7rrIpobgD73Q4nRhNTvpAmmGEoqaeDfPlEbvLSd
	haxnc4GXm3qW04E1L5RokIrZRmsyORI=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v3 3/3] mptcp: fix the stall problems with data_ready
Date: Tue, 17 Mar 2026 16:36:57 +0800
Message-ID: <9883dd53b01a0e307e35fe54005e0176a030cc30.1773735950.git.yangang@kylinos.cn>
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
 net/mptcp/protocol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1915eef4dcf..023a4fb68617 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,6 +29,10 @@
 #include "mib.h"
 
 static unsigned int mptcp_inq_hint(const struct sock *sk);
+static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs);
+static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
+				  struct list_head *skbs);
+static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -892,6 +896,17 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	bool moved;
 
 	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
+	if (!moved && skb_queue_empty(&sk->sk_receive_queue) &&
+	    !RB_EMPTY_ROOT(&msk->backlog_queue)) {
+		struct list_head skbs;
+		u32 delta;
+
+		while (mptcp_can_spool_backlog(sk, &skbs)) {
+			moved |= __mptcp_move_skbs(sk, &skbs, &delta);
+			mptcp_backlog_spooled(sk, moved, &skbs);
+		}
+	}
+
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err))
 		__mptcp_subflow_error_report(sk, ssk);
-- 
2.43.0

