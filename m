Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80B2CB3
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639583681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LV36V4Jc6PSPhljONjLZXF5UtRgzMuFLorSaXxI8R84=;
	b=FELECKgTgvgl3szDGuquBBA2HrGooSXClV534hG/mAYC4Fk1a+sZmC4JL+IEg5GGK993p1
	PTsjXWLiHkpkJiLZZDvBKgXwskJT3ST1sXLhWkye96fKSbZx4yCXnM3o9T9+cNxM0zjgf3
	5UF04p3BnatgIh9xpDcqUbgFF6hcCYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-BNx_j-3aPN6_y8H0Na_sXA-1; Wed, 15 Dec 2021 10:54:40 -0500
X-MC-Unique: BNx_j-3aPN6_y8H0Na_sXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2739B801AAB
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:54:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C5C85BD00
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:54:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next] mptcp: avoid atomic bit manipulation when possible
Date: Wed, 15 Dec 2021 16:53:37 +0100
Message-Id: <cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently the msk->flags bitmask carries both state for the
mptcp_release_cb() - mostly touched under the mptcp data lock
- and others state info touched even outside such lock scope.

As a consequence, msk->flags is always manipulated with
atomic operations.

This change splits such bitmask in two separate fields, so
that we use plain bit oper operations when touching the
cb-related info.

The MPTCP_PUSH_PENDING bit needs additional care, as it is the
only CB related field currently accessed either under the mptcp
data lock or the mptcp socket lock.
Let's add another mask just for such bit's sake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - use BIT() where appropriate
---
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++---------------------
 net/mptcp/protocol.h | 18 ++++++++++-------
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e81fd46a43c4..5a735c37cb8e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -763,7 +763,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 		if (!sock_owned_by_user(sk))
 			__mptcp_error_report(sk);
 		else
-			set_bit(MPTCP_ERROR_REPORT,  &msk->flags);
+			__set_bit(MPTCP_ERROR_REPORT,  &msk->cb_flags);
 	}
 
 	/* If the moves have caught up with the DATA_FIN sequence number
@@ -1529,9 +1529,8 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 void mptcp_check_and_set_pending(struct sock *sk)
 {
-	if (mptcp_send_head(sk) &&
-	    !test_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
-		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+	if (mptcp_send_head(sk))
+		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
@@ -2146,7 +2145,7 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 			mptcp_schedule_work(sk);
 	} else {
 		/* delegate our work to tcp_release_cb() */
-		set_bit(MPTCP_RETRANSMIT, &msk->flags);
+		__set_bit(MPTCP_RETRANSMIT, &msk->cb_flags);
 	}
 	bh_unlock_sock(sk);
 	sock_put(sk);
@@ -2858,7 +2857,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_destroy_common(msk);
 	msk->last_snd = NULL;
-	msk->flags = 0;
+	WRITE_ONCE(msk->flags, 0);
+	msk->cb_flags = 0;
+	msk->push_pending = 0;
 	msk->recovery = false;
 	msk->can_ack = false;
 	msk->fully_established = false;
@@ -3041,7 +3042,7 @@ void __mptcp_data_acked(struct sock *sk)
 	if (!sock_owned_by_user(sk))
 		__mptcp_clean_una(sk);
 	else
-		set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
 
 	if (mptcp_pending_data_fin_ack(sk))
 		mptcp_schedule_work(sk);
@@ -3060,22 +3061,22 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		else if (xmit_ssk)
 			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
 	} else {
-		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 	}
 }
 
+#define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
+				      BIT(MPTCP_RETRANSMIT) | \
+				      BIT(MPTCP_FLUSH_JOIN_LIST))
+
 /* processes deferred events and flush wmem */
 static void mptcp_release_cb(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	for (;;) {
-		unsigned long flags = 0;
-
-		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
-			flags |= BIT(MPTCP_PUSH_PENDING);
-		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
-			flags |= BIT(MPTCP_RETRANSMIT);
-		if (test_and_clear_bit(MPTCP_FLUSH_JOIN_LIST, &mptcp_sk(sk)->flags))
-			flags |= BIT(MPTCP_FLUSH_JOIN_LIST);
+		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
+				      msk->push_pending;
 		if (!flags)
 			break;
 
@@ -3086,7 +3087,8 @@ static void mptcp_release_cb(struct sock *sk)
 		 *    datapath acquires the msk socket spinlock while helding
 		 *    the subflow socket lock
 		 */
-
+		msk->push_pending = 0;
+		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
 			__mptcp_flush_join_list(sk);
@@ -3102,11 +3104,11 @@ static void mptcp_release_cb(struct sock *sk)
 	/* be sure to set the current sk state before tacking actions
 	 * depending on sk_state
 	 */
-	if (test_and_clear_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags))
+	if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
 		__mptcp_set_connected(sk);
-	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
+	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
+	if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 		__mptcp_error_report(sk);
 
 	__mptcp_update_rmem(sk);
@@ -3148,7 +3150,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 		if (!sock_owned_by_user(sk))
 			__mptcp_subflow_push_pending(sk, ssk);
 		else
-			set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
@@ -3268,7 +3270,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	} else {
 		sock_hold(ssk);
 		list_add_tail(&subflow->node, &msk->join_list);
-		set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->flags);
+		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
 	}
 	mptcp_data_unlock(parent);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 27a510b20996..0459f164dc0b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -110,18 +110,20 @@
 /* MPTCP TCPRST flags */
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
-/* MPTCP socket flags */
+/* MPTCP socket atomic flags */
 #define MPTCP_NOSPACE		1
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
-#define MPTCP_PUSH_PENDING	6
-#define MPTCP_CLEAN_UNA		7
-#define MPTCP_ERROR_REPORT	8
-#define MPTCP_RETRANSMIT	9
-#define MPTCP_FLUSH_JOIN_LIST	10
-#define MPTCP_CONNECTED		11
+
+/* MPTCP socket release cb flags */
+#define MPTCP_PUSH_PENDING	1
+#define MPTCP_CLEAN_UNA		2
+#define MPTCP_ERROR_REPORT	3
+#define MPTCP_RETRANSMIT	4
+#define MPTCP_FLUSH_JOIN_LIST	5
+#define MPTCP_CONNECTED		6
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -249,6 +251,8 @@ struct mptcp_sock {
 	u32		token;
 	int		rmem_released;
 	unsigned long	flags;
+	unsigned long	cb_flags;
+	unsigned long	push_pending;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8716b9cb8040..557ef71309b0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -388,7 +388,7 @@ static void mptcp_set_connected(struct sock *sk)
 	if (!sock_owned_by_user(sk))
 		__mptcp_set_connected(sk);
 	else
-		set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
@@ -1279,7 +1279,7 @@ static void subflow_error_report(struct sock *ssk)
 	if (!sock_owned_by_user(sk))
 		__mptcp_error_report(sk);
 	else
-		set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
-- 
2.33.1

