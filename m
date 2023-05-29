Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C676FDE
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685367722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eEHo+cMNktKeTB8M66Fp/wUo9P0kfPIMAG8dsVxffuQ=;
	b=D5bEEIvrJKJCx5FMPoZLNaG8sYwl4X2v1yDMq+DalduFGRXh8aV9w4RhoaF87HqMoRblfb
	DQz8uqnqoZqs2KdrFSLM620ZQBvdBq/OAkwYfp/acJF3stKIN46zrERwTxJbbH7zL9JRVn
	svhQ12G/nJmQzjGSbS2EelotZZGNS8k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-RLbf17PSMAOed0Ocr-rgWw-1; Mon, 29 May 2023 09:42:00 -0400
X-MC-Unique: RLbf17PSMAOed0Ocr-rgWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C2FA3C0C885
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 13:42:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2E02112132C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 13:41:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 1/2] mptcp: handle correctly disconnect() failures
Date: Mon, 29 May 2023 15:41:46 +0200
Message-Id: <360b09c704b56f03c42c4f3520e6602fbf884651.1685367663.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the mptcp code has assumes that disconnect() can fail only
at mptcp_sendmsg_fastopen() time - to avoid a deadlock scenario - and
don't even bother returning an error code.

Soon mptcp_disconnect() will handle more error conditions: let's track
them explicitly.

As a bonus, explicitly annotate TCP-level disconnect as not failing:
the mptcp code never blocks for event on the subflows.

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8e152a8619a..ce1a70ad37cf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1759,7 +1759,13 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
 	} else if (ret && ret != -EINPROGRESS) {
-		mptcp_disconnect(sk, 0);
+		/* The disconnect() op called by tcp_sendmsg_fastopen()/
+		 * __inet_stream_connect() is failed, due to looking check,
+		 * see mptcp_disconnect().
+		 * Attempt it again outside the problematic scope.
+		 */
+		if (!mptcp_disconnect(sk, 0))
+			sk->sk_socket->state = SS_UNCONNECTED;
 	}
 	inet_sk(sk)->defer_connect = 0;
 
@@ -2424,7 +2430,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		tcp_disconnect(ssk, 0);
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
 		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
@@ -2870,7 +2879,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			break;
 		fallthrough;
 	case TCP_SYN_SENT:
-		tcp_disconnect(ssk, O_NONBLOCK);
+		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
@@ -3134,11 +3143,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
-	 * msk->firstsocket lock). Do nothing and leave the cleanup to the
-	 * caller.
+	 * msk->firstsocket lock).
 	 */
 	if (msk->fastopening)
-		return 0;
+		return -EBUSY;
 
 	mptcp_listen_inuse_dec(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
-- 
2.40.1

