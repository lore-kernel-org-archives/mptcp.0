Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433B3C454F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051491; cv=none; b=dP8yRmBaJVwC0BZyX7YxEundROH5Nyu0zbLOQyI8Py56OrDLoP0Bk6mY5aOCdlWw4zD7pb8ymfZJEhUKqZGLgaEv53/7XmjDbYTqBXmqVkNL0mSHh2R9FQPjfHH8BwvK1fFrEJKt6FkW+GhsmHNXJhEraOrw24e2gRzsG6FNe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051491; c=relaxed/simple;
	bh=MldmtXDorhmIBYhwqmMUse0+Jmfv7UoaoLUN0QpDGqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fpgk5ixy1h4BBrZiyAz+aEuWxUpWUuul/0Y+Akv55cFqOur//1/yP5texGfCV2mRPX2TsI4vOVqWkVjmbv4Ea31pw0WwUY5a/FEeV/Zc8v2WKVUbQ9l5b5TF9eUxpx0xK0kAB7DXdf1wsIayT+5AA1FGYQg/YPGq6Ifx9drO3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2qn9qiX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2qn9qiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780051489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ni0R1/P1iP4W4/HjqyWOb5R/51zF+yeImHzPpCTTz4=;
	b=P2qn9qiXD8MFs5WzpQ2Q/PMj7UYMveh2Pv62ZNQDUBCmBOOJXjY+sAPCdXNBLURQtIEKa0
	K2HHBF9uh3ece1IMYcY5UE+yxOyMREPxloYwV7BEZ3AdaVNc8grOYNsI9tqGM1e9YirEqf
	gaAqAxL0D4Y4OiBdnJ6cmu0J8pbjl8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-h2LwUPOwMXS8ciFV-jZIXQ-1; Fri,
 29 May 2026 06:44:47 -0400
X-MC-Unique: h2LwUPOwMXS8ciFV-jZIXQ-1
X-Mimecast-MFC-AGG-ID: h2LwUPOwMXS8ciFV-jZIXQ_1780051486
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 685CE1956048
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E4DF19560A3
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v10 mptcp-next 1/3] Squash-to: "mptcp: implemented OoO queue pruning"
Date: Fri, 29 May 2026 12:44:29 +0200
Message-ID: <34aad036969501b2e71025a68bd3925e478bc3c8.1780049797.git.pabeni@redhat.com>
In-Reply-To: <cover.1780049797.git.pabeni@redhat.com>
References: <cover.1780049797.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ts4n9eo3aZ3PCMcqO6ACZZWSi9y_tDTkHJjSBUO3Drc_1780051486
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As discussed in the original patch, use the proper helper to
get the currently used memory, and let mptcp_prune_ofo_queue()
return true when skb can be accepted, to avoid code churn in
the caller.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29cb10c02ed8..03234e8cc26c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -376,7 +376,7 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 /* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
  * socket is under memory limit.
  */
-static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
+static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct rb_node *node, *prev;
@@ -384,7 +384,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 	u64 mem;
 
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return;
+		goto out;
 
 	node = &msk->ooo_last_skb->rbnode;
 
@@ -401,7 +401,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 		mptcp_drop(sk, skb);
 		msk->ooo_last_skb = rb_to_skb(prev);
 
-		mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
+		mem = (unsigned int)sk_rmem_alloc_get(sk);
 		if (mem < sk->sk_rcvbuf)
 			break;
 
@@ -410,6 +410,10 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 
 	if (pruned)
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+
+out:
+	mem = (unsigned int)sk_rmem_alloc_get(sk);
+	return mem < sk->sk_rcvbuf;
 }
 
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
@@ -424,13 +428,11 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will break.
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
-	    !__mptcp_check_fallback(msk)) {
-		mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq);
-		if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-			mptcp_drop(sk, skb);
-			return false;
-		}
+	    !__mptcp_check_fallback(msk) &&
+	    !mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
 	}
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
-- 
2.54.0

