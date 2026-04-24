Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3332FFFA4
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039767; cv=none; b=QfMyaNJ5fHflR3lk/zH0N40NI6F4R4S2pQ7SB1STfrq3A5grvisKPhrg5JnN1k3Ub4Yu9fkmZAaJxLUTRGVgSptdn5z86l8HwcDWyKdBYPYencfiy3I4HZD6v53SoM1xETCy/P9WipFuqc8WZ9sxllskOEe+R5YCv/8xFFKcw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039767; c=relaxed/simple;
	bh=yn8gArUsMp6IUy0gfJ9mp4Dbjxl1SM0isoBQdCvT86E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V/DN6urr0AYVxQGTcXWZuKk7QuMg8TEQAuLVvRq9KeSNw0nL6zK+6kfh5w1WNvIXji5mUGEHUHpazrudYZbp0I0ll9YVQSFRnYRDvNXyWwoFSajiUefSS78B1PMDi+XJNRNDVGBSDtHg1xtbqpA81sSQzE74mK2chGCdI2hA7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkPIt9RP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkPIt9RP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4TqL3/645XPBUisaZ1yLJTyUNsZsqkFv6eyLb+VhZY=;
	b=ZkPIt9RPToyo/xmQ7ZugQokTZApSvrlQjXG0T1ptRw+rJcQ/kohpT6UXD4BMa+8xTpHRJF
	/3VzwVvXxzoQOU6N4FJ3quo124J+iLJZDdvZVWbJncWJ53fdWc+Pkx65UjtzuLW/yHxRwl
	pk0sC8PX4ELVi5W5fGX/YWyJuB51/T4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-JpjrpAeuN46KuXgoPRhXVQ-1; Fri,
 24 Apr 2026 10:09:17 -0400
X-MC-Unique: JpjrpAeuN46KuXgoPRhXVQ-1
X-Mimecast-MFC-AGG-ID: JpjrpAeuN46KuXgoPRhXVQ_1777039755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA99D1808986;
	Fri, 24 Apr 2026 14:09:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D8C330078DC;
	Fri, 24 Apr 2026 14:09:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 3/9] mptcp: remove CB offset field
Date: Fri, 24 Apr 2026 16:08:36 +0200
Message-ID: <b2bd917110605374c618c8e951a9d4338e5f3c59.1777038888.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jvGDbmBuYIp4cOHNbZZmb9YpDGI8KjH6rMVZ81O6QV4_1777039755
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Instead, to track the bytes already consumed inside each skb, use a
msk-level new field, tracking the amount of bytes already copied to
user-space, alike what TCP is already doing.

This simplify a bit the code and will make possible the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: this has the potential to break almost everything. On the flip
side the CB->offset vs copied_seq difference from TCP is quite confusing
and removing it will be for the good.

Also this explicitly relays on "mptcp: do not drop partial packets" to
avoid dropping partially consumed packets
---
 net/mptcp/fastopen.c |  1 -
 net/mptcp/protocol.c | 30 +++++++++++-------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  1 +
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 82ec15bcfd7f..fe579e45ecdf 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -44,7 +44,6 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
-	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad0a289b544b..c0b77d77c268 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -161,7 +161,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 
 	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
 	    unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
-	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > (limit >> 3)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
@@ -343,8 +342,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
-			   int copy_len)
+static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
@@ -353,9 +351,8 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
 	 */
-	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
-	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
-	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) - offset;
+	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
@@ -728,7 +725,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			mptcp_init_skb(ssk, skb, offset, len);
+			mptcp_init_skb(ssk, skb, offset);
 
 			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
@@ -795,8 +792,6 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
-			MPTCP_SKB_CB(skb)->offset += delta;
-			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
@@ -2050,7 +2045,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 
 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
-		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
+		u32 delta, offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		u32 data_len = skb->len - offset;
 		u32 count;
 		int err;
@@ -2088,11 +2083,9 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 
 		if (!(flags & MSG_PEEK)) {
 			msk->bytes_consumed += count;
-			if (count < data_len) {
-				MPTCP_SKB_CB(skb)->offset += count;
-				MPTCP_SKB_CB(skb)->map_seq += count;
+			msk->copied_seq += count;
+			if (count < data_len)
 				break;
-			}
 
 			mptcp_eat_recv_skb(sk, skb);
 		} else {
@@ -3457,6 +3450,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	WRITE_ONCE(msk->copied_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -4340,7 +4334,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
-		offset = MPTCP_SKB_CB(skb)->offset;
+		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
 			*off = offset;
 			return skb;
@@ -4382,11 +4376,9 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		copied += count;
 
 		msk->bytes_consumed += count;
-		if (count < data_len) {
-			MPTCP_SKB_CB(skb)->offset += count;
-			MPTCP_SKB_CB(skb)->map_seq += count;
+		msk->copied_seq += count;
+		if (count < data_len)
 			break;
-		}
 
 		mptcp_eat_recv_skb(sk, skb);
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..dd437643e604 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -128,7 +128,6 @@
 struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
-	u32 offset;
 	u8  has_rxtstamp;
 	u8  cant_coalesce;
 };
@@ -289,6 +288,7 @@ struct mptcp_sock {
 	u64		bytes_sent;
 	u64		snd_nxt;
 	u64		bytes_received;
+	u64		copied_seq;
 	u64		ack_seq;
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c57ed27a5fb0..2a8d5da4aaea 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -494,6 +494,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->copied_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
-- 
2.53.0

