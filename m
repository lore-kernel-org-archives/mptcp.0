Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1870
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622045093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BQRcJTAP6dfxPM101NZlGbovsCjcanY7DSbzlDObwuY=;
	b=dTU/MMTIV1ls5hX9GO30Og6D1HMETTtCGAT3rpdpQbohcA2ud96rU8ZHCDNNIXrdM+SZqr
	XiLelVRHyrT7JR2ercd2ZDWbgzW1dzIvQk5ni3HCBnFe39yXs6sIAob4P4KGeTrLxX+Uql
	3R47Gg3e4Aqtx0lYdZvTrqdI8Ebi8tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-Y55UNWyWPqyOPfA9O3GLEw-1; Wed, 26 May 2021 12:04:51 -0400
X-MC-Unique: Y55UNWyWPqyOPfA9O3GLEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6A6E7B42;
	Wed, 26 May 2021 16:04:50 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-44.ams2.redhat.com [10.36.113.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65D6A5D9CC;
	Wed, 26 May 2021 16:04:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: max@internet.ru
Subject: [PATCH mptcp-net] tcp: ensure that backlog coalescing don't break MPTCP DSS
Date: Wed, 26 May 2021 18:04:36 +0200
Message-Id: <925dcab4e637ab2ad2d947baa937a62146040802.1622044966.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently the backlog coalescing does check for MPTCP validation:
a relevant DSS could be lost leading to MPTCP stream corruption.

The above is quite infrequent since the MPTCP subflows are not
exposed to user-space but the MPTCP still acquires the ssk socket
lock on some events.

Fix the issue adding the missing test.

Fixes: 85712484110d ("tcp: coalesce/collapse must respect MPTCP extensions")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this can possibly fix issues/196, but it's very hard to demonstrate,
even with pktdrill
---
 net/ipv4/tcp_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4f5b68a90be9..6b033593d069 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1822,6 +1822,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 
 	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
 	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags |
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
 	    !((TCP_SKB_CB(tail)->tcp_flags &
-- 
2.26.3

