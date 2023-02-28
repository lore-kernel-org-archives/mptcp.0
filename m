Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B06D18
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677601171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WKN/8e/jg84EHksVJbWc5KU5gf8HhKmF7unQPWhXz08=;
	b=NSWklVDxY5YhszUJGZ72E9h3CXlHbA/WhUq0yQHYuqKLpfO6QkWAwPbegkj1KCoKzxAeEF
	scqtOgAUAb8yz+uTLXi3QXl1pIrs8GIH0ajSkB/MpvRBAIlbiGYLCMTi9oeUupqN52nO2g
	N0UBKLuPSAaGIKtxcizQ8/n04mb0oP0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-YbUgGjYcNYSdD5rN08z0Sg-1; Tue, 28 Feb 2023 11:19:28 -0500
X-MC-Unique: YbUgGjYcNYSdD5rN08z0Sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D391C1C05136
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 634632026D4B
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] Squash-to: mptcp: use the workqueue to destroy unaccepted sockets
Date: Tue, 28 Feb 2023 17:19:19 +0100
Message-Id: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The workqueue could trigger before inet_csk_listen_stop() kicks-in,
or the closed socket could even land to accept(). Solve the race
falling back to TCP - we already complete the MPTCP level close
signaling.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/366

possibly worth manual handling
---
 net/mptcp/protocol.c | 14 +++++++++++++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  6 +++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 08a912bb7215..467989c2b0ec 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2398,7 +2398,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out;
 	}
 
-	sock_orphan(ssk);
 	subflow->disposable = 1;
 
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
@@ -2406,7 +2405,20 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 * reference owned by msk;
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
+		WARN_ON_ONCE(!sock_flag(sk, SOCK_DEAD));
 		kfree_rcu(subflow, rcu);
+	} else if (msk->in_accept_queue && msk->first == ssk) {
+		/* if the first subflow moved to a close state, e.g. due to
+		 * incoming reset and we reach here before inet_child_forget()
+		 * the TCP stack could later try to close it via
+		 * inet_csk_listen_stop(), or deliver it to the user space via
+		 * accept().
+		 * We can't delete the subflow - or risk a double free - nor let
+		 * the msk survive - or will be leaked in the non accept scenario:
+		 * fallback and let TCP cope with the subflow cleanup.
+		 */
+		WARN_ON_ONCE(sock_flag(sk, SOCK_DEAD));
+		mptcp_subflow_drop_ctx(ssk);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		if (ssk->sk_state == TCP_LISTEN) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba4d22ffd228..46962a2581b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -682,6 +682,8 @@ void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_drop_ctx(struct sock *ssk);
+
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bdbe9c783eed..cda6dc4cc6a7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -717,7 +717,7 @@ static void subflow_ulp_fallback(struct sock *sk,
 	mptcp_subflow_ops_undo_override(sk);
 }
 
-static void subflow_drop_ctx(struct sock *ssk)
+void mptcp_subflow_drop_ctx(struct sock *ssk)
 {
 	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
 
@@ -823,7 +823,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			if (new_msk)
 				mptcp_copy_inaddrs(new_msk, child);
-			subflow_drop_ctx(child);
+			mptcp_subflow_drop_ctx(child);
 			goto out;
 		}
 
@@ -914,7 +914,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 dispose_child:
-	subflow_drop_ctx(child);
+	mptcp_subflow_drop_ctx(child);
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-- 
2.39.2

