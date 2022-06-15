Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA7A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655284626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZOLrIX/u6B7BU490m/dmriUkhN4KcY+GxMfgb8X9B0=;
	b=SVUrp1q8Xj4Ax/O5fEY6PX3pGqjiNz07TxLBsdWTo8WLNCPkY5o/RCVvp9CUhdSWq5uzOw
	kg9shGnCKVqqHMyjCNQtEvRluvbPBzDJZCrgQQxr+JMoaRUhvoYMYBjFhiwio1RYWEfdrr
	TohnefEq4iTO4bU3ozeqIHxy7/d/ngw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-uPXAuzPGNXKsBlmHcMnycg-1; Wed, 15 Jun 2022 05:17:05 -0400
X-MC-Unique: uPXAuzPGNXKsBlmHcMnycg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3428802804
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72CF7C23DBF
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/5] Squash-to: "mptcp: invoke MP_FAIL response when needed"
Date: Wed, 15 Jun 2022 11:16:14 +0200
Message-Id: <a8a64e7da9f537998d49cd955abb443ee8ec7457.1655283387.git.pabeni@redhat.com>
In-Reply-To: <cover.1655283387.git.pabeni@redhat.com>
References: <cover.1655283387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This tries to address a few issues outstanding in the mentioned
patch:
- we explicitly need to reset the timeout timer for mp_fail's sake
- we need to explicitly generate a tcp ack for mp_fail, otherwise
  there are no guarantees for suck option being sent out
- the timeout timer needs handling need some caring, as it's still
  shared between mp_fail and msk socket timeout.
- we can re-use msk->first for msk->fail_ssk, as only the first/mpc
  subflow can fail without reset. That additionally avoid the need
  to clear fail_ssk on the relevant subflow close.
- fail_tout would need some additional annotation. Just to be on the
  safe side move its manipulaiton under the ssk socket lock.

Last 2 paragraph of the squash to commit should be replaced with:

"""
It leverages the fact that only the MPC/first subflow can gracefully
fail to avoid unneeded subflows traversal: the failing subflow can
be only msk->first.

A new 'fail_tout' field is added to the subflow context to record the
MP_FAIL response timeout and use such field to reliably share the
timeout timer between the MP_FAIL event and the MPTCP socket close timeout.

Finally, a new ack is generated to send out MP_FAIL notification as soon
as we hit the relevant condition, instead of waiting a possibly unbound
time for the next data packet.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       |  4 +++-
 net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  | 24 ++++++++++++++++++--
 4 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3c7f07bb124e..45e2a48397b9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -305,13 +305,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
 
-	if (!msk->fail_ssk) {
+	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map");
 
 		subflow->send_mp_fail = 1;
 		subflow->send_infinite_map = 1;
+		tcp_send_ack(sk);
 	} else {
 		pr_debug("MP_FAIL response received");
+		WRITE_ONCE(subflow->fail_tout, 0);
 	}
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b74c6ca52aee..2910105a99b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -500,7 +500,7 @@ static void mptcp_set_timeout(struct sock *sk)
 	__mptcp_set_timeout(sk, tout);
 }
 
-static bool tcp_can_send_ack(const struct sock *ssk)
+static inline bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
@@ -2503,24 +2503,56 @@ static void __mptcp_retrans(struct sock *sk)
 		mptcp_reset_timer(sk);
 }
 
+/* schedule the timeout timer for the nearest relevant event: either
+ * close timeout or mp_fail timeout. Both of them could be not
+ * scheduled yet
+ */
+void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
+{
+	struct sock *sk = (struct sock *)msk;
+	unsigned long timeout, close_timeout;
+
+	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
+		return;
+
+	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
+
+	/* the following is basically time_min(close_timeout, fail_tout) */
+	if (!fail_tout)
+		timeout = close_timeout;
+	else if (!sock_flag(sk, SOCK_DEAD))
+		timeout = fail_tout;
+	else if (time_after(close_timeout, fail_tout))
+		timeout = fail_tout;
+	else
+		timeout = close_timeout;
+
+	sk_reset_timer(sk, &sk->sk_timer, timeout);
+}
+
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 {
-	struct sock *ssk = msk->fail_ssk;
+	struct sock *ssk = msk->first;
 	bool slow;
 
+	if (!ssk)
+		return;
+
 	pr_debug("MP_FAIL doesn't respond, reset the subflow");
 
 	slow = lock_sock_fast(ssk);
 	mptcp_subflow_reset(ssk);
+	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
 
-	msk->fail_ssk = NULL;
+	mptcp_reset_timeout(msk, 0);
 }
 
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
 	struct sock *sk = &msk->sk.icsk_inet.sk;
+	unsigned long fail_tout;
 	int state;
 
 	lock_sock(sk);
@@ -2557,7 +2589,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
-	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
+	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
+	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
 
 unlock:
@@ -2585,8 +2618,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
-	msk->fail_ssk = NULL;
-	msk->fail_tout = 0;
 
 	mptcp_pm_data_init(msk);
 
@@ -2807,7 +2838,9 @@ static void __mptcp_destroy_sock(struct sock *sk)
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool do_cancel_work = false;
+	unsigned long fail_tout = 0;
 
 	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
@@ -2825,10 +2858,13 @@ static void mptcp_close(struct sock *sk, long timeout)
 cleanup:
 	/* orphan all the subflows */
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
-	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
 
+		if (ssk == msk->first)
+			fail_tout = subflow->fail_tout;
+
 		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
 	}
@@ -2837,13 +2873,13 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
 	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
+		mptcp_reset_timeout(msk, fail_tout);
 	}
 	release_sock(sk);
 	if (do_cancel_work)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e420a441c056..1d2d71711872 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,8 +306,6 @@ struct mptcp_sock {
 
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
-	struct sock	*fail_ssk;
-	unsigned long	fail_tout;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -483,6 +481,7 @@ struct mptcp_subflow_context {
 	u8	stale_count;
 
 	long	delegated_status;
+	unsigned long	fail_tout;
 
 	);
 
@@ -663,6 +662,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
+void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout);
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 98b12a9c4eb5..040901c1f40c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1158,6 +1158,27 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 		return !subflow->fully_established;
 }
 
+static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	unsigned long fail_tout;
+
+	/* grecefull failure can happen only on the MPC subflow */
+	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
+		return;
+
+	/* we don't need extreme accuracy here, use a zero fail_tout as special
+	 * value meaning no fail timeout at all;
+	 */
+	fail_tout = jiffies + TCP_RTO_MAX;
+	if (!fail_tout)
+		fail_tout = 1;
+	WRITE_ONCE(subflow->fail_tout, fail_tout);
+	tcp_send_ack(ssk);
+
+	mptcp_reset_timeout(msk, subflow->fail_tout);
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1233,8 +1254,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				while ((skb = skb_peek(&ssk->sk_receive_queue)))
 					sk_eat_skb(ssk, skb);
 			} else {
-				msk->fail_ssk = ssk;
-				msk->fail_tout = jiffies + TCP_RTO_MAX;
+				mptcp_subflow_fail(msk, ssk);
 			}
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return true;
-- 
2.35.3

