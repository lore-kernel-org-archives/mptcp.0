Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D28EF
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 10:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666173755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owPDeMElgBtwxyZbMxAAYSiYM74n7F8RQNiynGcF0kw=;
	b=FrA1Kl4XT2+cHRjraan85ZuZwXRTyk1hp9R2ilHPxLuB/394Inv6SHhpKNnaBqG63dTfQf
	hGU9KWcv0lNbtzR3+KMCJ4W+ExkMzcKLqGKiszPNSrg5EeLjzXGFWM4b95ebnDcbhqz124
	kMY6Kx+w+eaYlqIAxHbxYnABLJCVMfo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-RdbcssAaMMGCZ6SfOW6UXQ-1; Wed, 19 Oct 2022 06:02:32 -0400
X-MC-Unique: RdbcssAaMMGCZ6SfOW6UXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C835080280D;
	Wed, 19 Oct 2022 10:02:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F52F2024CBF;
	Wed, 19 Oct 2022 10:02:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 1/2] net: introduce and use custom sockopt socket flag
Date: Wed, 19 Oct 2022 12:02:00 +0200
Message-Id: <b9ca7b78bec42047bc9935be2697328c7b71b391.1666173045.git.pabeni@redhat.com>
In-Reply-To: <cover.1666173045.git.pabeni@redhat.com>
References: <cover.1666173045.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4

We will soon introduce custom setsockopt for UDP sockets, too.
Instead of doing even more complex arbitrary checks inside
sock_use_custom_sol_socket(), add a new socket flag and set it
for the relevant socket types (currently only MPTCP).

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/net.h  | 1 +
 net/mptcp/protocol.c | 4 ++++
 net/socket.c         | 8 +-------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 711c3593c3b8..59350fd85823 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -41,6 +41,7 @@ struct net;
 #define SOCK_NOSPACE		2
 #define SOCK_PASSCRED		3
 #define SOCK_PASSSEC		4
+#define SOCK_CUSTOM_SOCKOPT	5
 
 #ifndef ARCH_HAS_SOCKET_TYPES
 /**
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f599ad44ed24..0448a5c3da3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2708,6 +2708,8 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
 
+	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone will
 	 * propagate the correct value
 	 */
@@ -3684,6 +3686,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		struct mptcp_subflow_context *subflow;
 		struct sock *newsk = newsock->sk;
 
+		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+
 		lock_sock(newsk);
 
 		/* PM/worker can now acquire the first subflow socket
diff --git a/net/socket.c b/net/socket.c
index 00da9ce3dba0..55c5d536e5f6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2199,13 +2199,7 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
 
 static bool sock_use_custom_sol_socket(const struct socket *sock)
 {
-	const struct sock *sk = sock->sk;
-
-	/* Use sock->ops->setsockopt() for MPTCP */
-	return IS_ENABLED(CONFIG_MPTCP) &&
-	       sk->sk_protocol == IPPROTO_MPTCP &&
-	       sk->sk_type == SOCK_STREAM &&
-	       (sk->sk_family == AF_INET || sk->sk_family == AF_INET6);
+	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 }
 
 /*
-- 
2.37.3

