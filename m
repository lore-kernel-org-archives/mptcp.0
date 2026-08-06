Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF53B71BA
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027655; cv=none; b=Ret0+70jrKn2mQ8QdG0xkocEVAGV07vjMTWGTpXl8cQhXtvajO5CsP2ege1u/6QT9R2t3/0Z4yhD48C2RWYTTzKzKfnmK1DP94V8OgcD2uEKUz80VCvjOkuJEKIbll1MxkrAipDVuAyRukDKgZm8SviikFkY1dC5dQ5Wq4BWKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027655; c=relaxed/simple;
	bh=5RRfxqMV/jxbfI4OyeCH5Tq4DW+s+iAdQETPHbkTLy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Sk85YSThwg73ypeEoapAi7s3AJbn0N8yLk4xWfr/u0/fzDowX1VIYWy2J+6Ri8YIAcYGh+HtKZ75jeqpV5N4TJrFxdhzKgeMQF85Lv00PpN0XF6G2wRXfGxuIAl3laweY0jBHlGMhc+uHjzts3G9jBPKTbYTaW5VRV6k1ERImHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcMgyPbv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcMgyPbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPRCfmbU2pCKfQwHny6f+vIIUE7cp4KIQn14RwzcrsI=;
	b=BcMgyPbvdPHhY5QeCmMn+wsE5y3yBxnUv1YqfD6frAeMRB4OutBjilzv7epveZ3XPgSu0t
	7lNMV+0IHfu2fkxW9CqxKhERbG5mmYcCjgB4196JkAS2ncT+znU8KIHQs4NG9va+AiIpzV
	9bpw6MzHeWRElyNgbjb5ag91iBCg3/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-I9CNYhk7M6GcycraSXubBw-1; Thu,
 06 Aug 2026 10:47:31 -0400
X-MC-Unique: I9CNYhk7M6GcycraSXubBw-1
X-Mimecast-MFC-AGG-ID: I9CNYhk7M6GcycraSXubBw_1786027651
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EA94180034A
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BF5A1956094
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 6/7] mptcp: avoid code duplication in __mptcp_move_skb()
Date: Thu,  6 Aug 2026 16:45:27 +0200
Message-ID: <e03f728db1a7db552864f4447ca43a1d1bc9c56c.1786026372.git.pabeni@redhat.com>
In-Reply-To: <cover.1786026372.git.pabeni@redhat.com>
References: <cover.1786026372.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFYPavjGCho2UvvonU6-x7B2og6CZflpyLywrRzqkRY_1786027651
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Alike TCP, MPTCP handles in-sequence packets and partially overlapping
ones in a very similar way: we can use the same path to handle both,
avoiding some code duplication.

This will also make the next patch simpler.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d96fbdc34dbb..63f2c18bc01f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -399,6 +399,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
+insert:
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
@@ -413,26 +414,20 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* Completely old data? */
-	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-		mptcp_drop(sk, skb);
-		return false;
+	/* Partial packet */
+	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
+					     MPTCP_SKB_CB(skb)->map_seq;
+		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+					      MPTCP_SKB_CB(skb)->map_seq;
+		goto insert;
 	}
 
-	/* Partial packet: map_seq < ack_seq < end_seq.
-	 * Skip the already-acked bytes and enqueue the new data.
-	 */
-	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
-	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-				      MPTCP_SKB_CB(skb)->map_seq;
-	msk->bytes_received += copy_len;
-	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
-
-	skb_set_owner_r(skb, sk);
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	return true;
+	/* Completely old data */
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	mptcp_drop(sk, skb);
+	return false;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.55.0

