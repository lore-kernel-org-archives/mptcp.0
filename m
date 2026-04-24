Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF12AD3D
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039768; cv=none; b=mDrorpyFmtQocB3SCIQpDUXlBMKeN6hZ6DB2Yva7Ogma9Lvi1iyP45jIk7qSVY8MXxfWaTxh81rUZovqyQPqI9Y8TrDrKU5JUzf2rMa0S/WznGsEWLVV32p33B1r8iMPs17toKIC2WCk0o194gclwpk5VCaH9PFHRrzmyiCgHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039768; c=relaxed/simple;
	bh=n6OA5fuG6T/SlA1ZVjvHtLz2fbCkQOcs/rclLPH4Sno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=m5t8EZj0aQ/5geWN9QwpikPCggxCgbPgYIK0s8fXk00qqcfiklHd/7hsosJf7nU+nf80u6bF7fAl0h8WYzyqeyIOQ0GyLcp8DG7ofv2LSsDtTyFTXO6Wzo9ya2XXZR8I3anOGNwegpZ1vC4HtL6lorIvE6tq63cTtSH69d4V47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9uauiDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9uauiDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aQ1vjMh9NWFbxjixA+Untf0GWwYPF8ar8JzPBmf0Ek=;
	b=b9uauiDW5DrFWeWS6YNfbXveTskUgmLDzxPpwyjFhdYiYi6CdmfmozQLxl/W/4lMSmkXgg
	aIU+RE8VpdAh+c76NH7L8svJDUkZOqsJio4rE0OfLcT/mpUBEfq6yB+9JNrJU6Q5oOCVGG
	U6pvlY4aHJ5MQmaPGVhgyXZoxTlT4To=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-C4pah452MU2MV2TQkkbVhw-1; Fri,
 24 Apr 2026 10:09:21 -0400
X-MC-Unique: C4pah452MU2MV2TQkkbVhw-1
X-Mimecast-MFC-AGG-ID: C4pah452MU2MV2TQkkbVhw_1777039760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112B5185FD05;
	Fri, 24 Apr 2026 14:09:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 567E730078D7;
	Fri, 24 Apr 2026 14:09:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 4/9] mptcp: sync mptcp skb cb layout with tcp one
Date: Fri, 24 Apr 2026 16:08:37 +0200
Message-ID: <463a0e14913560e006276ce35204fd106792a6e7.1777038888.git.pabeni@redhat.com>
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FrS1ZwJvsqRH7Av-pEeY3d7t142FtP71iJdd8S1lBbo_1777039760
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol uses a significantly different CB layout WRT TCP, as it
includes different information and use 64 bits for the sequence numbers.

As the msk-level rcvbuf buffer size is limited by the core socket code the
INT_MAX, we can safely use 32 bits for MPTCP-level sequence number. This
allow updating the MPTCP CB layout so that fields with a corresponding TCP-level
data use the same area inside the CB itself.

Add build time check the unsure the latter invariant.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
rfc -> v1:
  - keep `ack_seq` up2date
