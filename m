Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D71DDF8
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686585771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=88v17oDXE8VI0UDlI7/83f2wi9zE67Qo5i6r2fkGwmo=;
	b=Jgbli959qhdr9aGgOZa88d6mlqYtQgYQXCO/TzsRZCBUejSCeUijftQDptmiOJjqo5eX0b
	KpLRQ5E4vSQPIx79DInqsO9goRltq8mJDUKNNxEhBHPRnD1iWH9a80SA7ZMKdquCT0kpiz
	DD5jw7xUEFvMoKCbxTJtYXZ1cpjYNQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-QZP_AvPcP7mp1oBgmc84fQ-1; Mon, 12 Jun 2023 12:02:49 -0400
X-MC-Unique: QZP_AvPcP7mp1oBgmc84fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B9F81D7B9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:02:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BBED51121314
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:02:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: drop legacy code.
Date: Mon, 12 Jun 2023 18:02:33 +0200
Message-Id: <3bac625cd995fdb3fc6786b599e3c413f00fc6f5.1686584494.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Thanks to the previous patch we can finally drop the "temporary hack"
used to detect rx eof.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
"previous patch" should be replace with a proper commit reference
once such patch is merged on -net, unless we target both patches on
the same tree (but this one is really net-next material, while the fix
is for -net)
---
 net/mptcp/protocol.c | 49 --------------------------------------------
 net/mptcp/protocol.h |  5 +----
 2 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f3e50065c13..feaedfd2b3eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -898,49 +898,6 @@ bool mptcp_schedule_work(struct sock *sk)
 	return false;
 }
 
-void mptcp_subflow_eof(struct sock *sk)
-{
-	if (!test_and_set_bit(MPTCP_WORK_EOF, &mptcp_sk(sk)->flags))
-		mptcp_schedule_work(sk);
-}
-
-static void mptcp_check_for_eof(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	int receivers = 0;
-
-	mptcp_for_each_subflow(msk, subflow)
-		receivers += !subflow->rx_eof;
-	if (receivers)
-		return;
-
-	if (!(sk->sk_shutdown & RCV_SHUTDOWN)) {
-		/* hopefully temporary hack: propagate shutdown status
-		 * to msk, when all subflows agree on it
-		 */
-		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
-
-		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
-		sk->sk_data_ready(sk);
-	}
-
-	switch (sk->sk_state) {
-	case TCP_ESTABLISHED:
-		inet_sk_state_store(sk, TCP_CLOSE_WAIT);
-		break;
-	case TCP_FIN_WAIT1:
-		inet_sk_state_store(sk, TCP_CLOSING);
-		break;
-	case TCP_FIN_WAIT2:
-		inet_sk_state_store(sk, TCP_CLOSE);
-		break;
-	default:
-		return;
-	}
-	mptcp_close_wake_up(sk);
-}
-
 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2193,9 +2150,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
-				mptcp_check_for_eof(msk);
-
 			if (sk->sk_shutdown & RCV_SHUTDOWN) {
 				/* race breaker: the shutdown could be after the
 				 * previous receive queue check
@@ -2726,9 +2680,6 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_pm_nl_work(msk);
 
-	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
-		mptcp_check_for_eof(msk);
-
 	mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..528586e2ed73 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,7 +113,6 @@
 /* MPTCP socket atomic flags */
 #define MPTCP_NOSPACE		1
 #define MPTCP_WORK_RTX		2
-#define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
 
@@ -481,14 +480,13 @@ struct mptcp_subflow_context {
 		send_mp_fail : 1,
 		send_fastclose : 1,
 		send_infinite_map : 1,
-		rx_eof : 1,
 		remote_key_valid : 1,        /* received the peer key from */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		local_id_valid : 1, /* local_id is correctly initialized */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 8;
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -744,7 +742,6 @@ static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
-void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
-- 
2.40.1

