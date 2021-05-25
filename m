Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123370
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621964262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voo/hz+knWmOVyC8UbgUKx6hF7iLzVDYsrKElUerk9c=;
	b=E3OkWtKCESiVJEiuuyQ1M9U1gElW2VvD6myLSsJ8ZRByhSu2LZq1tWmtxs1f8MSUCCIWjx
	nfBlu52AMaaNsu8No20xwv312+A42FmS0akx2owxaL4DeVRyFf8huVOF48zVLZseqFQNLg
	ZRZfty6isCgjVcphXrjgdarQja0vB2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-DI5BoTUBMuONsl41bjRIZw-1; Tue, 25 May 2021 13:37:40 -0400
X-MC-Unique: DI5BoTUBMuONsl41bjRIZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B4C31020C36
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:39 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E210C100E113;
	Tue, 25 May 2021 17:37:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH 1/4] mptcp: wake-up readers only for in sequence data.
Date: Tue, 25 May 2021 19:37:17 +0200
Message-Id: <1a99371fbd038cfcabac5fa4fe0f983c6ea96433.1621963632.git.pabeni@redhat.com>
In-Reply-To: <cover.1621963632.git.pabeni@redhat.com>
References: <cover.1621963632.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently we relay on the subflow->data_avail field,
which is subject to races:

	ssk1
		skb len = 500 DSS(seq=1, len=1000, off=0)
		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL

	ssk2
		skb len = 500 DSS(seq = 501, len=1000)
		# data_avail == MPTCP_SUBFLOW_DATA_AVAIL

	ssk1
		skb len = 500 DSS(seq = 1, len=1000, off =500)
		# still data_avail == MPTCP_SUBFLOW_DATA_AVAIL,
		# as the skb is covered by a pre-existing map,
		# which was in-sequence at reception time.

Instead we can explicitly check if some has been received in-sequence,
propagating the info from __mptcp_move_skbs_from_subflow().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 25 +++++++++----------------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 15 +++++----------
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb029dd4ff5e..e85ec0e84e06 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -677,7 +677,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
-static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
+static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
@@ -698,6 +698,8 @@ static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	if (mptcp_pending_data_fin(sk, NULL))
 		mptcp_schedule_work(sk);
 	mptcp_data_unlock(sk);
+
+	return moved > 0;
 }
 
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
@@ -705,7 +707,6 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int sk_rbuf, ssk_rbuf;
-	bool wake;
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -714,28 +715,20 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	if (unlikely(subflow->disposable))
 		return;
 
-	/* move_skbs_to_msk below can legitly clear the data_avail flag,
-	 * but we will need later to properly woke the reader, cache its
-	 * value
-	 */
-	wake = subflow->data_avail == MPTCP_SUBFLOW_DATA_AVAIL;
-	if (wake)
-		set_bit(MPTCP_DATA_READY, &msk->flags);
-
 	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
 	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
 	if (unlikely(ssk_rbuf > sk_rbuf))
 		sk_rbuf = ssk_rbuf;
 
-	/* over limit? can't append more skbs to msk */
+	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
 	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
-		goto wake;
-
-	move_skbs_to_msk(msk, ssk);
+		return;
 
-wake:
-	if (wake)
+	/* Wake-up the reader only for in-sequence data */
+	if (move_skbs_to_msk(msk, ssk)) {
+		set_bit(MPTCP_DATA_READY, &msk->flags);
 		sk->sk_data_ready(sk);
+	}
 }
 
 static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 520098188d80..2f22046a7565 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -374,7 +374,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 enum mptcp_data_avail {
 	MPTCP_SUBFLOW_NODATA,
 	MPTCP_SUBFLOW_DATA_AVAIL,
-	MPTCP_SUBFLOW_OOO_DATA
 };
 
 struct mptcp_delegated_action {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6b1cd4257edf..f8323a759af1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1137,18 +1137,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
 		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
 			 ack_seq);
-		if (ack_seq == old_ack) {
-			subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
-			break;
-		} else if (after64(ack_seq, old_ack)) {
-			subflow->data_avail = MPTCP_SUBFLOW_OOO_DATA;
-			break;
+		if (unlikely(before64(ack_seq, old_ack))) {
+			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
+			continue;
 		}
 
-		/* only accept in-sequence mapping. Old values are spurious
-		 * retransmission
-		 */
-		mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
+		subflow->data_avail = MPTCP_SUBFLOW_DATA_AVAIL;
+		break;
 	}
 	return true;
 
-- 
2.26.3

