Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E85393
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+gQx1AZjh2EmN9aClJ0FoXEeH93dbTsQFJlPh+6y40=;
	b=FRHpA8QHV1mLKNjFr68Gc7/h0Vsf37ZR07xamkMkD3dOtksq1IvOr87fJ6ld+/aUP2KmMi
	13mrtSTNU8JsVE+sCwhAGJFFkWF4TR/Uymt9BVgJ9GpkjUA+CrUC8+GQgaXMkP3PG3+D98
	geqV1js8uzlOHV+Y73oyPuxgcgiZOJs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-hDXBzWfCMxODXBGasUwBWg-1; Thu, 26 Jan 2023 16:05:46 -0500
X-MC-Unique: hDXBzWfCMxODXBGasUwBWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2789E382C96E
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B199A492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 09/15] mptcp: move first subflow allocation at mpc access time
Date: Thu, 26 Jan 2023 22:05:14 +0100
Message-Id: <192ab619774a07e38780eb95f9a3ff8abaeaad77.1674767058.git.pabeni@redhat.com>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
References: <cover.1674767058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In the long run this will simplify the mptcp code and will
allow for more consistent behavior. Move the first subflow
allocation out of the sock->init ops into the __mptcp_nmpc_socket()
helper.

Since the first subflow creation can now happen after the first
setsockopt() we additionally need to invoke mptcp_sockopt_sync()
on it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - more describing comment for __mptcp_nmpc_socket()
 - fully returns error code in mptcp_getsockopt_first_sf_only()
   Yes, this is the opposite of what discussed on the ML, but
   I had a last minute re-think about it: restricting the returned
   error codes in that point would be incoherent with other
   places, I think/hope consistency will help long-term mainteinance

v1 -> v2:
 - really remove subflow creation from init() (!!!)
---
 net/mptcp/pm_netlink.c |  4 +--
 net/mptcp/protocol.c   | 61 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  2 +-
 net/mptcp/sockopt.c    | 22 ++++++++-------
 4 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 155916174841..d1d859517d91 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1016,8 +1016,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	lock_sock(newsk);
 	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
 	release_sock(newsk);
-	if (!ssock)
-		return -EINVAL;
+	if (IS_ERR(ssock))
+		return PTR_ERR(ssock);
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9df49722e89..5ccd28764742 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -49,18 +49,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk);
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
-/* If msk has an initial subflow socket, and the MP_CAPABLE handshake has not
- * completed yet or has failed, return the subflow socket.
- * Otherwise return NULL.
- */
-struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
-{
-	if (!msk->subflow || READ_ONCE(msk->can_ack))
-		return NULL;
-
-	return msk->subflow;
-}
-
 /* Returns end sequence number of the receiver's advertised window */
 static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
@@ -116,6 +104,31 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	return 0;
 }
 
+/* If the MPC handshake is not started, returns the first subflow,
+ * eventually allocating it.
+ */
+struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		return ERR_PTR(-EINVAL);
+
+	if (!msk->subflow) {
+		if (msk->first)
+			return ERR_PTR(-EINVAL);
+
+		ret = __mptcp_socket_create(msk);
+		if (ret)
+			return ERR_PTR(ret);
+
+		mptcp_sockopt_sync(msk, msk->first);
+	}
+
+	return msk->subflow;
+}
+
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
 	sk_drops_add(sk, skb);
@@ -1699,6 +1712,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 {
 	unsigned int saved_flags = msg->msg_flags;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -1708,8 +1722,11 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	 * Since the defer_connect flag is cleared after the first succsful
 	 * fastopen attempt, no need to check for additional subflow status.
 	 */
-	if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
-		return -EINVAL;
+	if (msg->msg_flags & MSG_FASTOPEN) {
+		ssock = __mptcp_nmpc_socket(msk);
+		if (IS_ERR(ssock))
+			return PTR_ERR(ssock);
+	}
 	if (!msk->first)
 		return -EINVAL;
 
@@ -2768,10 +2785,6 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
-	ret = __mptcp_socket_create(mptcp_sk(sk));
-	if (ret)
-		return ret;
-
 	ret = mptcp_init_sched(mptcp_sk(sk),
 			       mptcp_sched_find(mptcp_get_scheduler(net)));
 	if (ret)
@@ -3601,8 +3614,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	int err = -EINVAL;
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock)
-		return -EINVAL;
+	if (IS_ERR(ssock))
+		return PTR_ERR(ssock);
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
@@ -3690,8 +3703,8 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 	lock_sock(sock->sk);
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
+	if (IS_ERR(ssock)) {
+		err = PTR_ERR(ssock);
 		goto unlock;
 	}
 
@@ -3727,8 +3740,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
+	if (IS_ERR(ssock)) {
+		err = PTR_ERR(ssock);
 		goto unlock;
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5f1a30959b5c..3a055438c65e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,7 +632,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8a9656248b0f..1fb4615fe586 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -301,9 +301,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
 		ssock = __mptcp_nmpc_socket(msk);
-		if (!ssock) {
+		if (IS_ERR(ssock)) {
 			release_sock(sk);
-			return -EINVAL;
+			return PTR_ERR(ssock);
 		}
 
 		ret = sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
@@ -396,9 +396,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		lock_sock(sk);
 		ssock = __mptcp_nmpc_socket(msk);
-		if (!ssock) {
+		if (IS_ERR(ssock)) {
 			release_sock(sk);
-			return -EINVAL;
+			return PTR_ERR(ssock);
 		}
 
 		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
@@ -693,9 +693,9 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 	lock_sock(sk);
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
+	if (IS_ERR(ssock)) {
 		release_sock(sk);
-		return -EINVAL;
+		return PTR_ERR(ssock);
 	}
 
 	issk = inet_sk(ssock->sk);
@@ -762,13 +762,15 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *sock;
-	int ret = -EINVAL;
+	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
 	lock_sock(sk);
 	sock = __mptcp_nmpc_socket(msk);
-	if (!sock)
+	if (IS_ERR(sock)) {
+		ret = PTR_ERR(sock);
 		goto unlock;
+	}
 
 	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
 
@@ -872,8 +874,10 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	}
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock)
+	if (IS_ERR(ssock)) {
+		ret = PTR_ERR(ssock);
 		goto out;
+	}
 
 	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
 
-- 
2.39.1

