Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531193ECBC3
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319540; cv=none; b=CvECowAxcYq8WjuA1/S3GI94SjqSgFDDcSA/fS/Ok5/LZ7HaF3rGDdr7rzQYF9CqG3Z09sGtNPAe/2FYKLLzdHdD/7KkLFibUkW/HbLtQHw6jGXShqGDdzqhg3Q2zffkEQJaYveiWjs8gJ4QC1YdcitT+3FbGc0Ui21c2SGKUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319540; c=relaxed/simple;
	bh=r2B2Znwq+STF7OG/akDr8kWwjPMsKQXPADrKxvHe34Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=m6275MqKa9UxCXRwbJfAi1KoyakTUXw67zqkLaxtuR4e5if5m78E/Z6VK8VfnC+0wyvQsdYAgZ7VcUrvqErPqpx8J8lVoYCUGVRFsRaKg3ZmYNj+q4CqqRRt89bhFkngDPY4Ub+4/p5xfTcOHyfTXkMZzatfFxvbVSE/WjcHI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tk3cW/gx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk3cW/gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpXzrkXaoWC2HqPMmw4WYl/kp+u1QDiWtdMkKwHddgI=;
	b=Tk3cW/gxM/rEAVOcew5+2RMIfCbJOKS6GVKnk5vfGfGj3XWULtzvMQB+YXJQCCo3XeKN3m
	NscMYdjWuNqS+RrXPb6nxQSg/qIvSb6ruWdxGUR9ps6+0+inB4VOwtGkmkjEymqi3y/Tyq
	cVJWhMOU1jFt3wW4JPPax2J26fF4ElM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-N82GldSwM8OlfocloNAVGw-1; Mon,
 27 Apr 2026 15:52:16 -0400
X-MC-Unique: N82GldSwM8OlfocloNAVGw-1
X-Mimecast-MFC-AGG-ID: N82GldSwM8OlfocloNAVGw_1777319535
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49C861956088
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80943300757C
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 01/10] mptcp: move checks vs rcvbuf size earlier in the RX path
Date: Mon, 27 Apr 2026 21:51:59 +0200
Message-ID: <dae3d1870f0295a5b84cfe0dc2d4053bac739002.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BrdbCmaegLylyMcv_IbXmOqwVu0Ep6R847xozuCXQ34_1777319535
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
v1 -> v2:
 - deal correctly with tcp fin and zero win probe

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
 net/mptcp/options.c  | 25 +++++++++++++++++++++++--
 net/mptcp/protocol.c | 10 ++--------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..ad4bb6fd86e1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,8 +1158,23 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
+			     const struct sk_buff *skb)
+{
+	if (likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)))
+		return false;
+
+	/* Avoid silently dropping pure acks, fin or zero win probes. */
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
+		return false;
+
+	return true;
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1185,6 +1200,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
+
+		if (mptcp_over_limit(subflow->conn, sk, skb))
+			return false;
 		return true;
 	}
 
@@ -1263,6 +1281,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
+	if (mptcp_over_limit(subflow->conn, sk, skb))
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

