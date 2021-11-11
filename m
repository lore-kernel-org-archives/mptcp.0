Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB162C85
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W50QpIb8FFp5BdkNVsVte2qDaRpQrfS5Es27d7tAdwA=;
	b=C0WF1KwdfF9uVow3SC0IMZsAGa59ZYzYsN4otAyAuoYMYLQFWW8Iaa5Lhuq958OhrNNIsn
	UfYSEo5Lnc8VpArdnKi7iWKS93aeVVOAdqZeP5QH7K2agwOsKWYlnPIcBbfE91KXfEtEgC
	2GnS+l2ARSQFPmzR2dQiRrFZWJ6Bo8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-x0WYAA5KMYu2ehXWUFtp8Q-1; Thu, 11 Nov 2021 11:21:55 -0500
X-MC-Unique: x0WYAA5KMYu2ehXWUFtp8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015B61030C20
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:55 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6686F5D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 5/7] mptcp: cleanup accept and poll
Date: Thu, 11 Nov 2021 17:21:40 +0100
Message-Id: <1bb810c54d43e268c570f894f74850c8226ffff8.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

After the previous patch,  msk->subflow will never be deleted during
the whole msk lifetime. We don't need anymore to acquire references to
it in mptcp_stream_accept() and we can use the listener subflow accept
queue to simplify mptcp_poll() for listener socket.

Overall this removes a lock pair and 4 more atomic operations per accept().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 25 +++++++------------------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  |  1 -
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84a3df43a38d..ee2a5169c13a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3517,17 +3517,9 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
-	if (sock->sk->sk_state != TCP_LISTEN)
-		goto unlock_fail;
-
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock)
-		goto unlock_fail;
-
-	clear_bit(MPTCP_DATA_READY, &msk->flags);
-	sock_hold(ssock->sk);
-	release_sock(sock->sk);
+		return -EINVAL;
 
 	err = ssock->ops->accept(sock, newsock, flags, kern);
 	if (err == 0 && !mptcp_is_tcpsk(newsock->sk)) {
@@ -3567,14 +3559,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		release_sock(newsk);
 	}
 
-	if (inet_csk_listen_poll(ssock->sk))
-		set_bit(MPTCP_DATA_READY, &msk->flags);
-	sock_put(ssock->sk);
 	return err;
-
-unlock_fail:
-	release_sock(sock->sk);
-	return -EINVAL;
 }
 
 static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
@@ -3620,8 +3605,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
-	if (state == TCP_LISTEN)
-		return test_bit(MPTCP_DATA_READY, &msk->flags) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (state == TCP_LISTEN) {
+		if (WARN_ON_ONCE(!msk->subflow || !msk->subflow->sk))
+			return 0;
+
+		return inet_csk_listen_poll(msk->subflow->sk);
+	}
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f8ed68c5ef9d..a6a4bd7de5b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -111,7 +111,6 @@
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
 /* MPTCP socket flags */
-#define MPTCP_DATA_READY	0
 #define MPTCP_NOSPACE		1
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 12c49f898e28..2aea7935019e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1298,7 +1298,6 @@ static void subflow_data_ready(struct sock *sk)
 		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
 			return;
 
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 		parent->sk_data_ready(parent);
 		return;
 	}
-- 
2.33.1

