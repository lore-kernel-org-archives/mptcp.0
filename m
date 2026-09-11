Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038113D9531
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120697; cv=pass; b=rX2uo57g0r6RRRik00+taatL1Zj3PITt3Q+qViXL2dzmZXTGVBKT1dYYogzQ2EVuC/+Xe8ltPAp5Qqc0cENhxnxttP89b7c7qDRuTfBj06+XvKQmdbCmXj887bxkYEQItwYFpGGu9yt19GEJi2XATJ7BKVUxWkmWtS9Yn5Tf4AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120697; c=relaxed/simple;
	bh=yPqctiTxMcMoB+5vfxTctzGVoEZTl64GYI7J4p/puxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gcfC058SA5Qn6tspUEGgafvKBbsz194NTSc0lnTx+sGWHRxQ8VHnZdfYzCVIwfXlQQXQY1nUq4SRNFl24K4uKhM8vKDkG70ycfiI8BqmJTyIAXc3BeiK8ogyINseOsTKHfsmk2zIEXpuMvp0WFlY61IRlYqBoQRGHwGraiRBW30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=qLK3UP4w reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="qLK3UP4w"
ARC-Seal: i=1; a=rsa-sha256; t=1789120680; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AEs+/yehj75mo/75ZBws4g0dPGx7RYE/h0bcUnmNPlSYbIcvOwPkY9u84V24vBxsGFRnN1wJPxkWoUq3IabazYqcRtPkKJiBakpnaPCTk4Ae65cUjzxs/dyIH9qhblhnQPikn07MrLfJCyqNqPr9eyjiYXrbsi322D/ouWhc1pM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120680; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tQewcVk8YvVG4bh8ZcBDavyRZVpbUnkoO5TTjMhd4TM=; 
	b=UiyHk/fhkNQF6PHTHAC2KRTkLoSspAmXvRT0qo++65yv0KAdSu4s5lmzt5SnAwIQZsI0L/z47JS97M43c1kWEd6FyJClLiUm66ncZHQ7kYoIZ0Hiy40R0WZ8Xa2Hmhc/RQ5DktQfDLDkHXYM8ToCGI4OBO4BaRnDCa02qHrRhBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120680;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=tQewcVk8YvVG4bh8ZcBDavyRZVpbUnkoO5TTjMhd4TM=;
	b=qLK3UP4wM9jENrgTwmP6LMw1WJBNXsEKEafTlPiIm6wVIcbu5OhvZDxvIoZdw7XW
	9z1eFRH2re26SuZI/SM+QYVvgPyQ7XL7bQu+fkp3btufm4UAtbBWaESUB8nDALX1uoN
	lk7qsRGNiAg2FeP7/C5BouO785hdnSgVXKXNFkVM=
Received: by smtp.zohomail.com with SMTPS id 1789120679804421.458447629494;
	Fri, 11 Sep 2026 02:57:59 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 11 Sep 2026 15:27:45 +0530
Subject: [PATCH mptcp-next v4 2/4] mptcp: sched: penalise a slow subflow by
 halving its cwnd
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mptcp_penalise_send_v2-v4-2-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

A poorly-performing but usable subflow (high latency, loss, bufferbloat)
can soak up connection resources and cause head-of-line blocking of the
aggregate stream. Give the default packet scheduler a way to send less
than such a subflow's full congestion window.

Once a subflow has been picked for transmission, flag it for penalisation
when:
- its smoothed pacing rate (avg_pacing_rate) is below half that of the
  fastest non-backup path, keying on rate, not RTT, so a
  slow-but-high-throughput path is left alone;
- the fastest path is cwnd-limited (saturated), so shifting load off the
  slow path is worthwhile;
- the subflow is in TCP_CA_Open, so its cwnd is not already being reduced
  by loss recovery;
- its cwnd is still above MPTCP_PENALISE_MIN_CWND, so a subflow already at
  the floor is left to recover instead of being churned by a halving that
  can no longer reduce it;
- it has not been penalised in the last RTT.

Backup subflows do not take part in the fastest-path comparison. While an
active subflow exists a backup carries no data, so both its rate estimate
and its cwnd-limited state go stale; using one as the reference would
penalise the subflow that is actually sending.

The reduction halves tcp_snd_cwnd, floored at MPTCP_PENALISE_MIN_CWND, and
halves ssthresh when cwnd is at or above it, following the out-of-tree
mptcp.org implementation's ssthresh handling. The congestion control is
left to raise the window again; this adds no MPTCP-side probe or timer.

