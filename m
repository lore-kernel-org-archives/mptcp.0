Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889D68
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638812097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqOgRXddF588gihmpOScUBIy3djtxZknyPx0u3WZ/oU=;
	b=JelzMk3lTZcb0pVaCwGllz+pn1qWTywWiSSu9eCZ2wTQkVF1w+s7Ovz6+/ytE2POWGiBQu
	umSlILrB+XB0XX0Rghj5nCyuCTh/HZ2xz5Iyz4L4FNJzoXiQyUC0PQbToK5TG2N1/QLH3b
	9xdDpIgnJ3aFWEMS2yqBjyr0Wd/4EfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-uQolgJYMOMCQAdEnPfC0dA-1; Mon, 06 Dec 2021 12:34:56 -0500
X-MC-Unique: uQolgJYMOMCQAdEnPfC0dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62DF81EE62
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:55 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 245CD4ABAF
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: avoid atomic bit manipulation when possible
Date: Mon,  6 Dec 2021 18:34:47 +0100
Message-Id: <f0535e76ebd1dcaa4ec8f5e507ba8c4c5002b793.1638811854.git.pabeni@redhat.com>
In-Reply-To: <cover.1638811854.git.pabeni@redhat.com>
References: <cover.1638811854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++---------------------
 net/mptcp/protocol.h | 18 ++++++++++-------
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38651c80b321..42c382d0eb01 100644
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
+		mptcp_sk(sk)->push_pending |= MPTCP_PUSH_PENDING;
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
@@ -2859,7 +2858,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_destroy_common(msk);
 	msk->last_snd = NULL;
-	msk->flags = 0;
+	WRITE_ONCE(msk->flags, 0);
+	msk->cb_flags = 0;
+	msk->push_pending = 0;
 	msk->recovery = false;
 	msk->can_ack = false;
 	msk->fully_established = false;
@@ -3040,7 +3041,7 @@ void __mptcp_data_acked(struct sock *sk)
 	if (!sock_owned_by_user(sk))
 		__mptcp_clean_una(sk);
 	else
-		set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
 
 	if (mptcp_pending_data_fin_ack(sk))
 		mptcp_schedule_work(sk);
@@ -3059,22 +3060,22 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		else if (xmit_ssk)
 			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
 	} else {
-		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 	}
 }
 
+#define MPTCP_FLAGS_PROCESS_CTX_NEED (MPTCP_PUSH_PENDING | \
+				      MPTCP_RETRANSMIT | \
+				      MPTCP_FLUSH_JOIN_LIST)
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
 
@@ -3085,7 +3086,8 @@ static void mptcp_release_cb(struct sock *sk)
 		 *    datapath acquires the msk socket spinlock while helding
 		 *    the subflow socket lock
 		 */
-
+		msk->push_pending = 0;
+		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
 			__mptcp_flush_join_list(sk);
@@ -3101,11 +3103,11 @@ static void mptcp_release_cb(struct sock *sk)
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
@@ -3147,7 +3149,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 		if (!sock_owned_by_user(sk))
 			__mptcp_subflow_push_pending(sk, ssk);
 		else
-			set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
@@ -3267,7 +3269,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	} else {
 		sock_hold(ssk);
 		list_add_tail(&subflow->node, &msk->join_list);
-		set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->flags);
+		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
 	}
 	mptcp_data_unlock(parent);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a140aec68b3..fca045f1936f 100644
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
@@ -243,6 +245,8 @@ struct mptcp_sock {
 	u32		token;
 	int		rmem_released;
 	unsigned long	flags;
+	unsigned long	cb_flags;
+	unsigned long	push_pending;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 536a322a6fd0..09225b57c7f6 100644
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
 
@@ -1280,7 +1280,7 @@ static void subflow_error_report(struct sock *ssk)
 	if (!sock_owned_by_user(sk))
 		__mptcp_error_report(sk);
 	else
-		set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->flags);
+		__set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->cb_flags);
 	mptcp_data_unlock(sk);
 }
 
-- 
2.33.1

