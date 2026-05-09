Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EF23ED5B
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312955; cv=none; b=EAV5HPjLEpvdN0g/W6U4RzySaa2AszD8TTiGD3Yn8IUp2F5Cz6/arNT2DLxlYC2ONm6ZRJM/unxu1wWe5mm3sddof71gx6RVOr9/09tlNd2uOGV/BW13sexBPpeJ3NX/XSAR9HT6HwUVShsCKu3x6/1LBHzQqh4sNReKAtZH9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312955; c=relaxed/simple;
	bh=lur4HQqPw7hF0oJSkWuC2N7C+JkQ7kRlcYSBHpoXtME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ba9hFHGGfk78I2b7z3WT1YWSy50BlB9w02EuqMcvNmgXEhQtsZIGIAOsIKr2TGymIyLHZlu3xjpL5oP/7U9pRGq7S4dZ5yAt8j83MKMxNCBGFhHn9EsLO8mK6HgY0t5X8mXHHqPYC2Em6Zs7iRJ7W4eFGM7ssCCUdAmfI737a10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crlj5/nx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crlj5/nx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+yR1Dud48WDg7YYavWvbc7vkPJ3+jR+QX6+uxUtBXk=;
	b=Crlj5/nxZ6HrIr0uHLw95cSr2+N6/sube+pXmzWljRvbFbFib98Q4rYdS0rKil2b49a+sE
	aofy8ehW7OW8mDW2wU5A5uzHBRAYeyF7+e0gIW95gRDgFdl8ZRPriuB7pMaf5Oefn7367r
	Eoa4DjULiITvhDnGDtA40k+mIg9hR4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-z8qs8l3qPP6EpXLZxxuEuw-1; Sat,
 09 May 2026 03:49:11 -0400
X-MC-Unique: z8qs8l3qPP6EpXLZxxuEuw-1
X-Mimecast-MFC-AGG-ID: z8qs8l3qPP6EpXLZxxuEuw_1778312950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93953180035D;
	Sat,  9 May 2026 07:49:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9098318004A3;
	Sat,  9 May 2026 07:49:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 02/12] mptcp: explicitly drop over memory limits
Date: Sat,  9 May 2026 09:48:22 +0200
Message-ID: <ce7beeb758f004cc86fe194db4c91ea4b487d042.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sc5wXcNmOQJYq4I30mqueiZ9nmTWlhN2xyUUwH1Yv1k_1778312950
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the enforcement of the rcvbuf constraint is implemented
when moving the skbs into the msk receive or OoO queue, keeping the
incoming skbs in the subflow queue when over limit.

Under significant memory pressure the above can cause permanent data
transfer stalls. Hard enforce the memory limits as early as possible,
before landing even in the subflow queues, and refine the check when
owning the msk socket lock.

Note that fallback socket must not drop on the later checks, as the
incoming skb is already acked, and such drop would break the stream.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
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
 - the memory comparison is intentionally very rough, as
   the msk socket lock is not currently held where the condition is
   now enforced. This should require some refinement, shared as-is
   to avoid more latency on my side
---
 net/mptcp/options.c  | 31 +++++++++++++++++++++++++++++--
 net/mptcp/protocol.c | 29 +++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..19c0bc92f04e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,8 +1158,29 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
+			     const struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (likely(sk_rmem_alloc_get(sk) + READ_ONCE(msk->backlog_len) <=
+		   READ_ONCE(sk->sk_rcvbuf)))
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
@@ -1185,6 +1206,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
+
+		if (mptcp_over_limit(subflow->conn, sk, skb))
+			return false;
 		return true;
 	}
 
@@ -1263,6 +1287,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
+	if (mptcp_over_limit(subflow->conn, sk, skb))
+		return false;
+
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce8372fb3c6a..492ee9ca9c77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -381,6 +381,15 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Can't drop packets for fallback socket this late, or the stream
+	 * will break.
+	 */
+	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
+	    !__mptcp_check_fallback(msk)) {
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -675,6 +684,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	struct sk_buff *tail = NULL;
 	struct sock *ssk = skb->sk;
 	bool fragstolen;
+	u64 limit;
 	int delta;
 
 	if (unlikely(sk->sk_state == TCP_CLOSE)) {
@@ -682,6 +692,15 @@ static void __mptcp_add_backlog(struct sock *sk,
 		return;
 	}
 
+	/* Similar additional allowance as plain TCP. */
+	limit = READ_ONCE(sk->sk_rcvbuf);
+	limit += (limit >> 1) + 64 * 1024;
+	limit = min_t(u64, limit, UINT_MAX);
+	if (msk->backlog_len > limit && !__mptcp_check_fallback(msk)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
+		return;
+	}
+
 	/* Try to coalesce with the last skb in our backlog */
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
@@ -753,7 +772,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2211,10 +2230,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2242,9 +2257,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
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

