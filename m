Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BED8C02
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687531869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BdeFGRkd1BEYHQiCf1zWxs5S4WlKcM3ETSzOvXb/6BY=;
	b=c9Q6Es1cxMxiWBg2N8A1CQYRVr9MhwEwsL0nv9LA4rLZE0INjG7mCswtrkZ9MzysAn3JlY
	N4RAKAsvdeYG0LQIkUeHJ7l1m3gmgkTJtxwic9Ok6mT+uJF/rA4jgGtktw2SzjRRAT0tKZ
	rFjA1zdEHkFmCSh2ZPCkxZS3gvyCbO8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-6DD8F5cUPeePzN_NXxAEPw-1; Fri, 23 Jun 2023 10:51:08 -0400
X-MC-Unique: 6DD8F5cUPeePzN_NXxAEPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C848C1C07598
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 14:51:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5824C200B402
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 14:51:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: ensure subflow is unhashed before cleaning the backlog
Date: Fri, 23 Jun 2023 16:51:01 +0200
Message-Id: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

While tacking care of the mptcp-level listener I unintentionally
moved the subflow level unhash after the subflow listener backlog
cleanup.

That could cause some nasty race and makes the code harder to read.

Address the issue restoring the proper order of operations.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2abae254524..03a7c83bc2d2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2957,10 +2957,10 @@ static void mptcp_check_listen_stop(struct sock *sk)
 		return;
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	tcp_set_state(ssk, TCP_CLOSE);
 	mptcp_subflow_queue_clean(sk, ssk);
 	inet_csk_listen_stop(ssk);
 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-	tcp_set_state(ssk, TCP_CLOSE);
 	release_sock(ssk);
 }
 
-- 
2.40.1

