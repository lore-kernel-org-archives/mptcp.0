Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD8AD54
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2szHhoL05307008MozVzBw9QdSsIq4UyYSwxBlQfqo=;
	b=HhePZPTxcxadb7IhE1dvFPcIbSG0hvxz1XLMe8mmgrbckDnj91NU8pXAoY3vKHdiOdvmB7
	ymEkiim4CGGZer5N3iblEQ+LZIm8cslOopyHH9m7uvQpmI0Qb/gVFjp8B960T+jt2XiM7c
	f1RPMakJNc1NFJ2yfAoTsH5rZ2h4XJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-QpxhwlSEOVK_Z6pVhRRRnQ-1; Fri, 13 Jan 2023 13:21:11 -0500
X-MC-Unique: QpxhwlSEOVK_Z6pVhRRRnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C04A85C1A0
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEB7C4078903
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 7/9] mptcp: do not keep around the first subflow after disconnect.
Date: Fri, 13 Jan 2023 19:20:54 +0100
Message-Id: <64723f701e27c7f44d96b7a28a25857e3a93c942.1673629755.git.pabeni@redhat.com>
In-Reply-To: <cover.1673629755.git.pabeni@redhat.com>
References: <cover.1673629755.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
index 1b93624db62d..9d440746704d 100644
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
 
@@ -3274,10 +3264,6 @@ static void mptcp_destroy(struct sock *sk)
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
2.38.1

