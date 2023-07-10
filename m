Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BA80C
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGxNXb5AAUHd4ml2+3mWQDjJlRRhPEzMsUZG876sX2s=;
	b=V+5TvXaE15EUwEb1LqDuPDFn/OdYImLvhjqQlKVF+DMkHIuU3ON4D93cu2gWYXJqgsJ132
	OvKO9zkq6kakToRyHrLtBHaecvB0FkMiC6zvyOXUEIodaydtITH0VScift78l/pb9P+yda
	NLAFzEzmMxrSTIdU4FxMdC7z2pl61So=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-g8cQ4Kw1PIegx99PrHzyRA-1; Mon, 10 Jul 2023 08:55:26 -0400
X-MC-Unique: g8cQ4Kw1PIegx99PrHzyRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79430101A54E
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 089CDC09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 05/14] net: factor out inet{,6}_bind_sk helpers
Date: Mon, 10 Jul 2023 14:55:00 +0200
Message-ID: <97fc442ffea35c420916bee59e8595290c0c28d2.1688993569.git.pabeni@redhat.com>
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
invoke a few stream operations on the first subflow. One of
them is bind().

Factor out the helpers operating directly on the struct sock, to
allow get rid of the above dependency in the next patch without
duplicating the existing code.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/inet_common.h |  1 +
 include/net/ipv6.h        |  1 +
 net/ipv4/af_inet.c        |  8 ++++++--
 net/ipv6/af_inet6.c       | 10 +++++++---
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index b86b8e21de7f..8e97de700991 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -42,6 +42,7 @@ int inet_shutdown(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 void inet_sock_destruct(struct sock *sk);
 int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 /* Don't allocate port at this moment, defer to connect. */
 #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
 /* Grab and release socket lock. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..af761504e2f6 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1220,6 +1220,7 @@ void inet6_cleanup_sock(struct sock *sk);
 void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer);
 int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9b2ca2fcc5a1..2fd23437c1d2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -431,9 +431,8 @@ int inet_release(struct socket *sock)
 }
 EXPORT_SYMBOL(inet_release);
 
-int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
-	struct sock *sk = sock->sk;
 	u32 flags = BIND_WITH_LOCK;
 	int err;
 
@@ -454,6 +453,11 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 	return __inet_bind(sk, uaddr, addr_len, flags);
 }
+
+int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	return inet_bind_sk(sock->sk, uaddr, addr_len);
+}
 EXPORT_SYMBOL(inet_bind);
 
 int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 5d593ddc0347..d68959434256 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -435,10 +435,8 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	goto out;
 }
 
-/* bind for INET6 API */
-int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
-	struct sock *sk = sock->sk;
 	u32 flags = BIND_WITH_LOCK;
 	const struct proto *prot;
 	int err = 0;
@@ -462,6 +460,12 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 	return __inet6_bind(sk, uaddr, addr_len, flags);
 }
+
+/* bind for INET6 API */
+int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	return inet6_bind_sk(sock->sk, uaddr, addr_len);
+}
 EXPORT_SYMBOL(inet6_bind);
 
 int inet6_release(struct socket *sock)
-- 
2.41.0

