Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836DAD56
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kM8PELoRbqwEgpC+2DjJUcI9v8FtOva6p7FYrOfa3oA=;
	b=UuVd2BkXxmopLFe5dli5DcftoyKc7Rhgl5O82n43Gkd73oWGeHgvLTmgUNnujvAoAccEWx
	qm2VWtSz0IIer90eTYuanlcbmi6SsuFrWQpq5ZcQYeABJNcKJ22A8NA1TMRV2Yw9ZDiM9D
	GHk8b2Z/BbH2RFQAZ65tXrSm4VeUOw0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-JP9Ds1D_N36z4jPzlP-0kQ-1; Fri, 13 Jan 2023 13:21:13 -0500
X-MC-Unique: JP9Ds1D_N36z4jPzlP-0kQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0F0B1C0513B
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6DBB24078904
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 9/9] mptcp: refactor mptcp_stream_accept()
Date: Fri, 13 Jan 2023 19:20:56 +0100
Message-Id: <b20fb19052027c1e2b2455e852537ebd068c78cf.1673629755.git.pabeni@redhat.com>
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

Rewrite the mptcp socket accept op, partially open-codying
inet_accept(), instead of indirectly calling it.

This way we can avoid acquiring the new socket lock twice
and we can avoid a couple of indirect calls.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5d1d2747e31..cfc112f73d6e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3752,6 +3752,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct socket *ssock;
+	struct sock *newsk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3763,16 +3764,26 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	if (!ssock)
 		return -EINVAL;
 
-	err = ssock->ops->accept(sock, newsock, flags, kern);
-	if (err == 0 && !mptcp_is_tcpsk(newsock->sk)) {
-		struct mptcp_sock *msk = mptcp_sk(newsock->sk);
+	newsk = mptcp_accept(sock->sk, flags, &err, kern);
+	if (!newsk)
+		return err;
+
+	lock_sock(newsk);
+
+	sock_rps_record_flow(newsk);
+	WARN_ON(!((1 << newsk->sk_state) &
+		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
+		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
+
+	sock_graft(newsk, newsock);
+
+	newsock->state = SS_CONNECTED;
+	if (!mptcp_is_tcpsk(newsock->sk)) {
+		struct mptcp_sock *msk = mptcp_sk(newsk);
 		struct mptcp_subflow_context *subflow;
-		struct sock *newsk = newsock->sk;
 
 		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
 
-		lock_sock(newsk);
-
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
@@ -3782,10 +3793,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (!ssk->sk_socket)
 				mptcp_sock_graft(ssk, newsock);
 		}
-		release_sock(newsk);
 	}
+	release_sock(newsk);
 
-	return err;
+	return 0;
 }
 
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
-- 
2.38.1

