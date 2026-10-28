Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186154;
	b=QsMjXg4l6cFod111LLRGt43Vc+wE0g51zuwajuikA4QbmapC5u9WNUBw0s5/9LfdsCQF
	 LUMl7axx+zgOJcXYdBFkPnRTXFe6n9mcHAMatLmRgKkXQv0pLVGHgSNfuZXQMr6bZZTJK
	 s0gRGVyDICWGgGJrwtC3um8fqKYm5a+yst0D8gf4T1Zb2r9lxT6vyTdCwdrfWx+fYOl5C
	 UqOQ0URYZhaJsUBt966oCcgJ5cvj0K9AdTJfz4xuHqn4Pza+CETI6MRseIT8QDOR81x8/
	 5f6l516fiC27LSyMIcuwBg4F6Jc3T0acpNRfAjjSO8yJhYkQU8r/3TNc4WZ34BrjIFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186154;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=q21RE6MccZGJhg5Lj2l+M+ogxP3l8KGSy8WYkdeSmp8=;
	b=2uTeLoLoqVyry8yKBkoBZYOjNk70tfU4BvST0U+xVgB8SGYuVCuVv03iW5RVON3PTtUm
	 czo7lispzZkZJRdkqGepiHHZ9gwCngiBUW8ZOCytuus2s6NiwvFehFkRMB/RCsPKqI/FR
	 VSqh0qv6M6YDJQknfPp1BuYIB2uhEW3klngedv5BAQvLbzMmSG7s2TwaRQ51COHS2dBAk
	 ArzFfDfWfmmraIxQhnUNaEcDcgrUKNeu949d+OCtXaTvbX66gb4NHsxY/bGpIetOuAmem
	 /TcKMrCZ9XI5Q1lwkEI17RJT4KNZ1ipiKRhAfE+HM9EcGxRoGhhDTqBiVnbAtCcFyxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.52
Received: from sender5-of-o52.zoho.com (sender5-of-o52.zoho.com [165.173.182.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700B606A31C
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D700B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793186140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a9gP9xvEAExXpGcujhF1YCQCYwOHpwdkKi72hn8DMGLLR95DM6waOTA+/YRwRqbfRxs5syFuZH19Q5nD3SwCkkXZ8pc9Tq7DLJGtsyAuDzmguNVx8KCcBED6oO8w7TqSdyJnkdih6ERXMvnbpJ+hBaDFt/gPyPsgomKvhJA7+Lo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793186140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q21RE6MccZGJhg5Lj2l+M+ogxP3l8KGSy8WYkdeSmp8=; 
	b=cIq1KKNrkz/+0+bsy3oQ0A8mRXKU1d39vK66HVgLFujY2TO8hJoHS/diyacGZ5DjCUZfH8por7c81R5DUvNt9j1E9ZFohaUzh9TpUcOg88LkrjiFj9mbE/fKWU9MMoLBzcnNYwZNqeWhP8h8ihMbz0QlBUgcTPhyuYBiug5pri4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793186140;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=q21RE6MccZGJhg5Lj2l+M+ogxP3l8KGSy8WYkdeSmp8=;
	b=pgEZT/W7u9kBY7+wnAb6j1siV5RJzSvqUXQcAm4TTkv9tSgIemnrlGhUJvHJ2ZoY
	OEWU5pPuAJ2cTcDF74e9FVrCuLr3fAcUC+wxftCW8dmRBRJwfOu05eNiqqkWRsBD9x7
	nICJLTvhD/BL9/JoaZvvWxosEBJAuqEvvyktEuac=
Received: by smtp.zohomail.com with SMTPS id 1793186138188530.9443410752061;
	Wed, 28 Oct 2026 04:15:38 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Wed, 28 Oct 2026 16:45:09 +0530
Subject: [PATCH mptcp-next v5 2/4] mptcp: sched: penalise a slow subflow by
 halving its cwnd
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
Message-Id: <20261028-mptcp_penalise_send_v2-v5-2-32fb379ce117@mpiricsoftware.com>
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
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Tested-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  2 ++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 886f00ee2a4d..395f9582ece8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1624,6 +1624,45 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
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
@@ -1633,10 +1672,11 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
 
@@ -1665,6 +1705,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1692,12 +1738,22 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
@@ -1759,6 +1815,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	if (mptcp_subflow_ctx(ssk)->penalise)
+		mptcp_penalise_cwnd(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..1d41ab1da2e0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,6 +605,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	bool	close_event_done;   /* has done the post-closed part,
@@ -630,6 +631,7 @@ struct mptcp_subflow_context {
 				     */
 
 	u32	subflow_id;
+	u32	last_penalise;	    /* tcp_jiffies32 of the last cwnd penalty */
 
 	long	delegated_status;
 	unsigned long	fail_tout;

-- 
2.34.1

