Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15140149B
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319548; cv=none; b=IJ0jcv4fQNhE2GImCS7blSTzQmk1iRRpbvSydDWFPK7Cz8CWwnZkwiC/aAzll18IoncT61TUAdGSzPxNxesDiqpa9bopwYhUQlCoJfc4Dn+UBJ4SDFIFgK7TBBC8V+yhhRH2zJiCEcMp5VtmsLxV5mh5h6Yrl3fDF/lMWOe64Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319548; c=relaxed/simple;
	bh=PzjbCP5LmS2p4tsX/Lb2omigYVVuGlhElnWXQyWd7Iw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bj65y0F7hFonNm3YbVDFq+VPdcr14WvvZWyNrd4fpFf8lFpkUnX5cwxaV8lYP2jdRUedECDELzghgRN6NC7A4tXms3FJ+CJoZTOICfQqCLGVTNaGBAe3cGp3Pbi1wY7qb8wqsDxHYokigHVo1YyXRZ4lRCDtxQLMGA4ZavG9urU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2U9l01m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2U9l01m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxI8NWf0ra8f8CoiZ4DpiTnLLBZWv72m1iMoSFdW8og=;
	b=b2U9l01mA4DZ4uouBnB8+DL5BoZuyYL2PLMla/5lw88d07C8/HSqlhTJvY15wYEtww4WyN
	mDhKE77GPCUayXaK1JTf+Teee8TVQQjQnUUEDmhZMlj9NtrijQNf6e6RmZ68CtUbkuT5XO
	UQQBiLlEZUgAm0SyEtjTysGjCAW9rEc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wgPlT1I9OZ6zP82HP6hJJQ-1; Mon,
 27 Apr 2026 15:52:24 -0400
X-MC-Unique: wgPlT1I9OZ6zP82HP6hJJQ-1
X-Mimecast-MFC-AGG-ID: wgPlT1I9OZ6zP82HP6hJJQ_1777319544
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF5F919560BE
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22C27300070A
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 08/10] mptcp: track prune recovery status
Date: Mon, 27 Apr 2026 21:52:06 +0200
Message-ID: <4790eaa2f5ccbac325da354d49116171b15d8d69.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jeDm6frA4A-wzsct5AHtqSyPwGlHT_CmxFUIOKP1ydw_1777319544
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
index 0c1d1d4da88a..2d050acad63b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1194,7 +1194,12 @@ static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
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
index 4137d587d3c5..3a6b0506d3a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -394,12 +394,14 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
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
 
@@ -410,16 +412,21 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
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
 		__mptcp_sync_rcv_sequence(sk);
 
 	if (__mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -898,6 +907,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
+	if (after(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, (u32)msk->ack_seq);
 	return moved;
 }
 
@@ -3540,6 +3551,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	msk->copied_seq = 0;
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1116a402771d..c369e0efe260 100644
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
index 6d3d0106749f..2a719146ebce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -496,6 +496,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 
-- 
2.53.0

