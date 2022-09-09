Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF87E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662713401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PPP4cMd0+Y6lp8YbMdeXEndVVNP3YmELBPk4XHa/lc=;
	b=ZOWwoGKw5kVvjSUANgJx3wkOxRaOtBBM8jjQe2504p8qtJJR6c3M/QJxA/7FhOEhKw0Wj9
	ztzP41YXzbrimCYf0qEZbA7Tj70Kdr8QED19PZFTREjvlCDJRCON/raj8G/kTTmpYCLsv/
	bgx4/61gGRxYctaZH87rOvzJipHwljM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-OyC-bJS2Mxa8cumDZnI7-g-1; Fri, 09 Sep 2022 04:49:59 -0400
X-MC-Unique: OyC-bJS2Mxa8cumDZnI7-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859C51C0758D
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:49:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11D3940B40C9
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:49:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 1/3] mptcp: propagate fastclose error.
Date: Fri,  9 Sep 2022 10:49:48 +0200
Message-Id: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When an mptcp socket is closed due to an incoming FASTCLOSE
option, so specific sk_err is set and later syscall will
fail usually with EPIPE.

Align the current fastclose error handling with TCP reset,
properly setting the socket error according to the current
msk state and propagating such error.

Additionally sendmsg() is currently not handling properly
the sk_err, always returning EPIPE.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55442df8fb97..f0abe7a7caf2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1686,9 +1686,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-			goto out;
+			goto do_error;
 	}
 
+	ret = -EPIPE;
+	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
+		goto do_error;
+
 	pfrag = sk_page_frag(sk);
 
 	while (msg_data_left(msg)) {
@@ -1697,11 +1701,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		bool dfrag_collapsed;
 		size_t psize, offset;
 
-		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)) {
-			ret = -EPIPE;
-			goto out;
-		}
-
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
 		 */
@@ -1733,7 +1732,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (copy_page_from_iter(dfrag->page, offset, psize,
 					&msg->msg_iter) != psize) {
 			ret = -EFAULT;
-			goto out;
+			goto do_error;
 		}
 
 		/* data successfully copied into the write queue */
@@ -1765,7 +1764,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
-			goto out;
+			goto do_error;
 	}
 
 	if (copied)
@@ -1773,7 +1772,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 out:
 	release_sock(sk);
-	return copied ? : ret;
+	return copied;
+
+do_error:
+	if (copied)
+		goto out;
+
+	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	goto out;
 }
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
@@ -2405,12 +2411,31 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		unlock_sock_fast(tcp_sk, slow);
 	}
 
+	/* Mirror the tcp_reset() error propagation */
+	switch (sk->sk_state) {
+	case TCP_SYN_SENT:
+		sk->sk_err = ECONNREFUSED;
+		break;
+	case TCP_CLOSE_WAIT:
+		sk->sk_err = EPIPE;
+		break;
+	case TCP_CLOSE:
+		return;
+	default:
+		sk->sk_err = ECONNRESET;
+	}
+
 	inet_sk_state_store(sk, TCP_CLOSE);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
-	mptcp_close_wake_up(sk);
+	/* the calling mptcp_worker will properly destroy the socket */
+	if (sock_flag(sk, SOCK_DEAD))
+		return;
+
+	sk->sk_state_change(sk);
+	sk_error_report(sk);
 }
 
 static void __mptcp_retrans(struct sock *sk)
-- 
2.37.2