Split the conditions by the lock that covers them. The scheduler runs
under the msk lock and only marks a candidate, using the rate comparison
against the fastest subflow. The conditions belonging to the subflow
itself (the cwnd floor, the CA_Open state and the once-per-RTT limiter)
are evaluated where the penalty is applied, under that subflow's own
socket lock, so the limiter's timestamp is written and read under one
lock.

The rate comparison reads the fastest subflow's state without holding its
lock: that is a different socket from the one being pushed, and taking a
second subflow's socket lock in the send path is not acceptable. The field
is a bitfield, so READ_ONCE() does not apply; annotate it with
data_race().

Halving the window without telling the congestion control is deliberately
a simple first step: not every congestion control reacts to an external
change the same way, and some may undo it quickly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/345
Link: https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L300-L330
Assisted-by: LLM
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  2 ++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c3c1c902d1d..0417bfb3db7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,6 +1619,45 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
 
+/* Penalise a subflow pacing below the fastest path's rate / this ratio */
+#define MPTCP_PENALISE_RATE_RATIO	2
+/* cwnd floor for the penalty: skip a subflow already there, and never reduce
+ * below it (halving at the floor only churns congestion control).
+ */
+#define MPTCP_PENALISE_MIN_CWND		2
+
+/* Rate-limit the penalty to at most once per subflow RTT, so the congestion
+ * control can grow the window back between reductions.
+ */
+static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	u32 rtt = usecs_to_jiffies(READ_ONCE(tcp_sk(ssk)->srtt_us) >> 3);
+
+	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
+}
+
+/* Halve cwnd, and ssthresh when cwnd is at or above it, under the subflow
+ * socket lock: the scheduler only marks a candidate, the conditions on this
+ * subflow are evaluated here, on current state.
+ */
+static void mptcp_penalise_cwnd(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 cwnd = tcp_snd_cwnd(tp);
+
+	subflow->penalise = false;
+	if (cwnd <= MPTCP_PENALISE_MIN_CWND ||
+	    inet_csk(ssk)->icsk_ca_state != TCP_CA_Open ||
+	    !mptcp_penalise_throttle_ok(subflow))
+		return;
+	subflow->last_penalise = tcp_jiffies32;
+	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, MPTCP_PENALISE_MIN_CWND));
+	if (cwnd >= tp->snd_ssthresh)
+		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
+}
+
 /* implement the mptcp packet scheduler;
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
@@ -1628,10 +1667,11 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	unsigned long pace;
+	unsigned long pace, max_pace = 0;
 	u32 burst, wmem;
+	bool penal_cand, fast_limited;
 	int i, nr_active = 0;
-	struct sock *ssk;
+	struct sock *ssk, *fastest = NULL;
 	u64 linger_time;
 	long tout = 0;
 
@@ -1660,6 +1700,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
+		/* fastest non-backup path; slower ones get throttled below */
+		if (!backup && pace > max_pace) {
+			max_pace = pace;
+			fastest = ssk;
+		}
+
 		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
@@ -1687,12 +1733,22 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
+	/* Flag a slow subflow for cwnd halving, applied in the push path */
+	subflow = mptcp_subflow_ctx(ssk);
+	penal_cand = fastest && ssk != fastest &&
+		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
+	/* We use data_race() because tcp_cwnd_validate() might change
+	 * is_cwnd_limited under us
+	 */
+	fast_limited = penal_cand && data_race(tcp_is_cwnd_limited(fastest));
+
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
+	/* the conditions on this subflow are re-checked on apply, under its lock */
+	subflow->penalise = burst && fast_limited;
 	if (!burst)
 		return ssk;
 
-	subflow = mptcp_subflow_ctx(ssk);
 	/* 64-bit arithmetic overflows at high rate with a large queue */
 	subflow->avg_pacing_rate =
 		mul_u64_u64_div_u64(subflow->avg_pacing_rate, wmem,
@@ -1752,6 +1808,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	if (mptcp_subflow_ctx(ssk)->penalise)
+		mptcp_penalise_cwnd(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4453db7a33cf..1f2a709864d9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -603,6 +603,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
@@ -625,6 +626,7 @@ struct mptcp_subflow_context {
 				     */
 
 	u32	subflow_id;
+	u32	last_penalise;	    /* tcp_jiffies32 of the last cwnd penalty */
 
 	long	delegated_status;
 	unsigned long	fail_tout;

-- 
2.34.1

