Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205222C8E
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635426524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEL7dSBhMDJ5HgGkCAFTX3dotRFWXKIiHItes1YHKWc=;
	b=TlmCo2iYQ+1VSPk+ewCS+sLTT6QiL2ECI3UW+IzsXIcwiPBm8VhTC5Qo45fJXJvDyvF0LJ
	GwgZ1T3KUGLkCJsWTXSjJSEDwwk4rPlVAdzZ+idO5XJdECbxxQREQjtWKORLsTA1cskorJ
	kssgY4sLosVo04A3U15gAQsmzA+Ztds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-LF8Khtx1PJ6Rsf-2qr4g3g-1; Thu, 28 Oct 2021 09:08:42 -0400
X-MC-Unique: LF8Khtx1PJ6Rsf-2qr4g3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 293ED802B7A
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63B7419D9F
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp <mptcp@lists.linux.dev>
Subject: [PATCH mptcp-net 2/2] mptcp: use delegate action to schedule 3rd ack retrans
Date: Thu, 28 Oct 2021 15:08:33 +0200
Message-Id: <2a28807616445b389496dc0f172e206180f5a099.1635426465.git.pabeni@redhat.com>
In-Reply-To: <cover.1635426465.git.pabeni@redhat.com>
References: <cover.1635426465.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Scheduling a delack in mptcp_established_options_mp() is
not a good idea: such function is called by tcp_send_ack() and
the pending delayed ack will be cleared shortly after by the
tcp_event_ack_sent() call in __tcp_transmit_skb().

Instead use the mptcp delegated action infrastructure to
schedule the delayed ack after the current bh processing completes.

Additionally moves the schedule_3rdack_retransmission() helper
into protocol.c to avoid making it visible in a different compilation
unit.

Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
side note:
 Why we already see 3rd ack retransimssion in pcap traces even if the delack timer
was broken sice the beginning?!? I guess that is due to pure ack generated
by mptcp_recvmsg() and pushed on all the subflow. mptcp_send_ack() only
checks for the TCP status and not the MPTCP one. When landing on MPJ
subflows not already fully established, such data-ack will be converted in MPJ
3rd ack by the MPTCP output path/out options building, as the MPJ option
has higher priority than DSS
---
 net/mptcp/options.c  | 33 ++++++++---------------------
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 17 ++++++++-------
 3 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 465d4143d555..12ffee025373 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -422,29 +422,6 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	return false;
 }
 
-/* MP_JOIN client subflow must wait for 4th ack before sending any data:
- * TCP can't schedule delack timer before the subflow is fully established.
- * MPTCP uses the delack timer to do 3rd ack retransmissions
- */
-static void schedule_3rdack_retransmission(struct sock *sk)
-{
-	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	unsigned long timeout;
-
-	/* reschedule with a timeout above RTT, as we must look only for drop */
-	if (tp->srtt_us)
-		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
-	else
-		timeout = TCP_TIMEOUT_INIT;
-	timeout += jiffies;
-
-	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
-	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
-	icsk->icsk_ack.timeout = timeout;
-	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
-}
-
 static void clear_3rdack_retransmission(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -527,7 +504,15 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
 		pr_debug("subflow=%p", subflow);
 
-		schedule_3rdack_retransmission(sk);
+		/* we can use the full delegate action helper only from BH context
+		 * If we are in process context - sk is flushing the backlog at
+		 * socket lock release time - just set the appropriate flag, will
+		 * be handled by the release callback
+		 */
+		if (sock_owned_by_user(sk))
+			set_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
+		else
+			mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_ACK);
 		return true;
 	}
 	return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 582f5f88d6ef..cd00f8998375 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk));
+				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
 				goto out;
 			}
 
@@ -2972,7 +2972,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
 		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk));
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
 	} else {
 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
 	}
@@ -3022,18 +3022,50 @@ static void mptcp_release_cb(struct sock *sk)
 	__mptcp_update_rmem(sk);
 }
 
+/* MP_JOIN client subflow must wait for 4th ack before sending any data:
+ * TCP can't schedule delack timer before the subflow is fully established.
+ * MPTCP uses the delack timer to do 3rd ack retransmissions
+ */
+static void schedule_3rdack_retransmission(struct sock *ssk)
+{
+	struct inet_connection_sock *icsk = inet_csk(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	unsigned long timeout;
+
+	if (mptcp_subflow_ctx(ssk)->fully_established)
+		return;
+
+	/* reschedule with a timeout above RTT, as we must look only for drop */
+	if (tp->srtt_us)
+		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
+	else
+		timeout = TCP_TIMEOUT_INIT;
+	timeout += jiffies;
+
+	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
+	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
+	icsk->icsk_ack.timeout = timeout;
+	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
+}
+
 void mptcp_subflow_process_delegated(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
-	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk))
-		__mptcp_subflow_push_pending(sk, ssk);
-	else
-		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
-	mptcp_data_unlock(sk);
-	mptcp_subflow_delegated_done(subflow);
+	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_subflow_push_pending(sk, ssk);
+		else
+			set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+		mptcp_data_unlock(sk);
+		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
+	}
+	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
+		schedule_3rdack_retransmission(ssk);
+		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
+	}
 }
 
 static int mptcp_hash(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 46691acdea24..f6f4054e19ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -387,6 +387,7 @@ struct mptcp_delegated_action {
 DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 
 #define MPTCP_DELEGATE_SEND		0
+#define MPTCP_DELEGATE_ACK		1
 
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
@@ -493,23 +494,23 @@ static inline void mptcp_add_pending_subflow(struct mptcp_sock *msk,
 
 void mptcp_subflow_process_delegated(struct sock *ssk);
 
-static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow)
+static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
 {
 	struct mptcp_delegated_action *delegated;
 	bool schedule;
 
+	/* the caller held the subflow bh socket lock */
+	lockdep_assert_in_softirq();
+
 	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
 	 * ensures the below list check sees list updates done prior to status
 	 * bit changes
 	 */
-	if (!test_and_set_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
+	if (!test_and_set_bit(action, &subflow->delegated_status)) {
 		/* still on delegated list from previous scheduling */
 		if (!list_empty(&subflow->delegated_node))
 			return;
 
-		/* the caller held the subflow bh socket lock */
-		lockdep_assert_in_softirq();
-
 		delegated = this_cpu_ptr(&mptcp_delegated_actions);
 		schedule = list_empty(&delegated->head);
 		list_add_tail(&subflow->delegated_node, &delegated->head);
@@ -534,16 +535,16 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 
 static inline bool mptcp_subflow_has_delegated_action(const struct mptcp_subflow_context *subflow)
 {
-	return test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
+	return !!READ_ONCE(subflow->delegated_status);
 }
 
-static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *subflow)
+static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *subflow, int action)
 {
 	/* pairs with mptcp_subflow_delegate, ensures delegate_node is updated before
 	 * touching the status bit
 	 */
 	smp_wmb();
-	clear_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
+	clear_bit(action, &subflow->delegated_status);
 }
 
 int mptcp_is_enabled(const struct net *net);
-- 
2.26.3

