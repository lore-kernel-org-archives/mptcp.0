Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1AD27739
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673031459; x=1704567459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYkfLw3lNyqjFtVXKSCPLcbOp9J52QgCDURd+/dVVFc=;
  b=MclLZRy0BFeRYiEHi7MH4aOzcgtHGekGGQLfO+NzkJIhsvJ1jM5/NjPs
   SYcq2yXyyQQGXG8BInsmSHM4p4fqYwWDhAdcqsJbj1h4UisXICDDpCxb2
   HBihKYP5nqYoJtkZOaD/PgQZ6VmWG7uCtWJt+vpKY4UOlOM/zKQ52lz/m
   zXZ+D4XB1DeQCCK5/8nPCEbbmX5MyFS7F7ol9dbweb2nE0AfSaM3LMakM
   WeONFou07mErexqAEXqSWGKaDQm11Q9VNoxRhFTG5KrYIIndzbAbUJ6CF
   cC6uhsfU1A4GLwwJhldj2ZGLfeuhicCbI+50QDsCOEsPUnAPTAPzL4B2A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322611242"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="322611242"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="688383434"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="688383434"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Menglong Dong <imagedong@tencent.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/9] mptcp: add statistics for mptcp socket in use
Date: Fri,  6 Jan 2023 10:57:23 -0800
Message-Id: <20230106185725.299977-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
References: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

Do the statistics of mptcp socket in use with sock_prot_inuse_add().
Therefore, we can get the count of used mptcp socket from
/proc/net/protocols:

& cat /proc/net/protocols
protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 12 +++++++++++-
 net/mptcp/token.c    |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1ce003f15d70..13595d6dad8c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2891,6 +2891,12 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
+static void mptcp_listen_inuse_dec(struct sock *sk)
+{
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2900,6 +2906,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
+		mptcp_listen_inuse_dec(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3000,6 +3007,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return 0;
 
+	mptcp_listen_inuse_dec(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
@@ -3657,8 +3665,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	err = ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
-	if (!err)
+	if (!err) {
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+	}
 
 	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 3af502a374bc..5bb924534387 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -153,6 +153,7 @@ int mptcp_token_new_connect(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int retries = MPTCP_TOKEN_MAX_RETRIES;
+	struct sock *sk = subflow->conn;
 	struct token_bucket *bucket;
 
 again:
@@ -175,6 +176,7 @@ int mptcp_token_new_connect(struct sock *ssk)
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
 	bucket->chain_len++;
 	spin_unlock_bh(&bucket->lock);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	return 0;
 }
 
@@ -190,8 +192,10 @@ void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
+	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
 
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
 
@@ -370,12 +374,14 @@ void mptcp_token_destroy_request(struct request_sock *req)
  */
 void mptcp_token_destroy(struct mptcp_sock *msk)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
 	struct mptcp_sock *pos;
 
 	if (sk_unhashed((struct sock *)msk))
 		return;
 
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	bucket = token_bucket(msk->token);
 	spin_lock_bh(&bucket->lock);
 	pos = __token_lookup_msk(bucket, msk->token);
-- 
2.39.0

