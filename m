Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548D448B88
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027652; cv=none; b=FAV1rZ1do0b6+O6liilijr1kLXiB2l1TO9+qg3662A8igmuvwD/aisZanD8O59oLoq13FrHiAi3Y2DjgAsJWznBjUyoHaOVqlVCbHNzUbQxkLverSSPiSfRVCJv7dX1XSWhWXAetcma93UGtiG2m3jR3tSfUIqVG4GzM29WQRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027652; c=relaxed/simple;
	bh=/O0Zb2z+zRqHjiW5tCT8W7HP9OZKSZe6qcH+8S5IbeE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=joVZuW+AlNk3oWe5/+PFNL/gJlc/Sr4nagE7mxmQMobrb5TtyOBY65zz5KvNqvWnJgVMnfpxD/iV43tlmYkYrQoJuyYpBmASu430OMhneHkUishcwQ+ZgDl8wd8V1hPGF7ytiunXXlDHzdDsvhWOe4UTdk1eWGPkGzpVsmQQdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgEbiU9E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgEbiU9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hga24OkJry397XDvJqKJ0CPsB4uBs3PMRO8/2CwXSTA=;
	b=QgEbiU9ENXnwNn9wtxp0UG+lD6UtUEEvHGo60WI1KEoFIEEGx6co9XNm//N5OToQ3P4Y1f
	ehBU0NOV6ctY1Hdava7t4eI8nx6+bQfgIdfDUYrxh4vDiXbhD5AwVeqlU7TXUMg3bVLQ/x
	oFVDLVjYPE9TciLD8aZJ+zRVN+zHXbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-auZbk5RkOQi4M5DVSV-pIg-1; Thu,
 06 Aug 2026 10:47:28 -0400
X-MC-Unique: auZbk5RkOQi4M5DVSV-pIg-1
X-Mimecast-MFC-AGG-ID: auZbk5RkOQi4M5DVSV-pIg_1786027647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A59218000A3
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDA0B1956094
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 4/7] mptcp: explicitly drop over memory limits
Date: Thu,  6 Aug 2026 16:45:25 +0200
Message-ID: <15eb12c744eff920cdd45c255668eec242d48937.1786026372.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tv0ZxhE0rEa0KMiSf4sXkfBqliXi2EJBs2r23D7I7hw_1786027647
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the enforcement of the rcvbuf constraint is implemented
when moving the skbs into the msk receive or OoO queue, keeping the
incoming skbs in the subflow queue when over limit.

Under significant memory pressure the above can cause permanent data
transfer stalls, as the skb needed to make forward progress can be
stuck in a subflow queue.

Over memory limits, drop the incoming skb, relaying on MPTCP-level
retransmissions.

Note that fallback socket must perform the limit before the skb reaches
the subflow-level queue, as dropping an in-sequence already acked skb
would break the stream.

This is not a complete fix for the stall issue, as the drop strategy
needs refinements that will come in the next patches.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v<n> -. v<n+1>:
  - refine mptcp_over_limit() to check separately backlog and rcvbuf
  - do not drop rst (with data)
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 32 +++++++++++++++++++++++++++++---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..ef65e2df709f 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
+	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
+	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..9271205f682e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1057d500577b..db3dcea652ee 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1190,8 +1190,34 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
+			     const struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if (likely((u32)sk_rmem_alloc_get(sk) <= rcvbuf &&
+		   READ_ONCE(msk->backlog_len) <= rcvbuf))
+		return false;
+
+	/* Avoid silently dropping pure acks, fin, rst or already-acked segments. */
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_FIN | TCPHDR_RST) ||
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
+		return false;
+
+	/* Dropped due to memory constraints, schedule an ack. */
+	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
+	inet_csk_schedule_ack(ssk);
+
+	/* Plain TCP (fallback) and skb is dropped before the TCP recv queue. */
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+
+	return true;
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1217,7 +1243,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
-		return true;
+		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
 	mptcp_get_options(skb, &mp_opt);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 09cd3c1f3cdb..cfb77a32518a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -387,6 +387,16 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Can't drop packets for fallback socket this late, or the stream
+	 * will break.
+	 */
+	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
+	    !__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -681,6 +691,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	struct sk_buff *tail = NULL;
 	struct sock *ssk = skb->sk;
 	bool fragstolen;
+	u64 limit;
 	int delta;
 
 	if (unlikely(sk->sk_state == TCP_CLOSE)) {
@@ -688,6 +699,16 @@ static void __mptcp_add_backlog(struct sock *sk,
 		return;
 	}
 
+	/* Similar additional allowance as plain TCP. */
+	limit = READ_ONCE(sk->sk_rcvbuf);
+	limit += (limit >> 1) + 64 * 1024;
+	limit = min_t(u64, limit, UINT_MAX);
+	if (msk->backlog_len > limit && !__mptcp_check_fallback(msk)) {
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_BACKLOGDROP);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG);
+		return;
+	}
+
 	/* Try to coalesce with the last skb in our backlog */
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
@@ -759,7 +780,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2210,10 +2231,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2241,9 +2258,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
 			       mem_cgroup_from_sk(sk));
 
-	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	if (list_empty(&msk->backlog_list))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.55.0