---
 net/mptcp/protocol.c | 81 ++++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  6 ++--
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c0b77d77c268..49e62f817fd6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,7 +28,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-static unsigned int mptcp_inq_hint(const struct sock *sk);
+static int mptcp_inq_hint(const struct sock *sk);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -165,7 +165,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
+	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -235,20 +235,20 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct rb_node **p, *parent;
-	u64 seq, end_seq, max_seq;
+	u32 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%x limit=%x empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
-	if (after64(end_seq, max_seq)) {
+	if (after(end_seq, max_seq)) {
 		/* out of window */
 		mptcp_drop(sk, skb);
-		pr_debug("oow by %lld, rcv_wnd_sent %llu\n",
-			 (unsigned long long)end_seq - (unsigned long)max_seq,
+		pr_debug("oow by %d, rcv_wnd_sent %llu\n",
+			 end_seq - max_seq,
 			 (unsigned long long)atomic64_read(&msk->rcv_wnd_sent));
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_NODSSWINDOW);
 		return;
@@ -273,7 +273,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	}
 
 	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
-	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
+	if (!before(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
 		parent = &msk->ooo_last_skb->rbnode;
 		p = &parent->rb_right;
@@ -285,18 +285,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	while (*p) {
 		parent = *p;
 		skb1 = rb_to_skb(parent);
-		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
 			p = &parent->rb_left;
 			continue;
 		}
-		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
-			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+		if (before(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
+			if (!after(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
 				/* All the bits are present. Drop. */
 				mptcp_drop(sk, skb);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 				return;
 			}
-			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
+			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
 				/* partial overlap:
 				 *     |     skb      |
 				 *  |     skb1    |
@@ -327,7 +327,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 merge_right:
 	/* Remove other segments covered by skb. */
 	while ((skb1 = skb_rb_next(skb)) != NULL) {
-		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
+		if (before(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
 			break;
 		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
 		mptcp_drop(sk, skb1);
@@ -349,10 +349,11 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
-	 * value
+	 * value; note that seq numbers are truncated to 32bits
 	 */
 	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) - offset;
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
+	MPTCP_SKB_CB(skb)->flags = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
@@ -364,13 +365,14 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
-	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 ack_seq = msk->ack_seq;
 	struct sk_buff *tail;
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
+	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
@@ -381,7 +383,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		skb_set_owner_r(skb, sk);
 		__skb_queue_tail(&sk->sk_receive_queue, skb);
 		return true;
-	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
+	} else if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq)) {
 		mptcp_data_queue_ofo(msk, skb);
 		return false;
 	}
@@ -762,40 +764,40 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb, *tail;
+	u32 seq_delta, ack_seq;
 	bool moved = false;
 	struct rb_node *p;
-	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
+		ack_seq = msk->ack_seq;
 		skb = rb_to_skb(p);
-		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
+		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
 
-		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
-				      msk->ack_seq))) {
+		if (unlikely(!after(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
 			mptcp_drop(sk, skb);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
 			continue;
 		}
 
-		end_seq = MPTCP_SKB_CB(skb)->end_seq;
+		seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
-			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
-				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
+			pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
+				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
-		msk->bytes_received += end_seq - msk->ack_seq;
-		WRITE_ONCE(msk->ack_seq, end_seq);
+		msk->bytes_received += seq_delta;
+		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
 	return moved;
@@ -2243,19 +2245,20 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+static int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
 
 	skb = skb_peek(&sk->sk_receive_queue);
 	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+		int hint_val = (u32)READ_ONCE(msk->ack_seq) -
+			       MPTCP_SKB_CB(skb)->map_seq;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+		if (hint_val < 0)
+			return -hint_val;
 
-		return (unsigned int)hint_val;
+		return hint_val;
 	}
 
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
@@ -2363,7 +2366,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tcp_recv_timestamp(msg, sk, &tss);
 
 		if (cmsg_flags & MPTCP_CMSG_INQ) {
-			unsigned int inq = mptcp_inq_hint(sk);
+			int inq = mptcp_inq_hint(sk);
 
 			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
 		}
@@ -4583,11 +4586,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
+	({					\
+		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
+			     offsetof(struct tcp_skb_cb, tcp_field));	      \
+		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
+			     offsetofend(struct tcp_skb_cb, tcp_field));      \
+	})
+
 void __init mptcp_proto_init(void)
 {
 	struct mptcp_delegated_action *delegated;
 	int cpu;
 
+	CHK_CB_FIELD(map_seq, seq);
+	CHK_CB_FIELD(end_seq, end_seq);
+	CHK_CB_FIELD(flags, tcp_flags);
+
 	mptcp_prot.h.hashinfo = tcp_prot.h.hashinfo;
 
 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd437643e604..e541f42fca25 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -126,8 +126,10 @@
 #define MPTCP_SYNC_SNDBUF	7
 
 struct mptcp_skb_cb {
-	u64 map_seq;
-	u64 end_seq;
+	u32 map_seq;
+	u32 end_seq;
+	u32 unused;
+	u16 flags;
 	u8  has_rxtstamp;
 	u8  cant_coalesce;
 };
-- 
2.53.0

