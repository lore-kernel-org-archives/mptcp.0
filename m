Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9011FB3
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBNr5u5HARESPaBwPPbQQt0n5Q7p7/rsZplOVB5vUPk=;
	b=bKyQcWQZGeS7KBFhb1PDViwc7BfMW9CtSz9E961Wk35VsaKZFH+RrOSvpKOqvFgXhgTni2
	kYAgKsKuPf5yoKkAagC8YTnpCxKGU/AggMjpKAV3n5aZK/GZUE9VwfeB39XNTEv2VjxJo3
	fZfUf0oeZWoSMg+l+40GT62eq1YUsFk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-sQl5Z7p2MhiPwHz4eniAvg-1; Tue, 17 Jan 2023 02:37:20 -0500
X-MC-Unique: sQl5Z7p2MhiPwHz4eniAvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24DF3381494D
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A76BD40C2004
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 10/13] mptcp: fastclose msk when cleaning unaccepted sockets
Date: Tue, 17 Jan 2023 08:36:30 +0100
Message-Id: <394c4a5a2cb8764519aa732fc27dad59fa2ba71c.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
index b867e3eec5b9..f742d558a1b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2977,10 +2977,13 @@ bool __mptcp_close(struct sock *sk, long timeout)
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
index 6f198d6e1b22..a1f8bb745c1b 100644
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
2.39.0

