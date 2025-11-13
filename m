Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018D2110
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992668; cv=none; b=BVdL9o7oXmqkaLgd+aSwUxkC/hIWkDbZKfEBddq9uzfBvCZ+SojoKIWj0HoS2l056IUbN7SFxnjqiaI4L3VxaCMQkygmCudVHJ476m/RYMmMMG8TNmM6+IVbYgXjftakQjvCWomn7uJx8v8SOHgNVK4n03t6T/AlWcP9Oyz9QS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992668; c=relaxed/simple;
	bh=1q9Rw2BrF7TzDCyWRsgI2hYlJCwCj2rFqfnb7sIFCYI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=j6mwaP7lzk8QiPNpxSP0IxmmiR0BcvY46gR3laI9SA/O4RHlzYRVA/SrP1yZYpNIqi/4M/xwxfsnUhD0Rbnm5s0CtIOBQfmA0N2u4FwDrORinLHoDHKv+D4l4DTHCAMo/G2+CqrO+yUgMSen/5oIIFhs6PREqYbb5QGvIofZF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlrXWlBV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlrXWlBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQuXFpC9aM5kuonXi2IVrHQ5YkA84CxRe3xKW/nnH5k=;
	b=KlrXWlBVTJKHC+YJlqe7MrthcMn8F9nLTSM4X+RuiQa/YuaPPpyHQzG4p8eUUelby6Jud4
	dBW9SJ6DxN+fBjXgUhx/jxyMwqDrZIEL/JYdICrIkMjPRiS86m94aPbkGzrCzdHycbIn+Z
	V1hg6A8g5Pg7E6Ey1ibvtU8Iz1cIghQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-i2hPL86_Md-p-5zX77z11g-1; Wed,
 12 Nov 2025 19:11:03 -0500
X-MC-Unique: i2hPL86_Md-p-5zX77z11g-1
X-Mimecast-MFC-AGG-ID: i2hPL86_Md-p-5zX77z11g_1762992662
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C31518011EF
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CDAA30044E0
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 2/3] Squash-to: "mptcp: fix memcg accounting for passive sockets"
Date: Thu, 13 Nov 2025 01:10:51 +0100
Message-ID: <60e9d25298d9c8da731e3e0a86788b4ca5aabfb9.1762992570.git.pabeni@redhat.com>
In-Reply-To: <cover.1762992570.git.pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BsCqpEmpCj0DzLK8vEAc3vYtPihj8OPZbphkBm3c8kE_1762992662
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__mptcp_inherit_memcg() is currently invoked by mptcp_graph_subflows()
with the wrong GFP flags, as lock_sock_fast() can yield atomic scope.

Since this is not the most extreme fast path, use plain lock_sock()
instead.

Additionally ensure the CG is correctly set even for active subflows
of not yet accepted passive msk.

Finally fix a typo in the mentioned helper name.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I'm sorry for the bad directions again. I had to rework completely
the next patch due to several races still present, and that
required the change here, quite unexpected otherwise.
---
 net/mptcp/protocol.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b3c5fd01600..addd8025d235 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -916,8 +916,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
-	__mptcp_inherit_cgrp_data(sk, ssk);
-	__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
@@ -3737,9 +3735,13 @@ static void mptcp_check_graft(struct sock *sk, struct sock *ssk)
 
 	write_lock_bh(&sk->sk_callback_lock);
 	sock = sk->sk_socket;
-	write_lock_bh(&sk->sk_callback_lock);
-	if (sock)
+	write_unlock_bh(&sk->sk_callback_lock);
+
+	if (sock) {
 		mptcp_sock_graft(ssk, sock);
+		__mptcp_inherit_cgrp_data(sk, ssk);
+		__mptcp_inherit_memcg(sk, ssk, GFP_ATOMIC);
+	}
 }
 
 bool mptcp_finish_join(struct sock *ssk)
@@ -4052,18 +4054,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	return err;
 }
 
-static void mptcp_graph_subflows(struct sock *sk)
+static void mptcp_graft_subflows(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
-		slow = lock_sock_fast(ssk);
+		lock_sock(ssk);
 
-		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
+		/* Set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
 		if (!ssk->sk_socket)
@@ -4071,7 +4072,7 @@ static void mptcp_graph_subflows(struct sock *sk)
 
 		__mptcp_inherit_cgrp_data(sk, ssk);
 		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 }
 
@@ -4122,7 +4123,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
-		mptcp_graph_subflows(newsk);
+		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
 
 		/* Do late cleanup for the first subflow as necessary. Also
-- 
2.51.1

