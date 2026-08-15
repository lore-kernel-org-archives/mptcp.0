Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4241F5CA
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805314; cv=pass; b=POdYNXNkNeJ4Oapr2zaPnxClFDx4r2c9rqrGDooBBvz7aWeOvWOFNxcqBe/l7wqaXaBAtVYSUtIoawWyyQR/M/ZwtwZv1+TB/2gmZ74mVYpsI/A8WEC9Qqoa4JxzWaafCpK9ZllaSWVCFAurLMcD42MI/od55Nsvv/k08fmE33g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805314; c=relaxed/simple;
	bh=hmrFll5gDUlbGoaiu5CxiZhxJRVum3JldNTTZi+z6RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ec1o3xf4nxNnVPW9p5kEiCBSh83xJTLkJ5Djc2WZCIbC+O6s7P8LBVVSo7VxIZP7+tgiEvpDXRsane0SlR+jzF8RWHeFUKzZNRycQTnKAghZzE2z8qcftTLVTTLcIakZTDE9jxx/6L4BgfTsba1HwJSrcLK4btj8Ws9uKkrFtnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=TfR0rqOc reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="TfR0rqOc"
ARC-Seal: i=1; a=rsa-sha256; t=1786805247; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DsXRve9mZdN31ek4FPEPnmB6MusYVyHHYmb0/zIu2tPW3GOSntVUbL8uGphwVvJXa5xlJvLb8jRq/gWdbx7Twe8G+HAl9lrtoRMMcNeKd5KsRb2fnoEClACIfZy0AMXtPyDU14Dhr1e4ilrpl4fDmP4dFBM9Lv5leqXckFJ1GEw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786805247; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1vF3F7Sz6iWc16IumqxikyVHDBfjussqUACbo8JBYw0=; 
	b=dG7Tawz5VJZRonDQ9PXJRLoSSEr45/V6CxxjEba4OLgSozKAKJ12bcjL/hB331Z1SFdAjVPGhFxXrON0ikNAJvBCyHHtAkZPF3NLn773DgbLX+ZJljZtsQM23HwT556ygg2bnb5/yHjvHPHfXMM9nzuYKuFkRfdYp4ALaR2hsK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786805247;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=1vF3F7Sz6iWc16IumqxikyVHDBfjussqUACbo8JBYw0=;
	b=TfR0rqOcqIYULY4PMjcsu4KH91qo3HRLkduUSkCTpmJOEgYAX1AF/AlckOB8iI4J
	RLvP8922U+eckAlDFf+DOo3nit2D/PdnQaxl3vYxYj7cKpipgHozC/EIbjtQiTUFyMA
	stI9g1vuhJoOJIVmUPMe/pvTbdrEEVJm0d4cLn7Q=
Received: by mx.zohomail.com with SMTPS id 1786805244111507.42978943774676;
	Sat, 15 Aug 2026 07:47:24 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 15 Aug 2026 20:10:17 +0530
Subject: [PATCH RFC mptcp-next v2 4/4] mptcp: sched: add penalise counters
 and tracepoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-mptcp_penalise_send_v2-v2-4-3e5049a73681@mpiricsoftware.com>
References: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
In-Reply-To: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
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

The two show whether the rate trigger fired at all and how many of those
candidates were actually halved; the gap reflects the gates and the
once-per-RTT limiter collectively, not any single condition.

Add a mptcp_subflow_penalise tracepoint. The penalise verdict is decided
after the subflow-selection loop, once the fastest path is known, so it is
exposed through a dedicated tracepoint rather than the per-candidate
mptcp_subflow_get_send emit. It reports the selected subflow's pace, the
fastest path's pace and its cwnd alongside the verdict, so a slow-but-gated
subflow and its window can be watched from a single line.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 include/trace/events/mptcp.h | 30 ++++++++++++++++++++++++++++++
 net/mptcp/mib.c              |  2 ++
 net/mptcp/mib.h              |  2 ++
 net/mptcp/protocol.c         |  6 ++++++
 4 files changed, 40 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 22882bd03459..fe13f0c8a34d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -68,6 +68,36 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		  __entry->backup, __entry->ratio)
 );
 
+TRACE_EVENT(mptcp_subflow_penalise,
+
+	TP_PROTO(struct mptcp_subflow_context *subflow, unsigned long max_pace),
+
+	TP_ARGS(subflow, max_pace),
+
+	TP_STRUCT__entry(
+		__field(u64, pace)
+		__field(u64, max_pace)
+		__field(u32, cwnd)
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
+		__entry->penalise = subflow->penalise;
+	),
+
+	TP_printk("pace=%llu max_pace=%llu cwnd=%u penalise=%d",
+		  __entry->pace, __entry->max_pace,
+		  __entry->cwnd, __entry->penalise)
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
index e6c10816df8d..ee7a3baa45e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1656,6 +1656,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
 		return;
 	subflow->last_penalise = tcp_jiffies32;
 	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALISED);
 	if (cwnd >= tp->snd_ssthresh)
 		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
 }
@@ -1739,6 +1740,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow = mptcp_subflow_ctx(ssk);
 	penal_cand = fastest && ssk != fastest &&
 		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
+	if (penal_cand)
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);
 	subflow->penalise = penal_cand &&
 			    tcp_snd_cwnd(tcp_sk(ssk)) > MPTCP_PENALISE_MIN_CWND &&
 			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
@@ -1746,6 +1749,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			    mptcp_snd_wnd_test(msk) &&
 			    mptcp_penalise_throttle_ok(subflow);
 
+	/* trace the penalise verdict, decided here after the selection loop */
+	trace_mptcp_subflow_penalise(subflow, max_pace);
+
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst) {

-- 
2.34.1

