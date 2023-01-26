Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F35397
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wpJQ565EtYJXTIJozpdOTBVQsrBqKZkehRbi+zRhJ4=;
	b=Pj4R1Ei4f7dUZFy/bUeKfrF3I/dd60vTiCIM92dj1Q+tlyN5HUFoQBLss/atXIU13KiEET
	f+q6i41OEXbwHObCFC9g+5YONz+oTStDOWux3ZW7JGAsNzW5j10WFCPxHL7yFTxkiXJRLC
	XNV3f8FcZv/F6nx1ZGOEvKUiP+UfCto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-3l5LKAwKPI20_BI_c8YCfg-1; Thu, 26 Jan 2023 16:05:50 -0500
X-MC-Unique: 3l5LKAwKPI20_BI_c8YCfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C47D858F0E
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9545B492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 13/15] mptcp: refactor mptcp_stream_accept()
Date: Thu, 26 Jan 2023 22:05:18 +0100
Message-Id: <cc08ac87aecbf8cd77306c3090fa6fa1582bd524.1674767058.git.pabeni@redhat.com>
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

Rewrite the mptcp socket accept op, leveraging the new
__inet_accept() helper.

This way we can avoid acquiring the new socket lock twice
and we can avoid a couple of indirect calls.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - use the new helper
---
 net/mptcp/protocol.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d337207f5ec2..546df81c162f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3757,6 +3757,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct socket *ssock;
+	struct sock *newsk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3768,16 +3769,19 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
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
+	__inet_accept(sock, newsock, newsk);
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
@@ -3787,10 +3791,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
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
2.39.1

