Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAA6FC8
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGxNXb5AAUHd4ml2+3mWQDjJlRRhPEzMsUZG876sX2s=;
	b=fzs67XzInJTNa9ydHo0Dd71WB/I1y1+auyoRInuJ5NJTnQSiE9m/EwYVVkq2lRRzhflGdf
	jF70D/rYIrRhloRFyOGiZ5hLK3EXTO4vm3uH+G49+hb94af/9qmRGrSA9Lv5XxuQb6HMcE
	fDpE1K+nv02bYRvhpCxZdfPiRC5meXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-_y9C9nzAMcGS14JlREtFeA-1; Fri, 14 Jul 2023 07:30:00 -0400
X-MC-Unique: _y9C9nzAMcGS14JlREtFeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32829805C10
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B64662166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 04/13] net: factor out inet{,6}_bind_sk helpers
Date: Fri, 14 Jul 2023 13:29:35 +0200
Message-ID: <0ae88674cecce303698c169be39bdeefe27e9232.1689334116.git.pabeni@redhat.com>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
References: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

