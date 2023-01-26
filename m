Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86F5394
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYNkH/bGQDAuGvpFdy3/Q2d8ga0b8MWtqnl+vIie7xA=;
	b=NFtGU+Eu5u7DR1REHc126U/d1LWY15AI0VFWpn/vG5RfibJx0Tncc6O23oTg3SeO7PMsfT
	reHOAD55hZLKAdp/+Tw1QgoYwPhh8UMrsdjALj4dRWJVeq5TTlwb08wd0O66cTVwuCjqy6
	KvT/zVA051xiZa05s7ZzsUyLRvRienI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-1NCMhlyfPxGSyI9flssEzA-1; Thu, 26 Jan 2023 16:05:47 -0500
X-MC-Unique: 1NCMhlyfPxGSyI9flssEzA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89631991C44
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B113492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 10/15] mptcp: do not keep around the first subflow after disconnect.
Date: Thu, 26 Jan 2023 22:05:15 +0100
Message-Id: <ba9b8bdeea40d9bc11ce7728f8a9462d8c6d480d.1674767058.git.pabeni@redhat.com>
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
index 5ccd28764742..98eaf8314521 100644
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
 
@@ -3279,10 +3269,6 @@ static void mptcp_destroy(struct sock *sk)
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
2.39.1

