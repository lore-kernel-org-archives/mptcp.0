Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9411CBC
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9QsJgvZDYs/XVLTfaGLB7/pV8l+Qvhr3aU/ISUo/bQ=;
	b=fdh1JQdd+DfvVr72s4LeGmOXo44D8FDU+0o/V93CO2myhLwnPyt2fC7VFOHnI1v0w5P6HL
	6Yz8Q/q/snfxUPFhVgJZIXyGH6FPdOyAjF5G4eVVSIk0ZgzKLgyl53Vdkb6iXGoNs/+0hr
	7zY29XwstUXVMWTXvBc4CdQAaIYqebc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-dzlRzrpNPFasN_iLTgDYDA-1; Fri, 14 Jul 2023 07:30:06 -0400
X-MC-Unique: dzlRzrpNPFasN_iLTgDYDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 235B2381495B
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A64932166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 12/13] mptcp: change the mpc check helper to return a sk
Date: Fri, 14 Jul 2023 13:29:43 +0200
Message-ID: <739a0a577cbf621e2132e1003e597c47eaf1f05c.1689334116.git.pabeni@redhat.com>
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

After the previous patch the __mptcp_nmpc_socket helper is used
only to ensure that the MPTCP socket is a suitable status - that
is, the mptcp capable handshake is not started yet.

Change the return value to the relevant subflow sock, to finally
remove the last references to first subflow socket in the MPTCP stack.

As a bonus, we can get rid of a few local variables in different
functions.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c |  8 +++-----
 net/mptcp/protocol.c   | 40 +++++++++++++++------------------------
 net/mptcp/protocol.h   |  2 +-
 net/mptcp/sockopt.c    | 43 +++++++++++++++++++-----------------------
 4 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b939e442477a..9661f3812682 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1004,7 +1004,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-	struct socket *ssock;
 	int backlog = 1024;
 	int err;
 
@@ -1030,17 +1029,16 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 				      &mptcp_keys[is_ipv6]);
 
 	lock_sock(newsk);
-	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
+	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
 	release_sock(newsk);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	if (IS_ERR(ssk))
+		return PTR_ERR(ssk);
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk = mptcp_sk(newsk)->first;
 	if (ssk->sk_family == AF_INET)
 		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbc17fdac0ef..47079c257e52 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -108,7 +108,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 /* If the MPC handshake is not started, returns the first subflow,
  * eventually allocating it.
  */
-struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
+struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	int ret;
@@ -116,10 +116,7 @@ struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
 	if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		return ERR_PTR(-EINVAL);
 
-	if (!msk->subflow) {
-		if (msk->first)
-			return ERR_PTR(-EINVAL);
-
+	if (!msk->first) {
 		ret = __mptcp_socket_create(msk);
 		if (ret)
 			return ERR_PTR(ret);
@@ -127,7 +124,7 @@ struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
 		mptcp_sockopt_sync(msk, msk->first);
 	}
 
-	return msk->subflow;
+	return msk->first;
 }
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
@@ -1671,7 +1668,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 {
 	unsigned int saved_flags = msg->msg_flags;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -1682,9 +1678,9 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	 * fastopen attempt, no need to check for additional subflow status.
 	 */
 	if (msg->msg_flags & MSG_FASTOPEN) {
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock))
-			return PTR_ERR(ssock);
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk))
+			return PTR_ERR(ssk);
 	}
 	if (!msk->first)
 		return -EINVAL;
@@ -3617,16 +3613,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 	int err = -EINVAL;
 	struct sock *ssk;
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		return PTR_ERR(ssk);
 
 	inet_sk_state_store(sk, TCP_SYN_SENT);
-	ssk = msk->first;
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3724,17 +3718,15 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *ssk, *sk = sock->sk;
-	struct socket *ssock;
 	int err = -EINVAL;
 
 	lock_sock(sk);
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		err = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		err = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ssk = msk->first;
 	if (sk->sk_family == AF_INET)
 		err = inet_bind_sk(ssk, uaddr, addr_len);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -3753,7 +3745,6 @@ static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int err;
 
@@ -3765,13 +3756,12 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
 		goto unlock;
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		err = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		err = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ssk = msk->first;
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb4d50c8c398..c26587fd7d50 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -636,7 +636,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
+struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 348475dcbc23..91ee1aa2284e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -292,7 +292,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -302,13 +301,12 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_BINDTODEVICE:
 	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock)) {
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk)) {
 			release_sock(sk);
-			return PTR_ERR(ssock);
+			return PTR_ERR(ssk);
 		}
 
-		ssk = msk->first;
 		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
@@ -392,7 +390,6 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 {
 	struct sock *sk = (struct sock *)msk;
 	int ret = -EOPNOTSUPP;
-	struct socket *ssock;
 	struct sock *ssk;
 
 	switch (optname) {
@@ -400,13 +397,12 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_TRANSPARENT:
 	case IPV6_FREEBIND:
 		lock_sock(sk);
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock)) {
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk)) {
 			release_sock(sk);
-			return PTR_ERR(ssock);
+			return PTR_ERR(ssk);
 		}
 
-		ssk = msk->first;
 		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
 		if (ret != 0) {
 			release_sock(sk);
@@ -689,7 +685,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 {
 	struct sock *sk = (struct sock *)msk;
 	struct inet_sock *issk;
-	struct socket *ssock;
+	struct sock *ssk;
 	int err;
 
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
@@ -698,13 +694,13 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 
 	lock_sock(sk);
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
 		release_sock(sk);
-		return PTR_ERR(ssock);
+		return PTR_ERR(ssk);
 	}
 
-	issk = inet_sk(msk->first);
+	issk = inet_sk(ssk);
 
 	switch (optname) {
 	case IP_FREEBIND:
@@ -767,18 +763,18 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 					  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *sock;
+	struct sock *ssk;
 	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
 	lock_sock(sk);
-	sock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(sock)) {
-		ret = PTR_ERR(sock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		ret = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 
 unlock:
 	release_sock(sk);
@@ -868,7 +864,6 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 					  char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -879,9 +874,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		ret = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		ret = PTR_ERR(ssk);
 		goto out;
 	}
 
-- 
2.41.0

