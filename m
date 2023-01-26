Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E823222
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674747871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gRBUVUb5JW+rI3IWg/I8aDe+6thlvj13K5dP7odLxU=;
	b=CE3yui3Hc7m9+VO7R88HMQLOuaArhIl3uMLb9uGZuQS/a392SNkrqy2ULaUPHaL3/GEkbP
	9yqtrHKVozmaCVQ1RWOQBKjBTMdFwQXJgoU4udW0sqPcQCZdr9UhKmIORk34O9N7OBIHi6
	szzYpxYN0go8agThnywIRLAUMUGbYww=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-H_k4elYOMrWcDqDCpIxkKA-1; Thu, 26 Jan 2023 10:44:30 -0500
X-MC-Unique: H_k4elYOMrWcDqDCpIxkKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BCCA1C09064
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 15:44:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A12872026D76
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 15:44:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: do not wait for bare sockets' timeout
Date: Thu, 26 Jan 2023 16:44:26 +0100
Message-Id: <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
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

If the peer closes all the existing subflows for a given
mptcp socket and later the application closes it, the current
implementation let it survive until the timewait timeout expires.

While the above is allowed by the protocol specification it
consumes resources for almost no reason and additionally
causes sporadic self-tests failures.

Let's move the mptcp socket to the TCP_CLOSE state when there are
no alive subflows at close time, so that the allocated resources
will be freed immediately.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
this could land either on -net or net-next, as it introduces
a change of behavior that "fixes" self-tests.

The fix tag would be:

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 003b44a79fce..43f53fd20364 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2954,6 +2954,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool do_cancel_work = false;
+	int subflows_alive = 0;
 
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
@@ -2980,6 +2981,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
 
+		subflows_alive += ssk->sk_state != TCP_CLOSE;
+
 		/* since the close timeout takes precedence on the fail one,
 		 * cancel the latter
 		 */
@@ -2995,6 +2998,12 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	}
 	sock_orphan(sk);
 
+	/* all the subflows are closed, only timeout can change the msk
+	 * state, let's not keep resources busy for no reasons
+	 */
+	if (subflows_alive == 0)
+		inet_sk_state_store(sk, TCP_CLOSE);
+
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
 	if (msk->token)
-- 
2.39.1

