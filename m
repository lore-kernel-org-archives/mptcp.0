Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A7481FA1
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946649; cv=none; b=lUnlqqwuxprz479nqd+ZeuDAVsqjLCZU5L8Y5HM++6P4SrqAnaC/l/BKgWrzqBRrevbwl6iaFR2DF49Dw4WpdMqyNrFTNoTU4ypCxlkcYKFnUogw+rPDVDg4G3eH+CSk4PrIS6o9bOErXyJqz5KBOTT2+i/LhuDVmEZ4AOcEXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946649; c=relaxed/simple;
	bh=LsdMkO7JJkDhFiipcEb75Fr2Gp6rQWTARKjQk7VEObQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DeTkhFvA5yRZ5gvYo/lH/mE8rsdV3Eta8zhHEoAmkKcEaJ8EvH6OliTHLzIDrnaXPHYMt4Cs/anL4R6UQR0w/vJopI82zMvTfdE5x6/tUnoUpKz25+3SZhC42IqtlJNhmoBhwIZ/G0F/pnTg3GgQJkNFzf8O2N/DK4CGJWNZ4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMoIPrkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMoIPrkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRAVTQ20TrbG2jPGiWbAXd34Gwa6o8Lv9Rhl+NOBZQs=;
	b=JMoIPrkZAiSDq0Dbl5xcSzOdsMiTayRJx/D6iOKqvdvW4OJMktEEM9TeO5nuWL0LxKFGKP
	lucUli7zeu4RmcePggc6cK65ThNGTdrV99/SwRLcIFUkkxkDSr+tX3rZWYSM6Y/kGDfrRs
	3d3ra83tYs481JIkb1NPL4fUEOSlfdk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-2jm85X22OACeF8V-M82-vQ-1; Wed,
 05 Aug 2026 12:17:24 -0400
X-MC-Unique: 2jm85X22OACeF8V-M82-vQ-1
X-Mimecast-MFC-AGG-ID: 2jm85X22OACeF8V-M82-vQ_1785946644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 235451956095
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56A8A1800347
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/7] mptcp: move the stale logic out of retrans scheduler
Date: Wed,  5 Aug 2026 18:17:09 +0200
Message-ID: <57485667802eaecb541c09a3c0964b8528578058.1785943854.git.pabeni@redhat.com>
In-Reply-To: <cover.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1oWjV0IVjeK3T8yANJgtM_kXnx95BrcE8HX0oh7TNy8_1785946644
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This allow separating the stale logic invocation and the retrans
scheduler, and will simplify the next patch.

It's also a cleaner design as the retrans scheduler has currently
too many side effects. As a possible downside, the retrans work will
now traverse the subflows list additional times; that does not matter
much, as this is slowpath.

While at it, pick more accurate names for the involved helpers

Also note that the scheduler and the stale logic may observe different
subflow statues, as no lock is acquired. This is intentional and not
harmful, worst case leading to slower retransmissions.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       | 42 +++++++++++++++++++++++++++---------------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  2 +-
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5e499ec1c50a..9ce50e8a149d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1061,7 +1061,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return msk->pm.ops->get_priority(msk, &skc_local);
 }
 
-static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+static void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
@@ -1098,22 +1098,34 @@ static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct soc
 	}
 }
 
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	u32 rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
-
-	/* keep track of rtx periods with no progress */
-	if (!subflow->stale_count) {
-		subflow->stale_rcv_tstamp = rcv_tstamp;
-		subflow->stale_count++;
-	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
-		if (subflow->stale_count < U8_MAX)
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		u32 rcv_tstamp;
+
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		/* No data outstanding at TCP level? not stale */
+		if (tcp_rtx_and_write_queues_empty(ssk))
+			continue;
+
+		/* keep track of rtx periods with no progress */
+		rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
+		if (!subflow->stale_count) {
+			subflow->stale_rcv_tstamp = rcv_tstamp;
 			subflow->stale_count++;
-		mptcp_pm_subflows_chk_stale(msk, ssk);
-	} else {
-		subflow->stale_count = 0;
-		mptcp_subflow_set_active(subflow);
+		} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
+			if (subflow->stale_count < U8_MAX)
+				subflow->stale_count++;
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+		} else {
+			subflow->stale_count = 0;
+			mptcp_subflow_set_active(subflow);
+		}
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a21b10a8c5d3..88167edc6598 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2469,7 +2469,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
 			continue;
 		}
@@ -2859,9 +2858,10 @@ static void __mptcp_retrans(struct sock *sk)
 	struct mptcp_data_frag *dfrag;
 	int err, len;
 
+	mptcp_pm_chk_stale(msk);
+
 	mptcp_clean_una_wakeup(sk);
 
-	/* first check ssk: need to kick "stale" logic */
 	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0042112f118a..c5a9c3d3f223 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1104,7 +1104,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- 
2.55.0

