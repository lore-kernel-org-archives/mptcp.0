Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA58F7D
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878791; cv=none; b=T8epxY+9j0H5599KapE8pjfXQgiQspkxrdNBeZJKLzjAUdio9WNHeFXlNtozML/pflmXhlbtm67gt0Uz4TvVMp/G16uPUiR7JWw0EDARFyxRIU9vBLj5ys/vvVs5ockhWc1IkzfXxaqjMju/dCyEduov++UcQtEsK+0VXGiS/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878791; c=relaxed/simple;
	bh=oziDYzaaZklVxmIasPfI4bZW+xuTrYq48ui7/d4w9i4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=InIXo6V32CbFprrkR+Zx4/XGGqeqc2K6bk89nLKf5W+LkPXRanO275503WPtnOxjhNi3eGvZNQRforacuJe8lADZ2hvw3YnserIpW2VmX0lFWXYhymFiEhS1F/uQDXC9dCnQwnzNkUNiq9aefLeOzWUSJ3cM7UxGj6HNDyjZLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVpFRzce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVpFRzce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779878788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXC9p6mpSxj8jwy4nA/L9GVclegUpq5nSYCF0Xf6Slo=;
	b=WVpFRzce1cT1bDIzBBuCNs5JdWUuy9DOR5RfA/GaSFqD0LFYP52hjuELrDlB8moJ39XV/F
	jJbAmFccr5xk2xgp/a2/zxaBJrSIgT6YjgFqYhoWWGGNIJtMTdkpQ0mCkDtGwcVbO6nxmz
	d2uaNq6EsjqhV5x4NedW12EoXXizf28=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ojRIDOnvMQWBxpu458QXIg-1; Wed,
 27 May 2026 06:46:26 -0400
X-MC-Unique: ojRIDOnvMQWBxpu458QXIg-1
X-Mimecast-MFC-AGG-ID: ojRIDOnvMQWBxpu458QXIg_1779878785
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1DCB180034C
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 025A119560AB
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v9 mptcp-next 4/6] mptcp: implemented OoO queue pruning
Date: Wed, 27 May 2026 12:45:34 +0200
Message-ID: <94af7b55233828311a361cdd70b837805448218a.1779876523.git.pabeni@redhat.com>
In-Reply-To: <cover.1779876523.git.pabeni@redhat.com>
References: <cover.1779876523.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zqeS4Mh4WdbvO2CWJDwcPRV8aty4R6yOnpqyHaJvWNU_1779878785
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When moving incoming skbs in the msk receive queue and the latter
is above limits, prune it as needed quite alike what TCP is doing
at the subflow level. The main difference relies in the stop condition:
since MPTCP does not perform collapsing, it's better off dropping the
bare minimum to fit the (newer) incoming packet.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v8 -> v9:
 - reworded the (obsoleted) commit message

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
 net/mptcp/protocol.c | 48 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index b0a0c51e0a13..29cb10c02ed8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -373,6 +373,45 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
+ * socket is under memory limit.
+ */
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
@@ -386,9 +425,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
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

