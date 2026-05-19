Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908D367B7C
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210122; cv=none; b=rGXp7c4N43BI8EEWBLItgOqO01S8/XEsS1xYA0xa3ngpF/Y9PCr/D3TtvVH6u1saPeb8Piaq9m63oVFw+OdTSgpd3H4f10I1jkpr/ftFbHcjjtQqcrDyNyki2YGSBFIRK04lfe5oOSt2kuXAmnAzx9hBDqgStvycvgtLTxquM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210122; c=relaxed/simple;
	bh=FWqTxJ0XLghGmcD1hgWHaD1IYJEXr5gCWeIYa6D5Oas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TBZUSxmGJoawrYdG4ahbRIOoojoePcXXA7+6L8UHRpzw1dXkeaqRiBDnIPILhoj6SNd35l5uHZGq60wdrjDgODw9+xHk2a7gWNzsEAg6B47AqAYL1Ty1BllV7L4TY2WlcRFCeCV/TRtb3aD8QNsRwdxhP50kJI029yNUriJRBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR4s+u2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR4s+u2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779210120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTs/fa+YsmB7b1xyoh0ERPqAN/BncFlXOmD857oeSK4=;
	b=DR4s+u2+Pn0RDrVvoD9Kpko5GedvuSiFjJDAQcI5WIEWwEepQDDqu9T+Gfg9KRmqN3NDWx
	wGokSSjB4UuFUBa1D6lWF0qx3ZBPlY+RaprjVtaASuy9v4a9hgUSc/mskSrAwUAXN7ujVz
	HZvgTKZPYqh7TpHQRrbEJytVVUz6egk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-ei3N5cDfNtmVr5ms4ts5Mg-1; Tue,
 19 May 2026 13:01:57 -0400
X-MC-Unique: ei3N5cDfNtmVr5ms4ts5Mg-1
X-Mimecast-MFC-AGG-ID: ei3N5cDfNtmVr5ms4ts5Mg_1779210116
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B524819560AE;
	Tue, 19 May 2026 17:01:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69187180056E;
	Tue, 19 May 2026 17:01:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v7 mptcp-next 5/7] mptcp: track prune recovery status
Date: Tue, 19 May 2026 19:01:39 +0200
Message-ID: <083f266c0b67226ddad01571a422346d9c0d5852.1779210016.git.pabeni@redhat.com>
In-Reply-To: <cover.1779210016.git.pabeni@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7VGg3sfxQnra072oBZFNt7VSFDQ5AY7JPeZcIz9Pz8s_1779210116
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
v6 -> v7:
  - add missing READ_ONCE() on ack_seq (sashiko was right)
  - introduce mptcp_pruned() helper, use it in __mptcp_add_backlog(), too
  - fix u64 -> u32 truncation
---
 net/mptcp/options.c  | 7 +++++++
 net/mptcp/protocol.c | 7 +++++++
 net/mptcp/protocol.h | 9 +++++++++
 net/mptcp/subflow.c  | 1 +
 4 files changed, 24 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e5d5a50a907f..f149b74cc15a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1193,6 +1193,13 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 		limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
 	}
 	ret = mptcp_mem(sk) > limit;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission.
+	 */
+	if (before64(READ_ONCE(msk->ack_seq), READ_ONCE(msk->pruned_seq)))
+		ret = false;
+
 	mptcp_data_unlock(sk);
 
 	if (ret) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f207f001c97e..8da4f43543e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -396,6 +396,7 @@ void mptcp_prune_ofo_queue(struct sock *sk, bool use_bl, u64 seq)
 		pruned = true;
 		prev = rb_prev(node);
 		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_pruned(msk, MPTCP_SKB_CB(skb)->end_seq);
 		mptcp_drop(sk, skb);
 		msk->ooo_last_skb = rb_to_skb(prev);
 
@@ -429,6 +430,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	    !__mptcp_check_fallback(msk)) {
 		mptcp_prune_ofo_queue(sk, false, MPTCP_SKB_CB(skb)->map_seq);
 		if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
+			mptcp_pruned(msk, MPTCP_SKB_CB(skb)->end_seq);
+
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 			mptcp_drop(sk, skb);
 			return false;
@@ -742,6 +745,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	limit += (limit >> 1) + 64 * 1024;
 	limit = min_t(u64, limit, UINT_MAX);
 	if (msk->backlog_len > limit && !__mptcp_check_fallback(msk)) {
+		mptcp_pruned(msk, MPTCP_SKB_CB(skb)->end_seq);
 		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
 		return;
 	}
@@ -890,6 +894,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, end_seq);
 		moved = true;
 	}
+
+	mptcp_pruned(msk, msk->ack_seq);
 	return moved;
 }
 
@@ -3539,6 +3545,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 816210ed2630..2590aceb7c98 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -303,6 +303,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u64		pruned_seq;		/* If strictly above ack_seq,
+						 * the highest seq pruned.
+						 */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
@@ -837,6 +840,12 @@ void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
 void mptcp_prune_ofo_queue(struct sock *sk, bool use_bl, u64 seq);
 
+static inline void mptcp_pruned(struct mptcp_sock *msk, u64 seq)
+{
+	if (after64(seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, seq);
+}
+
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
 void mptcp_local_address(const struct sock_common *skc,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..cc75d914c1b5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -494,6 +494,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
-- 
2.54.0

