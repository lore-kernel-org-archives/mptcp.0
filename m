Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656C3161A8
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215717; cv=none; b=VWYVOpY7oUROXJa06v8ZCQp+rNSjxaMI8C/6Vs6ho2D2AVtNYwgxJeBDatIQQ9OUY3GF3ssjQnuicIqsIDLrEibvVDRp0do2MJe4lcYg0hQAAoqka51F1tZ6iUIIFRjx7Et+y9m5NPG7aEeygWgdmaUdXRmvleSsS3MO9zzftmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215717; c=relaxed/simple;
	bh=hP1K+FS3uEgLCSZe+MVPitH+2UFfd1nO7jq0RAzOzTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Em6VV5D2ihNiYuWWRApe5LYPLamjVt7tW2hQppPseVVSv1UWekd2ou7klzFascWiFHgq/wswe2PXR+6Cdw/iqBMGcmhUDxGdlvY40mdYD1wrXlGcPncMIZG+LbzTgBF88o6zKvg3c+5P1RJ7GFDI6YGGE+S8bcTM9om5hWRD+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSZJ7e0I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSZJ7e0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwnpdFKsJh3rygT4cCoNMmNOreqzkefWCjkQplxWBhw=;
	b=gSZJ7e0IYXae8l5donv6NPVSYcmgWZJCFw6rXJasHAKtePltxPvhzpxh3JeJty15mNspFV
	eXIYzqMR+clFJsTy7aCCmesYWmaRgt/CWv6Hf+2KuCQGJDAAPCql0m8DA5ultmfkKOjMl3
	qVvRXOcrZ1Hidt3EE9XobOdPebeWGrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-7sGvA8-oMTChGCu8W4a6bQ-1; Thu,
 18 Sep 2025 13:15:13 -0400
X-MC-Unique: 7sGvA8-oMTChGCu8W4a6bQ-1
X-Mimecast-MFC-AGG-ID: 7sGvA8-oMTChGCu8W4a6bQ_1758215713
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0B671956089
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2923730002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 06/12] mptcp: factor out a basic skb coalesce helper
Date: Thu, 18 Sep 2025 19:14:48 +0200
Message-ID: <0be52a39543e405a7812399646499b6f3c0cacde.1758214564.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Og3yCWN00ZxxceM4hr1rBfeBAFRTvhiqCpeAIjHo6u4_1758215713
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The upcoming patch will introduced backlog processing for MPTCP
socket, and we want to leverage coalescing in such data path.

Factor out the relevant bits not touching memory accounting to
deal with such use-case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 19b5b925e2acc..66ad9a38a6082 100644
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

