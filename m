Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B880C
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlPtSxuSSyAeGp222kI07CojQxwNI4w1YXE18ZWpW4s=;
	b=UihbB1VhIjW1FlxO+P1ZbG1l9DL/e1uDY/085mlVP8I1BnFtjCuDC00BDXHGIwJF7tGvPu
	PFxCrKAvWr/CWgUh75vGZQyUSrSrjLsZNJhMLGkLouJwry5tfmJbDegDngmd4D9ZaQ2UsK
	Qxg6keYFPz/9rIv8ND1Ui5y8yccJy70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-Kre9J4gkO2OgT0xMdMW1Pg-1; Mon, 10 Jul 2023 08:55:28 -0400
X-MC-Unique: Kre9J4gkO2OgT0xMdMW1Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE77B858290
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED3BC09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 07/14] net: factor out __inet_listen_sk() helper
Date: Mon, 10 Jul 2023 14:55:02 +0200
Message-ID: <c5d9a8a411ec56d847418aad437b63d24872cb71.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp protocol maintains an additional socket just to easily
invoke a few stream operations on the first subflow. One of them
is inet_listen().

Factor out an helper operating directly on the (locked) struct sock,
to allow get rid of the above dependency in the next patch without
duplicating the existing code.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/inet_common.h |  1 +
 net/ipv4/af_inet.c        | 39 +++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 8e97de700991..f50a644d87a9 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -40,6 +40,7 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
 int inet_shutdown(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
+int __inet_listen_sk(struct sock *sk, int backlog);
 void inet_sock_destruct(struct sock *sk);
 int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
 int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 2fd23437c1d2..fa482e314162 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -187,24 +187,13 @@ static int inet_autobind(struct sock *sk)
 	return 0;
 }
 
-/*
- *	Move a socket into listening state.
- */
-int inet_listen(struct socket *sock, int backlog)
+int __inet_listen_sk(struct sock *sk, int backlog)
 {
-	struct sock *sk = sock->sk;
-	unsigned char old_state;
+	unsigned char old_state = sk->sk_state;
 	int err, tcp_fastopen;
 
-	lock_sock(sk);
-
-	err = -EINVAL;
-	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
-		goto out;
-
-	old_state = sk->sk_state;
 	if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
-		goto out;
+		return -EINVAL;
 
 	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
 	/* Really, if the socket is already in listen state
@@ -227,10 +216,28 @@ int inet_listen(struct socket *sock, int backlog)
 
 		err = inet_csk_listen_start(sk);
 		if (err)
-			goto out;
+			return err;
+
 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
 	}
-	err = 0;
+	return 0;
+}
+
+/*
+ *	Move a socket into listening state.
+ */
+int inet_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	lock_sock(sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto out;
+
+	err = __inet_listen_sk(sk, backlog);
 
 out:
 	release_sock(sk);
-- 
2.41.0

