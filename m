Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DB1171F
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695200974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqeBqOy0pIR/m2yNImN3WC1/K3cDkLITdnfiuKHBmd8=;
	b=A8UBjRbMsCGiMc7TZSblzwiB06Jzxh2pXjhBHgf58jqvV7wY4Cyz6bxaRhdR4sNrm9xFSq
	6dleZ57zhYiZxrM2nDXBkZ71pQ5U5Cz48zxszLzy40eNeX5XsrdaBdJKz/oIPEzkFCEcdC
	E73hWdgW2VEGJTg/fm7jdOIpeD5dO1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-IfrWLoj1Ot2KcfQRA_vSrw-1; Wed, 20 Sep 2023 05:09:19 -0400
X-MC-Unique: IfrWLoj1Ot2KcfQRA_vSrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5462803497;
	Wed, 20 Sep 2023 09:09:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDE12156701;
	Wed, 20 Sep 2023 09:09:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: fix delegated action races.
Date: Wed, 20 Sep 2023 11:09:09 +0200
Message-ID: <93a4a1fde9b8b8e1a723ae8c2938954af9388eb5.1695200723.git.pabeni@redhat.com>
In-Reply-To: <cover.1695200723.git.pabeni@redhat.com>
References: <cover.1695200723.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The delegated action infrastructure is prone to the following
race: different CPUs can try to schedule different delegated
actions on the same subflow at the same time.

Each of them will check different bits via mptcp_subflow_delegate(),
and will try to schedule the action on the related per-cpu napi
instance.

Depending on the timing, both can observe an empty delegated list
node, causing the same entry to be added simultaneously on two different
lists.

The root cause is that the delegated actions infra does not provide
a single synchronization point. Address the issue reserving an additional
bit to mark the subflow as scheduled for delegation. Acquiring such bit
guarantee the caller to own the delegated list node, and being able to
safely schedule the subflow.

Clear such bit only when the subflow scheduling is completed, ensuring
proper barrier in place.

Additionally swap the meaning of the delegated_action bitmask, to allow
the usage of the existing helper to set multiple bit at once.

Fixes: bcd97734318d ("mptcp: use delegate action to schedule 3rd ack retrans")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 28 ++++++++++++++--------------
 net/mptcp/protocol.h | 35 ++++++++++++-----------------------
 net/mptcp/subflow.c  |  6 ++++--
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a0b463f8c97..04eda1b8f7a4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3425,24 +3425,21 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
 }
 
-void mptcp_subflow_process_delegated(struct sock *ssk)
+void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
-	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
+	if (status & BIT(MPTCP_DELEGATE_SEND)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
 			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
-	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
+	if (status & BIT(MPTCP_DELEGATE_ACK))
 		schedule_3rdack_retransmission(ssk);
-		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
-	}
 }
 
 static int mptcp_hash(struct sock *sk)
@@ -3968,14 +3965,17 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		bh_lock_sock_nested(ssk);
-		if (!sock_owned_by_user(ssk) &&
-		    mptcp_subflow_has_delegated_action(subflow))
-			mptcp_subflow_process_delegated(ssk);
-		/* ... elsewhere tcp_release_cb_override already processed
-		 * the action or will do at next release_sock().
-		 * In both case must dequeue the subflow here - on the same
-		 * CPU that scheduled it.
-		 */
+		if (!sock_owned_by_user(ssk)) {
+			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
+		} else {
+			/* tcp_release_cb_override already processed
+			 * the action or will do at next release_sock().
+			 * In both case must dequeue the subflow here - on the same
+			 * CPU that scheduled it.
+			 */
+			smp_wmb();
+			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..7c7ad087d8ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -444,9 +444,11 @@ struct mptcp_delegated_action {
 
 DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 
-#define MPTCP_DELEGATE_SEND		0
-#define MPTCP_DELEGATE_ACK		1
+#define MPTCP_DELEGATE_SCHEDULED	0
+#define MPTCP_DELEGATE_SEND		1
+#define MPTCP_DELEGATE_ACK		2
 
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -564,23 +566,24 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
 
-void mptcp_subflow_process_delegated(struct sock *ssk);
+void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
 {
+	long old, mask = BIT(MPTCP_DELEGATE_SCHEDULED) | BIT(action);
 	struct mptcp_delegated_action *delegated;
 	bool schedule;
 
 	/* the caller held the subflow bh socket lock */
 	lockdep_assert_in_softirq();
 
-	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
-	 * ensures the below list check sees list updates done prior to status
-	 * bit changes
+	/* The implied barrier pairs with tcp_release_cb_override()
+	 * mptcp_napi_poll(), and ensures the below list check sees list
+	 * updates done prior to delegated status bits changes
 	 */
-	if (!test_and_set_bit(action, &subflow->delegated_status)) {
-		/* still on delegated list from previous scheduling */
-		if (!list_empty(&subflow->delegated_node))
+	old = set_mask_bits(&subflow->delegated_status, 0, mask);
+	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED))) {
+		if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
 			return;
 
 		delegated = this_cpu_ptr(&mptcp_delegated_actions);
@@ -605,20 +608,6 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
-static inline bool mptcp_subflow_has_delegated_action(const struct mptcp_subflow_context *subflow)
-{
-	return !!READ_ONCE(subflow->delegated_status);
-}
-
-static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *subflow, int action)
-{
-	/* pairs with mptcp_subflow_delegate, ensures delegate_node is updated before
-	 * touching the status bit
-	 */
-	smp_wmb();
-	clear_bit(action, &subflow->delegated_status);
-}
-
 int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 918c1a235790..0d860cb730b4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1956,9 +1956,11 @@ static void subflow_ulp_clone(const struct request_sock *req,
 static void tcp_release_cb_override(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	long status;
 
-	if (mptcp_subflow_has_delegated_action(subflow))
-		mptcp_subflow_process_delegated(ssk);
+	status = set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE_ACTIONS_MASK, 0);
+	if (status)
+		mptcp_subflow_process_delegated(ssk, status);
 
 	tcp_release_cb(ssk);
 }
-- 
2.41.0

