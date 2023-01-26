Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602F5392
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Q00Z4Trst2e3TeHPJUTeBUPj/W8TtHliQ41m22Xlsc=;
	b=SprOmql9TsdbZa6usgX7WFchKD00RXnqacAclGvLrURAVrjJ4maFcE/KX1FjSBPj21hSE2
	2Doylkf1cBs5egpdek3VbOoa9xT2tWqKopUsnAda0E3K6dJEW0ch30HenyH7o0oWZ/Mcgt
	+r0stFVdYq2B3lZmIF4Adokjy2Ov9Zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-Kq6LH1dKMCW0QE7nZkJ2KA-1; Thu, 26 Jan 2023 16:05:41 -0500
X-MC-Unique: Kq6LH1dKMCW0QE7nZkJ2KA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BEA2857A86
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94672492C18
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 02/15] mptcp: fix locking for setsockopt corner-case
Date: Thu, 26 Jan 2023 22:05:07 +0100
Message-Id: <0d9c9eb3fac78843df8c62e287e9e2a11fabfcdc.1674767058.git.pabeni@redhat.com>
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

We need to call the __mptcp_nmpc_socket(), and later subflow socket
access under the msk socket lock, or e.g. a racing connect() could
change the socket status under the wood, with unexpected results.

Fixes: 54635bd04701 ("mptcp: add TCP_FASTOPEN_CONNECT socket option")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this and the next patch are new v2. In both case the addressed issue
is almost irrelevant until patch 8/12, but will cause lockdep splat
after such change
---
 net/mptcp/sockopt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9986681aaf40..8a9656248b0f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -760,14 +760,21 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  sockptr_t optval, unsigned int optlen)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct socket *sock;
+	int ret = -EINVAL;
 
 	/* Limit to first subflow, before the connection establishment */
+	lock_sock(sk);
 	sock = __mptcp_nmpc_socket(msk);
 	if (!sock)
-		return -EINVAL;
+		goto unlock;
 
-	return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+
+unlock:
+	release_sock(sk);
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
-- 
2.39.1

