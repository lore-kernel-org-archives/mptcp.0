Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98078371EB2
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040057; cv=none; b=Y2j0Xw5vWl+ghL06m1bUG0B4+75HmkE/JnvoddJrxFVwJZdmrLR4XyJ+ics7osbCKj0svuHg7HjLGXPm83rWTlnrQilm5pJ/w842WD7U57Hb1APsEhhZcLsD96wPcreEzMVOxDfN0s6UXVgjwRSiXE6hYlESwl6SdVegpIXNClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040057; c=relaxed/simple;
	bh=Q2INywZt/aKkUcdXYBYNLzbqVCUMIuLt/RDMp8uvix8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VceK8UyhxVXdzAWqwK8dOfZCyvYp4QyvyDCJY8jPyQi5krqCgGzsF8ner7gM50MKO2jNMIMFkXcFGmghxKYZ+XArSV9PCxd0AY9ybxm0SwHeokcOKUlQRXhfod77tFzbhBjfOEw8zWsAZ6iwUMW1si8GhAP3qaSrgAeUUlL4C1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHdhH89C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHdhH89C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leevm05Lx0IpAHQgB2Gr714aqU5lgDMSwqYLJ/kqFVo=;
	b=CHdhH89CVZ+CSljGTTdbnB1Fl5FFm+luDBPQETSM6Wvp0fiUvhIg5HkfUIV48vS/qVv60b
	wUoKaFycpNnzQgjVApG8NK80ycgB6LoAoa/myNRw4g7e3d6iIlLRSVUQ0W4H56qjPUAtwf
	135dTD6C7sACFej7jeb+RhetHaZ/KG4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-SYMyiZGQO5Kj-8fU9YnHKw-1; Tue,
 16 Sep 2025 12:27:33 -0400
X-MC-Unique: SYMyiZGQO5Kj-8fU9YnHKw-1
X-Mimecast-MFC-AGG-ID: SYMyiZGQO5Kj-8fU9YnHKw_1758040052
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0741956048
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6759419560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 03/12] mptcp: rcvbuf auto-tuning improvement
Date: Tue, 16 Sep 2025 18:27:13 +0200
Message-ID: <d3f96328a76e6fffcb871e8542c526ea99135ea5.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LOuEttaC3IEU5oK6jgmuoo_WoGwvv-l_GWvUrZGIyLY_1758040052
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Apply to the MPTCP auto-tuning the same improvements introduced for the
TCP protocol by the merge commit 2da35e4b4df9 ("Merge branch
'tcp-receive-side-improvements'").

The main difference is that TCP subflow and the main MPTCP socket need
to account separately for OoO: MPTCP does not care for TCP-level OoO
and vice versa.

The above additionally allow dropping the msk receive buffer update at
receive time, as the latter only intended to cope with subflow receive
buffer increase due to OoO packets.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 95 +++++++++++++++++++++-----------------------
 net/mptcp/protocol.h |  4 +-
 2 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c51aede20779d..671c51cb9539c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -178,6 +178,33 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
+static bool mptcp_rcvbuf_grow(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int rcvwin, rcvbuf;
+
+	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		return false;
+
+	rcvwin = ((u64)msk->rcvq_space.space << 1);
+
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
+
+	rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
+		       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
+
+	if (rcvbuf > sk->sk_rcvbuf) {
+		u32 window_clamp;
+
+		window_clamp = mptcp_win_from_space(sk, rcvbuf);
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+		return true;
+	}
+	return false;
+}
+
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -291,6 +318,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
+	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
+	if (sk->sk_socket)
+		mptcp_rcvbuf_grow(sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -770,18 +800,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	return moved;
 }
 
-static void __mptcp_rcvbuf_update(struct sock *sk, struct sock *ssk)
-{
-	if (unlikely(ssk->sk_rcvbuf > sk->sk_rcvbuf))
-		WRITE_ONCE(sk->sk_rcvbuf, ssk->sk_rcvbuf);
-}
-
 static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	__mptcp_rcvbuf_update(sk, ssk);
-
 	/* Wake-up the reader only for in-sequence data */
 	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
 		sk->sk_data_ready(sk);
@@ -1984,48 +2006,26 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
-	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		u64 rcvwin, grow;
-		int rcvbuf;
-
-		rcvwin = ((u64)msk->rcvq_space.copied << 1) + 16 * advmss;
-
-		grow = rcvwin * (msk->rcvq_space.copied - msk->rcvq_space.space);
-
-		do_div(grow, msk->rcvq_space.space);
-		rcvwin += (grow << 1);
-
-		rcvbuf = min_t(u64, mptcp_space_from_win(sk, rcvwin),
-			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
-
-		if (rcvbuf > sk->sk_rcvbuf) {
-			u32 window_clamp;
-
-			window_clamp = mptcp_win_from_space(sk, rcvbuf);
-			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+	msk->rcvq_space.space = msk->rcvq_space.copied;
+	if (mptcp_rcvbuf_grow(sk)) {
 
-			/* Make subflows follow along.  If we do not do this, we
-			 * get drops at subflow level if skbs can't be moved to
-			 * the mptcp rx queue fast enough (announced rcv_win can
-			 * exceed ssk->sk_rcvbuf).
-			 */
-			mptcp_for_each_subflow(msk, subflow) {
-				struct sock *ssk;
-				bool slow;
+		/* Make subflows follow along.  If we do not do this, we
+		 * get drops at subflow level if skbs can't be moved to
+		 * the mptcp rx queue fast enough (announced rcv_win can
+		 * exceed ssk->sk_rcvbuf).
+		 */
+		mptcp_for_each_subflow(msk, subflow) {
+			struct sock *ssk;
+			bool slow;
 
-				ssk = mptcp_subflow_tcp_sock(subflow);
-				slow = lock_sock_fast(ssk);
-				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
-				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
-				if (tcp_can_send_ack(ssk))
-					tcp_cleanup_rbuf(ssk, 1);
-				unlock_sock_fast(ssk, slow);
-			}
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			slow = lock_sock_fast(ssk);
+			tcp_sk(ssk)->rcvq_space.space = msk->rcvq_space.copied;
+			tcp_rcvbuf_grow(ssk);
+			unlock_sock_fast(ssk, slow);
 		}
 	}
 
-	msk->rcvq_space.space = msk->rcvq_space.copied;
 new_measure:
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.time = mstamp;
@@ -2054,11 +2054,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
 	if (list_empty(&msk->conn_list))
 		return false;
 
-	/* verify we can move any data from the subflow, eventually updating */
-	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK))
-		mptcp_for_each_subflow(msk, subflow)
-			__mptcp_rcvbuf_update(sk, subflow->tcp_sock);
-
 	subflow = list_first_entry(&msk->conn_list,
 				   struct mptcp_subflow_context, node);
 	for (;;) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1787a1344ac1..128baea5b496e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -341,8 +341,8 @@ struct mptcp_sock {
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
 	struct {
-		u32	space;	/* bytes copied in last measurement window */
-		u32	copied; /* bytes copied in this measurement window */
+		int	space;	/* bytes copied in last measurement window */
+		int	copied; /* bytes copied in this measurement window */
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
-- 
2.51.0

