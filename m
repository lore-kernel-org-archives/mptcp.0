Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4831BDF4
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0ttmeNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698764962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i3cJAEaJDSNr0w0kqupgoMWbbyduRuYzAQzClQIWzhg=;
	b=E0ttmeNYdDtFuIF24mI4rC5QNHROTh7QzLvUGmrFZOzaxT8dl1gI6gSExIeKqgufsR9k9x
	r/c0OY9eo8RqjNiRdRYovBciFaEydKkAQVpWtS157e+XbhJC6SilHzI/xa/EeEosR5SWeK
	E4b+dRcSi2GuRC8TDfcCkjZSwtHVhq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-pKJFGOLlMMWQxo5OUGGovQ-1; Tue, 31 Oct 2023 11:09:21 -0400
X-MC-Unique: pKJFGOLlMMWQxo5OUGGovQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28697811E88
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 15:09:21 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B04FC1121306
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 15:09:20 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] net/mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
Date: Tue, 31 Oct 2023 16:09:13 +0100
Message-ID: <a2581b975c0c5bec417b2dd5e0b014acd7770e14.1698764762.git.dcaratti@redhat.com>
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

Eric suggests:

 > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
 > bit strange to me.
 > mptcp_is_tcpsk() should answer a question, with a read-only argument.

re-factor code to avoid overwriting sock_ops inside that function. Also,
change the helper name to reflect the semantic, and to disambiguate from
its dual sk_is_mptcp().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/protocol.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ad507ac6bc7..9a9f8acd979e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,28 +55,15 @@ u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->wnd_end);
 }
 
-static bool mptcp_is_tcpsk(struct sock *sk)
+static const struct proto_ops *mptcp_get_fallback_tcp_ops(const struct sock *sk)
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
+	if (unlikely(sk->sk_prot == &tcp_prot))
+		return &inet_stream_ops;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
-		WRITE_ONCE(sock->ops, &inet6_stream_ops);
-		return true;
+	else if (unlikely(sk->sk_prot == &tcpv6_prot))
+		return &inet6_stream_ops;
 #endif
-	}
-
-	return false;
+	return NULL;
 }
 
 static int __mptcp_socket_create(struct mptcp_sock *msk)
@@ -3832,6 +3819,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	const struct proto_ops *fallback_ops;
 	struct sock *ssk, *newsk;
 	int err;
 
@@ -3851,7 +3839,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	lock_sock(newsk);
 
 	__inet_accept(sock, newsock, newsk);
-	if (!mptcp_is_tcpsk(newsock->sk)) {
+	fallback_ops = mptcp_get_fallback_tcp_ops(newsock->sk);
+	if (!fallback_ops) {
 		struct mptcp_sock *msk = mptcp_sk(newsk);
 		struct mptcp_subflow_context *subflow;
 
@@ -3877,6 +3866,15 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				inet_sk_state_store(newsk, TCP_CLOSE);
 		}
+	} else {
+		/* we are being invoked after mptcp_accept() has
+		 * accepted a non-mp-capable flow: sk is a tcp_sk,
+		 * not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		WRITE_ONCE(newsock->sk->sk_socket->ops, fallback_ops);
 	}
 	release_sock(newsk);
 
-- 
2.41.0

