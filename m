Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52E70
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+CGTkoMHcODWpNPzRuw+QpegJVd2BbOrk9AVkPrc1g=;
	b=FSSKkaN2CRGclQ/b/XiAFGPZqQehGovmw4K06Bi6p7mXI0JmCLf7mq/15juiIFQ80lBUfC
	tFPv5lMi4Co1dpT4pWL8Tx1tAob1uxhRZBYni/kOQ/eWFPkVGxHxL/FO3G1THb3vKY/na9
	XpjxChSCFBatpzBbTfNBirBcJoxJUtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-eAQNeiuAP2-O56bekAQ09Q-1; Fri, 23 Apr 2021 10:50:37 -0400
X-MC-Unique: eAQNeiuAP2-O56bekAQ09Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A805F8030DB;
	Fri, 23 Apr 2021 14:50:35 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D853C19D9B;
	Fri, 23 Apr 2021 14:50:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 18/22] mptcp: tune re-injections for csum enabled mode.
Date: Fri, 23 Apr 2021 16:49:57 +0200
Message-Id: <a9454fc62649ecab6e33211656598742fb208593.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If the MPTCP-level checksum is enabled, on re-injections we
must spool a complete DSS, or the receive side will not be
able to compute the csum and process any data.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d8005b480ab..91e25fc91951 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2324,8 +2324,8 @@ static void __mptcp_retrans(struct sock *sk)
 
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent = 0;
-	info.limit = dfrag->already_sent;
-	while (info.sent < dfrag->already_sent) {
+	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
+	while (info.sent < info.limit) {
 		if (!mptcp_alloc_tx_skb(sk, ssk))
 			break;
 
@@ -2337,9 +2337,11 @@ static void __mptcp_retrans(struct sock *sk)
 		copied += ret;
 		info.sent += ret;
 	}
-	if (copied)
+	if (copied) {
+		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+	}
 
 	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
-- 
2.26.2

