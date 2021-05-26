Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1370
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622045450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KyjA/x7RYrn2Z4MVMcxwI2PUusUcokfZKrZnI8j+QJ0=;
	b=a19l8J4nZL49mde+oEYperEUoWny605DZU6MgLTyHhev4DZr04xSqkXQkv2bmaePFVsX3B
	d3FNEDUxwZbCbMci5aq0fiVOF7PcBwuyfUb3NckHgQBTkZ405cz5U+xf2z8UnKlQZZqj+k
	VDPSitVTp2anJLti5wx4Wx/d0RVb3T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-s_RWq2akPZylRGKrVtHDbw-1; Wed, 26 May 2021 12:10:48 -0400
X-MC-Unique: s_RWq2akPZylRGKrVtHDbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23EB107ACC7
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:10:47 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-44.ams2.redhat.com [10.36.113.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A82958899
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:10:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: try harder to borrow memory from subflow under pressure
Date: Wed, 26 May 2021 18:10:43 +0200
Message-Id: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If the host is under sever memory pressure, and RX forward
memory allocation for the msk fails, we try to borrow the
required memory from the ingress subflow.

The current attempt is a bit flaky: if skb->truesize is less
than SK_MEM_QUANTUM, the ssk will not release any memory, and
the next schedule will fail again.

Instead, directly move the required amount of pages from the
ssk to the msk, if available

Fixes: 9c3f94e1681b ("mptcp: add missing memory scheduling in the rx path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb029dd4ff5e..785e74c13b3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -286,11 +286,13 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 
 	/* try to fetch required memory from subflow */
 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		if (ssk->sk_forward_alloc < skb->truesize)
-			goto drop;
-		__sk_mem_reclaim(ssk, skb->truesize);
-		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
+
+		if (ssk->sk_forward_alloc < amount)
 			goto drop;
+
+		ssk->sk_forward_alloc -= amount;
+		sk->sk_forward_alloc += amount;
 	}
 
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
-- 
2.26.3

