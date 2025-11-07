Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052A3074AC
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504357; cv=none; b=P213nKj4DwxxV3MQ44213JBPCGFGE+Pm+NtN70+Kg1hLuiQ+O9KvgBv5JbYNiCO1sKlhdh4MNNHaxfz/nup1wqsHTbvWvcZXtGXvStrw6fkX3f+5hnBq61x1vxfudsEdesT+CeODL461+Tssm1v6xG3TsZEJhjljlqtwu4OhLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504357; c=relaxed/simple;
	bh=6cQr7iit7lVsPPWU2+7SO3rDibTEUfE3hHNdjtDHGmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=b1MohR9zV7IO7ojWyP3tT8jdWTDb2fbFiYloapEUv4D+hOiS7+V8Qf4TGZ6eyT+YtzP1A6JcdmDk0AGJpoRfZNcNzhC65CKuL4SflDvpR6PwXcdDcDk3kGBrz7BCP+fRLRCTCZWow0ippFV0bgH1rFSDZLpf+PU6O0HDl9WTZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFIyycEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFIyycEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762504354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1z6R9AvxAWYdaqeA5m2RJmxcDo4L++i7gfy8KZ8atIM=;
	b=dFIyycELMZUR1jsDhtVDB8dpmGXkh3qSjBLBkJs9NJToc5Q2yoI1VtnB4NsnL3k1CyZSr1
	ZoCOLvuVW2VNAvjRtxB62PxjpVRrISI9LVhd5G5M6dhZP1/1UFC/U1jPKZo4ROTgLDKpW1
	ldTpt102XuYIbe0o9/N9K+h/2I5ePgc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-xtnnh5eBMnK7RIOoH26PYA-1; Fri,
 07 Nov 2025 03:32:31 -0500
X-MC-Unique: xtnnh5eBMnK7RIOoH26PYA-1
X-Mimecast-MFC-AGG-ID: xtnnh5eBMnK7RIOoH26PYA_1762504350
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4832195608F;
	Fri,  7 Nov 2025 08:32:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A23761800361;
	Fri,  7 Nov 2025 08:32:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH v3 mptcp-next 6/7] mptcp: better mptcp-level RTT estimator
Date: Fri,  7 Nov 2025 09:32:10 +0100
Message-ID: <2e404a1c673c812819ac5b6f12d57d23625c1e71.1762504059.git.pabeni@redhat.com>
In-Reply-To: <cover.1762504059.git.pabeni@redhat.com>
References: <cover.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z3BMKDWcTF0MU7U43XTifZPzDSBt3IAw-66ZRCw23Bw_1762504350
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

Additionally, setting the msk rtt to the maximum among all the subflows
RTTs makes DRS constantly overshooting the rcvbuf size when a subflow has
considerable higher latency than the other(s).

Finally, during unidirectional bulk transfers with multiple active
subflows, the TCP-level RTT estimator occasionally sees considerably higher
value than the real link delay, i.e. when the packet scheduler reacts to
an incoming ack on given subflow pushing data on a different subflow.

Address the issue with a more accurate RTT estimation strategy: the
MPTCP-level RTT is set to the minimum of all the subflows, in a rcv-win
based interval, feeding data into the MPTCP-receive buffer.

Use some care to avoid updating msk and ssk level fields too often and
to avoid 'too high' samples.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - do not use explicit reset flags - do rcv win based decision instead
  - discard 0 rtt_us samples from subflows
  - discard samples on non empty rx queue
  - discard "too high" samples, see the code comments WRT the whys
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 74 ++++++++++++++++++++++--------------
 net/mptcp/protocol.h         |  7 +++-
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 0f24ec65cea6..d30d2a6a8b42 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -218,7 +218,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
 		__be32 *p32;
 
 		__entry->time = time;
-		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
+		__entry->rtt_us = msk->rcv_rtt_est.rtt_us >> 3;
 		__entry->copied = msk->rcvq_space.copied;
 		__entry->inq = mptcp_inq_hint(sk);
 		__entry->space = msk->rcvq_space.space;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 97c4f1ee25e0..3d0990c58c02 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -868,6 +868,42 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
+static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
+				 struct mptcp_subflow_context *subflow)
+{
+	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
+	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
+	u8 sr = tp->scaling_ratio;
+
+	/* MPTCP can react to incoming acks pushing data on different subflows,
+	 * causing apparent high RTT: ignore large samples; also do the update
+	 * only on RTT changes
+	 */
+	if (tp->rcv_rtt_est.seq == subflow->prev_rtt_seq ||
+	    (subflow->prev_rtt_us && (rtt_us >> 1) > subflow->prev_rtt_us))
+		return;
+
+	/* Similar to plain TCP, only consider samples with empty RX queue. */
+	if (!rtt_us || mptcp_data_avail(msk))
+		return;
+
+	/* Refresh the RTT after a full win per subflow */
+	subflow->prev_rtt_us = rtt_us;
+	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
+	if (after(subflow->map_seq, msk->rcv_rtt_est.seq)) {
+		msk->rcv_rtt_est.seq = subflow->map_seq +
+				       tp->rcv_wnd * msk->pm.extra_subflows;
+		msk->rcv_rtt_est.rtt_us = rtt_us;
+		msk->scaling_ratio = sr;
+		return;
+	}
+
+	if (rtt_us < msk->rcv_rtt_est.rtt_us)
+		msk->rcv_rtt_est.rtt_us = rtt_us;
+	if (sr < msk->scaling_ratio)
+		msk->scaling_ratio = sr;
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -881,6 +917,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	mptcp_data_lock(sk);
+	mptcp_rcv_rtt_update(msk, subflow);
 	if (!sock_owned_by_user(sk)) {
 		/* Wake-up the reader only for in-sequence data */
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
@@ -2058,6 +2095,7 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk)
 	msk->rcvspace_init = 1;
 
 	mptcp_data_lock(sk);
+	msk->rcv_rtt_est.seq = atomic64_read(&msk->rcv_wnd_sent);
 	__mptcp_sync_rcvspace(sk);
 
 	/* Paranoid check: at least one subflow pushed data to the msk. */
@@ -2076,9 +2114,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u8 scaling_ratio = U8_MAX;
-	u32 time, advmss = 1;
-	u64 rtt_us, mstamp;
+	u32 rtt_us, time;
+	u64 mstamp;
 
 	msk_owned_by_me(msk);
 
@@ -2093,29 +2130,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
+	rtt_us = READ_ONCE(msk->rcv_rtt_est.rtt_us);
+	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
@@ -2954,7 +2970,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
 	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
+	msk->rcv_rtt_est.rtt_us = U32_MAX;
+	msk->scaling_ratio = U8_MAX;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3399,7 +3416,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
+	msk->scaling_ratio = U8_MAX;
+	msk->rcv_rtt_est.rtt_us = U32_MAX;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index adc0851bad69..051f21b06d33 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -340,11 +340,14 @@ struct mptcp_sock {
 				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+	struct {
+		u32	rtt_us;		/* Minimum RTT of subflows */
+		u64	seq;		/* Refresh RTT after this seq */
+	} rcv_rtt_est;
 	struct {
 		int	space;	/* bytes copied in last measurement window */
 		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
-		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
 	bool		allow_subflows;
@@ -523,6 +526,8 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
+	u32	prev_rtt_us;
+	u32	prev_rtt_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
-- 
2.51.0

