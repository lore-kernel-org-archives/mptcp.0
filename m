Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BD2F81
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFPoO1xFHGD14yS6HK4WeNJGhPGEWRq0zOLOmpU4PuU=;
	b=cBgmz9zvlKwxh+lIAQYYx5yVW3l2xGL3FnBdQr7Kqo1C1mW1punV09V0Jl+q/GsdWjJPkP
	6mckUflYnS7BzTCYOVjRbwVIptWK9O/K2QfRU94s9TugaE0xYptcOPSnzcQaJGlaSk4LQA
	45I9kQm7jA30GBuZzgQZ8T8i6c8uhkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-f4Gtn36IPJqkDIR0aW9Nmg-1; Tue, 04 May 2021 17:42:46 -0400
X-MC-Unique: f4Gtn36IPJqkDIR0aW9Nmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435501006C80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:45 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD73C5C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 16/22] Squash-to: mptcp: validate the data checksum
Date: Tue,  4 May 2021 23:42:04 +0200
Message-Id: <7213bd0191be37de7b7fa4946fef91fa0baaa21e.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
v4 -> v5:
 - combine partial DSS csum via csum_block_add() to cope with odd
   alignment

v3 -> v4:
 - drop unrelated 'fallback' changes (geliang)
 - fix csum computation for data segment with data fin bit set
---
 net/mptcp/protocol.c |  37 +--------------
 net/mptcp/protocol.h |   7 +--
 net/mptcp/subflow.c  | 108 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 104 insertions(+), 48 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba488a36dca0..2a9327f5c14c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -528,35 +528,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
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
@@ -625,12 +596,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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
@@ -1320,7 +1285,7 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 {
 	struct mptcp_ext *mpext = mptcp_get_ext(skb);
-	__wsum csum = csum_unfold(mpext->csum);
+	__wsum csum = ~csum_unfold(mpext->csum);
 	int offset = skb->len - added;
 
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f1d9657eb6ce..39ba2efc60e9 100644
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
@@ -411,6 +410,8 @@ struct mptcp_subflow_context {
 		pm_notified : 1,    /* PM hook called for established status */
 		conn_finished : 1,
 		map_valid : 1,
+		map_csum_reqd : 1,
+		map_data_fin : 1,
 		mpc_map : 1,
 		backup : 1,
 		send_mp_prio : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8648d25190e1..2d7579ba1536 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -829,10 +829,90 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
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
+			__wsum csum;
+
+			len = min(skb->len - offset, delta);
+			csum = skb_checksum(skb, offset, len, 0);
+			subflow->map_data_csum = csum_block_add(subflow->map_data_csum, csum,
+								subflow->map_csum_len);
+
+			delta -= len;
+			subflow->map_csum_len += len;
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
+	/* note that 'map_data_len' accounts only for the carried data, does
+	 * not include the eventual seq increment due to the data fin,
+	 * while the pseudo header requires the original DSS data len,
+	 * including that
+	 */
+	header.data_seq = cpu_to_be64(subflow->map_seq);
+	header.subflow_seq = htonl(subflow->map_subflow_seq);
+	header.data_len = htons(subflow->map_data_len + subflow->map_data_fin);
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
@@ -926,9 +1006,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
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
@@ -940,20 +1021,27 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		}
 
 		/* will validate the next map after consuming the current one */
-		return MAPPING_OK;
+		goto validate_csum;
 	}
 
 	subflow->map_seq = map_seq;
 	subflow->map_subflow_seq = mpext->subflow_seq;
 	subflow->map_data_len = data_len;
 	subflow->map_valid = 1;
+	subflow->map_data_fin = mpext->data_fin;
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
@@ -963,7 +1051,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		return MAPPING_INVALID;
 
 	skb_ext_del(skb, SKB_EXT_MPTCP);
-	return MAPPING_OK;
+
+validate_csum:
+	return validate_data_csum(ssk, skb, csum_reqd);
 }
 
 static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
-- 
2.26.2

