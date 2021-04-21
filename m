Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A582F9E
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XoA5/+ON6co8BgppByYWxl/B79Mslx40RQ2lsHXDtj4=;
	b=AU9jnSheMfFfoq3ut4xWEzSgmemEFDYk0DTbsNldIwlkZhei8D6HdgQKf6P+ibveZlbnns
	yRjrMTIrGvTWXMRjQ7Mm4MALsV2Ds8QLG+6dzVNtrfu/BNeJI2ze0p7BGTjLNCQZKbpfre
	P1Suk2Lthpe+pO09MwYJ8/GqmV7Ksa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-d4v59E4iMjCu2t8HisVNyg-1; Wed, 21 Apr 2021 16:20:57 -0400
X-MC-Unique: d4v59E4iMjCu2t8HisVNyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0208030C4;
	Wed, 21 Apr 2021 20:20:56 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E61B16085A;
	Wed, 21 Apr 2021 20:20:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 16/21] Squash-to: mptcp: validate the data checksum
Date: Wed, 21 Apr 2021 22:18:05 +0200
Message-Id: <a61b61ef9ba9df2c47f91bcfd668cb33afc5dc43.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Move the RX csum validation into get_mapping_status().
If the current mapping is valid and csum is enabled traverse the
later pending skbs and compute csum incrementally till the whole
mapping has been covered. If not enough data is available in the
rx queue, return MAPPING_EMPTY - that is, no data.

Next subflow_data_ready invocation will trigger again csum computation.

When the full DSS is available, validate the csum and return to the
caller an appropriate error code, to trigger subflow reset of fallback
as required by the RFC.

Additionally:
- if the csum prevence in the DSS don't match the negotiated value
e.g. csum present, but not requested, return invalid mapping to trigger
subflow reset.
- keep some csum state, to avoid re-compute the csum on the
same data when multiple rx queue traversal are required.
- clean-up the uncompleted mapping from the receive queue on close,
to allow proper subflow disposal

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  35 ------------
 net/mptcp/protocol.h |   6 +--
 net/mptcp/subflow.c  | 124 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 107 insertions(+), 58 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5160256de731..0d8005b480ab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -520,35 +520,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
-static bool mptcp_validate_data_checksum(struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	struct csum_pseudo_header header;
-	__wsum csum;
-
-	if (__mptcp_check_fallback(msk))
-		goto out;
-
-	if (subflow->csum_len < subflow->map_data_len)
-		goto out;
-
-	header.data_seq = subflow->map_seq;
-	header.subflow_seq = subflow->map_subflow_seq;
-	header.data_len = subflow->map_data_len;
-	header.csum = subflow->map_csum;
-
-	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
-
-	if (csum_fold(csum))
-		return false;
-	subflow->data_csum = 0;
-	subflow->csum_len = 0;
-
-out:
-	return true;
-}
-
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -617,12 +588,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (tp->urg_data)
 				done = true;
 
