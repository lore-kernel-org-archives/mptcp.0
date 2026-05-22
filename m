Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBB38D3F8
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486271; cv=none; b=OZqI3tqbi7TkbWk7Nno8Tci73Qkh87bUhYEFo58EfVxvRSgBj+a/t7ORVisNDvi5z6awf50USW9baCzvx1CTHje8tz8Xd+MvWgASSgXVqi7PlrUxhsfMzEntFgYizJdxa3w4p4mFrTi9snyp7oGcGKa5tWKaTYs6oTccuz0F0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486271; c=relaxed/simple;
	bh=o13NYolT5k+nEfLd27KLp4le6KIvNjMSLUhFnp3jLPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=paNIkuleZxZBPUqZILcGJS3F0hMxKWwxFymsEA7WdBFeNe9LDadmCDcBWbQrENAr8QaLu7cxxrGjs1up49hApvYHHcXnhGkQDmOBH5cfA2iT5sqtYGlHaCMO3xSTflZp1YmBszVUsNJbQOD1VmgNhxs7zh9IXQNDBWse0BfxUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gf+w1UOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf+w1UOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779486268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quWSaWnMw4mZ3M5OuK9L7Q3zwSS0dWlde40/ujdEQcY=;
	b=gf+w1UOtFioEgVGvTZ6cQa49LgFmNF0eEBNJHZIKybaRz/LBUkq7l2xmUjYOjnm8qW0cXs
	PnHn5NLsAmpr6jgdWLEUd0cfv2SgSWj6orjILCSDfayiUvSlla++L/YMndXyN7TtGEwuMF
	0oAfaHxClgEgTwVAElfIK/lFLtQ4/l8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-VT8UmyavPtWy1OUGMxktRg-1; Fri,
 22 May 2026 17:44:22 -0400
X-MC-Unique: VT8UmyavPtWy1OUGMxktRg-1
X-Mimecast-MFC-AGG-ID: VT8UmyavPtWy1OUGMxktRg_1779486259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA0E1956089;
	Fri, 22 May 2026 21:44:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EB2F18004A3;
	Fri, 22 May 2026 21:44:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v8 mptcp-next 7/9] mptcp: implemented OoO queue pruning
Date: Fri, 22 May 2026 23:43:48 +0200
Message-ID: <b67f85e91abafcdc87d4b0b8e479f715489ed6f2.1779485511.git.pabeni@redhat.com>
In-Reply-To: <cover.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2HCtn-3xzbUPZmww3HX0SVaEfbX4A1MOPTyY60nzJhE_1779486259
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Leverage the hybrid helpers to implement the receive queue and OoO queue
collapsing at ingress time when reaching memory bounds.

If the msk is owned by the user-space at incoming skb time, perform the
pruning in the release_cb. The prune check is additionally performed
when the skb reaches the msk-level queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7:
 - fix u64 -> u32 truncation

v2 -> v3:
 - deal with unsynced TFO skb at prune time - only possible when pruning
   in mptcp_over_limit()

v1 -> v2:
 - collapse rcv queue, too
 - deal with MPC map, too
 - drop left-over sentence in the commit message

RFC -> v1:
 - use data_seq only when available
 - avoid ack_seq lockless access
 - drop limit on fallback
 - collapse rcvqueue, too
 - drop only when pruning is not possible and over rcvbuf * 2

Note:
 - sashiko can be confused about fwd memory lifecycle (I can
 understand that :). Any exceeding amount of fwd allocated memory
 is always released by the next sk_mem_uncharge() - i.e. fwd memory
 is not tied to the current skb.
 - AFAICS KASAN handles bitmap variables in a sane way, and sashiko
 doesn't know about that
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ef65e2df709f..d9bd4f4afcc0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c84eb853d499..18f35f7e0a2d 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
+	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 03d6f8658467..f446e22148b9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -373,6 +373,43 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspired" from the TCP version */
+static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct rb_node *node, *prev;
+	bool pruned = false;
+	u64 mem;
+
+	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return;
+
+	node = &msk->ooo_last_skb->rbnode;
+
+	do {
+		struct sk_buff *skb = rb_to_skb(node);
+
+		/* Stop pruning if the incoming skb would land in OoO tail. */
+		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
+			break;
+
+		pruned = true;
+		prev = rb_prev(node);
+		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb);
+		msk->ooo_last_skb = rb_to_skb(prev);
+
+		mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
+		if (mem < sk->sk_rcvbuf)
+			break;
+
+		node = prev;
+	} while (node);
+
+	if (pruned)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -386,9 +423,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
 	    !__mptcp_check_fallback(msk)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		mptcp_drop(sk, skb);
-		return false;
+		mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq);
+		if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+			mptcp_drop(sk, skb);
+			return false;
+		}
 	}
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
-- 
2.54.0

