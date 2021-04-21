Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9F2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+CGTkoMHcODWpNPzRuw+QpegJVd2BbOrk9AVkPrc1g=;
	b=EMJKCwmxvJmSfPbB/KtZugD7aXRyZjc2rk6rtuXaNYU7tfYpurYFUKGfL9icoEmAzZKdD8
	vEOAgLHn/ifP72ICzbsid2Pu27GuepZ2mva3LFmhv0WOymjjATuZwHkP4DDca7eJUYMR7G
	k6v+uTP/o+5GvfXQ81eRbAoxMQEMpIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-CNeGLfJPPJGMR8I8uK-zzA-1; Wed, 21 Apr 2021 16:21:00 -0400
X-MC-Unique: CNeGLfJPPJGMR8I8uK-zzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E022107ACF2;
	Wed, 21 Apr 2021 20:20:59 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 658FA6085A;
	Wed, 21 Apr 2021 20:20:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 17/21] mptcp: tune re-injections for csum enabled mode.
Date: Wed, 21 Apr 2021 22:18:06 +0200
Message-Id: <07fceb9ac04b312d3c2732e892a5716156ac8c1a.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

