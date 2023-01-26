Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30B5393
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sge10ImAD5NAvP6eaHg1jUTI3Jkqpl+KEmkaKqdCvNI=;
	b=MPtnxlmv0OcJCWCUo6HM7gqWv92j93/dHNyY65UJ/Nh7mNTqx8os+ZP6Y3AwEv9hRDe4Fx
	mEea+pS90P7sr9NAextNbD/sGcPgn3dh7UiqtAXpXtAWR5GupRlf/X7IY/f+tgetPvH8lR
	Ua6HkxItQV6Ev9xqflww1RKq8F47KBY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-gzTDZCTaOLeQtWARP4hYIA-1; Thu, 26 Jan 2023 16:05:47 -0500
X-MC-Unique: gzTDZCTaOLeQtWARP4hYIA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 964E8382C96A
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2921E492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 11/15] mptcp: fastclose msk when cleaning unaccepted sockets
Date: Thu, 26 Jan 2023 22:05:16 +0100
Message-Id: <16ab82292cc0a95b9604f5664d809d74f02be549.1674767058.git.pabeni@redhat.com>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
References: <cover.1674767058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
v2 -> v3:
 - fix typo in comment (Mat)
---
 net/mptcp/protocol.c | 7 +++++--
 net/mptcp/subflow.c  | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 98eaf8314521..d337207f5ec2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2978,10 +2978,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_check_readable(msk)) {
-		/* the msk has read data, do the MPTCP equivalent of TCP reset */
+	if (mptcp_check_readable(msk) || timeout < 0) {
+		/* If the msk has read data, or the caller explicitly ask it,
+		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
+		 */
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
+		timeout = 0;
 	} else if (mptcp_close_state(sk)) {
 		__mptcp_wr_shutdown(sk);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a438fae96344..53e2a1852ca7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1854,7 +1854,7 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		if (msk->first)
 			sock_hold(msk->first);
 
-		do_cancel_work = __mptcp_close(sk, 0);
+		do_cancel_work = __mptcp_close(sk, -1);
 		release_sock(sk);
 		if (do_cancel_work) {
 			/* lockdep will report a false positive ABBA deadlock
-- 
2.39.1

