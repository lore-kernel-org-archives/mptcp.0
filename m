Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E31E5706
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398364; cv=none; b=VOMDLDwYWXXDLH/WvhsBpfH9auwMC4uYtBIok/nBFl4NeyHXihjnH7Fcn53SYJndIN3J/b1MEPL2sN4Do7cmVJVZWNSaavGwA7pDiu1HRFuITaRohW44huJ1lgyPEZbS4Uu5Y6WttATnpWSp+PgpsA/Hz5XuVJPA1SJE4t/WiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398364; c=relaxed/simple;
	bh=pONn5g6P9eAF4UakA+LYHbTm3KDoeS4mAucyVeBxgRk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=TPd/NT0U4yUze/+4y4AJyo0jRq616khAEmqpSxB3WI+AXBTc27qCi6kTWsnWr0OqtMx8LEAZE9J0fcM2drDgNJOUO3sqE0mOEV4s03HtT88Ta4f/O058QgS9N2OIkI2wpx9n3H213DnWS79sYnA+DoPZ0TiuPqk+mzmQn7Qz1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKjJHR7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKjJHR7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737398361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TEShlYjlm3cheyBBG2SpeopbnewmwjqTDrDdZIeMoPQ=;
	b=CKjJHR7sXBG3hFTZ/3co516SuwSVfXInPEv1CwkukAL5ldwyjOiEOFtEj63ZHD4JirgdoC
	jJ9TpfxK3/CQ//+C2+ZafqhuIscvqr82XRuRjEiAHTF0yymRRpfvrbacE5ZYR1BNip0zv1
	G0cOVmO/Lgkjj+vQT28kuthGIG5B1RY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-sMhRrOEUOwWLILUZJqnZCQ-1; Mon,
 20 Jan 2025 13:39:08 -0500
X-MC-Unique: sMhRrOEUOwWLILUZJqnZCQ-1
X-Mimecast-MFC-AGG-ID: sMhRrOEUOwWLILUZJqnZCQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF929195609E
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 18:39:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3DDE19560A3
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 18:39:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
Date: Mon, 20 Jan 2025 19:39:00 +0100
Message-ID: <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yQ5f56iM_wtF7U6rZ-bxllUClEHoNBx7PyMjgqXZdXY_1737398347
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When we will move the whole RX path under the msk socket lock, updating
the already queued skb for passive fastopen socket at 3rd ack time will
be extremely painful and race prone

The map_seq for already enqueued skbs is used only to allow correct
coalescing with later data; preventing collapsing to the first skb of
a fastopen connect we can completely remove the
__mptcp_fastopen_gen_msk_ackseq() helper.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/539

Must be applied just before commit:
 "mptcp: move the whole rx path under msk socket lock protection"

To such extent, the patch will require a little mangling, as
__mptcp_fastopen_gen_msk_ackseq() at that history point still lacks
the
	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
annotation.

I preferred such option to a cleanly applying patch for the target
place in the repo log to trigger the CI at submission time.

Optimistically sharing this only with very little testing, to distract
myself from the net-next PR burden.
---
 net/mptcp/fastopen.c | 25 ++-----------------------
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  5 ++---
 net/mptcp/subflow.c  |  3 ---
 4 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index b0f1dddfb143..b9e451197902 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -40,13 +40,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
 
-	/* initialize a dummy sequence number, we will update it at MPC
-	 * completion, if needed
-	 */
+	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
@@ -59,23 +58,3 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_data_unlock(sk);
 }
-
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *skb;
-
-	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
-	skb = skb_peek_tail(&sk->sk_receive_queue);
-	if (skb) {
-		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
-		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx\n", sk,
-			 MPTCP_SKB_CB(skb)->map_seq, MPTCP_SKB_CB(skb)->map_seq + msk->ack_seq,
-			 MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
-		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
-		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
-	}
-
-	pr_debug("msk=%p ack_seq=%llx\n", msk, msk->ack_seq);
-}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5cda189d29f2..5a75a39b9c67 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -124,7 +124,8 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	bool fragstolen;
 	int delta;
 
-	if (MPTCP_SKB_CB(from)->offset ||
+	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
+	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
@@ -299,6 +300,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
+	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b1ece280e139..2c1232bfd722 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -130,7 +130,8 @@ struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
-	u8  has_rxtstamp:1;
+	u8  has_rxtstamp;
+	u8  cant_coalesce;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
@@ -1056,8 +1057,6 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 int mptcp_nl_fill_addr(struct sk_buff *skb,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2926bdf88e42..d2caffa56bdd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -802,9 +802,6 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
-
-	if (subflow->is_mptfo)
-		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
-- 
2.47.1

