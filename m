Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016592FF64F
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628014; cv=none; b=ogVN/EOfHyf0HFN3k5baBU2auydCOakzU4E09jibTmMNA76HRVDFKH6bIg9r3IM2fX1ScIjRwyo9ru3bv20k013cPaRPqkE69iOgl4NtnPr4ojfY3K8GiL3pmBCPPEI21eTe/a1V8Oj2Ag8mbqvjhhKk216iYfwtwFoa73ik1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628014; c=relaxed/simple;
	bh=VVquttA7yGyhLBbPyWHq/vc/VpHwX7EnHgT8rh/Uiec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Er5iTmWm9bG3xE7fDy3Ed1ZZKMBLV0OcA/owG0CSKBmgg4rfQ1olye1+QiazYpe7TzYSk1k1VqrxJsdcVechLObNNYEVqIsT123PMmWcrgxdBLqtbZUW8YQh6/FmZ2vbz6QofOPsfcduXp2V2mInzzkifTU3utyHnpNvagYggBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmHjAbHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmHjAbHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763628011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMo725Nsvwr6yCfluXwFUFy3GgJcnUBlQE2OUpfBoXM=;
	b=SmHjAbHQzYNzupnSVKKB02wX1AUi3LJxoXF3KSk94oiwgC/NSiDUIi823xIpF45aJ3Z4B/
	eevoficWEPAbyVUgjwR0S4O1UYY9/ksc2W3CIGjqtXw+zwXs0XMOsPKpkomWtTqtgHJGdi
	dEJFH5DqUQZnGHd04XEMfGk9/aTpZjo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-DJaiaEGVMKCK31u9SrFQ3A-1; Thu,
 20 Nov 2025 03:40:07 -0500
X-MC-Unique: DJaiaEGVMKCK31u9SrFQ3A-1
X-Mimecast-MFC-AGG-ID: DJaiaEGVMKCK31u9SrFQ3A_1763628006
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 681A119540DD;
	Thu, 20 Nov 2025 08:40:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34ABA3001E83;
	Thu, 20 Nov 2025 08:40:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH v7 mptcp-next 5/6] mptcp: better mptcp-level RTT estimator
Date: Thu, 20 Nov 2025 09:39:49 +0100
Message-ID: <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
In-Reply-To: <cover.1763625391.git.pabeni@redhat.com>
References: <cover.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OzbIsyVOTj6eA48Jsdq7Fd58scFVb3uD8rM9-InRC34_1763628006
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current MPTCP-level RTT estimator has several issues. On high speed
links, the MPTCP-level receive buffer auto-tuning happens with a frequency
well above the TCP-level's one. That in turn can cause excessive/unneeded
receive buffer increase.

On such links, the initial rtt_us value is considerably higher
than the actual delay, and the current mptcp_rcv_space_adjust() updates
msk->rcvq_space.rtt_us with a period equal to the such field previous
value. If the initial rtt_us is 40ms, its first update will happen after
40ms, even if the subflows see actual RTT orders of magnitude lower.

Additionally:
- setting the msk rtt to the maximum among all the subflows RTTs makes DRS
constantly overshooting the rcvbuf size when a subflow has considerable
higher latency than the other(s).

- during unidirectional bulk transfers with multiple active subflows, the
TCP-level RTT estimator occasionally sees considerably higher value than
the real link delay, i.e. when the packet scheduler reacts to an incoming
ack on given subflow pushing data on a different subflow.

- currently inactive but still open subflows (i.e. switched to backup mode)
are always considered when computing the msk-level rtt.

Address the all the issues above with a more accurate RTT estimation
strategy: the MPTCP-level RTT is set to the minimum of all the subflows
actually feeding data into the MPTCP receive buffer, using a small sliding
window.

While at it, also use EWMA to compute the msk-level scaling_ratio, to that
mptcp can avoid traversing the subflow list is mptcp_rcv_space_adjust().

Use some care to avoid updating msk and ssk level fields too often.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - avoid filtering out too high value, use sliding window instead

v3 -> v4:
  - really refresh msk rtt after a full win per subflow (off-by-one in prev
    revision)
  - sync mptcp_rcv_space_adjust() comment with the new code

v1 -> v2:
  - do not use explicit reset flags - do rcv win based decision instead
  - discard 0 rtt_us samples from subflows
  - discard samples on non empty rx queue
  - discard "too high" samples, see the code comments WRT the whys
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 63 ++++++++++++++++++++----------------
 net/mptcp/protocol.h         | 38 +++++++++++++++++++++-
 3 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 269d949b2025..04521acba483 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -219,7 +219,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__be32 *p32;
 
 		__entry->time = time;
-		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
+		__entry->rtt_us = mptcp_rtt_us_est(msk) >> 3;
 		__entry->copied = msk->rcvq_space.copied;
 		__entry->inq = mptcp_inq_hint(sk);
 		__entry->space = msk->rcvq_space.space;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 40c90d841237..5dde016a108d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -880,6 +880,32 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
