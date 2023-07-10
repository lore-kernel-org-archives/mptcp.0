Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5E111A9
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=My9bJBL97ni8UXlxKYjv29tf7ZPY3pCwltWAFluONU4=;
	b=X/TU/F7MpwXhm7OdJlv9dnOjKPt+5V46XApayGWAVffBGBAnori0dSzd9LYJysgwj4t/+t
	lcxPtrpDrJqsFcwkAjGygpzMOGKKvtz2ahK20QOZOa9UgrcMUV9vQ/gUP2ZTNbzwyHeLNE
	S96Bcg6Oy4oftyDUdlXyAm8p28A8FpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-0DgnYMkAMWOPbuuGZBWsWw-1; Mon, 10 Jul 2023 08:55:29 -0400
X-MC-Unique: 0DgnYMkAMWOPbuuGZBWsWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1338800159
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 408C4C51488
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 08/14] mptcp: avoid additional indirection in mptcp_listen()
Date: Mon, 10 Jul 2023 14:55:03 +0200
Message-ID: <3e6dc1e7ec147cf1ab8109a7ec65b62319565604.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We are going to remove the first subflow socket soon, so avoid
the addictional indirection via at listen() time. Instead call
directly the recently introduced helper on the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 00b891f709f7..c5da7a172ee9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3759,6 +3759,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct socket *ssock;
+	struct sock *ssk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3775,15 +3776,20 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
+		WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
-		mptcp_copy_inaddrs(sk, ssock->sk);
-		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+		mptcp_copy_inaddrs(sk, ssk);
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
 	}
 
 unlock:
-- 
2.41.0

