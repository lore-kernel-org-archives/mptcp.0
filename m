Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD76FC8
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SaSXFic5JPrABMsbLBxiXqzTD9bnvv3Y577KQqkdTA=;
	b=Jn2AAQ6gdijJAS0hswHcOFta5SUdpmOhctJpN21EE04WGWkD0kJkWL06p1ecJ6UeO0sfeo
	1Jb92O18u/vqJJ6XBMb0skTD2grzNT1tHK2K6SneHYf/uMoFMR0JXs4a0R8xc476aSnb9j
	TsLX+2PBPcRxxzvctHrFzWGpqe4U4TY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-SzYwif6xNKKkm1kmUdpmOw-1; Fri, 14 Jul 2023 07:30:02 -0400
X-MC-Unique: SzYwif6xNKKkm1kmUdpmOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 693608D1684
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC9672166B26
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 07/13] mptcp: avoid additional indirection in mptcp_listen()
Date: Fri, 14 Jul 2023 13:29:38 +0200
Message-ID: <ff3ad706b754495b96215d5ed7876b47cc46261b.1689334116.git.pabeni@redhat.com>
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

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at listen() time. Instead call
directly the recently introduced helper on the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - dropped msk backlog init chunk (Mat)
 - fixed commit message type (Mat)
---
 net/mptcp/protocol.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fa62e6d2d1ac..4d9775f45dd6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3762,6 +3762,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct socket *ssock;
+	struct sock *ssk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3778,15 +3779,19 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
+	ssk = msk->first;
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
+	lock_sock(ssk);
+	err = __inet_listen_sk(ssk, backlog);
+	release_sock(ssk);
+	inet_sk_state_store(sk, inet_sk_state_load(ssk));
+
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-		mptcp_copy_inaddrs(sk, ssock->sk);
-		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+		mptcp_copy_inaddrs(sk, ssk);
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
 	}
 
 unlock:
-- 
2.41.0

