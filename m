Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3562505AF
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297237; cv=none; b=rIegUxCOHmWsuuBPL1nduFjK2S5EtaCysXWe0lPeOEF5zrbZy8BXEa0CNjk+KG5rHCuXfaucWdjV5UW6kJEM0Hd3eBA5bpsG7cgNGTMIhUI4SXBA+Bakh6hk2PR78FQLql/a8Neq11/3xAm3OHS9xjfh8AZPMjrlEKyAR0AnjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297237; c=relaxed/simple;
	bh=m0GT7gE7Q6Rb6irZ5YomX4U0/rGNe8slelTVThvrDrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WcjfbN031P7CQsDSMM7ZlvR52e6m/gnYK/G7ut9YJ7Dkt7E+7VMCr33WWLz/fpvGjMCDz9lsvGZiIB0XOi0FxiZWmHHNXjCoTJE6gWMc43HczHXMEKroAFutsM+fAJIpnfp6RCqU8sRGpRnh7VtfmLhDv8G4GBzMqJBS+TtkqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czY9c4wa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czY9c4wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAgSptIs6u3HNzfo35xURYw/mO0S9ufu/jIMp4vzgUs=;
	b=czY9c4waBTE3n9mZDmlaNSHY8+aExssLU7Xhpv8MyzNYXTIzsSMgWRSEpeqYTs7fE+o0gi
	LIDP9xEBGb+Vc6yjUI16Jp/w3AxZdS5jrEDmc5PYQ/8mYgTPuCx6L5wZio1ucONIEMio9g
	xUKn+ssJn5Y5ModYShNnkL1O1fGflW4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-Wm8dNdnJPaeVSZ2t1hi-4g-1; Fri,
 19 Sep 2025 11:53:53 -0400
X-MC-Unique: Wm8dNdnJPaeVSZ2t1hi-4g-1
X-Mimecast-MFC-AGG-ID: Wm8dNdnJPaeVSZ2t1hi-4g_1758297233
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0854419560AE
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C35918004D8
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 11/12] mptcp: prevernt __mptcp_move_skbs() interfering with the fastpath
Date: Fri, 19 Sep 2025 17:53:25 +0200
Message-ID: <3ee365d367054da93f2532a1727dde3224aa147f.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pWb94lrhW3tiksgFQkc_wwT3HrKGXU3yOjC8Qlds-E4_1758297233
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

skbs will be left waiting in the subflow only in exceptional cases,
we want to avoid messing with the fast path by unintentionally
processing in __mptcp_move_skbs() packets landed into the subflows
after the last check.

Use a separate flag to mark delayed skbs and only process subflow
with such flag set. Also add new mibs to track the exceptional events.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - rebased
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  4 ++++
 net/mptcp/protocol.c | 40 ++++++++++++----------------------------
 net/mptcp/protocol.h |  1 +
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 6003e47c770a7..ac5ccf81159de 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
+	SNMP_MIB_ITEM("RcvDelayed", MPTCP_MIB_RCVDELAYED),
+	SNMP_MIB_ITEM("DelayedProcess", MPTCP_MIB_DELAYED_PROCESS),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 309bac6fea325..f6d0eaea463e5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,10 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
+	MPTCP_MIB_RCVDELAYED,		/* Data move from subflow is delayed due to msk
+					 * receive buffer full
+					 */
+	MPTCP_MIB_DELAYED_PROCESS,	/* Delayed data moved in slowpath */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 201e6ac5fe631..2a025c0c4ca0c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -681,13 +681,17 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 	tp = tcp_sk(ssk);
 	do {
 		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk->sk_backlog.len;
+		bool over_limit = mem > READ_ONCE(sk->sk_rcvbuf);
 		u32 map_remaining, offset;
 		u32 seq = tp->copied_seq;
 		struct sk_buff *skb;
 		bool fin;
 
-		if (mem > READ_ONCE(sk->sk_rcvbuf))
+		WRITE_ONCE(subflow->data_delayed, over_limit);
+		if (subflow->data_delayed) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVDELAYED);
 			break;
+		}
 
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
@@ -2113,32 +2117,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
-static struct mptcp_subflow_context *
-__mptcp_first_ready_from(struct mptcp_sock *msk,
-			 struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_subflow_context *start_subflow = subflow;
-
-	while (!READ_ONCE(subflow->data_avail)) {
-		subflow = mptcp_next_subflow(msk, subflow);
-		if (subflow == start_subflow)
-			return NULL;
-	}
-	return subflow;
-}
-
 static bool __mptcp_move_skbs(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool ret = false;
 
-	if (list_empty(&msk->conn_list))
-		return false;
-
-	subflow = list_first_entry(&msk->conn_list,
-				   struct mptcp_subflow_context, node);
-	for (;;) {
+	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk;
 		bool slowpath;
 
@@ -2149,23 +2134,22 @@ static bool __mptcp_move_skbs(struct sock *sk)
 		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
 			break;
 
-		subflow = __mptcp_first_ready_from(msk, subflow);
-		if (!subflow)
-			break;
+		if (!subflow->data_delayed)
+			continue;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		slowpath = lock_sock_fast(ssk);
-		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true) || ret;
+		ret |= __mptcp_move_skbs_from_subflow(msk, ssk, true);
 		if (unlikely(ssk->sk_err))
 			__mptcp_error_report(sk);
 		unlock_sock_fast(ssk, slowpath);
-
-		subflow = mptcp_next_subflow(msk, subflow);
 	}
 
 	__mptcp_ofo_queue(msk);
-	if (ret)
+	if (ret) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DELAYED_PROCESS);
 		mptcp_check_data_fin((struct sock *)msk);
+	}
 	return ret;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7bfd4e0d21a8a..a295ce11774ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -560,6 +560,7 @@ struct mptcp_subflow_context {
 	u8	reset_transient:1;
 	u8	reset_reason:4;
 	u8	stale_count;
+	bool	data_delayed;
 
 	u32	subflow_id;
 
-- 
2.51.0

