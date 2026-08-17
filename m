Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1544780A
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980296; cv=pass; b=X72tXei8O8WprcFD0CMi/YOoHdYrc52spHqa6US6RbuGgVzllGQ9kHCunpeX6/nWJ72AG/Y5wYLSm3fdqRy96rY8yuNB6v9teWjsAWb4QXx0heMKX515gXEZj/y8WRoWxBd8obKuI5dwbeyIyzfnzpHo87jrPS2Hr0DrO+nfrxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980296; c=relaxed/simple;
	bh=ZxexvrsCYi8oLZz5AAG150TFLFja1pDpM8pRvyIGVm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYLB8E8k1WysM2TyeUUwqlkSIhHaLkRCphPaZK029opPXC9M7cf6Tektaeln3DTGjbxf/itQQE/agWoSyFrnTJ0K161GCO+4eg+mr991cGLkm9sy2W20l2mCFAOMn7yjE5IYzZaxbOrcnJTUaOu/5xhw0bKDrznaJTbnvWxpsv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=UpUQICau reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="UpUQICau"
ARC-Seal: i=1; a=rsa-sha256; t=1786980280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LRQ4EB4EhiCKygCIPgayqUVPoapQUTQiDI9c1ykb/uoGws1Ymg10JbZBk6ZD6YrdkMAwWmIWtMgNO3wlo4cc7ifOVF0qDcM58zwfzQ5PoHXysVUxbn7OyaFnX6qAMLefVNZIix44K5kAkstFVI02gTLGj76cLcVQ1BOucjrFncA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786980280; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZVV6or4Eaj3eiGqEbMvw5TS3CQe+YKl3UdJDJfxbrAk=; 
	b=L8P33o+f2rxggpTkixk5GUhV2y+RXOl9BAUYdd5/s4GyFnx63evDK0pl6CvQwqbHLptAWdHKvekmsuIBf6/RRWoPMka1XbifR9NLsQds5+3Y3uX+z3h7Qxtxym99Nlu4fsgmywnvLukUT4RLntkjklmKw0K3BXc6d6pn1JMf7NM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786980280;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ZVV6or4Eaj3eiGqEbMvw5TS3CQe+YKl3UdJDJfxbrAk=;
	b=UpUQICau9IiezaBSBQx5rasZ1phg3y5DiOa1siRtbzDVOenOvzqIhH8QWZ/jSLob
	zdQ0PcHNiigfI3jfE+qGqxldNKGXiDtP3B+Kq97w9PF/8hlXfjexJc9l+FKtfbRKJb+
	FOhA5pR9EkdUyrcNQv5LsQXcr0JgAGBqz4uJKrCU=
Received: by mx.zohomail.com with SMTPS id 1786980276042660.7226623471341;
	Mon, 17 Aug 2026 08:24:36 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 17 Aug 2026 20:54:15 +0530
Subject: [PATCH mptcp-next v3 2/4] mptcp: sched: penalise a slow subflow by
 halving its cwnd
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mptcp_penalise_send_v2-v3-2-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
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
- its smoothed delivery rate (avg_pacing_rate) is below half that of the
  fastest path, keying on rate, not RTT, so a slow-but-high-throughput
  path is left alone;
- the fastest path is cwnd-limited (saturated), so shifting load off the
  slow path is worthwhile;
- the subflow is in TCP_CA_Open, so its cwnd is not already being reduced
  by loss recovery;
- its cwnd is still above MPTCP_PENALISE_MIN_CWND, so a subflow already at
  the floor is left to recover instead of being churned by a halving that
  can no longer reduce it;
- it has not been penalised in the last RTT.

The reduction halves tcp_snd_cwnd, floored at MPTCP_PENALISE_MIN_CWND, and
ssthresh if cwnd is past it. It is applied in the push path under the
subflow socket lock, which protects snd_cwnd (the scheduler runs under the
msk lock). The congestion control grows the window back, ACK-clocked; that
regrowth is the built-in probe, so no explicit MPTCP-side probing is
needed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/345
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 46a49ec75e78..63cc6cb33044 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1617,6 +1617,41 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
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
+/* Halve cwnd (and ssthresh if past it) under the subflow socket lock. */
+static void mptcp_penalise_cwnd(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 cwnd = tcp_snd_cwnd(tp);
+
+	subflow->penalise = false;
+	/* CA state may have left TCP_CA_Open since get_send flagged this */
+	if (inet_csk(ssk)->icsk_ca_state != TCP_CA_Open)
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
@@ -1626,10 +1661,11 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	unsigned long pace;
+	unsigned long pace, max_pace = 0;
 	u32 burst, wmem;
+	bool penal_cand;
 	int i, nr_active = 0;
-	struct sock *ssk;
+	struct sock *ssk, *fastest = NULL;
 	u64 linger_time;
 	long tout = 0;
 
@@ -1658,6 +1694,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
+		/* track the fastest path; slower ones get throttled below */
+		if (pace > max_pace) {
+			max_pace = pace;
+			fastest = ssk;
+		}
+
 		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
 			send_info[backup].ssk = ssk;
@@ -1685,12 +1727,24 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
+	/* Flag a slow subflow for cwnd halving, applied in the push path */
+	subflow = mptcp_subflow_ctx(ssk);
+	penal_cand = fastest && ssk != fastest &&
+		     subflow->avg_pacing_rate < max_pace / MPTCP_PENALISE_RATE_RATIO;
+	subflow->penalise = penal_cand &&
+			    tcp_snd_cwnd(tcp_sk(ssk)) > MPTCP_PENALISE_MIN_CWND &&
+			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
+			    tcp_is_cwnd_limited(fastest) &&
+			    mptcp_penalise_throttle_ok(subflow);
+
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst)
+	if (!burst) {
+		/* no window room to send; skip the penalty */
+		subflow->penalise = false;
 		return ssk;
+	}
 
-	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   (u64)READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
@@ -1747,6 +1801,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	if (mptcp_subflow_ctx(ssk)->penalise)
+		mptcp_penalise_cwnd(ssk);
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..ab9ba6699ccd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -588,6 +588,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
@@ -611,6 +612,7 @@ struct mptcp_subflow_context {
 				     */
 
 	u32	subflow_id;
+	u32	last_penalise;	    /* tcp_jiffies32 of the last cwnd penalty */
 
 	long	delegated_status;
 	unsigned long	fail_tout;

-- 
2.34.1

