Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57476D19
	for <mptcp@lists.linux.dev>; Thu,  1 Sep 2022 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662053491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOP6kDp3WbB3Pe3pNV2NdQ+oh+Usl3crLeuWA+rQnbY=;
	b=JPD1CZr3nVUW0aY8xFEYIrbt9vhoxhuN3rz71hrFprdwQyX6gtXoBf0rv8xssJZcXBlwJs
	Dbk4lsHtb1FljS/T4pcXB5igk1GcZBqo2Op7YARYfVDuNE9FF07NVYRXS49l6QqW+qQ/w0
	pbjGpARoLxYp7oi9aago6D5EURW4K7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-mw-7T61hOXKVFhlQcPBlAw-1; Thu, 01 Sep 2022 13:31:30 -0400
X-MC-Unique: mw-7T61hOXKVFhlQcPBlAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14C01811E83
	for <mptcp@lists.linux.dev>; Thu,  1 Sep 2022 17:31:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0958C15BB3
	for <mptcp@lists.linux.dev>; Thu,  1 Sep 2022 17:31:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 2/3] mptcp: use fastclose on more edge scenarios.
Date: Thu,  1 Sep 2022 19:31:21 +0200
Message-Id: <6b0e74898fa34539427222eaab65c0b406d715d1.1662051551.git.pabeni@redhat.com>
In-Reply-To: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Daire reported a user-space application hang-up when the
peer is forcibly closed before the data transfer completion.

The relevant application expects the peer to either
do an application-level clean shutdown or a transport-level
connection reset.

We can accommodate a such user by extending the fastclose
usage: at fd close time, if the msk socket has some unread
data, and at FIN_WAIT timeout.

Note that at MPTCP close time we must ensure that the TCP
subflows will reset: set the linger socket option to a suitable
value.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v2 -> v3:
 - move self-tests update to a different patch

v1 -> v2:
 - ensure mptcp_do_fastclose will reset all the subflows,
 - update fastclose self-tests
---
 net/mptcp/protocol.c | 50 +++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b04f184695e4..fec542fea02a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,8 +2276,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if (flags & MPTCP_CF_FASTCLOSE)
+	if (flags & MPTCP_CF_FASTCLOSE) {
+		/* be sure to force the tcp_disconnect() path,
+		 * to generate the egress reset
+		 */
+		ssk->sk_lingertime = 0;
+		sock_set_flag(ssk, SOCK_LINGER);
 		subflow->send_fastclose = 1;
+	}
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2540,6 +2546,16 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_reset_timeout(msk, 0);
 }
 
+static void mptcp_do_fastclose(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
+				  subflow, MPTCP_CF_FASTCLOSE);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
@@ -2571,6 +2587,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (sock_flag(sk, SOCK_DEAD) &&
 	    (mptcp_check_close_timeout(sk) || sk->sk_state == TCP_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_do_fastclose(sk);
 		__mptcp_destroy_sock(sk);
 		goto unlock;
 	}
@@ -2823,6 +2840,18 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
+static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+{
+	/* Concurrent splices from sk_receive_queue into receive_queue will
+	 * always show at least one non-empty queue when checked in this order.
+	 */
+	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
+	    skb_queue_empty_lockless(&msk->receive_queue))
+		return 0;
+
+	return EPOLLIN | EPOLLRDNORM;
+}
+
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2837,8 +2866,13 @@ static void mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_close_state(sk))
+	if (mptcp_check_readable(msk)) {
+		/* the msk has read data, do the MPTCP equivalent of TCP reset */
+		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_do_fastclose(sk);
+	} else if (mptcp_close_state(sk)) {
 		__mptcp_wr_shutdown(sk);
+	}
 
 	sk_stream_wait_close(sk, timeout);
 
@@ -3646,18 +3680,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
-{
-	/* Concurrent splices from sk_receive_queue into receive_queue will
-	 * always show at least one non-empty queue when checked in this order.
-	 */
-	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
-	    skb_queue_empty_lockless(&msk->receive_queue))
-		return 0;
-
-	return EPOLLIN | EPOLLRDNORM;
-}
-
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-- 
2.37.2

