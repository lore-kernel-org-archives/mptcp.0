Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8F24E8C
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684429167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxPJ2/8gRAFtd58/qPb4zk3Rzvir5sID78RnbQJ6xH0=;
	b=NKSmoE5o75xFfvn5lp72DKfG+RVVGgs6SeSkCLHYjVyLUMUKsD/qezhOrfOK7WKViYM/LF
	sA0lxOjUxX+EQPsclafxttFxjh9lmmnEhIR+TthjqUSeda26jWHjkh+Bs6PXC+T1z/dfZZ
	zthqLJqFvdYowBGKJFq/zGWBa2Ke0K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-sYVdrRd6PaKWpgWRvI1HdQ-1; Thu, 18 May 2023 12:59:26 -0400
X-MC-Unique: sYVdrRd6PaKWpgWRvI1HdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541C5185A78B;
	Thu, 18 May 2023 16:59:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B830A492B01;
	Thu, 18 May 2023 16:59:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 4/5] mptcp: add annotations around sk->sk_shutdown accesses
Date: Thu, 18 May 2023 18:59:13 +0200
Message-Id: <2265cd91d7b8e011386b86aae848a603daae4cb9.1684427027.git.pabeni@redhat.com>
In-Reply-To: <cover.1684427027.git.pabeni@redhat.com>
References: <cover.1684427027.git.pabeni@redhat.com>
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

Christoph reported the mptcp variant of a recently addressed plain
TCP issue. Similar to commit e14cadfd80d7 ("tcp: add annotations around
sk->sk_shutdown accesses") add READ/WRITE ONCE annotations to silence
KCSAN reports around lockless sk_shutdown access.

Fixes: 71ba088ce0aa ("mptcp: cleanup accept and poll")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/401
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cea9992fec98..4b24f3bc6919 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -603,7 +603,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 
 		switch (sk->sk_state) {
@@ -910,7 +910,7 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		/* hopefully temporary hack: propagate shutdown status
 		 * to msk, when all subflows agree on it
 		 */
-		sk->sk_shutdown |= RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 		sk->sk_data_ready(sk);
@@ -2553,7 +2553,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	}
 
 	inet_sk_state_store(sk, TCP_CLOSE);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
 
@@ -3006,7 +3006,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	bool do_cancel_work = false;
 	int subflows_alive = 0;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		mptcp_listen_inuse_dec(sk);
@@ -3149,7 +3149,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
 }
@@ -3856,9 +3856,6 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (unlikely(sk->sk_shutdown & SEND_SHUTDOWN))
-		return EPOLLOUT | EPOLLWRNORM;
-
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
@@ -3876,6 +3873,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
 	__poll_t mask = 0;
+	u8 shutdown;
 	int state;
 
 	msk = mptcp_sk(sk);
@@ -3892,17 +3890,22 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		return inet_csk_listen_poll(ssock->sk);
 	}
 
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+		mask |= EPOLLHUP;
+	if (shutdown & RCV_SHUTDOWN)
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
+
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
-		mask |= mptcp_check_writeable(msk);
+		if (shutdown & SEND_SHUTDOWN)
+			mask |= EPOLLOUT | EPOLLWRNORM;
+		else
+			mask |= mptcp_check_writeable(msk);
 	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
 		/* cf tcp_poll() note about TFO */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
-		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-- 
2.40.1

