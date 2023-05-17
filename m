Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4B2C739
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684323349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvbWvWeCGg7OLtCob8tBk2leVJPwRYAyb2yBU4ji2xM=;
	b=FHvmZD/JK3huEE/SZE00HNkRDPaZpBOpaAA3oV6d9+UwwdhkIjJxiMnJgiDlxvl8BIdzl8
	XSpCqixUPIBRz4VVk0RN9fHKWlSZTKAJWgdYmNFtFqm9F5LihlMI6gVr3fqcpFOoOCI87Y
	0sZmEOLsdQwodnHnAQw1Bqeaob+753I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-CI6z4OgxMCumD1PQhzUxWA-1; Wed, 17 May 2023 07:35:45 -0400
X-MC-Unique: CI6z4OgxMCumD1PQhzUxWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87F96185A790;
	Wed, 17 May 2023 11:35:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED25563F8E;
	Wed, 17 May 2023 11:35:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 3/4] mptcp: fix data race around msk->first access
Date: Wed, 17 May 2023 13:35:35 +0200
Message-Id: <ee801feaacad6c44dc24418c67cca8293b3d63dc.1684321532.git.pabeni@redhat.com>
In-Reply-To: <cover.1684321532.git.pabeni@redhat.com>
References: <cover.1684321532.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The first subflow socket is accessed outside the msk socket lock
by mptcp_subflow_fail(), we need to annotate each write access
with WRITE_ONCE, but a few spots still lacks it.

Fixes: 76a13b315709 ("mptcp: invoke MP_FAIL response when needed")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55db12cf7ccb..379ae468d755 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -90,7 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
-	msk->first = ssock->sk;
+	WRITE_ONCE(msk->first, ssock->sk);
 	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -2446,7 +2446,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	sock_put(ssk);
 
 	if (ssk == msk->first)
-		msk->first = NULL;
+		WRITE_ONCE(msk->first, NULL);
 
 out:
 	if (ssk == msk->last_snd)
@@ -2762,7 +2762,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 
-	msk->first = NULL;
+	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
-- 
2.40.1