+static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
+				 struct mptcp_subflow_context *subflow)
+{
+	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
+	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
+	int id;
+
+	/* Update once per subflow per rcvwnd to avoid touching the msk
+	 * too often.
+	 */
+	if (!rtt_us || tp->rcv_rtt_est.seq == subflow->prev_rtt_seq)
+		return;
+
+	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
+
+	/* Pairs with READ_ONCE() in mptcp_rtt_us_est(). */
+	id = msk->rcv_rtt_est.next_sample;
+	WRITE_ONCE(msk->rcv_rtt_est.samples[id], rtt_us);
+	if (++msk->rcv_rtt_est.next_sample == MPTCP_RTT_SAMPLES)
+		msk->rcv_rtt_est.next_sample = 0;
+
+	/* EWMA among the incoming subflows */
+	msk->scaling_ratio = ((msk->scaling_ratio << 3) - msk->scaling_ratio +
+			     tp->scaling_ratio) >> 3;
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -893,6 +919,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
+	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
@@ -2067,7 +2094,6 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 
 	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
 
 	/* initial rcv_space offering made to peer */
 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
@@ -2078,15 +2104,15 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
- * Only difference: Use highest rtt estimate of the subflows in use.
+ * Only difference: Use lowest rtt estimate of the subflows in use, see
+ * mptcp_rcv_rtt_update() and mptcp_rtt_us_est().
  */
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u8 scaling_ratio = U8_MAX;
-	u32 time, advmss = 1;
-	u64 rtt_us, mstamp;
+	u32 time, rtt_us;
+	u64 mstamp;
 
 	msk_owned_by_me(msk);
 
@@ -2101,29 +2127,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	mstamp = mptcp_stamp();
 	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
-	rtt_us = msk->rcvq_space.rtt_us;
-	if (rtt_us && time < (rtt_us >> 3))
-		return;
-
-	rtt_us = 0;
-	mptcp_for_each_subflow(msk, subflow) {
-		const struct tcp_sock *tp;
-		u64 sf_rtt_us;
-		u32 sf_advmss;
-
-		tp = tcp_sk(mptcp_subflow_tcp_sock(subflow));
-
-		sf_rtt_us = READ_ONCE(tp->rcv_rtt_est.rtt_us);
-		sf_advmss = READ_ONCE(tp->advmss);
-
-		rtt_us = max(sf_rtt_us, rtt_us);
-		advmss = max(sf_advmss, advmss);
-		scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
-	}
-
-	msk->rcvq_space.rtt_us = rtt_us;
-	msk->scaling_ratio = scaling_ratio;
-	if (time < (rtt_us >> 3) || rtt_us == 0)
+	rtt_us = mptcp_rtt_us_est(msk);
+	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
@@ -2969,6 +2974,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	mptcp_init_rtt_est(msk);
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3412,6 +3418,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ee0dbd6dbacf..b392d7855928 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,6 +269,13 @@ struct mptcp_data_frag {
 	struct page *page;
 };
 
+/* Arbitrary compromise between as low as possible to react timely to subflow
+ * close event and as big as possible to avoid being fouled by biased large
+ * samples due to peer sending data on a different subflow WRT to the incoming
+ * ack.
+ */
+#define MPTCP_RTT_SAMPLES	5
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -340,11 +347,17 @@ struct mptcp_sock {
 				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+
+	/* Most recent rtt_us observed by in use incoming subflows. */
+	struct {
+		u32	samples[MPTCP_RTT_SAMPLES];
+		u32	next_sample;
+	} rcv_rtt_est;
+
 	struct {
 		int	space;	/* bytes copied in last measurement window */
 		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
-		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
 	bool		allow_subflows;
@@ -422,6 +435,27 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return msk->first_pending;
 }
 
+static inline void mptcp_init_rtt_est(struct mptcp_sock *msk)
+{
+	int i;
+
+	for (i = 0; i < MPTCP_RTT_SAMPLES; ++i)
+		msk->rcv_rtt_est.samples[i] = U32_MAX;
+	msk->rcv_rtt_est.next_sample = 0;
+	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
+}
+
+static inline u32 mptcp_rtt_us_est(const struct mptcp_sock *msk)
+{
+	u32 rtt_us = msk->rcv_rtt_est.samples[0];
+	int i;
+
+	/* Lockless access of collected samples. */
+	for (i = 1; i < MPTCP_RTT_SAMPLES; ++i)
+		rtt_us = min(rtt_us, READ_ONCE(msk->rcv_rtt_est.samples[i]));
+	return rtt_us;
+}
+
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -523,6 +557,8 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
+	u32	prev_rtt_us;
+	u32	prev_rtt_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
-- 
2.51.1

