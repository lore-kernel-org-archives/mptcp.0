Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B97316197
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215715; cv=none; b=CRMlLPe4IuZBbWKAPRieXmLW53N+7ky7Kbpd1LFqjQ8Lx5qIbKMcMoB4uJVt1q5A9Pjg/MboA82yDTWwgj0qtsmeQ+ytEQuTanQgJNvLRXK4tKAFwJ8MaDaij4GB6fKxSBJoLzOnEy5mSZR/qgynCCb5EbrJi4Rf5is6ELhJtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215715; c=relaxed/simple;
	bh=6qYEMAcLasGEC8EmIleDSlKxeKZaIxJtUSZnxAQWa9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FrD8KsKdRk7q2Bkmfovm/sc17f5oHoGp23A6yoHMyq8Icv73gnlBo5aBG9a3Ge89uIqz1+nkBReVqaHAdH+EHwOzkRNb/XUCKPAsrcZszH1OqpO/lUYOJhbIK/PVotUaMYvzt5MEySh0vI1aZZbMd8byeCA+hIkZ1C5OxbL2mMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiegORZ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiegORZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=502QDRlYJzXpzFTJLNJfj4Vr/nXWqOYuLyb3kl7aEdU=;
	b=TiegORZ7YdV47w41eKdMipWfDt8jpQtTvv7vmbUO48rxjNv8zILV3cBRiOw/whzwC5dYT4
	psqCqz0r6rH439AjwQiri+bv35SuDFKnuXqziDB4Q4YScdAOjI1wdfyRw7M3wl1Rbz6/EW
	OF3glDWzoRK8PuGRRZG+Bkz8WbUOOm4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-9f7FX3wgOR6TMW951sPTKQ-1; Thu,
 18 Sep 2025 13:15:11 -0400
X-MC-Unique: 9f7FX3wgOR6TMW951sPTKQ-1
X-Mimecast-MFC-AGG-ID: 9f7FX3wgOR6TMW951sPTKQ_1758215710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40D0019560B1
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E72730002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 04/12] mptcp: introduce the mptcp_init_skb helper.
Date: Thu, 18 Sep 2025 19:14:46 +0200
Message-ID: <81224b133af708289f5d62ad5960b4bb2c0b95dc.1758214564.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DNBt3YjDlDkfLJOaU_TUfFVfqjdXsXCsTCznWMRjtKo_1758215710
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Factor out all the skb initialization step in a new helper and
use it. Note that this change moves the MPTCP CB initialization
earlier: we can do such step as soon as the skb leaves the
subflow socket receive queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - drop subflow argument from mptcp_init_skb()
  - change msk args to sock arg in __mptcp_move_skb()
---
 net/mptcp/protocol.c | 46 ++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 162abafe3f320..048056b29a92d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -321,27 +321,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
@@ -353,6 +337,24 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
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
@@ -673,7 +675,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
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

