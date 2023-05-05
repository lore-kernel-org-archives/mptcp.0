Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98104C2EF
	for <mptcp@lists.linux.dev>; Fri,  5 May 2023 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683315292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PILKqN7kXuoItU427+VyZis4QqtO9Zuj/Qd6VEgodSY=;
	b=HneUPrKE2Hzb7tQLO8Wjyfq6tzHk6GVuOE1CC9rE4W+HnkQE7PBQD+lB8Ibyuht9VpJnX8
	y2AoJXoJyrAzG1dRaFKdko52tWhOX2n0ZGEIeZ5dAjTh+w6MQt6kUzDAZt15M+RwivQxmD
	155zxldQkm6NTfvppVBsdnihNGpl9t4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-wQ8ut1ScMd2ZWGjp_iEI_g-1; Fri, 05 May 2023 15:34:51 -0400
X-MC-Unique: wQ8ut1ScMd2ZWGjp_iEI_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 292D2857E60
	for <mptcp@lists.linux.dev>; Fri,  5 May 2023 19:34:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 834E22026D25;
	Fri,  5 May 2023 19:34:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH mptcp-net] mptcp: fix connect timeout handling
Date: Fri,  5 May 2023 21:34:44 +0200
Message-Id: <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
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

Ondrej reported a functional issue WRT timeout handling on connect
with a nice reproducer.

The problem is that the current mptcp connect waits for both the
MPTCP socket level timeout, and the first subflow socket timeout.
The latter is not influenced/touched by the exposed setsockopt().

Overall the above makes the SO_SNDTIMEO a no-op on connect.

Since mptcp_connect is invoked via inet_stream_connect and the
latter properly handle the MPTCP level timeout, we can address the
issue making the nested subflow level connect always unblocking.

This also allow simplifying a bit the code, dropping an ugly hack
to handle the fastopen and custom proto_ops connect.

The issues predates the blamed commit below, but the current resolution
requires the infrastructure introduced there.

Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: there is needed follow-up correctly propagating the SYN_SENT
-> CLOSE state transition from the first subflow to the msk socket in
case of connect error, but that is somewhat independed/pre-existent.

Sending out early for testing.
---
 net/mptcp/protocol.c | 29 +++++++----------------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5842f93c891..4747058a8b6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1734,7 +1734,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
-	msk->connect_flags = O_NONBLOCK;
 	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
 	msk->fastopening = 0;
@@ -3672,9 +3671,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * acquired the subflow socket lock, too.
 	 */
 	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
+		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
 	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
+		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
 	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3687,12 +3686,10 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	mptcp_copy_inaddrs(sk, ssock->sk);
 
-	/* unblocking connect, mptcp-level inet_stream_connect will error out
-	 * without changing the socket state, update it here.
+	/* silence EINPROGRESS and let the caller inet_stream_connect
+	 * handle the connection in progress
 	 */
-	if (err == -EINPROGRESS)
-		sk->sk_socket->state = ssock->state;
-	return err;
+	return 0;
 }
 
 static struct proto mptcp_prot = {
@@ -3751,18 +3748,6 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	return err;
 }
 
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
-				int addr_len, int flags)
-{
-	int ret;
-
-	lock_sock(sock->sk);
-	mptcp_sk(sock->sk)->connect_flags = flags;
-	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
-	release_sock(sock->sk);
-	return ret;
-}
-
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
@@ -3917,7 +3902,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.owner		   = THIS_MODULE,
 	.release	   = inet_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet_getname,
@@ -4012,7 +3997,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.owner		   = THIS_MODULE,
 	.release	   = inet6_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet6_getname,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8d9d87e2f840..39613bba1c46 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -300,7 +300,6 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1;
-	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-- 
2.40.0

