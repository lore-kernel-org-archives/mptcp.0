Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD231CA4E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297233; cv=none; b=tMXAfKUGYfhuvur1ZaeMuQaRIBcUgXejJKUO0gjbKcVzYyUf0XBKeT5fTStnVU0l8AeqOWz+DoHd8WsVqnpyxti87HxrLJVeS/S+w8VXRlzgK0XauofcWulcQ91/BODLOqsB9DDHMhgPWoHjreZIqzXVRZIPEkg6Bnc4psaz3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297233; c=relaxed/simple;
	bh=mbdu3YO/yLycgRg8w/z7nvqT3cY1YpD3nMHXFxZl35I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=apE4hbSDlTh5uJ9wQ2IyDQD2KHFmYwYMDgb2hALqdefp/AIpC+d+AsJfIRyr8YUz7gV3uQl6v6KBswY3X/ZCdjv2DGJsTl7n/s9i2B2Zaqr/cQ7VyA9cxNQtBUjHFQPm9lnUChxt9riigaRGTyfIXJhAhfKwgjXfB8bZaiDYR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcUspT+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcUspT+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Y+027PCZr0jJZaLZPxCmWemuOJIGAGkRZ8KHVz8pY=;
	b=EcUspT+0m2e6nYIcjZ90kB3aXhnl+4hM1FpDEKDLEGg7l2PErtGhiwgEN7hGaNdAYu0CnB
	OWFAZOonVgQMOIn+IyMbdI0oUy4i3WW6AEMuK7A88CeuZam5WW1qQbLEFypnk5Nu61ajoE
	jT7gkNZI6KFXhXuNlPPQnlhJoIRBRJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-Q3pEm3W4N1a1WHikKJV4Aw-1; Fri,
 19 Sep 2025 11:53:44 -0400
X-MC-Unique: Q3pEm3W4N1a1WHikKJV4Aw-1
X-Mimecast-MFC-AGG-ID: Q3pEm3W4N1a1WHikKJV4Aw_1758297223
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 286351800298
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AB86180035E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 04/12] mptcp: introduce the mptcp_init_skb helper.
Date: Fri, 19 Sep 2025 17:53:18 +0200
Message-ID: <df18a15a52a3884f05ad97cb53716d92bb7c8d88.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KQKx-jTvJSJwWdl99Zo4iZYRuFPpNOQbMpIFozkAKKk_1758297223
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - drop subflow argument from mptcp_init_skb()
  - change msk args to sock arg in __mptcp_move_skb()
---
 net/mptcp/protocol.c | 46 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c9fcdbaf50874..3aa03da781ba3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -326,27 +326,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
-			     struct sk_buff *skb, unsigned int offset,
-			     size_t copy_len)
+static void mptcp_init_skb(struct sock *ssk,
+			   struct sk_buff *skb, int offset, int copy_len)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct sock *sk = (struct sock *)msk;
-	struct sk_buff *tail;
-	bool has_rxtstamp;
-
-	__skb_unlink(skb, &ssk->sk_receive_queue);
-
-	skb_ext_reset(skb);
-	skb_orphan(skb);
-
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
-
-	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -358,6 +342,24 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
 
+	__skb_unlink(skb, &ssk->sk_receive_queue);
+
+	skb_ext_reset(skb);
+	skb_dst_drop(skb);
+}
+
+static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
+{
+	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sk_buff *tail;
+
+	/* try to fetch required memory from subflow */
+	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		goto drop;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -678,7 +680,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
 
-			ret = __mptcp_move_skb(msk, ssk, skb, offset, len) || ret;
+			mptcp_init_skb(ssk, skb, offset, len);
+			skb_orphan(skb);
+			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
-- 
2.51.0

