Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF72C21F8
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297226; cv=none; b=AFWac+uQGopJFaqDNAF4S5OyIbjt4ySADG/DXe93tyfOb0Nt6LficwdKAmiSnCUNj2EO9mXCapTPaNVf+r5i/ADhNJdsMkweFZ2gQKSWsIqRw7ZZDTi6wz3X+77cXztlhcrBMbk0MDNQ1x4MmRGJrFsWM10C5IxTcGbYGGpeCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297226; c=relaxed/simple;
	bh=ubCKXzaFwjqSZEdr2xKc5qEJhiq1yqyo3JSi6A9Va7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Q8L4lVyI8G9QsY3MX/dziAd1YIN2ROZ6mi+8fvkASrTNDYGMygxekbGaiIKjyTd6P7NHUdBNutBhhniela6jVTSX4xuvTuKcpdP6AXvFlP79haqz8Mnr13eTMn9qDMfUXAaff4TVCPizyeMuQXjBo+uq7MFsfdodOnl261T3UEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkD5o8zK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkD5o8zK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lOEbne5y/2o7H2yMVxjqtL9Q4iFhY3IW+KbQaxCbN4=;
	b=dkD5o8zKupI8oSmMeWE0YIoCRHYIkvM0yc1taTE0cF6+VMSr+JuM88iUuEoy/l9LjZMGq1
	Jo5KabH/6ImhTTxW6336u5Y0rwAUmwmDqQLjC72TSKzMbtFW3hP8DqTYFGSIZzbbMHRFWl
	/yQTXWfmUCSdFnA1zLw+XrDL/HMw8xg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-xLmESz_kOOKarafJG89_Cw-1; Fri,
 19 Sep 2025 11:53:42 -0400
X-MC-Unique: xLmESz_kOOKarafJG89_Cw-1
X-Mimecast-MFC-AGG-ID: xLmESz_kOOKarafJG89_Cw_1758297221
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDBCC180028C
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB6DE1800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 03/12] mptcp: rcvbuf auto-tuning improvement
Date: Fri, 19 Sep 2025 17:53:17 +0200
Message-ID: <3b9f144fd4df4c02550946d4208a0ede8e776526.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aMxpGy4VrT6CaRVaoJ61b9XlbMOOtJuA46L0p_qaszQ_1758297221
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Apply to the MPTCP auto-tuning the same improvements introduced for the
TCP protocol by the merge commit 2da35e4b4df9 ("Merge branch
'tcp-receive-side-improvements'").

The main difference is that TCP subflow and the main MPTCP socket need
to account separately for OoO: MPTCP does not care for TCP-level OoO
and vice versa, as a consequence do not reflect MPTCP-level rcvbuf
increase due to OoO packets at the subflow level.

This refeactor additionally allow dropping the msk receive buffer update
at receive time, as the latter only intended to cope with subflow receive
buffer increase due to OoO packets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/559
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - copy tcp_rcvbuf_grow() implementation, verbatim
  - intentionally omitted Mat's tag due to the many changes

v1 -> v2:
  - fix unused variable
  - reword the commit message
---
 net/mptcp/protocol.c | 97 +++++++++++++++++++++-----------------------
 net/mptcp/protocol.h |  4 +-
 2 files changed, 49 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d95d24781509..c9fcdbaf50874 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -179,6 +179,35 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 	return mptcp_try_coalesce((struct sock *)msk, to, from);
 }
 
+/* "inspired" by tcp_rcvbuf_grow(), main difference:
+ * - mptcp does not maintain a msk-level window clamp
+ * - returns true when  the receive buffer is actually updated
+ */
+static bool mptcp_rcvbuf_grow(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct net *net = sock_net(sk);
+	int rcvwin, rcvbuf, cap;
+
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
+	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
+		return false;
+
+	rcvwin = msk->rcvq_space.space << 1;
+
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
+
+	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
+
+	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
+	if (rcvbuf > sk->sk_rcvbuf) {
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+		return true;
+	}
+	return false;
+}
+
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -292,6 +321,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
+	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
+	if (sk->sk_socket)
+		mptcp_rcvbuf_grow(sk);
 }
 
 static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
@@ -784,18 +816,10 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
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
@@ -2014,48 +2038,26 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
@@ -2084,11 +2086,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
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
index 9b5a248bad404..6ac58e92a1aa3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -342,8 +342,8 @@ struct mptcp_sock {
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

