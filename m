Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BF309EFF
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778447062; cv=none; b=u+S/GzN0GLOLk7fdLyB6MNUaphpaRwtamrKjqWZ4OoBHuZzMGtH7mSvkCDHaZcCGe30rHSdjcQcPwq9f2f+/z6rS+/DqO3XwhBZOyWD+0OI8qxtSZQ0T4Zkhph3uqRYKJijwaY/B/CTRCy0fWVG96UzXECHpfgBkei15gR1e4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778447062; c=relaxed/simple;
	bh=svpxXqGsg1+0KUCyOacNCArlRX08NuVKNvkmLNNNfmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=htvn0shb6pP4DFVP4kNfpVZUaONC6GyLtIA845oAexd2M6RlbRntDdz5LfTRwvik6SXo+WR4qEb4BQ7/z/X77EkACQrPlxAkXjjf+y9795YErBr1Qc2BnreQrAscFFr3alp3kqCDojM3blnekkzpfnqVoM3pcUpeuAMtWmYKV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKDsPm28; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKDsPm28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778447060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmUXJL8o3B1a8cpte5vMpZUn4QVyHuQHmpXQCTeekCA=;
	b=hKDsPm28/H6QvjY9OPiwpttc/HY9Gvoo0XGA+6Eb2Pcv314ytRlV/0MsMRzw4j/I9PTr8r
	BfTH7DT2+heuI5myJI4Hmu1EoL1cdnbcsATKc2Li4HqGaKK1ixaQTho/deQI5fWiupoRwe
	XJ/IJx+qrjASPwbzByafzEATVW3j4PA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-L2MHoJGGPtSeXs71Hf0O-w-1; Sun,
 10 May 2026 17:04:16 -0400
X-MC-Unique: L2MHoJGGPtSeXs71Hf0O-w-1
X-Mimecast-MFC-AGG-ID: L2MHoJGGPtSeXs71Hf0O-w_1778447056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03E94195608B;
	Sun, 10 May 2026 21:04:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F36FB180034E;
	Sun, 10 May 2026 21:04:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v5 10/12] mptcp: track prune recovery status
Date: Sun, 10 May 2026 23:03:45 +0200
Message-ID: <7bf9a71624ffd5a3cfb52025a45ceb7bd1b85ec7.1778446731.git.pabeni@redhat.com>
In-Reply-To: <cover.1778446731.git.pabeni@redhat.com>
References: <cover.1778446731.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPN_457cuGJx2wJXo1EtaYAo9PAhtXRWZFgLqujVfwA_1778447056
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After dropping any data already acked at the TCP level, the MPTCP must
avoid inducing TCP-level retransmission until the pruned data has been
successfully acked at MPTCP level. Otherwise the subflows could keep
retransmitting skbs carring OoO MPTCP data, preventing reinjections and
stalling completely the data transfer.

Explicitly keep track of the highest pruned MPTCP-level seq number and
stop dropping at TCP level until such sequence has been acked.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Notes:
 - sashiko may miss that msk->ack_seq access in mptcp_over_limit()
 happens under the msk data lock and this is raceless.
---
 net/mptcp/options.c  |  7 +++++++
 net/mptcp/protocol.c | 16 ++++++++++++++--
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5669d0a395c6..bc987ab5bdfc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1201,6 +1201,13 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
 	}
 	ret = sk_rmem_alloc_get(sk) + msk->backlog_len > limit;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission.
+	 */
+	if (before((u32)(msk->ack_seq), READ_ONCE(msk->pruned_seq)))
+		ret = false;
+
 	mptcp_data_unlock(sk);
 
 	if (ret) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6c309c73c128..baf3457d37a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -392,12 +392,14 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct rb_node *node, *prev;
 	bool pruned = false;
+	u32 pruned_seq;
 
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		return;
 
 	node = &msk->ooo_last_skb->rbnode;
 
+	pruned_seq = msk->pruned_seq;
 	do {
 		struct sk_buff *skb = rb_to_skb(node);
 
@@ -408,16 +410,21 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
 		pruned = true;
 		prev = rb_prev(node);
 		rb_erase(node, &msk->out_of_order_queue);
+		if (after(MPTCP_SKB_CB(skb)->end_seq, pruned_seq))
+			pruned_seq = MPTCP_SKB_CB(skb)->end_seq;
 		mptcp_drop(sk, skb);
 		msk->ooo_last_skb = rb_to_skb(prev);
+
 		if (atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf)
 			break;
 
 		node = prev;
 	} while (node);
 
-	if (pruned)
+	if (pruned) {
+		WRITE_ONCE(msk->pruned_seq, pruned_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+	}
 }
 
 bool __mptcp_check_prune(struct sock *sk, u32 seq)
@@ -464,6 +471,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
 	    __mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq) &&
 	    !__mptcp_check_fallback(msk)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -882,7 +891,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
-		ack_seq = msk->ack_seq;
+		ack_seq = (u32)(msk->ack_seq);
 		skb = rb_to_skb(p);
 		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
@@ -911,6 +920,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
+	if (after(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, (u32)msk->ack_seq);
 	return moved;
 }
 
@@ -3554,6 +3565,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
 	msk->copied_seq = 0;
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ae019a10e1c8..70431cde1757 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -307,6 +307,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		pruned_seq;		/* If strictly above ack_seq,
+						 * the highest seq pruned.
+						 */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8ea876bdd03..f35afe64d9cd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -496,6 +496,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 
-- 
2.54.0

