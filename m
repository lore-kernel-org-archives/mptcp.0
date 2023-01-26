Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B65392
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVHCHc/TjaM+7kdAVxq3J87QbYzW/Q3QRRy7MUnSt+U=;
	b=RTfWcOI2gOHXer9SLVUVtgnsHR5bioMlAvc0iKdGdrLgSttABA7g8G51p3mDZX/LvKnX99
	8KqtV+8r30DugUPO/3uaytxwCjKhfUtvo+jVSuKkpKN5KoJehiC7ZD6Kh4sfNSoJPc5B/3
	S7G87sPcL2jMtZ2gSLuV9kuXLoXBCK8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-pOYsk9CgMMa_E5YEUcH8zg-1; Thu, 26 Jan 2023 16:05:48 -0500
X-MC-Unique: pOYsk9CgMMa_E5YEUcH8zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FFB12801E47
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D946D492C18
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 12/15] inet: factor out locked section of inet_accept() in a new helper
Date: Thu, 26 Jan 2023 22:05:17 +0100
Message-Id: <2bdbfdf227a9e0e3d6fa9078c435259ea31be748.1674767058.git.pabeni@redhat.com>
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

No functional changes intended. The new helper will be used
by the MPTCP protocol in the next patch to avoid duplicating
a few LoC.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/inet_common.h |  2 ++
 net/ipv4/af_inet.c        | 32 +++++++++++++++++---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index cec453c18f1d..77f4b0ef5b92 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -31,6 +31,8 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		       int addr_len, int flags);
 int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 		bool kern);
+void __inet_accept(struct socket *sock, struct socket *newsock,
+		   struct sock *newsk);
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
 ssize_t inet_sendpage(struct socket *sock, struct page *page, int offset,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 81535997dbfd..51d82f1a07ce 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -735,6 +735,20 @@ int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 }
 EXPORT_SYMBOL(inet_stream_connect);
 
+void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
+{
+	sock_rps_record_flow(newsk);
+	WARN_ON(!((1 << newsk->sk_state) &
+		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
+		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
+
+	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
+		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
+	sock_graft(newsk, newsock);
+
+	newsock->state = SS_CONNECTED;
+}
+
 /*
  *	Accept a pending connection. The TCP layer now gives BSD semantics.
  */
@@ -748,24 +762,12 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
-		goto do_err;
+		return err;
 
 	lock_sock(sk2);
-
-	sock_rps_record_flow(sk2);
-	WARN_ON(!((1 << sk2->sk_state) &
-		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
-		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
-
-	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
-		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
-	sock_graft(sk2, newsock);
-
-	newsock->state = SS_CONNECTED;
-	err = 0;
+	__inet_accept(sock, newsock, sk2);
 	release_sock(sk2);
-do_err:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(inet_accept);
 
-- 
2.39.1

