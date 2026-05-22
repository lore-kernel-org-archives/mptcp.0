Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C325B09E
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486262; cv=none; b=NQG8pm883EuBL52jALRRsih6fferWB3Qysoeqs5G8HOhFjgK7U8pP4mXeFwxi07sQ8i2jRJd4ZMjXSaSHN+EL0aGrywuQhTChx1SinlTDK/xEBxUTrKNxJFAF+w6nl3tAhunL8PzT4t21nmtzGLlLtkZAch2ofbKYBAr5Raspc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486262; c=relaxed/simple;
	bh=nc/zQEncJ0SUYhFhDqQHTQ2ExHZanIRBk2fEvDyzXDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=taMTJ9poYIUgTiXjyhCPbKJNJxqiXMZSbMvSKgg+ZAXrg/Yt22muI/Qt939oXioUCdqx+1b5bJdIU8Bz6Fu03J14r9XxTxpyZ57i+kay2sigLum9r1LSg7qA4Lu8N2cjITdLpamzEPsXz6JuJ5pKx8+kG4m1X/kY0/tdEZtongc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6QgFQCQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6QgFQCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779486260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh20VZz/YFfN5GZJ4Y6PF9MU51+fgFR+8Z0NwauxmjQ=;
	b=d6QgFQCQoAsmG9liVT5kPwwHjH4WO8m1e+cR2ECZ0AgolqMV9gp1TFiDNjGwbV6IOileKo
	d8xTgCL80j08cdCN7E+NPnTNsGC46hBRGISEhv2nCRz23VfvduGhZnhDGyN5rteXx5Ob4C
	fnfGCz/ZqOvWymmhD8dKyHDqEevrxBo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-Ut-23MAKNcqRvcEi_3KQKA-1; Fri,
 22 May 2026 17:44:16 -0400
X-MC-Unique: Ut-23MAKNcqRvcEi_3KQKA-1
X-Mimecast-MFC-AGG-ID: Ut-23MAKNcqRvcEi_3KQKA_1779486255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6AA31800451;
	Fri, 22 May 2026 21:44:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B3311800347;
	Fri, 22 May 2026 21:44:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v8 mptcp-next 5/9] mptcp: explicitly drop over memory limits
Date: Fri, 22 May 2026 23:43:46 +0200
Message-ID: <999dc99ccc3d98f3a668fe784114e3f5a814ec12.1779485511.git.pabeni@redhat.com>
In-Reply-To: <cover.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zZ9fVD1O7cGGwh9HUGOY4z8w4Nz1EqZMPb97xeCGgrY_1779486255
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
---
v7 -> v8:
 - removed non fallback check in mptcp_incoming_option(): that is an
   tput optimization (avoid rejections) for a slowpath case (sender
   is misbehaving) and needs too much additional complexity.
 - move here from later patches mibs definition

v6 -> v7:
 - fix sign extension issues

v4 -> v5:
 - fix possible u32 overflow in mptcp_over_limit

v3 -> v4:
 - schedule TCP ack on drop
 - enforce limits in __mptcp_move_skb() and __mptcp_add_backlog(), too
   but only if not fallback.

v1 -> v2:
 - deal correctly with tcp fin and zero win probe

RFC -> v1:
 - limit vs actual buffer size
 - use CB info instead of skb->len

Note that:
 - this needs the follow-up patches to really fix the stall
 - sashiko can assume ZWP carries unacked data and may be silently dropped.
   AFAIK that is false.
 - sashiko apparently can't graps mptcp subflow never hit the tcp rx
   fastpath, and the mptcp_incoming_options in tcp_rcv_state_process
   is hit, the peer can't transmit any more data.
 - the memory comparison is intentionally very rough, as
   the msk socket lock is not currently held where the condition is
   now enforced. This should require some refinement, shared as-is
   to avoid more latency on my side
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
 4 files changed, 52 insertions(+), 11 deletions(-)

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
index 812218b5ed2b..c84eb853d499 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 97ea4aa37b33..2b35bdc113a5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1161,8 +1161,30 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
+			     const struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 mem = sk_rmem_alloc_get(sk);
+
+	mem += READ_ONCE(msk->backlog_len);
+	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
+		return false;
+
+	/* Avoid silently dropping pure acks, fin or zero win probes. */
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
+		return false;
+
+	/* Dropped due to memory constraints, schedule an ack. */
+	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
+	inet_csk_schedule_ack(ssk);
+	return true;
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1188,7 +1210,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
-		return true;
+		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
 	mptcp_get_options(skb, &mp_opt);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f2b2868031a..1d498c601145 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -381,6 +381,16 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
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
@@ -675,6 +685,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	struct sk_buff *tail = NULL;
 	struct sock *ssk = skb->sk;
 	bool fragstolen;
+	u64 limit;
 	int delta;
 
 	if (unlikely(sk->sk_state == TCP_CLOSE)) {
@@ -682,6 +693,16 @@ static void __mptcp_add_backlog(struct sock *sk,
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
@@ -753,7 +774,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2211,10 +2232,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2242,9 +2259,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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

