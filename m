Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954423E0259
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909225; cv=none; b=ntaSneWkm3R/lzyxD7xEDAn/gLGndb8rLPz++c+xSR+7pauzfh71KRtV9tbmymfsNse9dbQTFkOoq2tyZWoo1sxf/Grl5JRhPCoFLbLC/CgV5WUAB7EAL5c2rfXitj9YqI1LVb5Px/OFojIDqz8UjIJd6/mrepawhvLbisKjoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909225; c=relaxed/simple;
	bh=g/mUn5zAOuJ9ldN5dirjcNuEC4iFBKaoKhi1xjDTCXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=igMzIzOLFl+vb/6H+zycI4AYKIvpnr1c2kPSX/APFUZR84CQfWyrevB2a8gpq6DwdUGY5kVQ8kkBzDA6tY53UyvSt5A+SW2c4xVWOsY08litZNSg2RvAnz17OI7Qsn4Bnh0x+7byVM1zYZbIgAOlflIpZi7sKLOIOvl3NrtXFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlBn+H+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlBn+H+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZnd4Fm9Nwl7g0ea2QBmTvWZUJTgkCuOKLSv+cATPJo=;
	b=PlBn+H+4F6CmMHM573kI+G4UqvFcZt4ANBghjYC5dpcd8Tz73pRhuw05SR+7iyG4izIV53
	0//qKQCn+F5q6z6yiB0aCQDJVdlKAUToD7o+/dsud82Ir0u7vG+HnQCJ2/xMpPKW/0IvyF
	MTOP9RHwJ8wRoF3HN/Y4JY/2ej6ZH50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-k3-1wpz5NTOrdhJHnd3wMA-1; Mon,
 04 May 2026 11:40:19 -0400
X-MC-Unique: k3-1wpz5NTOrdhJHnd3wMA-1
X-Mimecast-MFC-AGG-ID: k3-1wpz5NTOrdhJHnd3wMA_1777909218
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 038511800378;
	Mon,  4 May 2026 15:40:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD7F19560B7;
	Mon,  4 May 2026 15:40:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 01/10] mptcp: move checks vs rcvbuf size earlier in the RX path
Date: Mon,  4 May 2026 17:39:56 +0200
Message-ID: <a8205bf730578c8314404bdbbc3ba660f2ce70ae.1777908248.git.pabeni@redhat.com>
In-Reply-To: <cover.1777908248.git.pabeni@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7HdOdjqmgufD4qeKbq5wXWAsFhJKmcIBZPXFWdfqB2Q_1777909218
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
 - sashiko can assume ZWP carries unacked data and may be silently dropped.
   AFAIK that is false.
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
2.54.0

