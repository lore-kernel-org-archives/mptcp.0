Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90B334697
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931769; cv=none; b=fpeDDuRFs1sILOSLbFsR1qo10RV2yZmrxGbwpKbB3aTaU7FYkHMG36yuhyUoQq0a4F/fO7kOo2FywIbe20NOaPHD6S2UqKM3XFZuFbwc8sQ7nNF6E2/pA/VdXtf7JeflN2NKz4UcURwOJYRNd/htczRyE3/iElQqK3XZRMYne8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931769; c=relaxed/simple;
	bh=8PkyaWkKkwp1oyiF3ZSj54+JMOqqM3MsuLnGsHf7Bds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gDMBCv6WCNA0U7j+6zwOkJ6Un2J8kEXNm0lOot9j+h/9llpq8YqXDR+SbcZOo3X7il9Q82q+vPu3IJIa5+Fy8y2lE5fIKpZbFMqjlADtmbbGFtVDfE+PGes9qs77D61EBZ3DcoFfv1bzSS0n1Z8LJYJoXL3ACdRISteeGydbMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIHiJ2EC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIHiJ2EC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761931766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKDfIZptn2R0xHEKJhCM4jrdvU3lAz4m9FC7OrPVAl4=;
	b=PIHiJ2ECQI+zfkYlZN/zsUWQPsSr/TJFKCnucO61BmNwdh7HcYUBvdpI2sUhmH2i3Or3Rc
	OaqfT/lqoquIXnzkE83Ync4My879z3upcwtBSTPlvhkA6UmqqLPxcISLXtXQQlL7YMbTL4
	3TaNa62pkPKzfsmHQbn8lxDjwm2eGkY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-ciOxZZg7MgKk4K-DgwR48w-1; Fri,
 31 Oct 2025 13:29:24 -0400
X-MC-Unique: ciOxZZg7MgKk4K-DgwR48w-1
X-Mimecast-MFC-AGG-ID: ciOxZZg7MgKk4K-DgwR48w_1761931764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 221FA195606E
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24DCA30001A1
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/4] mptcp: better mptcp-level rtt estimator
Date: Fri, 31 Oct 2025 18:29:09 +0100
Message-ID: <d061c491e4e6729509e2c8762534ad45cf7c6b87.1761931390.git.pabeni@redhat.com>
In-Reply-To: <cover.1761931390.git.pabeni@redhat.com>
References: <cover.1761931390.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BobTCUSTRZDXSFZbOnJx0bdryMAMoQz0rPLSP3Ip65k_1761931764
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

On high speed links, the MPTCP-level receive buffer auto-tuning
happens with a frequency well above the TCP-level's one. That in
turn can cause excessive/unneeded receive buffer increase.

On such links, the initial rtt_us value is considerably higher
than the actual delay, but the current mptcp_rcv_space_adjust() logic
prevents msk->rcvq_space.rtt_us from decreasing.

Address the issue with a more accurate RTT estimation strategy: the
MPTCP-level RTT is set to the minimum of all the subflow feeding data into
the MPTCP-receive buffer.

Some complexity is due to try to avoid frequent updates of MPTCP-level
fields and to allow subflow feeding data via the backlog to still perform
the update under the msk socket lock.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 89 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  8 +++-
 2 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e17abab7bab6..4fc1519baab6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -865,10 +865,52 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
