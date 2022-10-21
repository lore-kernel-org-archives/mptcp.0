Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08136AB7
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666393144; x=1697929144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVoQO49mbb5TcS4QVTWYXVSx7xX/0TjdWjL77zoQ0eU=;
  b=h7Kk6SjyOQ6Ej7HqguKaav4IHL1GI4BCkbeYaqHE1pzVfgBYCQCl0BfT
   hmvV9hsucNr0I3HFBk8Q1aZMMGdI9H2/l+251lUZJJUNSh6Ni2NJds7PZ
   eo+1Nl1+gSQZp03DY4ciclZDmAI+hgtV7VfQ/CKKrZyP0aVHIXbenIA7d
   COlhwrVgqDpsq+G01wEpxFDBiYMyhYx0jXm8Xjz6paU9HM1A3EB0Eu8E6
   b+BVeeJzXoYDv3Zo7E1mYshg5rCLsWqii05lI8wUVGCoHzgaGFHrBUs5u
   D7+2acRNqjNt4DepKNQirbx67L10s/4+9UJYj17Tf1cPm6hab3IXeo3WZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333699092"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="333699092"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="663928732"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="663928732"
Received: from tremple-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	dmytro@shytyi.net,
	benjamin.hesmans@tessares.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/3] mptcp: factor out mptcp_connect()
Date: Fri, 21 Oct 2022 15:58:55 -0700
Message-Id: <20221021225856.88119-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
References: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The current MPTCP connect implementation duplicates a bit of inet
code and does not use nor provide a struct proto->connect callback,
which in turn will not fit the upcoming fastopen implementation.

Refactor such implementation to use the common helper, moving the
MPTCP-specific bits into mptcp_connect(). Additionally, avoid an
indirect call to the subflow connect callback.

Note that the fastopen call-path invokes mptcp_connect() while already
holding the subflow socket lock. Explicitly keep track of such path
via a new MPTCP-level flag and handle the locking accordingly.

Additionally, track the connect flags in a new msk field to allow
propagating them to the subflow inet_stream_connect call.

Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 136 ++++++++++++++++++++++---------------------
 net/mptcp/protocol.h |   4 +-
 2 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e33f9caf409d..f2930699c6d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1698,7 +1698,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		lock_sock(ssk);
 
+		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
+		msk->is_sendmsg = 1;
 		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
+		msk->is_sendmsg = 0;
 		copied += copied_syn;
 		if (ret == -EINPROGRESS && copied_syn > 0) {
 			/* reflect the new state on the MPTCP socket */
@@ -3507,10 +3510,73 @@ static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 	return put_user(answ, (int __user *)arg);
 }
 
+static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
+					 struct mptcp_subflow_context *subflow)
+{
+	subflow->request_mptcp = 0;
+	__mptcp_do_fallback(msk);
+}
+
+static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct socket *ssock;
+	int err = -EINVAL;
+
+	ssock = __mptcp_nmpc_socket(msk);
+	if (!ssock)
+		return -EINVAL;
+
+	mptcp_token_destroy(msk);
+	inet_sk_state_store(sk, TCP_SYN_SENT);
+	subflow = mptcp_subflow_ctx(ssock->sk);
+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+		mptcp_subflow_early_fallback(msk, subflow);
+#endif
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
+		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
+		mptcp_subflow_early_fallback(msk, subflow);
+	}
+	if (likely(!__mptcp_check_fallback(msk)))
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
+
+	/* if reaching here via the fastopen/sendmsg path, the caller already
+	 * acquired the subflow socket lock, too.
+	 */
+	if (msk->is_sendmsg)
+		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
+	else
+		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
+	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
+
+	/* on successful connect, the msk state will be moved to established by
+	 * subflow_finish_connect()
+	 */
+	if (unlikely(err && err != -EINPROGRESS)) {
+		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+		return err;
+	}
+
+	mptcp_copy_inaddrs(sk, ssock->sk);
+
+	/* unblocking connect, mptcp-level inet_stream_connect will error out
+	 * without changing the socket state, update it here.
+	 */
+	if (err == -EINPROGRESS)
+		sk->sk_socket->state = ssock->state;
+	return err;
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
+	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
 	.accept		= mptcp_accept,
@@ -3562,78 +3628,16 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	return err;
 }
 
-static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-					 struct mptcp_subflow_context *subflow)
-{
-	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
-}
-
 static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 				int addr_len, int flags)
 {
-	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-	struct mptcp_subflow_context *subflow;
-	struct socket *ssock;
-	int err = -EINVAL;
+	int ret;
 
 	lock_sock(sock->sk);
-	if (uaddr) {
-		if (addr_len < sizeof(uaddr->sa_family))
-			goto unlock;
-
-		if (uaddr->sa_family == AF_UNSPEC) {
-			err = mptcp_disconnect(sock->sk, flags);
-			sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
-			goto unlock;
-		}
-	}
-
-	if (sock->state != SS_UNCONNECTED && msk->subflow) {
-		/* pending connection or invalid state, let existing subflow
-		 * cope with that
-		 */
-		ssock = msk->subflow;
-		goto do_connect;
-	}
-
-	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock)
-		goto unlock;
-
-	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
-	subflow = mptcp_subflow_ctx(ssock->sk);
-#ifdef CONFIG_TCP_MD5SIG
-	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
-	 * TCP option space.
-	 */
-	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
-		mptcp_subflow_early_fallback(msk, subflow);
-#endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
-		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
-		mptcp_subflow_early_fallback(msk, subflow);
-	}
-	if (likely(!__mptcp_check_fallback(msk)))
-		MPTCP_INC_STATS(sock_net(sock->sk), MPTCP_MIB_MPCAPABLEACTIVE);
-
-do_connect:
-	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
-	inet_sk(sock->sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
-	sock->state = ssock->state;
-
-	/* on successful connect, the msk state will be moved to established by
-	 * subflow_finish_connect()
-	 */
-	if (!err || err == -EINPROGRESS)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
-	else
-		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-
-unlock:
+	mptcp_sk(sock->sk)->connect_flags = flags;
+	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
 	release_sock(sock->sk);
-	return err;
+	return ret;
 }
 
 static int mptcp_listen(struct socket *sock, int backlog)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index be19592441df..6a09ab99a12d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -285,7 +285,9 @@ struct mptcp_sock {
 	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
-			nodelay:1;
+			nodelay:1,
+			is_sendmsg:1;
+	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
-- 
2.38.1

