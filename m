Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2F3E0220
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909236; cv=none; b=C7GW2zunuhwzOXrq1dpQDPyPBRuZyerHJyi8713QUvyUWNrFydPlkrg0g6NCVhtmpz/rc3RJTJJFuzjq+wxmfZO2mvXp3fJChx3xRowYFOzOVH4uJfte5jn7XXc2OTNULOx7AjY3qYGMqSy/TpRDw4/hfWT/q3F5TTBY31GWGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909236; c=relaxed/simple;
	bh=KjOfhQGPHDSkiP+2l5wCdoQxPD4jjYKB5Y2wWsPpbuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LbxumJPoABHI/BKt+BQpBnjzCqNsOAB8gUwqHgBfD577YCaR+QhUpaK8vfwO7yMbV4hsQ5FtAUQYDUch+fktTVk2VI987MJw8Jis8FAPnmsjllX6OZzEa13Fh3ke4YNhGyQUufSGiZmDaOdcmJsqoOMJcAsDdtKOsrVbfNubhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LovZk/7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LovZk/7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+LWAEnnXNuFi+6q44jdSQvRu16bv2NxYIIItP7uSA4=;
	b=LovZk/7gXAvggLXEXBEheFsJnGz/m3Xj9UgqZLDAmuVZHKVRLCuQOvJD7xFqd1VExJgN3X
	Ub7HAQ2kDX3KoVn5CqqZYlA8uYD3CGGX1+eEXlZQ5fNnZ0EN1hPRMOhVq8gIV+FfvYgKY4
	T7l8Hhsj9NzZY5dqd4HwsopmH+QNylw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-xjd20ZsPNIKMa5vFliDvow-1; Mon,
 04 May 2026 11:40:31 -0400
X-MC-Unique: xjd20ZsPNIKMa5vFliDvow-1
X-Mimecast-MFC-AGG-ID: xjd20ZsPNIKMa5vFliDvow_1777909230
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68C421956095;
	Mon,  4 May 2026 15:40:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2601B19560B1;
	Mon,  4 May 2026 15:40:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 08/10] mptcp: track prune recovery status
Date: Mon,  4 May 2026 17:40:03 +0200
Message-ID: <7e3df8b4d6b29472e33b1b1fe312a627d1afa647.1777908248.git.pabeni@redhat.com>
In-Reply-To: <cover.1777908248.git.pabeni@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gSnA6x_feXeOXuyCCkNYajS5RMtxos5RLERCXz4zchI_1777909230
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
 net/mptcp/options.c  |  7 ++++++-
 net/mptcp/protocol.c | 14 +++++++++++++-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 607451166d77..061116babeff 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1200,7 +1200,12 @@ static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
 		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
 	}
 	mptcp_data_unlock(sk);
-	return ret;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission
+	 */
+	return ret &&
+	       !before(READ_ONCE(msk->ack_seq), READ_ONCE(msk->pruned_seq));
 }
 
 /* Return false when the caller must drop the packet, i.e. in case of error,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f4015a949f6f..2db6d076ce48 100644
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
@@ -462,6 +469,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		__mptcp_sync_rcv_sequence(sk);
 
 	if (__mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -896,6 +905,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
+	if (after(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, (u32)msk->ack_seq);
 	return moved;
 }
 
@@ -3539,6 +3550,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	msk->copied_seq = 0;
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ae019a10e1c8..37e3f4c95163 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -307,6 +307,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		pruned_seq;		/* If above ack_seq, highest
+						 * seq pruned.
+						 */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 130f9ed7d809..cb55d8808d49 100644
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

