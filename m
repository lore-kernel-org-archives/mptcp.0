Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207C2C21F8
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297230; cv=none; b=genxK9X0xvwJd8eB3dNIpT7tjJqvuum2y5pDczcXpw9k3y+UnYPs/jC974unIMbHZtCN+4AMvx34PlTTfIWy09vtIUy+6uG+uodpBgrlE9wgGFXnmUK46AV924V8KdHhjA8usBP6uN7/Vj7moq5/QcV5Wt8zZ8x6ua7iG8giqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297230; c=relaxed/simple;
	bh=tk0jaOjpxW2DkCYN0SuoutbqVV43j6pm1agowucL0UU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qBgr1mb0q5hqCn8CJ0YsBrrkb0R2fw5ydUR2HMh+tWXKTDTxs8xMpEgJ3Olw3v3Isdq3ipY1C7LgBr1cWWew174smWaSnUFsVzMlOvchk0STPovXyLyg5TV9Lu2mjX43Rr0t6kpvx1SO8X3hRoOmofGRwFFhCPafmwy5gxR+bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeUA6Wp3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeUA6Wp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oydInhb1rU3mKN92O0oRxak9M7HFtyLZ73iNMMrffxw=;
	b=JeUA6Wp3AlnUfF1uQQYzf2qG6k9x10NzYwO8XYH040Atc4c2jUDoqHhT62n6/Oe/kF5FHh
	HaKJKy0B0ZVFHxEy5gSxseGRTQ7yWzK90Eyi3aRp0aa+QmBt4X8hWMUuWV5na3FYp/ivoe
	B7ybsDQf9P2ZKWhql66F4hRva9NIl9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-OPKPq5dqNaaGICwbCNL6YQ-1; Fri,
 19 Sep 2025 11:53:46 -0400
X-MC-Unique: OPKPq5dqNaaGICwbCNL6YQ-1
X-Mimecast-MFC-AGG-ID: OPKPq5dqNaaGICwbCNL6YQ_1758297226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DA9318002C4
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D6D1800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 06/12] mptcp: factor out a basic skb coalesce helper
Date: Fri, 19 Sep 2025 17:53:20 +0200
Message-ID: <b0da49d04e0e833a08597b77dd0a21ef37090406.1758296923.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: JTEqI37TM35g1LYcGhi2BGOQQVOpUXOArnRx0lSAX8o_1758297226
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The upcoming patch will introduced backlog processing for MPTCP
socket, and we want to leverage coalescing in such data path.

Factor out the relevant bits not touching memory accounting to
deal with such use-case.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 909c611d5b528..bd83abefe4965 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -142,22 +142,34 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
-static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
-			       struct sk_buff *from)
+static int __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+				struct sk_buff *from, bool *fragstolen)
 {
-	bool fragstolen;
+	int limit = READ_ONCE(sk->sk_rcvbuf);
 	int delta;
 
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
-	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
-	    !skb_try_coalesce(to, from, &fragstolen, &delta))
-		return false;
+	    ((to->len + from->len) > (limit >> 3)) ||
+	    !skb_try_coalesce(to, from, fragstolen, &delta))
+		return 0;
 
 	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
+	return delta;
+}
+
+static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
+			       struct sk_buff *from)
+{
+	bool fragstolen;
+	int delta;
+
+	delta = __mptcp_try_coalesce(sk, to, from, &fragstolen);
+	if (!delta)
+		return false;
 
 	/* note the fwd memory can reach a negative value after accounting
 	 * for the delta, but the later skb free will restore a non
-- 
2.51.0

