Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BDA939
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692779334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEcTAIgQimIjgxx8oEynxFmf0wRPobmL9wC7HpqOL7w=;
	b=SWq8FSWR/GuafwQdUrAs3wJfyR1cGl45qXCr6u4RSA/VcrOdejzUjuqKI/IyZxgWhr0acM
	VwE8rcIG9qb9dvbVnM8Gy2jIIGrSnT7w7WpOwUeZ5pQlk7Dh2qv4jJuoVEoQcXrlJIiPg3
	gKsN+RM7dpXrKxzISCj51VEKnciqlbo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-MymwerveNS-BtJmI2yyxAA-1; Wed, 23 Aug 2023 04:28:52 -0400
X-MC-Unique: MymwerveNS-BtJmI2yyxAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09FB78015A8
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E9A2492C14
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 1/2] mptcp: move __mptcp_error_report in protocol.c
Date: Wed, 23 Aug 2023 10:28:40 +0200
Message-ID: <afcab92f049e431bb12351e2aa8b715c9d081b03.1692779220.git.pabeni@redhat.com>
In-Reply-To: <cover.1692779220.git.pabeni@redhat.com>
References: <cover.1692779220.git.pabeni@redhat.com>
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

This will simplify the next patch. No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab3aaf6cacc5..12d3b575ceba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -764,6 +764,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err = sock_error(ssk);
+		int ssk_state;
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+		break;
+	}
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9bf3c7bc1762..2f40c23fdb0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1362,42 +1362,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
-- 
2.41.0

