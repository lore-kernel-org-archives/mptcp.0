Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89833D813E
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039756; cv=none; b=pWUiCEMR2DrQtjlkaryqLkOemyMCjS9HF27sEyeo1VhTtPL2Ct7zXktEOvivCIAbhqJFLrydTeqDXLlyYzuASIRXpfyBFBjjT5OtUPoKK6tEUs67vREpz1fa3MDhTrD9OyI+US4J7AuP4w6YVVqvk41za84XRaipu+cuAQiiAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039756; c=relaxed/simple;
	bh=Ka7BcZBvKQUpj+o1vHTFNxP7HsOdaeZEGraPGv+qbkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dsFbKqTlb9OjRuxcAkbzVs+C7VZsUn4EXnyPomcimh2HwOkvtypyoMrCc8bJ3S57lEccz835jZPr/MIUCHOypBXTw7fVjVNQbMTOBjiA1HoyJZAvjcbAheE9fC1/FQNzXbHCdYeV/cTuXPiEqeh4W4aQNcEFNsmQB1EZkIt45SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=af2ftEWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af2ftEWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pJTdjrdSJxjGf0/dkpfdRyHY1/+A5QrZuNbJuSH2DU=;
	b=af2ftEWIRnpuKdk0i+w70HqzUaDA69te7JcoFoeNkvT6XYcJ/v45XPoNi/u4SX0lVstnvy
	sAwfN84UVnpyDKZKXED+IXMVIX7/Wlmst5ID7jADQOqWA5biXLlzCb3gihzP7zBwfA7UDB
	BmiAa+Qw8CG8W9JrDggBSwdHzubbBd4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-j9sm4UmlOTOJCDtw2MpiMw-1; Fri,
 24 Apr 2026 10:09:10 -0400
X-MC-Unique: j9sm4UmlOTOJCDtw2MpiMw-1
X-Mimecast-MFC-AGG-ID: j9sm4UmlOTOJCDtw2MpiMw_1777039749
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4D2F18C1072;
	Fri, 24 Apr 2026 14:08:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E28ED30078E5;
	Fri, 24 Apr 2026 14:08:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 1/9] mptcp: move checks vs rcvbuf size earlier in the RX path
Date: Fri, 24 Apr 2026 16:08:34 +0200
Message-ID: <aa979ec3f7c915f9f5ce5a8017cdfc753aaa9c6d.1777038888.git.pabeni@redhat.com>
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 62q8hcgWNiui6T2bQG7i2aOQmm0943eJY1OCm8vGtpw_1777039749
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the enforcement of the rcvbuf constraint is implemented
when moving the skbs into the msk receive or OoO queue.

Under significant memory pressure the above can cause permanent data
transfer stalls. Move the checks early on, before landing even in
the subflow queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
RFC -> v1:
 - limit vs actual buffer size
 - use CB info instead of skb->len

Note that:
 - this needs the follow-up patches to really fix the stall
 - the memory comparison is intentionally very rough, as
   the msk socket lock is not currently held where the condition is
   now enforced. This should require some refinement, shared as-is
   to avoid more latency on my side
---
 net/mptcp/options.c  | 18 ++++++++++++++++--
 net/mptcp/protocol.c | 10 ++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..14afeee8ca5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,8 +1158,16 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(const struct sock *sk, struct sk_buff *skb)
+{
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq)
+		return false;
+
+	return sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf);
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1185,6 +1193,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
+
+		if (mptcp_over_limit(subflow->conn, skb))
+			return false;
 		return true;
 	}
 
@@ -1263,6 +1274,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
+	if (mptcp_over_limit(subflow->conn, skb))
+		return false;
+
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..81a9b8077d6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,7 +739,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2197,10 +2197,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2228,9 +2224,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
 			       mem_cgroup_from_sk(sk));
 
-	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	if (list_empty(&msk->backlog_list))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.53.0

