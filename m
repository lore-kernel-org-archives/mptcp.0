Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901B3164DA
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215723; cv=none; b=l6WPt6uaUwfO90palFj/WwaCy+ppHHySr/O9S5w6/FjjK+yPQlh+wfv7BkNHAg3TmD0FlwFKelqZUbdPSRdhnKVqLIzPdlg8daX6xqKmLinmclwCKgykMNbPqGyOOhoMYc1bRMRTjoLLcAOXNdsQD4yl9UI1WsvgThh+VajEmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215723; c=relaxed/simple;
	bh=za3zfG5FzKrmR4r2PHSsVBpmQJJJNzohm2/OGmOB4nw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OckMnSEeCNlKtoPKUH49drYVw8o6yMvdH0KFAZS8JlSKwiDypLq9AlwBlgqxFwi6nvSDpy/qafTeOUOHpLTD5rVxPQ7fsxv3vMaNCC3Ldner0H+b2fUK1Cy5WZPYbUFphHs0uH6EXRqbyqt1D8TMWke0zV6NZyQKHChNvNDdB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifE8lpuJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifE8lpuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdiibhULx9nKxMch5VIhMjd7elW35fAWZ8FNHtMXvEs=;
	b=ifE8lpuJrOidfWNdvjNBF0qkm5j0QoqmZc1ds7Ir56je9n/X8gPNhlSnuMmUtpcVGNJ4b8
	EVlt0UmzC6T8AQ7ZT1CIOFtX9Z7n/rDwejcRW3m7tdXu95TYjIYDcmd8TggaTrKfVsPzQf
	oxUn2N6DJkF/P5YPw8pZAwoHtjwG7Qo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-mzuI-8_wMBKaUckyhvfMRg-1; Thu,
 18 Sep 2025 13:15:19 -0400
X-MC-Unique: mzuI-8_wMBKaUckyhvfMRg-1
X-Mimecast-MFC-AGG-ID: mzuI-8_wMBKaUckyhvfMRg_1758215718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4843319560B4
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A9A30002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 10/12] mptcp: prevernt __mptcp_move_skbs() interfering with the fastpath
Date: Thu, 18 Sep 2025 19:14:52 +0200
Message-ID: <c7c1ef249ec14f9f456d7a853a16ec05f69d89c0.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sRmS2nr5FrKPnvtgK70p0vRdSqyDK6oVebHk_k2KbEU_1758215718
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
index 07326c1e6fbae..3c514b6be4eb9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -676,13 +676,17 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
@@ -2108,32 +2112,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
 
@@ -2144,23 +2129,22 @@ static bool __mptcp_move_skbs(struct sock *sk)
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

