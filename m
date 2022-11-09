Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB182C9E
	for <mptcp@lists.linux.dev>; Wed,  9 Nov 2022 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668005566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIMeHOuBx7qBys0Kp4EMRrdRCnBrgcjuX4DpWCUOgBI=;
	b=OFVeQm49LR38C+8MvAaIsLs64TCYoMbXGEaBppzdWokTW4MR5Kn7Q3X9HBzEz0VxDLBBSv
	/ytI93mqazSmeBiPC/22owfWuG0JrAQAwQfWaqyB2nc/L6lvJFmzo+poD4s3cSnZU+e9zg
	ZOukKCp+USNaab7KfZEYdkm4h4qXSXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-BGhTzpttMoef_qxEoA5eKg-1; Wed, 09 Nov 2022 09:52:43 -0500
X-MC-Unique: BGhTzpttMoef_qxEoA5eKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61A878027EC;
	Wed,  9 Nov 2022 14:52:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0AF2024CC6;
	Wed,  9 Nov 2022 14:52:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH net-next] Squash-to: "mptcp: implement delayed seq generation for passive fastopen"
Date: Wed,  9 Nov 2022 15:52:30 +0100
Message-Id: <0c2a587290902feb0c3c0a2f5c7f04e788d63751.1667993471.git.pabeni@redhat.com>
In-Reply-To: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
References: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A bunch of fixups:
- must use sk->sk_receive_queue instead of msk->receive_queue, as the
  latter is protected via the msk socket lock, quite the first is under
  msk data lock proteciton

- can't fully init skb MPTCP_CB at
  subflow_fastopen_send_synack_set_params() time, as the msk ack_seq is
  not known yet. Instead put it some dunny seq and update it as needed
  when the peer key is received. Note that we need the correct seq value
  only to handle correctly coalescing of later skb, that is, only if
  the first data skb is still in the receive queue when the next one
  comes in

- must prevent subflow_syn_recv_sock() from switching the newly created
  mptfo socket to fully established status, as only the initial syn is
  recived and we still lack the peer's key

- hook mptcp_gen_msk_ackseq_fastopen() to fully established swiching

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 56 ++++++++++++++++++++++++++++----------------
 net/mptcp/options.c  | 14 +++++------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  5 +++-
 4 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 2a36a83cd846..10f901e281f6 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -7,13 +7,11 @@
 void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
 					     struct request_sock *req)
 {
-	struct tcp_request_sock *treq = tcp_rsk(req);
 	struct sock *ssk = subflow->tcp_sock;
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
-	u32 offset;
 
 	msk = mptcp_sk(sk);
 	tp = tcp_sk(ssk);
@@ -22,45 +20,63 @@ void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subfl
 	msk->is_mptfo = 1;
 
 	skb = skb_peek(&ssk->sk_receive_queue);
+	if (WARN_ON_ONCE(!skb))
+		return;
 
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
 	skb_orphan(skb);
 
-	/* set the skb mapping */
-	tp->copied_seq += tp->rcv_nxt - treq->rcv_isn - 1;
-	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	subflow->ssn_offset = tp->copied_seq - 1;
-
-	/* initialize MPTCP_CB */
-	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
-				     (skb->len - offset);
-	MPTCP_SKB_CB(skb)->offset = offset;
+	/* We copy the fastopen data, but that don't belown to the mptcp sequence
+	 * space, need to offset it in the subflow sequence, see mptcp_subflow_get_map_offset()
+	 */
+	tp->copied_seq += skb->len;
+	subflow->ssn_offset += skb->len;
+
+	/* initialize a dummy sequence number, we will update it at MPC
+	 * completion, if needed
+	 */
+	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
+	MPTCP_SKB_CB(skb)->end_seq = 0;
+	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	mptcp_data_lock(sk);
 
 	mptcp_set_owner_r(skb, sk);
-	__skb_queue_tail(&msk->receive_queue, skb);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
 
-	(sk)->sk_data_ready(sk);
+	sk->sk_data_ready(sk);
 
 	mptcp_data_unlock(sk);
 }
 
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   struct mptcp_options_received mp_opt)
+				   const struct mptcp_options_received *mp_opt)
 {
+	struct sock *sk = (struct sock *)msk;
+	struct sk_buff *skb;
 	u64 ack_seq;
 
-	WRITE_ONCE(msk->can_ack, true);
-	WRITE_ONCE(msk->remote_key, mp_opt.sndr_key);
-	mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+	mptcp_crypto_key_sha(mp_opt->sndr_key, NULL, &ack_seq);
 	ack_seq++;
+
+	mptcp_data_lock(sk);
+	WRITE_ONCE(msk->can_ack, true);
 	WRITE_ONCE(msk->ack_seq, ack_seq);
-	pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
 	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+	msk->remote_key = mp_opt->sndr_key;
+	skb = skb_peek_tail(&sk->sk_receive_queue);
+	if (skb) {
+		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
+		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx", sk,
+			MPTCP_SKB_CB(skb)->map_seq,  msk->ack_seq + MPTCP_SKB_CB(skb)->map_seq,
+			MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
+		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
+		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
+	}
+
+	pr_debug("msk=%p ack_seq=%llx", msk, msk->ack_seq);
+	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ca54a08aa0a3..398f5afac124 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -939,7 +939,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
 		    !subflow->request_join)
 			tcp_send_ack(ssk);
-		goto fully_established;
+		goto check_notify;
 	}
 
 	/* we must process OoO packets before the first subflow is fully
@@ -950,6 +950,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (TCP_SKB_CB(skb)->seq != subflow->ssn_offset + 1) {
 		if (subflow->mp_join)
 			goto reset;
+		if (msk->is_mptfo && mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+			goto set_fully_established;
 		return subflow->mp_capable;
 	}
 
@@ -960,7 +962,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		 */
 		subflow->fully_established = 1;
 		WRITE_ONCE(msk->fully_established, true);
-		goto fully_established;
+		goto check_notify;
 	}
 
 	/* If the first established packet does not contain MP_CAPABLE + data
@@ -979,11 +981,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
+set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 	mptcp_subflow_fully_established(subflow, mp_opt);
 
-fully_established:
+check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't
 	 * notify the PM: this subflow is still on the listener queue
 	 * and the PM possibly acquiring the subflow lock could race with
@@ -1213,11 +1216,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			mpext->dsn64 = 1;
 			mpext->mpc_map = 1;
 			mpext->data_fin = 0;
-
-			if (msk->is_mptfo) {
-				mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
-				mpext->data_seq = READ_ONCE(msk->ack_seq);
-			}
 		} else {
 			mpext->data_seq = mp_opt.data_seq;
 			mpext->subflow_seq = mp_opt.subflow_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2df779c5f8cb..f805036e3c93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -849,7 +849,7 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 // Fast Open Mechanism functions begin
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   struct mptcp_options_received mp_opt);
+				   const struct mptcp_options_received *mp_opt);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
 					     struct request_sock *req);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2e3f858a73cb..ff9716e53786 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -685,6 +685,9 @@ void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 	subflow->fully_established = 1;
 	subflow->can_ack = 1;
 	WRITE_ONCE(msk->fully_established, true);
+
+	if (msk->is_mptfo)
+		mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
@@ -800,7 +803,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
 			 */
-			if (mp_opt.suboptions & OPTIONS_MPTCP_MPC)
+			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK)
 				mptcp_subflow_fully_established(ctx, &mp_opt);
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
-- 
2.38.1

