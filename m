Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01592F80
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXeHGCmNwBv4/CFI+xGLepKV2eIQLi3huVxIXdv/bQM=;
	b=Je+8VJNqQQIrAC98L3qt6US38yOO4JcBU4dHhQivyfpzwF19Gvg/Z/TAjCv55dicbN9jh7
	0rB3xKa+C34PpL0+fh7BaASDNzC6vnb4VJMGuOSe2EsQ6qAz+2N+SqmIGBsYvYtDvHaIeG
	kaLrcIZ//O9GsPMnTjdchGQk3wD+bcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-s8t5SEq9OzeOws_zmqcYNQ-1; Tue, 13 Jul 2021 17:13:51 -0400
X-MC-Unique: s8t5SEq9OzeOws_zmqcYNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE648015C6
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:50 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E59B860C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/8] mptcp: more accurate timeout
Date: Tue, 13 Jul 2021 23:13:31 +0200
Message-Id: <d4ab7e417c82dfefa3dc91ab6ea4adcb7c5752c3.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

As reported by Maxim, we have a lot of MPTCP-level
retransmissions when multilple links with different latencies
are in use.

This patch refactor the mptcp-level timeout accounting so that
the maximum of all the active subflow timeout is used. To avoid
traversing the subflow list multiple times, the update is
perfomed inside the packet scheduler.

Additionally clean-up a bit timeout handling.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - be sure to always set timer in get_send()
 - mptcp_timeout_from_ssk -> mptcp_timeout_from_subflow, will simplfy
   the next patch
 - always rearm the timeout in __mptcp_*push_pending(), to catch
   link failure even when no data are send
---
 net/mptcp/protocol.c | 60 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ae80c1d7f79..19d734825928 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -411,16 +411,28 @@ static void mptcp_set_datafin_timeout(const struct sock *sk)
 				       TCP_RTO_MIN << icsk->icsk_retransmits);
 }
 
-static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
+static void __mptcp_set_timeout(struct sock *sk, long tout)
 {
-	long tout = ssk && inet_csk(ssk)->icsk_pending ?
-				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
-
-	if (tout <= 0)
-		tout = mptcp_sk(sk)->timer_ival;
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
+static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return inet_csk(ssk)->icsk_pending ? inet_csk(ssk)->icsk_timeout - jiffies : 0;
+}
+
+static void mptcp_set_timeout(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	long tout = 0;
+
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
+		tout = max(tout, mptcp_timeout_from_subflow(subflow));
+	__mptcp_set_timeout(sk, tout);
+}
+
 static bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
@@ -531,7 +543,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_set_timeout(sk, NULL);
 		mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
@@ -791,10 +802,7 @@ static void mptcp_reset_timer(struct sock *sk)
 	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
 		return;
 
-	/* should never be called with mptcp level timer cleared */
-	tout = READ_ONCE(mptcp_sk(sk)->timer_ival);
-	if (WARN_ON_ONCE(!tout))
-		tout = TCP_RTO_MIN;
+	tout = mptcp_sk(sk)->timer_ival;
 	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
 }
 
@@ -1077,7 +1085,7 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 
 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
-		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
+		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_timer(sk);
 	} else {
 		mptcp_reset_timer(sk);
@@ -1366,16 +1374,22 @@ struct subflow_send_info {
 	u64 ratio;
 };
 
+/* implement the mptcp packet scheduler;
+ * returns the subflow that will transmit the next DSS
+ * additionally updates the rtx timeout
+ */
 static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[2];
 	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
 	int i, nr_active = 0;
 	struct sock *ssk;
+	long tout = 0;
 	u64 ratio;
 	u32 pace;
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me(sk);
 
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
@@ -1386,8 +1400,10 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd)))
+	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
+		mptcp_set_timeout(sk);
 		return msk->last_snd;
+	}
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < 2; ++i) {
@@ -1400,6 +1416,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
+		tout = max(tout, mptcp_timeout_from_subflow(subflow));
 		nr_active += !subflow->backup;
 		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
@@ -1415,6 +1432,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			send_info[subflow->backup].ratio = ratio;
 		}
 	}
+	__mptcp_set_timeout(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
@@ -1433,7 +1451,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 			       struct mptcp_sendmsg_info *info)
 {
-	mptcp_set_timeout(sk, ssk);
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
 }
@@ -1501,12 +1518,11 @@ static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_push_release(sk, ssk, &info);
 
 out:
-	if (copied) {
-		/* start the timer, if it's not pending */
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+	/* ensure the rtx timer is running */
+	if (!mptcp_timer_pending(sk))
+		mptcp_reset_timer(sk);
+	if (copied)
 		__mptcp_check_send_data_fin(sk);
-	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
@@ -1567,7 +1583,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	 */
 	__mptcp_update_wmem(sk);
 	if (copied) {
-		mptcp_set_timeout(sk, ssk);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
@@ -2313,7 +2328,6 @@ static void __mptcp_retrans(struct sock *sk)
 			 info.size_goal);
 	}
 
-	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 
 reset_timer:
@@ -2384,6 +2398,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->wmem_reserved = 0;
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->tx_pending_data = 0;
+	msk->timer_ival = TCP_RTO_MIN;
 
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -2476,7 +2491,6 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			tcp_shutdown(ssk, how);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
-			mptcp_set_timeout(sk, ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_timer_pending(sk))
 				mptcp_reset_timer(sk);
-- 
2.26.3