-			if (READ_ONCE(msk->csum_enabled)) {
-				subflow->data_csum = skb_checksum(skb, offset, len,
-								  subflow->data_csum);
-				subflow->csum_len += len;
-				mptcp_validate_data_checksum(ssk);
-			}
 			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
 				moved += len;
 			seq += len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 176f175a00bd..766412e50e73 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -399,9 +399,8 @@ struct mptcp_subflow_context {
 	u32	map_subflow_seq;
 	u32	ssn_offset;
 	u32	map_data_len;
-	__wsum	data_csum;
-	u32	csum_len;
-	__sum16	map_csum;
+	__wsum	map_data_csum;
+	u32	map_csum_len;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
@@ -411,6 +410,7 @@ struct mptcp_subflow_context {
 		pm_notified : 1,    /* PM hook called for established status */
 		conn_finished : 1,
 		map_valid : 1,
+		map_csum_reqd : 1,
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 68efc81eaf2c..6a3c161ebe34 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -829,10 +829,81 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 	return true;
 }
 
+static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *skb,
+					      bool csum_reqd)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct csum_pseudo_header header;
+	u32 offset, seq, delta;
+	__wsum csum;
+	int len;
+
+	if (!csum_reqd)
+		return MAPPING_OK;
+
+	/* mapping already validated on previous traversal */
+	if (subflow->map_csum_len == subflow->map_data_len)
+		return MAPPING_OK;
+
+	/* traverse the receive queue, ensuring it contains a full
+	 * DSS mapping and accumulating the related csum.
+	 * Preserve the accoumlate csum across multiple calls, to compute
+	 * the csum only once
+	 */
+	delta = subflow->map_data_len - subflow->map_csum_len;
+	for (;;) {
+		seq = tcp_sk(ssk)->copied_seq + subflow->map_csum_len;
+		offset = seq - TCP_SKB_CB(skb)->seq;
+
+		/* if the current skb has not been accounted yet, csum its contents
+		 * up to the amount covered by the current DSS
+		 */
+		if (offset < skb->len) {
+			len = min(skb->len - offset, delta);
+			delta -= len;
+			subflow->map_csum_len += len;
+			subflow->map_data_csum = skb_checksum(skb, offset, len,
+							      subflow->map_data_csum);
+		}
+		if (delta == 0)
+			break;
+
+		if (skb_queue_is_last(&ssk->sk_receive_queue, skb)) {
+			/* if this subflow is closed, the partial mapping
+			 * will be never completed; flush the pending skbs, so
+			 * that subflow_sched_work_if_closed() can kick in
+			 */
+			if (unlikely(ssk->sk_state == TCP_CLOSE))
+				while ((skb = skb_peek(&ssk->sk_receive_queue)))
+					sk_eat_skb(ssk, skb);
+
+			/* not enough data to validate the csum */
+			return MAPPING_EMPTY;
+		}
+
+		/* the DSS mapping for next skbs will be validated later,
+		 * when a get_mapping_status call will process such skb
+		 */
+		skb = skb->next;
+	}
+
+	header.data_seq = subflow->map_seq;
+	header.subflow_seq = subflow->map_subflow_seq;
+	header.data_len = subflow->map_data_len;
+	header.csum = 0;
+
+	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
+	if (unlikely(csum_fold(csum)))
+		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
+
+	return MAPPING_OK;
+}
+
 static enum mapping_status get_mapping_status(struct sock *ssk,
 					      struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	bool csum_reqd = READ_ONCE(msk->csum_enabled);
 	struct mptcp_ext *mpext;
 	struct sk_buff *skb;
 	u16 data_len;
@@ -926,9 +997,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		/* Allow replacing only with an identical map */
 		if (subflow->map_seq == map_seq &&
 		    subflow->map_subflow_seq == mpext->subflow_seq &&
-		    subflow->map_data_len == data_len) {
+		    subflow->map_data_len == data_len &&
+		    subflow->map_csum_reqd == mpext->csum_reqd) {
 			skb_ext_del(skb, SKB_EXT_MPTCP);
-			return MAPPING_OK;
+			goto validate_csum;
 		}
 
 		/* If this skb data are fully covered by the current mapping,
@@ -940,7 +1012,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		}
 
 		/* will validate the next map after consuming the current one */
-		return MAPPING_OK;
+		goto validate_csum;
 	}
 
 	subflow->map_seq = map_seq;
@@ -948,12 +1020,18 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	subflow->map_data_len = data_len;
 	subflow->map_valid = 1;
 	subflow->mpc_map = mpext->mpc_map;
-	subflow->data_csum = 0;
-	subflow->csum_len = 0;
-	subflow->map_csum = mpext->csum;
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%u",
+	subflow->map_csum_reqd = mpext->csum_reqd;
+	subflow->map_csum_len = 0;
+	subflow->map_data_csum = csum_unfold(mpext->csum);
+
+	/* Cfr RFC 8684 Section 3.3.0 */
+	if (unlikely(subflow->map_csum_reqd != csum_reqd))
+		return MAPPING_INVALID;
+
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
-		 subflow->map_data_len, subflow->map_csum);
+		 subflow->map_data_len, subflow->map_csum_reqd,
+		 subflow->map_data_csum);
 
 validate_seq:
 	/* we revalidate valid mapping on new skb, because we must ensure
@@ -963,7 +1041,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		return MAPPING_INVALID;
 
 	skb_ext_del(skb, SKB_EXT_MPTCP);
-	return MAPPING_OK;
+
+validate_csum:
+	return validate_data_csum(ssk, skb, csum_reqd);
 }
 
 static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
@@ -1024,17 +1104,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			ssk->sk_err = EBADMSG;
 			goto fatal;
 		}
-		if (status == MAPPING_DUMMY) {
-			__mptcp_do_fallback(msk);
-			skb = skb_peek(&ssk->sk_receive_queue);
-			subflow->map_valid = 1;
-			subflow->map_seq = READ_ONCE(msk->ack_seq);
-			subflow->map_data_len = skb->len;
-			subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
-						   subflow->ssn_offset;
-			subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
-			return true;
-		}
+		if (status == MAPPING_DUMMY)
+			goto fallback;
 
 		if (status != MAPPING_OK)
 			goto no_data;
@@ -1089,6 +1160,19 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	subflow->data_avail = 0;
 	return false;
+
+fallback:
+	__mptcp_do_fallback(msk);
+	skb = skb_peek(&ssk->sk_receive_queue);
+	subflow->map_csum_reqd = 0;
+	subflow->map_valid = 1;
+	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	subflow->map_data_len = skb->len;
+	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
+				   subflow->ssn_offset;
+	subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
+	return true;
+
 }
 
 bool mptcp_subflow_data_available(struct sock *sk)
-- 
2.26.2

