Received: from sender5-of-o52.zoho.com (sender5-of-o52.zoho.com [165.173.182.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259623AEF51
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120713; cv=pass; b=cncRHie5/oEUihUI3kobKAjnZXNy/SdhPLRgrMKiVseU1WEbwWZlEUNULedyPISpHChWYlTHpKGOpoOcmnMKKmGQzcsoeuYrycAEmJXmuYKBxPCbW8vOSckAljbXkSJdNsk2mAcWeoWBvp5zZ7M0e2QX91FIelOIFcyjk0nJJO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120713; c=relaxed/simple;
	bh=QVhF43U47EOFGckHlU0zUQe5lHlnFxDkqHBpzI7ED8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCSxcu9aONNGPrY06Y7TZRNLTuM/XwYxC3TrZlCK9DjTjBhjF2H+CR3Mr3fGB6s1LQnWRUSGiphZKmutE9H20OhcDYSJeEe8IJ07p5BTpGMmg1FRvE9ooPWbNyUDDp7prVBIltySr+xCMUiQ5PTj3msCOG/KxnHi+cyKt1Xmx5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=BTXNktvW reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="BTXNktvW"
ARC-Seal: i=1; a=rsa-sha256; t=1789120686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b5SOXiZorBy/SvDhh/kKdM74JuQ5Q8+Wtt6n5d/VtLpQhx+zqvtCuvOlIH+XvphtHYGcoZw+wy7huFtFDk39f/iEirJxFP8zd+xpgmZWplXtL2GmnVULDw/eDIwua3cDr6jmlzTIpynDrUt2s7tqgD50RXAXa3Ir5ZiuuIihdBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120686; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HOInaFlfUeMybGO4powUer8F0tv5KGhqMCQIEeTMSP8=; 
	b=PUrtaESVvKci0MwU/+tkbs6+eBmjq3NPGKw+2zRfBjC+uxITxYFSLv8qUlOCj4zAcNhFdyZWHHCFeIZTp+agkh7wTpsqzze+wsmzOEQtVJyg/ReNLr7XPUOVfrcmTcKa/W7KiJCBN+BbXyeDy5d7+EPuBKZiagJwLN8W+LxWRnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120686;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=HOInaFlfUeMybGO4powUer8F0tv5KGhqMCQIEeTMSP8=;
	b=BTXNktvWmW9riZ4DMM+FKD8uRse+FrxaqyMNeX4yCS6QVd9uz/pp5+S9dDYMc3Yk
	MZkQSU1TLGN0gFoKu2P9m+xUPiCAKpQFiAiTblK6pPKQlOzNcIVQpWj5V+oa05RDTPG
	TbO2b79Gju9Fx+BNtwYlMypGVKAir1/GWNjEu8qk=
Received: by smtp.zohomail.com with SMTPS id 1789120685060799.4295343833461;
	Fri, 11 Sep 2026 02:58:05 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 11 Sep 2026 15:27:47 +0530
Subject: [PATCH mptcp-next v4 4/4] mptcp: sched: add penalise counters and
 tracepoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mptcp_penalise_send_v2-v4-4-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Add observability for the cwnd-halving penalty introduced in the previous
patches.

Two MPTcpExt SNMP counters:
- CwndPenalised: times a subflow cwnd was actually halved;
- PenalCandidate: times the rate trigger picked a slow subflow.

The two together show how often the rate trigger fired and how many of
those candidates were actually halved. The difference is the combined
effect of the remaining conditions, so it does not isolate any one of
them.

Add a mptcp_subflow_penalise tracepoint. The penalise verdict is decided
after the subflow-selection loop, once the fastest path is known, so it is
exposed through a dedicated tracepoint rather than the per-candidate
mptcp_subflow_get_send emit. It reports the selected subflow's pace,
the fastest path's pace, its cwnd and the send burst alongside the
verdict, so a slow subflow and its window can be watched from a single
line.

The verdict is emitted once the send burst is known, so it accounts for
the window check. The conditions local to the subflow are evaluated
later, under that subflow's own lock, so a set verdict here means the
scheduler picked the subflow as a candidate; CwndPenalised remains the
count of penalties actually applied.

Assisted-by: LLM
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 include/trace/events/mptcp.h | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/mib.c              |  2 ++
 net/mptcp/mib.h              |  2 ++
 net/mptcp/protocol.c         |  4 ++++
 4 files changed, 41 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 22882bd03459..f16e04b81322 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -68,6 +68,39 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		  __entry->backup, __entry->ratio)
 );
 
+TRACE_EVENT(mptcp_subflow_penalise,
+
+	TP_PROTO(struct mptcp_subflow_context *subflow, unsigned long max_pace,
+		 u32 burst),
+
+	TP_ARGS(subflow, max_pace, burst),
+
+	TP_STRUCT__entry(
+		__field(u64, pace)
+		__field(u64, max_pace)
+		__field(u32, cwnd)
+		__field(u32, burst)
+		__field(bool, penalise)
+	),
+
+	TP_fast_assign(
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		__entry->pace = subflow->avg_pacing_rate;
+		__entry->max_pace = max_pace;
+		if (ssk && sk_fullsock(ssk))
+			__entry->cwnd = tcp_snd_cwnd(tcp_sk(ssk));
+		else
+			__entry->cwnd = 0;
+		__entry->burst = burst;
+		__entry->penalise = subflow->penalise;
+	),
+
+	TP_printk("pace=%llu max_pace=%llu cwnd=%u burst=%u penalise=%d",
+		  __entry->pace, __entry->max_pace,
+		  __entry->cwnd, __entry->burst, __entry->penalise)
+);
+
 DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 
 	TP_PROTO(struct mptcp_ext *mpext),
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..b39b5511345d 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("CwndPenalised", MPTCP_MIB_CWNDPENALISED),
+	SNMP_MIB_ITEM("PenalCandidate", MPTCP_MIB_PENALCAND),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..a7b5bf684af7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_CWNDPENALISED,	/* subflow cwnd halved by the scheduler */
+	MPTCP_MIB_PENALCAND,		/* scheduler picked a slow (low-rate) subflow */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 24e1d6bd8577..682710ab262e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1662,6 +1662,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
 		return;
 	subflow->last_penalise = tcp_jiffies32;
 	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALISED);
 	if (cwnd >= tp->snd_ssthresh)
 		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
 }
@@ -1745,6 +1746,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow = mptcp_subflow_ctx(ssk);
 	penal_cand = fastest && ssk != fastest &&
 		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
+	if (penal_cand)
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);
 	/* We use data_race() because tcp_cwnd_validate() might change
 	 * is_cwnd_limited under us
 	 */
@@ -1754,6 +1757,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	/* the conditions on this subflow are re-checked on apply, under its lock */
 	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);
+	trace_mptcp_subflow_penalise(subflow, max_pace, burst);
 	if (!burst)
 		return ssk;
 

-- 
2.34.1

