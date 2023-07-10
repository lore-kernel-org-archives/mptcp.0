Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7A111A9
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbZLlRFWlZNfcU1wPKuhyU/k14sbw0TksznnDxYHH9M=;
	b=LgTyhPpk2BYnoX4hUJPda6nmnGUuQKr0E3zWXMnTUO5my6iQjzi57pCy7uv4dWoAm+N1AL
	TdkEkNLMDpsOJ5wED8V0iT45JQscwMlicNLQkqMlgQjhIMjtPamcKdiBk2EZWpSQEHRqHv
	TWPuHGID/QH2DYVKTcJvL7brt38FbKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-5RSmF8_fN4WLEo1P1aLP0w-1; Mon, 10 Jul 2023 08:55:27 -0400
X-MC-Unique: 5RSmF8_fN4WLEo1P1aLP0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39EA480006E
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDD01C09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 06/14] mptcp: mptcp: avoid additional indirection in mptcp_bind()
Date: Mon, 10 Jul 2023 14:55:01 +0200
Message-ID: <9a02286946adbca8844050396ef04c31f2969c2c.1688993569.git.pabeni@redhat.com>
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
the addictional indirection via at bind() time. Instead call directly
the recently introduced helpers on the first subflow sock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fe4232870a37..00b891f709f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3728,22 +3728,29 @@ static struct proto mptcp_prot = {
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

