Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454211CB0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YiZ9nlVq4YyNofryNWObarf1zFadP9clDs7hnCHD2hU=;
	b=Mecss/1Yk9NdP6S8yyIVe+LocJlZ/OPeNvoDKG32hjmn53QzknDccHZJlif28WIZVKg3cb
	xwcn/LHzlFq7UbbEmEcDhonpYtaDVPjAq42ZyDHTUnOoHUSeAw4aSABgv41hOjwMssDDJI
	iBkZU6kwIV0iqa/LwVID14C09kzFvRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622--ScGw_vsOECM3Pm57TdGNA-1; Fri, 14 Jul 2023 07:30:01 -0400
X-MC-Unique: -ScGw_vsOECM3Pm57TdGNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E740E1011573
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77DFA2166B27
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 05/13] mptcp: mptcp: avoid additional indirection in mptcp_bind()
Date: Fri, 14 Jul 2023 13:29:36 +0200
Message-ID: <a4cffc007614c4d449df0b1e792a68ea60b6336b.1689334116.git.pabeni@redhat.com>
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
the additional indirection via at bind() time. Instead call directly
the recently introduced helpers on the first subflow sock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba26c16eaecd..fa62e6d2d1ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3731,22 +3731,29 @@ static struct proto mptcp_prot = {
 static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *ssk, *sk = sock->sk;
 	struct socket *ssock;
-	int err;
+	int err = -EINVAL;
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock)) {
 		err = PTR_ERR(ssock);
 		goto unlock;
 	}
 
-	err = ssock->ops->bind(ssock, uaddr, addr_len);
+	ssk = msk->first;
+	if (sk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, uaddr, addr_len);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (sk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, uaddr, addr_len);
+#endif
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssk);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
-- 
2.41.0

