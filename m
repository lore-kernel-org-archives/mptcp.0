Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D98111CBC
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ol0Hep/2nAzre6eKlHHvYKy6RWx62u4KDSHiVXrzy/c=;
	b=CYqhVk4IN3zn4o6y2XSRHpaYqY3T3RjujGnbb2jReaBYH7lbcVeX4TIT1dkPNB05GlC4Rk
	W//IFSO6R5Y6fxdk3MEZlf+2dx4ptQeAk55O4z0ZRCzTXy3gDW0pUtssX6IDi/UlGjz96z
	PRufdMsXUbJEmYeUIP8Ky9tQAmhWEXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-373q2NQAONKGxDp1LKpdQw-1; Fri, 14 Jul 2023 07:29:58 -0400
X-MC-Unique: 373q2NQAONKGxDp1LKpdQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6441800159
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AA702166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 02/13] mptcp: avoid additional __inet_stream_connect() call
Date: Fri, 14 Jul 2023 13:29:33 +0200
Message-ID: <419f27ff608db6a749476301f6d52703e3666c09.1689334116.git.pabeni@redhat.com>
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
invoke a few stream operations on the first subflow. One of them is
__inet_stream_connect().

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at connect time, calling directly
into the sock-level connect() ops.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - added comment pointing to __inet_stream_connect() similar code (Mattbe)
 - fixed typo in the commit message (Mat)
---
 net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17174bdae1ca..8eaf19c01c64 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3629,22 +3629,24 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 	int err = -EINVAL;
+	struct sock *ssk;
 
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
 	inet_sk_state_store(sk, TCP_SYN_SENT);
-	subflow = mptcp_subflow_ctx(ssock->sk);
+	ssk = msk->first;
+	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
-		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
 	if (likely(!__mptcp_check_fallback(msk)))
@@ -3653,21 +3655,40 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* if reaching here via the fastopen/sendmsg path, the caller already
 	 * acquired the subflow socket lock, too.
 	 */
-	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
-	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
-	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
+	if (!msk->fastopening)
+		lock_sock(ssk);
+
+	/* the following mirrors closely a very small chunk of code from
+	 * __inet_stream_connect()
+	 */
+	if (ssk->sk_state != TCP_CLOSE)
+		goto out;
+
+	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
+		err = ssk->sk_prot->pre_connect(ssk, uaddr, addr_len);
+		if (err)
+			goto out;
+	}
+
+	err = ssk->sk_prot->connect(ssk, uaddr, addr_len);
+	if (err < 0)
+		goto out;
+
+	inet_sk(sk)->defer_connect = inet_sk(ssk)->defer_connect;
+
+out:
+	if (!msk->fastopening)
+		release_sock(ssk);
 
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err && err != -EINPROGRESS)) {
-		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+		inet_sk_state_store(sk, inet_sk_state_load(ssk));
 		return err;
 	}
 
-	mptcp_copy_inaddrs(sk, ssock->sk);
+	mptcp_copy_inaddrs(sk, ssk);
 
 	/* silence EINPROGRESS and let the caller inet_stream_connect
 	 * handle the connection in progress
-- 
2.41.0

