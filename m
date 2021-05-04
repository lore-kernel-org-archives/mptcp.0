Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C662F81
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpeErRkVz8AqXTT/E34wms/0jZmPLPGjoV038HAN1PY=;
	b=G47TBGT5v/aDps7PUIcyQMaYqeQzc5ucFwZk/E4RZew6FnZFnDQ7rgYoRkyvzvLmD3n1hS
	Ch3O54+Bx5KWInHCvMGL5FocCcrN93RXAtQhzCGzGAEtBqCv+hASgj6jB3x8JFAor2GAe4
	l/eEPH3nZ4K76FbYBa2wRpY1ic9zgJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Y1gJ5pz1Mq6ig4sFWBSrDA-1; Tue, 04 May 2021 17:42:47 -0400
X-MC-Unique: Y1gJ5pz1Mq6ig4sFWBSrDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142691006C80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:47 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 816105C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 18/22] mptcp: tune re-injections for csum enabled mode.
Date: Tue,  4 May 2021 23:42:06 +0200
Message-Id: <db2e985048bca57f5d316d5d16d38dbf399fe8f6.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
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

If the MPTCP-level checksum is enabled, on re-injections we
must spool a complete DSS, or the receive side will not be
able to compute the csum and process any data.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a9327f5c14c..32a39774075b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2333,8 +2333,8 @@ static void __mptcp_retrans(struct sock *sk)
 
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent = 0;
-	info.limit = dfrag->already_sent;
-	while (info.sent < dfrag->already_sent) {
+	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
+	while (info.sent < info.limit) {
 		if (!mptcp_alloc_tx_skb(sk, ssk))
 			break;
 
@@ -2346,9 +2346,11 @@ static void __mptcp_retrans(struct sock *sk)
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

