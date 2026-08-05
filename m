Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11E47ECCC
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946654; cv=none; b=fVYe5aADV1dGrcPsbWKAzVQRwtxpxmcgdsilPwyKjPaD2YgmC8VvR7TBrW01egqNxYdp9ZlLjHi4ux2squK8qmxJnryxzML3Z9khWhPXhJWB6DcelEyT5rtDAILvzPamrajfDLPFlX96/31vjBr5HYZDnmgGp8wYys/1V4H418I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946654; c=relaxed/simple;
	bh=T/B0l6DjXDtVHE8YG0ZNjLd9fPDPQbB3NgHDbcrVzL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UhFUI/WRTQe6MYPc5jqbEOJW1/FmHUM+Q7kPOjOcs7uH6avg8sPUMI0vcrk5Q1RiYqiqoaH+WtAeWJO/xfy1pxeZM8DAtwA5isw6ROVjEmYAXA4R+j4rQWTl+GIg8oscym5rjP+vKgXM+QBuSTJ/Tr+67WjVU8xean/GaBFhXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpCu4fpu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpCu4fpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEmQFsy3K6xAm2T7yVuEBexUYQFETYR8ZXjIOmVIeSM=;
	b=bpCu4fput4FWP3vv0YNt1YjiIqfM8pJTdqPEvFxWRFSTZtZj0ZOwuRzxUUdideTGFzF/Oe
	U2482UVWhybctXrjNU85PSVmes8Htp1xQTslzrstrbpFwYPqa0oxQXf01iue2hQaZPF/Hq
	OF5VkP6eoK31VAbfKXBqvl4MrubADuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-aqXHtgtTNouAHxZxWV89wg-1; Wed,
 05 Aug 2026 12:17:31 -0400
X-MC-Unique: aqXHtgtTNouAHxZxWV89wg-1
X-Mimecast-MFC-AGG-ID: aqXHtgtTNouAHxZxWV89wg_1785946650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32F3C19560B7
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75AE41800347
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 7/7] mptcp: implemented OoO queue pruning
Date: Wed,  5 Aug 2026 18:17:14 +0200
Message-ID: <d752484304c0615fcc6972384f8312a8bb18bf9f.1785943854.git.pabeni@redhat.com>
In-Reply-To: <cover.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t1Ik_mEQdhASqpwcC9dkdjeolJc4mqhpKVgtzdyZAdY_1785946650
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When moving incoming skbs in the msk receive queue and the latter
is above limits, prune it as needed quite alike what TCP is doing
at the subflow level. The main difference relies in the stop condition:
since MPTCP does not perform collapsing, it's better off dropping the
bare minimum to fit the (newer) incoming packet.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v<n> -> v<n+1>:
  - prune only for new data
  - reorganize the code to follow more closely TCP
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 81 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ef65e2df709f..2569385bab7c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 9271205f682e..3a3425e258a7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
+	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1181d733bc4b..fa41a8c33dad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -242,6 +242,65 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	return false;
 }
 
+/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
+ * socket is under memory limit.
+ */
+static void mptcp_prune_ofo_queue(struct sock *sk,
+				  const struct sk_buff *in_skb)
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
+		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
+			    MPTCP_SKB_CB(skb)->map_seq))
+			break;
+
+		pruned = true;
+		prev = rb_prev(node);
+		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb);
+		msk->ooo_last_skb = rb_to_skb(prev);
+
+		mem = (unsigned int)sk_rmem_alloc_get(sk);
+		if (mem <= sk->sk_rcvbuf)
+			break;
+
+		node = prev;
+	} while (node);
+
+	if (pruned)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNED);
+}
+
+/* The stack can't drop packets for fallback socket at the msk level, or the
+ * stream will break.
+ */
+static bool mptcp_can_ingest(const struct sock *sk)
+{
+	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
+			__mptcp_check_fallback(mptcp_sk(sk));
+}
+
+static bool mptcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb)
+{
+	if (!mptcp_can_ingest(sk)) {
+		mptcp_prune_ofo_queue(sk, skb);
+		return mptcp_can_ingest(sk);
+	}
+	return true;
+}
+
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -253,6 +312,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
+	if (!mptcp_try_rmem_schedule(sk, skb)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return;
+	}
+
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
@@ -387,19 +452,15 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	/* Can't drop packets for fallback socket this late, or the stream
-	 * will break.
-	 */
-	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
-	    !__mptcp_check_fallback(msk)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		mptcp_drop(sk, skb);
-		return false;
-	}
-
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 insert:
+		if (!mptcp_try_rmem_schedule(sk, skb)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+			mptcp_drop(sk, skb);
+			return false;
+		}
+
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
-- 
2.55.0

