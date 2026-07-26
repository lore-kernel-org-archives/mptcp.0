Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7A345EBA
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045358; cv=pass; b=RKpIcjjnVm0zQqR0mAwMnKDYUVEN6adeEKyNRn5UMchhH7ypOCYMeXfAInFEoXUl9L2GXyN4okgw9A7m3kIVwqybyHnwK607p4bJpxUY4jorEQLBSawQfLiYTQUjWPqZUFLqvCjtkn91EbPeOlSAWdB41H9Qm4B+iUCylpnORnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045358; c=relaxed/simple;
	bh=Cv4Vjadr/xT4540f5vJ4RvllAke9wZV6FPfeUgyBrew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4SSJp7SjPdwmRsqMb7kyZFC0AmsAWOR6/5Q8uc2JKJHXhum9N3sZxPekfOIwEAa7TAYfSGB9SOzbY6ntQqOHJpK1w+s7Z7lei1poRUqFOWAzYBaOqj+IGz7ohd002qneXuGiH9vroD/TBM/sYDx8/QWv2jtpxYxZGCXqdcuk1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=nlUx+g44 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="nlUx+g44"
ARC-Seal: i=1; a=rsa-sha256; t=1785045349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pcx6aJSTCAAZmXgax45oErpj13cUkYIIze+xWGb/NLtykmTAUMLc4oVC8QalsF5In6K5eKbbaPgr2o8/S142XRT+Xc+PFS9Sr7o9pk3eEk+A10xaMUbCTszAjamMAuKAd/9DNRsAtL4khes20s0zJ4jJ0CmwLbr7TuMSp63xHHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785045349; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UVtITDEgz/KxhUnTc1UPqAUDFUyjySAdLQEixgkK4g0=; 
	b=ZX36XphVUht70CUmHl09GD3AvgOisB5KfLN6SEwuXZ4gqZfSeiQIQs+fB49K3P4IPJPEYjV6Kp66ZCJUBbweRogglaOIvbYB/KXNKN6q1lxKAvB5dkQsj/qDeVUhHpDSulcfKs1fY9bkyca/YhV+lj4efAY7nHU/zbl4gxnfiJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785045349;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UVtITDEgz/KxhUnTc1UPqAUDFUyjySAdLQEixgkK4g0=;
	b=nlUx+g44IyNdNgvEg2qHDX/H+mIQatrYmdhb6wWyamSDdB0zi02C/1A1W16lBtTA
	8Xl9bhfk+Ad12gTkFgAde5YzhuCZ0ifxATpHKAgz6XKQTuJgVW+vJ6UGcyPqiwoURBg
	ZaIiKUzUZiiOHtBoB/ZPihQDFZ5oGtgFHiiXm2Z0=
Received: by mx.zohomail.com with SMTPS id 1785045347193826.8495920531584;
	Sat, 25 Jul 2026 22:55:47 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sun, 26 Jul 2026 11:25:39 +0530
Subject: [PATCH mptcp-next 1/3] mptcp: sched: penalise a slow subflow by
 halving its cwnd
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-mptcp_penalise_send-v1-1-84485e0e995b@mpiricsoftware.com>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
In-Reply-To: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

Issue #345: a poorly-performing but usable subflow (high latency, loss,
bufferbloat) can soak up connection resources and cause head-of-line
blocking of the aggregate stream. Give the default packet scheduler a way
to send less than such a subflow's full congestion window.

Once a subflow has been picked for transmission, flag it for penalisation
when:
- its smoothed delivery rate (avg_pacing_rate) is below half that of the
  fastest path, keying on rate, not RTT, so a slow-but-high-throughput
  path is left alone;
- the fastest path is cwnd-limited (saturated), so shifting load off the
  slow path is worthwhile;
- the subflow is in TCP_CA_Open, so its cwnd is not already being reduced
  by loss recovery;
- it has not been penalised in the last RTT.

The reduction halves tcp_snd_cwnd (floor 2) and ssthresh if cwnd
is past it. It is applied in the push path under the subflow socket lock,
which protects snd_cwnd (the scheduler runs under the msk lock). The
congestion control grows the window back, ACK-clocked; that regrowth is
the built-in probe, so no explicit MPTCP-side probing is needed.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  2 ++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 954e20bb27de..d31bcb9ad894 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1556,6 +1556,44 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
 
+/* Penalise a subflow whose delivery (pacing) rate is below the fraction
+ * 1 / MPTCP_PENALISE_RATE_RATIO of the fastest path's rate. Keying on rate,
+ * not RTT, throttles only a path whose throughput contribution is small
+ * relative to the head-of-line cost it imposes, and leaves a merely
+ * higher-latency but high-throughput path alone.
+ */
+#define MPTCP_PENALISE_RATE_RATIO	2
+
+/* Rate-limit the penalty to at most once per subflow RTT, so the congestion
+ * control can grow the window back between reductions.
+ */
+static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	u32 rtt = usecs_to_jiffies(tcp_sk(ssk)->srtt_us >> 3);
+
+	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
+}
+
+/* Halve the congestion window (and ssthresh, if cwnd is past it) of a subflow
+ * the scheduler flagged. Runs in the push path under the subflow socket lock,
+ * which protects snd_cwnd. The congestion control grows the window back,
+ * ACK-clocked, and that regrowth is the built-in probe, so no explicit probing
+ * is needed.
+ */
+static void mptcp_penalise_cwnd(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 cwnd = tcp_snd_cwnd(tp);
+
+	subflow->penalise = false;
+	subflow->last_penalise = tcp_jiffies32;
+	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, 2));
+	if (cwnd >= tp->snd_ssthresh)
+		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
+}
+
 /* implement the mptcp packet scheduler;
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
@@ -1565,9 +1603,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u32 pace, burst, wmem;
+	u32 pace, burst, wmem, max_pace = 0;
 	int i, nr_active = 0;
-	struct sock *ssk;
+	struct sock *ssk, *fastest = NULL;
 	u64 linger_time;
 	long tout = 0;
 
@@ -1596,6 +1634,14 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
+		/* track the fastest path by delivery rate; the penalty below
+		 * throttles paths that are slow relative to it.
+		 */
+		if (pace > max_pace) {
+			max_pace = pace;
+			fastest = ssk;
+		}
+
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
@@ -1623,12 +1669,25 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
+	/* Flag the chosen subflow for cwnd halving (applied in the push path)
+	 * when its delivery rate is a small fraction of the fastest path's and
+	 * that fast path is saturated (cwnd-limited), so moving load off the
+	 * slow path is worthwhile. Only penalise a path in TCP_CA_Open, one
+	 * whose cwnd is not already being shrunk by loss recovery, and at most
+	 * once per RTT.
+	 */
+	subflow = mptcp_subflow_ctx(ssk);
+	subflow->penalise = fastest && ssk != fastest &&
+			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&
+			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
+			    tcp_is_cwnd_limited(fastest) &&
+			    mptcp_penalise_throttle_ok(subflow);
+
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst)
 		return ssk;
 
-	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
@@ -1685,6 +1744,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	if (mptcp_subflow_ctx(ssk)->penalise)
+		mptcp_penalise_cwnd(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..2bf801292563 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -587,6 +587,7 @@ struct mptcp_subflow_context {
 		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
+	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
@@ -606,6 +607,7 @@ struct mptcp_subflow_context {
 	u8	stale_count;
 
 	u32	subflow_id;
+	u32	last_penalise;	    /* tcp_jiffies32 of the last cwnd penalty */
 
 	long	delegated_status;
 	unsigned long	fail_tout;

-- 
2.34.1

