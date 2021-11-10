Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFC2C8B
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636547554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W50QpIb8FFp5BdkNVsVte2qDaRpQrfS5Es27d7tAdwA=;
	b=UTDwbyzwmuSylnUs+t9UsJ5IqZhPp9leyfqLf8+moU93/Am73YVpkS8KRlOE5HaN2ORa5n
	f61DZRlQIq2Hcon3oBwPiAD+xtuKniWoqf5cR14w3PUQ3lNOsyVoyMNYhxAPLBY0Q+X3I0
	dh6K19KzuYSgBINzTNR0xWx4eqRksPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-N3lZeSMLNH2dFRSa5lXBkg-1; Wed, 10 Nov 2021 07:32:33 -0500
X-MC-Unique: N3lZeSMLNH2dFRSa5lXBkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32201102CB29
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:32 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9850460854
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 5/7] mptcp: cleanup accept and poll
Date: Wed, 10 Nov 2021 13:31:38 +0100
Message-Id: <043a38f611a1388f6c2bda3325fc239d2f01b568.1636545174.git.pabeni@redhat.com>
In-Reply-To: <cover.1636545174.git.pabeni@redhat.com>
References: <cover.1636545174.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

