Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49136283FC5
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976622; cv=none; b=fd3mZKTAuz6XPYppY1vEMgY6tPJx5Lhqt2mcUSc4dfaGO1M5MMBDMo9VsTyKHoXNSjJmFE3F5SOFp9MGjwqOjkxOplIy5CMvHZVMTMgfKPJke5uqF+pJNPlQGWzliB4nsY9sLRb+I3JRITXbJoeIQWWA8dDUkr+2XH/I0G2x5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976622; c=relaxed/simple;
	bh=FCNvse8nTOi9q5lFWgamMfn85CogSnqjMy4t2ho94YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=e5sZKIbepVC4/xa0Yvr/b+VvctUONpoOnU9YnX0MdyevvybG3Ngdwl7iDptlKhKLBB+L2iXfnI4HNcjbD7N21pzKfG/UdngzbIMC+kykJX29yZOus9HLdtP5s4b5VUVGGGn5unh97bw8GIn7NjnmfbqAI8RlDx+GeYLT0Y3maT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eq9B19yq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eq9B19yq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760976620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8LWI+r6WqglyTkJUBQi7LOiHbqVB8HjEYJdBaB1YAM=;
	b=eq9B19yqYRTroZ1TezWUQ9vzrPZQAR3Ldxh+KQqtgzJgixxPK/ggCZxQgFJpSjmTE0Jdhs
	RLZC18Hhz40ND4RA/WMFQRPV2oOb55mjS4XWFWHrsBR+fvW7PqFaGNcMYPo8Ab4JqoD6gt
	QCniZqOQjkgiMYTKDyHxojgR5bcPe6A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-wnfm8AELPHmXYzs-9U5Xwg-1; Mon,
 20 Oct 2025 12:10:15 -0400
X-MC-Unique: wnfm8AELPHmXYzs-9U5Xwg-1
X-Mimecast-MFC-AGG-ID: wnfm8AELPHmXYzs-9U5Xwg_1760976614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 384721830677;
	Mon, 20 Oct 2025 16:10:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CF683000233;
	Mon, 20 Oct 2025 16:10:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org
Subject: [PATCH mptcp-net 1/2] mptcp: restore window probe
Date: Mon, 20 Oct 2025 18:10:01 +0200
Message-ID: <59d900cbb2c2ff8e742d55a78e22727d1951bb51.1760976334.git.pabeni@redhat.com>
In-Reply-To: <cover.1760976334.git.pabeni@redhat.com>
References: <cover.1760976334.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6adgrU_SToJHMfZW6Vwlmr7RJ0n-eiQoBab2W_5qek_1760976614
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit 72377ab2d671 ("mptcp: more conservative check for zero
probes") the MPTCP-level zero window probe check is always disabled, as
the TCP-level write queue always contains at least the newly allocated
skb.

Refine the relevant check tacking in account that the above condition
and that such skb can have zero length.

Fixes: 72377ab2d671 ("mptcp: more conservative check for zero probes")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bde76b7311f986..fe029359b7d7a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1276,6 +1276,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1311,14 +1312,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
@@ -1339,7 +1340,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
+		/* No need for zero probe if there are any data pending
+		 * either at the msk or ssk level; skb is the current write
+		 * queue tail and can be empty at this point.
+		 */
+		if (snd_una != msk->snd_nxt || skb->len ||
+		    skb != tcp_send_head(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1367,7 +1373,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.51.0

