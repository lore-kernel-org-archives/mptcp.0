Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0FAD55
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggf3M+W8TT1rfmXGh2ofEladlxwPVJxhQzKMOuC5Tio=;
	b=Axiu1qqywq54lNFho6kT0NvSL5iPJ1FDczNMfxIjGDiSDiUiduhcxC6J0j1eXfBRgZtDnI
	1PoJXwHy9aRMa3bQiSpDl9BK2oVS/jB/uavQsBsABPzE+ey9i7RFNfMLg5TfpR7AIbFSOp
	4h0BL/8mldi1gyw+79X6pl5Y96KSsag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-3lZwcFFiORqI_VRQzw4vjw-1; Fri, 13 Jan 2023 13:21:12 -0500
X-MC-Unique: 3lZwcFFiORqI_VRQzw4vjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 264D61C0041B
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4C9B4078903
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 8/9] mptcp: fastclose msk when cleaning unaccepted sockets
Date: Fri, 13 Jan 2023 19:20:55 +0100
Message-Id: <ef15ea7b7b51df3d23b3e9ad27968366a5487130.1673629755.git.pabeni@redhat.com>
In-Reply-To: <cover.1673629755.git.pabeni@redhat.com>
References: <cover.1673629755.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When cleaning up unaccepted mptcp socket still laying inside
the listener queue at listener close time, such sockets will
go through a regular close, waiting for a timeout before
shutting down the subflows.

There is no need to keep the kernel resources in use for
such a possibly long time: short-circuit to fast-close.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 +++++--
 net/mptcp/subflow.c  | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d440746704d..e5d1d2747e31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2981,10 +2981,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk)) {
-		/* the msk has read data, do the MPTCP equivalent of TCP reset */
+	if (mptcp_check_readable(msk) || timeout < 0) {
+		/* If the msk has read data, or the caller explicitly ask it,
+		 * do the MPTCP equivalent of TCP reset, aka MTCP fastclose
+		 */
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
+		timeout = 0;
 	} else if (mptcp_close_state(sk)) {
 		__mptcp_wr_shutdown(sk);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d3a17f924377..b4d693089476 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1856,7 +1856,7 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		if (msk->first)
 			sock_hold(msk->first);
 
-		do_cancel_work = __mptcp_close(sk, 0);
+		do_cancel_work = __mptcp_close(sk, -1);
 		release_sock(sk);
 		if (do_cancel_work) {
 			/* lockdep will report a false positive ABBA deadlock
-- 
2.38.1

