Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065122F34
	for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 11:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657883468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HGems0LCutp5I0DpH5X2WCkyCBJQupMG00wPWcmhl58=;
	b=HPCQ6TE7D992oZ+98auVw5TD9dt1BymlC2rY2j6gofgYDxAzAmp7RGJeUpudoFUVaXeRTd
	OTDDAiXC+IfOnbtPqnh8eYe9vN9JBTcpdVsL+K6kJaPgtF2V3Q+n0/915AZuw0OldAPDxb
	5DzxtPxBgRrHD2F95xYR48bf2EasrLY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-Gla4HKhUMgaOuHH_pApMWg-1; Fri, 15 Jul 2022 07:11:07 -0400
X-MC-Unique: Gla4HKhUMgaOuHH_pApMWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C153C0E21E;
	Fri, 15 Jul 2022 11:11:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D10802166B26;
	Fri, 15 Jul 2022 11:11:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: phind.uet@gmail.com
Subject: [PATCH mptcp-net] mptcp: move subflow cleanup in mptcp_destroy_common()
Date: Fri, 15 Jul 2022 13:10:44 +0200
Message-Id: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the mptcp socket creation fails due to a CGROUP_INET_SOCK_CREATE
eBPF program, the MPTCP protocol ends-up leaking all the subflows:
the related cleanup happens in __mptcp_destroy_sock() that is not
invoked in such code path.

Address the issue moving the subflow sockets cleanup in the
mptcp_destroy_common() helper, which is invoked in every msk cleanup
path.

Additionally get rid of the intermediate list_splice_init step, which
is an unneeded relic from the past.

The issue is present since before the reported root cause commit, but
any attempt to backport the fix before that hash will require a complete
rewrite.

Fixes: e16163b6e2 ("mptcp: refactor shutdown and close")
Reported-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Co-developed-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
The tags are provisional, waiting for Nguyen feedback/preferences.

Sending out early to trigger the CI.

This will need likely some staging period.

"mptcp: add mptcp_for_each_subflow_safe helper" needs to be rebased
on top of this (we can replace another list_for_each_safe instance)
---
 net/mptcp/protocol.c | 39 +++++++++++++++------------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  3 ++-
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21a3ed64226e..6f3324955355 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2804,30 +2804,16 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 static void __mptcp_destroy_sock(struct sock *sk)
 {
-	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	LIST_HEAD(conn_list);
 
 	pr_debug("msk=%p", msk);
 
 	might_sleep();
 
-	/* join list will be eventually flushed (with rst) at sock lock release time*/
-	list_splice_init(&msk->conn_list, &conn_list);
-
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
-	/* clears msk->subflow, allowing the following loop to close
-	 * even the initial subflow
-	 */
-	mptcp_dispose_initial_subflow(msk);
-	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		__mptcp_close_ssk(sk, ssk, subflow, 0);
-	}
-
 	sk->sk_prot->destroy(sk);
 
 	WARN_ON_ONCE(msk->rmem_fwd_alloc);
@@ -2919,24 +2905,20 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
-	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-
-		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
-	}
-
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (mptcp_sk(sk)->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
 
-	mptcp_destroy_common(msk);
+	/* msk->subflow is still intact, the following will not free the first
+	 * subflow
+	 */
+	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
@@ -3086,12 +3068,17 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	return newsk;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk)
+void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 {
+	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
 
 	__mptcp_clear_xmit(sk);
 
+	/* join list will be eventually flushed (with rst) at sock lock release time */
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+
 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
 	mptcp_data_lock(sk);
 	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
@@ -3113,7 +3100,11 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	mptcp_destroy_common(msk);
+	/* clears msk->subflow, allowing the following to close
+	 * even the initial subflow
+	 */
+	mptcp_dispose_initial_subflow(msk);
+	mptcp_destroy_common(msk, 0);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 480c5320b86e..78c8c471b22e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,7 +718,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	}
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk);
+void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63e8892ec807..fc4ceb02328d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -621,7 +621,8 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 
-	mptcp_destroy_common(mptcp_sk(sk));
+	/* We don't need to clear msk->subflow, as it's still NULL at this point */
+	mptcp_destroy_common(mptcp_sk(sk), 0);
 	inet_sock_destruct(sk);
 }
 
-- 
2.35.3

