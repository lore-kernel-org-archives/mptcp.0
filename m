Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE023C082
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAWbWeMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701767553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XkU1JSudaPAdaVBrckGGtum5O8AMv78+dv/co6Vyjng=;
	b=WAWbWeMttHGRZCZm5trfymZ+8LB+nr3TnFszhBimvBUDE3o1HtUvIeBA3flcYMkZ6A3FfL
	Egdk9U9nlEOYaWZ/jH3+3Su1Rc6M/VRUJgxYrdrlI9kZg08syWsdFMzdfurNsZrCDYXI1/
	jcb4D3CH0N2lnr8sIEQqEVZpK9aHAN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-zAxrwjWLMcO82kWXhKZwTw-1; Tue, 05 Dec 2023 04:12:26 -0500
X-MC-Unique: zAxrwjWLMcO82kWXhKZwTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2317C83DDE0
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 09:12:26 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1BE51121313
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 09:12:25 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
Date: Tue,  5 Dec 2023 10:12:21 +0100
Message-ID: <20231205091221.2657807-1-dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Eric Dumazet suggests:

 > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
 > bit strange to me.
 > mptcp_is_tcpsk() should answer a question, with a read-only argument.

re-factor code to avoid overwriting sock_ops inside that function. Also,
change the helper name to reflect the semantics and to disambiguate from
its dual, sk_is_mptcp(). While at it, collapse mptcp_stream_accept() and
mptcp_accept() into a single function, where fallback / non-fallback are
separated into a single sk_is_mptcp() conditional.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/protocol.c | 110 ++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 64 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68d..31822a4fb16e8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,28 +55,16 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->wnd_end);
 }
 
-static bool mptcp_is_tcpsk(struct sock *sk)
+static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
-		/* we are being invoked after mptcp_accept() has
-		 * accepted a non-mp-capable flow: sk is a tcp_sk,
-		 * not an mptcp one.
-		 *
-		 * Hand the socket over to tcp so all further socket ops
-		 * bypass mptcp.
-		 */
-		WRITE_ONCE(sock->ops, &inet_stream_ops);
-		return true;
+	if (sk->sk_prot == &tcp_prot)
+		return &inet_stream_ops;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
-		WRITE_ONCE(sock->ops, &inet6_stream_ops);
-		return true;
+	else if (sk->sk_prot == &tcpv6_prot)
+		return &inet6_stream_ops;
 #endif
-	}
-
-	return false;
+	WARN_ON_ONCE(1);
+	return sk->sk_socket->ops;
 }
 
 static int __mptcp_socket_create(struct mptcp_sock *msk)
@@ -3258,44 +3246,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
-static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
-				 bool kern)
-{
-	struct sock *newsk;
-
-	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
-	newsk = inet_csk_accept(ssk, flags, err, kern);
-	if (!newsk)
-		return NULL;
-
-	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
-	if (sk_is_mptcp(newsk)) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *new_mptcp_sock;
-
-		subflow = mptcp_subflow_ctx(newsk);
-		new_mptcp_sock = subflow->conn;
-
-		/* is_mptcp should be false if subflow->conn is missing, see
-		 * subflow_syn_recv_sock()
-		 */
-		if (WARN_ON_ONCE(!new_mptcp_sock)) {
-			tcp_sk(newsk)->is_mptcp = 0;
-			goto out;
-		}
-
-		newsk = new_mptcp_sock;
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
-	}
-
-out:
-	newsk->sk_kern_sock = kern;
-	return newsk;
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3739,7 +3689,6 @@ static struct proto mptcp_prot = {
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
-	.accept		= mptcp_accept,
 	.setsockopt	= mptcp_setsockopt,
 	.getsockopt	= mptcp_getsockopt,
 	.shutdown	= mptcp_shutdown,
@@ -3849,18 +3798,36 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	if (!ssk)
 		return -EINVAL;
 
-	newsk = mptcp_accept(ssk, flags, &err, kern);
+	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, &err, kern);
 	if (!newsk)
 		return err;
 
-	lock_sock(newsk);
-
-	__inet_accept(sock, newsock, newsk);
-	if (!mptcp_is_tcpsk(newsock->sk)) {
-		struct mptcp_sock *msk = mptcp_sk(newsk);
+	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
+	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
+		struct sock *new_mptcp_sock;
+
+		subflow = mptcp_subflow_ctx(newsk);
+		new_mptcp_sock = subflow->conn;
+
+		/* is_mptcp should be false if subflow->conn is missing, see
+		 * subflow_syn_recv_sock()
+		 */
+		if (WARN_ON_ONCE(!new_mptcp_sock)) {
+			tcp_sk(newsk)->is_mptcp = 0;
+			goto out;
+		}
+
+		newsk = new_mptcp_sock;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
 
 		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
@@ -3882,6 +3849,21 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				inet_sk_state_store(newsk, TCP_CLOSE);
 		}
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+out:
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
+		/* we are being invoked after accepting a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		WRITE_ONCE(newsock->sk->sk_socket->ops,
+			   mptcp_fallback_tcp_ops(newsock->sk));
 	}
 	release_sock(newsk);
 
-- 
2.27.0

