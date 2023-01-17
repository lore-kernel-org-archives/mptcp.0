Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA21FB7
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI7KDsVT/Mi0T+DWAF9+aOS8tyYS2rhVoEOXIYb/AF8=;
	b=evnzcEo2CaISeUKmrPyqMA8hqiWOkelSqqLRWuEye3bZAPO5kVlwPA7kH+i4UiM4cVF+ks
	XY1uY/HWlaldYwtzGCxTPuwzj7pkV0XcVonfpDjDo1VMo8AW3HYAMhPutGZcS+9NSiXOYP
	Y5R0G8TMdhCKWNDH4J9eBt2Ang1VRaU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-rntRgAl9OS-wHYgoeaMOzQ-1; Tue, 17 Jan 2023 02:37:19 -0500
X-MC-Unique: rntRgAl9OS-wHYgoeaMOzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C7492804127
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF5D540C2064
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 09/13] mptcp: do not keep around the first subflow after disconnect.
Date: Tue, 17 Jan 2023 08:36:29 +0100
Message-Id: <e95fb0ec5b8c920c9bc6583642c257a7252b2621.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the previous patch the first subflow is allocated as
needed at bind, connect, listen time. We don't need anymore
to keep alive the first subflow after a disconnect just to
be able to perform such syscall.

Overal this change makes the passive and active sockets consistent:
even passive sockets will be allowed to complete life cycle after
disconnect.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/290
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4f7a71561efd..b867e3eec5b9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2371,11 +2371,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	bool need_push, dispose_it;
+	bool need_push;
 
-	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
-	if (dispose_it)
-		list_del(&subflow->node);
+	list_del(&subflow->node);
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
@@ -2389,15 +2387,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
-	if (!dispose_it) {
-		tcp_disconnect(ssk, 0);
-		msk->subflow->state = SS_UNCONNECTED;
-		mptcp_subflow_ctx_reset(subflow);
-		release_sock(ssk);
-
-		goto out;
-	}
-
 	sock_orphan(ssk);
 	subflow->disposable = 1;
 
@@ -2424,10 +2413,11 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	sock_put(ssk);
 
-	if (ssk == msk->first)
+	if (ssk == msk->first) {
 		msk->first = NULL;
+		mptcp_dispose_initial_subflow(msk);
+	}
 
-out:
 	if (ssk == msk->last_snd)
 		msk->last_snd = NULL;
 
@@ -3270,10 +3260,6 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* clears msk->subflow, allowing the following to close
-	 * even the initial subflow
-	 */
-	mptcp_dispose_initial_subflow(msk);
 	mptcp_destroy_common(msk, 0);
 	sk_sockets_allocated_dec(sk);
 }
-- 
2.39.0