+static void mptcp_rcv_rtt_update(struct mptcp_sock *msk, u32 rtt_us, u8 sr)
+{
+	/* Similar to plain TCP, only consider samples with empty RX queue */
+	if (mptcp_data_avail(msk))
+		return;
+
+	if (msk->rcv_rtt_est.reset) {
+		msk->rcv_rtt_est.rtt_us = rtt_us;
+		msk->rcv_rtt_est.reset = false;
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
+static void mptcp_rcv_rtt_update_from_backlog(struct mptcp_sock *msk)
+{
+	mptcp_rcv_rtt_update(msk, msk->rcv_rtt_est.bl_rtt_us,
+			     msk->rcv_rtt_est.bl_scaling_ratio);
+
+	if (READ_ONCE(msk->rcv_rtt_est.reset_bl)) {
+		msk->rcv_rtt_est.bl_rtt_us = U32_MAX;
+		msk->rcv_rtt_est.bl_scaling_ratio = U8_MAX;
+		msk->rcv_rtt_est.reset_bl = false;
+	}
+}
+
+static void mptcp_backlog_rcv_rtt_update(struct mptcp_sock *msk, u32 rtt_us,
+					 u8 sr)
+{
+	if (rtt_us < msk->rcv_rtt_est.bl_rtt_us)
+		msk->rcv_rtt_est.bl_rtt_us = rtt_us;
+	if (sr < msk->rcv_rtt_est.bl_scaling_ratio)
+		msk->rcv_rtt_est.bl_scaling_ratio = sr;
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	u32 rtt_us = tcp_sk(ssk)->rcv_rtt_est.rtt_us;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u8 sr = tcp_sk(ssk)->scaling_ratio;
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at subflow destruction time, but we must avoid enqueuing
@@ -879,10 +921,12 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 	mptcp_data_lock(sk);
 	if (!sock_owned_by_user(sk)) {
+		mptcp_rcv_rtt_update(msk, rtt_us, sr);
 		/* Wake-up the reader only for in-sequence data */
 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 			sk->sk_data_ready(sk);
 	} else {
+		mptcp_backlog_rcv_rtt_update(msk, rtt_us, sr);
 		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
 	mptcp_data_unlock(sk);
@@ -2053,7 +2097,6 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 
 	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
 
 	/* initial rcv_space offering made to peer */
 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
@@ -2070,16 +2113,15 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u8 scaling_ratio = U8_MAX;
-	u32 time, advmss = 1;
-	u64 rtt_us, mstamp;
+	u32 rtt_us, time;
+	u64 mstamp;
 
 	msk_owned_by_me(msk);
 
 	if (copied <= 0)
 		return;
 
-	if (!msk->rcvspace_init)
+	if (unlikely(!msk->rcvspace_init))
 		mptcp_rcv_space_init(msk, msk->first);
 
 	msk->rcvq_space.copied += copied;
@@ -2087,29 +2129,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
+	rtt_us = msk->rcv_rtt_est.rtt_us;
+	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
@@ -2137,6 +2158,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 new_measure:
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.time = mstamp;
+	msk->rcv_rtt_est.reset = true;
+	WRITE_ONCE(msk->rcv_rtt_est.reset_bl, true);
 }
 
 static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
@@ -2198,6 +2221,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	u32 moved;
 
 	mptcp_data_lock(sk);
+	mptcp_rcv_rtt_update_from_backlog(mptcp_sk(sk));
 	while (mptcp_can_spool_backlog(sk, &skbs)) {
 		mptcp_data_unlock(sk);
 		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
@@ -2933,6 +2957,10 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	msk->rcv_rtt_est.bl_rtt_us = U32_MAX;
+	msk->rcv_rtt_est.rtt_us = U32_MAX;
+	msk->rcv_rtt_est.bl_scaling_ratio = U8_MAX;
+	msk->scaling_ratio = U8_MAX;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3375,6 +3403,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->scaling_ratio = U8_MAX;
+	msk->rcv_rtt_est.rtt_us = U32_MAX;
+	msk->rcv_rtt_est.bl_rtt_us = U32_MAX;
+	msk->rcv_rtt_est.bl_scaling_ratio = U8_MAX;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
@@ -3560,6 +3592,7 @@ static void mptcp_release_cb(struct sock *sk)
 
 		INIT_LIST_HEAD(&join_list);
 		list_splice_init(&msk->join_list, &join_list);
+		mptcp_rcv_rtt_update_from_backlog(msk);
 
 		/* the following actions acquire the subflow socket lock
 		 *
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1f67d8468dfb..d38a455f8f5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -340,11 +340,17 @@ struct mptcp_sock {
 				 */
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+	struct {
+		u32	rtt_us;		/* Minimum rtt of subflows */
+		u32	bl_rtt_us;	/* Min rtt if subflows using the bl */
+		u8	bl_scaling_ratio;
+		bool	reset;
+		bool	reset_bl;	/* Protected by data lock */
+	} rcv_rtt_est;
 	struct {
 		int	space;	/* bytes copied in last measurement window */
 		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
-		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
 	bool		allow_subflows;
-- 
2.51.0

