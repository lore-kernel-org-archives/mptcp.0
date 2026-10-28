Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186176;
	b=VqsJU4/yOhFuxpdqm5lJlV0QdWqP+2In3M5+McjmXQ/nyGeaLaWmuTMI3+ZS4s22/BC3
	 eYPcZJYn+uc0iu9Z3gqu9HH7AtBY6etdcE5p4lUfFnZWw0ySDWGnyyYwUzBBR0JMLUwD4
	 WJtp2oATzafTRO+Ji90TwvNr2XVokKBEtTHbN0u+7DP75XsDQgMR1KnCUOTbTWXabS9ol
	 a3xd0TIiItlwAIMAZJhgUPPOXrD5Jhg0qocqGaMhJsxnGjVzG3Am1I9cBxl1hq/DR15o1
	 fWQezBO2yL30yPNT7aYpa1M/AFE1DTIn9Dej6M4+1kVsYJ8aUWVpAnwo/nQWzYOFJHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186176;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=bjo63Po4HnZgVzbwBJLMYyaHXsG3hyUNqmtV9wHK36I=;
	b=IKgr773UtVZI9PLaJhjnwwAkzfuDKN63aAuC4gGCFPerU3so3w7eZN/8rT6DC0wSMz5o
	 OUn0MiqBvtrfNPuEAD7nWKfdqvh/OqgxkH4F51R1in7BXvnfzOI9mek4eukRrirE1i3wP
	 d7sMqfL69GZ18cMtUCTWdx3GBVmWiPxmYaiXIKAtoHxGSNmI7cjOTU4N6Mvfm4ZpPOqOY
	 0hwrV0Glnx6hjUURSO9Jyq0IuCPuUT9UaFg4rmZcGgXSpZdHNJkNtP2mKyqY8Ke5XabqW
	 7NcF7zlVkIDThi0DBV7dytxicSAWbqYgo5Xj3Bla6In1nGHOrbFsZ4/Qhj9NgPiInxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0B606A31D
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A0B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793186146; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lL9ZG7SvbEUKnWffA1xe+9uyJpNhrr9paGoBIj0Ks13tTP+w7rLhPUIqMNIW5ZXslFuytF3dKNwJNnWLKiW1ENlp2Gw+BZa4IRQik+bQ/lObpW52rcMx4BAFUD2IO3g43DyxSJjcXhzEIpMfXgJTtGs6owzkGOOFloh2rhGTpcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793186146; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bjo63Po4HnZgVzbwBJLMYyaHXsG3hyUNqmtV9wHK36I=; 
	b=jVo4jq8J74HVjz1CjO290t4lLFVdbc2FQqMJU89K9c5DS0trh7+04B0UCwBt4EufU66Q9A8JlQUb/9v5yjD3zTTr7RQd+PDvzV9N2m98Z6TdL5Nym+Rt73YZTvG2S8EiaOcqPUmN+hEGLDQS0p6uA2Y9NlbEf1cpirG8bjfJdGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793186146;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=bjo63Po4HnZgVzbwBJLMYyaHXsG3hyUNqmtV9wHK36I=;
	b=fUCKM/nl355WbbipRnQpOIYdv+KV8N+qaoQMpeuxjz93atQ6moWGwlUmsOECaytR
	rJKSMtopNxv9yvEwv7mmtxWYd4xCI166KIvS+GDGQfj+XtK/zxDm4/OB68GCcQv8s0Q
	0bJSBD6FgncCLLID3OZOb7vYnV/r+5M6ii0vp6JI=
Received: by smtp.zohomail.com with SMTPS id 1793186144423313.807320454046;
	Wed, 28 Oct 2026 04:15:44 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Wed, 28 Oct 2026 16:45:11 +0530
Subject: [PATCH mptcp-next v5 4/4] mptcp: sched: add penalise counters and
 tracepoint
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-mptcp_penalise_send_v2-v5-4-32fb379ce117@mpiricsoftware.com>
References: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
In-Reply-To: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Abdul Wasey <w453y.me@gmail.com>
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

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Tested-by: Abdul Wasey <w453y.me@gmail.com>
---
 include/trace/events/mptcp.h | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/mib.c              |  2 ++
 net/mptcp/mib.h              |  2 ++
 net/mptcp/protocol.c         |  4 ++++
 4 files changed, 41 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index c47fa2672b84..de34e107e202 100644
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
index 5eef96fa4f3e..8f3c6ebd49ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1667,6 +1667,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
 		return;
 	subflow->last_penalise = tcp_jiffies32;
 	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALISED);
 	if (cwnd >= tp->snd_ssthresh)
 		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
 }
@@ -1750,6 +1751,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow = mptcp_subflow_ctx(ssk);
 	penal_cand = fastest && ssk != fastest &&
 		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
+	if (penal_cand)
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);
 	/* We use data_race() because tcp_cwnd_validate() might change
 	 * is_cwnd_limited under us
 	 */
@@ -1759,6 +1762,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	/* the conditions on this subflow are re-checked on apply, under its lock */
 	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);
+	trace_mptcp_subflow_penalise(subflow, max_pace, burst);
 	if (!burst)
 		return ssk;
 

-- 
2.34.1

