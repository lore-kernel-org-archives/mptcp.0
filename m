Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C662C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636109385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyY/WUYdJtP6gwCGDcHLvwtdy+aDd5yuFvsXsxkMt/A=;
	b=L1GxaycqJ4MaTKXHjqWWSG2wwAzVM2o6iwetNAuUFLu/BX2gh4RCExJXEh1PMKEWEsDsYR
	hIRVCJ4xqDJfYEzhSvJ41kF2MXbt1pKztdvKWmzJN+U2ppFMCAiNSvieYnm/wAmMdso79W
	kJT9PPIsjDqeRVhihgSLBfJHJBFSvoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-3IeaNP7SNpSrv1eoo_ONKw-1; Fri, 05 Nov 2021 06:49:32 -0400
X-MC-Unique: 3IeaNP7SNpSrv1eoo_ONKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35D721835AC8
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7825D9D3
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [RFC PATCH 3/3] mptcp: cleanup accept and poll
Date: Fri,  5 Nov 2021 11:49:12 +0100
Message-Id: <bcf5c3220ac27570e942835d97b4b10b8e448eb8.1636107361.git.pabeni@redhat.com>
In-Reply-To: <cover.1636107361.git.pabeni@redhat.com>
References: <cover.1636107361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 5fe19adb88a5..38f5b4bcba69 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3402,17 +3402,9 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
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
@@ -3452,14 +3444,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
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
@@ -3505,8 +3490,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
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
index 188b9e044672..b2d016f8803a 100644
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
index 72ccbd85941b..4e7395cfab9b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1293,7 +1293,6 @@ static void subflow_data_ready(struct sock *sk)
 		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
 			return;
 
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 		parent->sk_data_ready(parent);
 		return;
 	}
-- 
2.26.3

