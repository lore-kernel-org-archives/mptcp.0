Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D6A497
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671822024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULqKTqz06NnyraDBeKRoaACwrjiY+WsUXPOEZwey9Dk=;
	b=FXCIdnhc01FvZWfepgPXSNTbNX3+MPwkYQueV30EEVSc4zBfzT6RAe6rjiqDmPJCF6jb7d
	3wJf4n1DT+Ey3KAijdwmjvlH7xaag4XxZkeKTzPPZoNuWtzWnM0ARTAOL1RIlonCWA4oYn
	iUVAOOgoydeN9jyTs18yWF7DGhmse60=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-7b2VtL0SNoaNX-teuKoeYg-1; Fri, 23 Dec 2022 14:00:23 -0500
X-MC-Unique: 7b2VtL0SNoaNX-teuKoeYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35B761C05122
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B51C540C945A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/3] mptcp: explicitly specify sock family at subflow creation time
Date: Fri, 23 Dec 2022 20:00:12 +0100
Message-Id: <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671821017.git.pabeni@redhat.com>
In-Reply-To: <cover.1671821017.git.pabeni@redhat.com>
References: <cover.1671821017.git.pabeni@redhat.com>
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

Let the caller specify the to-be-created subflow family. No
functional change intended, will be leveraged by the next
patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 9 +++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e813580c394..f08ef9ca242a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -98,7 +98,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	struct socket *ssock;
 	int err;
 
-	err = mptcp_subflow_create_socket(sk, &ssock);
+	err = mptcp_subflow_create_socket(sk, sk->sk_family, &ssock);
 	if (err)
 		return err;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3cd3270407b0..fcce8f03c1b5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,7 +643,8 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 			    const struct mptcp_addr_info *remote);
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
+				struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bd387d4b5a38..ec54413fb31f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1547,7 +1547,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
-	err = mptcp_subflow_create_socket(sk, &sf);
+	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
 	if (err)
 		goto err_out;
 
@@ -1660,7 +1660,9 @@ static void mptcp_subflow_ops_undo_override(struct sock *ssk)
 #endif
 		ssk->sk_prot = &tcp_prot;
 }
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+
+int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
+				struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
 	struct net *net = sock_net(sk);
@@ -1673,8 +1675,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
-- 
2.38.1

