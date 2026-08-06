Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F903B5E19
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027649; cv=none; b=bk05P4v9Mj5mWWVMl5iYa22NpsLMN9SSeK5S/20vX1vKGIJsWfVk0wEKVmNxDbXb3770jiWDq/70iR/2tOMFGQKBo6o8xlexOYDMx1ShjUmOKBcANEFAkqsS1e1jInYEWRY9gOkFUOTh5HX1rU0UzV6WeTxYwk2ceLRSieiB7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027649; c=relaxed/simple;
	bh=B/HVbNL9NcHOQTNgV3hUCjGBokijakHwFi6IGOdxYhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XhWhN/LcpE6GLI8pmlritF2NYUQ3ysXK3YvKvaxqxIdB8jxyjmXyHW4UO8nhkMS12TufPRXXALO9HZfU69mkp78aPkZoeOptK8kyKdPjTgQH+LmnBsFiO1XC59Iha7tMHGMdllG82s0x0gNvnO/+YYil3N2HzFYUxysQrjqgj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfQWXrPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfQWXrPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZwkhc/Nor0MJJ3V42q1hBXdkmy1mkuGdcG9Uc73Uu4=;
	b=hfQWXrPI1MSmQy3+1cgO+ri37IWIpbPYbv+DxiMrXgCMAULWoEsaun8BfO7dgvWkO0dYJl
	hfTdBN8XJ0ID9XEL3kw3cCqLfYsOgXpSDjM5QeUfMfuoPE9uu7/VtYDavAsuze0p4zfVsE
	Us3OaDX6eQ3kt2mbWYE7T+0J+UqUBoU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-Kx5MaXD3NWal_5gxmgK0Uw-1; Thu,
 06 Aug 2026 10:47:25 -0400
X-MC-Unique: Kx5MaXD3NWal_5gxmgK0Uw-1
X-Mimecast-MFC-AGG-ID: Kx5MaXD3NWal_5gxmgK0Uw_1786027644
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D6A01800637
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FFAA1956094
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/7] mptcp: move the stale logic out of retrans scheduler
Date: Thu,  6 Aug 2026 16:45:23 +0200
Message-ID: <0a81a4bf60008faefdd1688012b8fcebc291a4d6.1786026372.git.pabeni@redhat.com>
In-Reply-To: <cover.1786026372.git.pabeni@redhat.com>
References: <cover.1786026372.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: feFBKc2pwTqL61KTimUGFC56j3jwkwoEVXmGYU_nW7k_1786027644
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This allow separating the stale logic invocation and the retrans
scheduler, and will simplify the next patch.

It's also a cleaner design as the retrans scheduler has currently
too many side effects. As a possible downside, the retrans work will
now traverse the subflows list additional times; that does not matter
much, as this is slowpath.

While at it, pick more accurate names for the involved helpers and
explicitly note that the per subflow stale data is under msk socket
lock protection.

The scheduler and the stale logic may observe different subflow
statues, as no subflow lock is acquired. This is intentional and not
harmful, worst case leading to slower retransmissions.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - fix stale lockless access

Note: BPF scheduler should be rebase to use the renamed helper
---
 net/mptcp/pm.c       | 42 +++++++++++++++++++++++++++---------------
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h | 11 +++++++----
 3 files changed, 36 insertions(+), 21 deletions(-)

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
index 0042112f118a..44fd0ecd626d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -581,12 +581,11 @@ struct mptcp_subflow_context {
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		closing : 1,	    /* must not pass rx data to msk anymore */
-		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
@@ -605,7 +604,11 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
-	u8	stale_count;
+	u8	stale_count;	    /* Protected by the msk socket lock */
+	u8	stale;	    	    /* Protected by the msk socket lock,
+				     * if set the subflow is unable to snd/rcv
+				     * data, the schedule should skip it
+				     */
 
 	u32	subflow_id;
 
@@ -1104,7 +1107,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
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

