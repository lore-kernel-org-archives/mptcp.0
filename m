Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917748380E
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946653; cv=none; b=e7ywI3FpnmunY5I0yjDD/1IAQGzsj73SA2TghFC/sfJJYYHLhRLA15gNarKUP8/Iq2EGfklQn9BO3zPozwrIUDRkq+knxXvP1b9lVNZc9wuwfLIgaRR4KmaQKGFe69T3IJ97yvaS+6T+FoQ8aF7n4l7UO1rJzclugqeoJSJmagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946653; c=relaxed/simple;
	bh=8igfls5jaoC9A4BhLQsAcfGhUm443QBzMofD6hUk0Q0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D+B4BLww2XEmTjqjnZnJ5P9fNs92vkh+T76mA30jMPqKYvSfAS+LIruxyYaMHlEuDBVYrmKPKkB3WEryptUJ1nfvpJcPq+zMTlsdFgFQUl7dT/WJHO8KD+MMFtdJwizP6pUh+MOW4RTxS5RcbvojUJSAWPCqwDWPqaIunBr5sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB+Rz2+I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB+Rz2+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785946651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZk+NcmXbim99ukax1ogWB7ZbVpkJu9M5sOsCDa4SU4=;
	b=BB+Rz2+ItJl+hr1Y5mGFfEUiLAN5F04spMsTMGLj2bBStQukaAj7+jSd9uBTU7cNubBMLw
	h0wlyr+CGPu0lZ4x0h8Knwb8fwDoWhooHg0Lfw/vlkW4Erc7glt9oENOsJMr+PHCsj328x
	cHx3pG7pJNjKsnBFTkMsPORsCmoN7U0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-yvYszWBROV27yba2sfm5pg-1; Wed,
 05 Aug 2026 12:17:29 -0400
X-MC-Unique: yvYszWBROV27yba2sfm5pg-1
X-Mimecast-MFC-AGG-ID: yvYszWBROV27yba2sfm5pg_1785946649
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 087901800115
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 494751800347
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:17:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 6/7] mptcp: avoid code duplication in __mptcp_move_skb()
Date: Wed,  5 Aug 2026 18:17:13 +0200
Message-ID: <53966df5b6ab1c707702a69972d6223fa89f85b6.1785943854.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: EuRzbZNv40cGQYsuwSh-2q1PmgLP1wxKeapLV3Askq4_1785946649
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
index df1801699cce..1181d733bc4b 100644
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

