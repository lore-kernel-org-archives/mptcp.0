Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A222FE589
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940481; cv=none; b=ge7mQ355RWSQ/6ZJXmZ7WfFPEv77DNSNezQa/2YAJO+6t9jXyCv/i4ZnLxvjegjijU/XluEgadk9IvPcIhWD/qe9KN5DuaWnmQjoHne/95i5TcPkspMJfSu1rDs05lo7VfCLvzCMwBCFCutwHX+UYKdGRr3D+ReLJToPUI4q+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940481; c=relaxed/simple;
	bh=PLh9ZvU1g6a8ooF1WHjSCJMpSFfhJMkfEtbSa7nsqRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LppP0oiVoARWBMubSEGviv8tCrMKEbeO4eYi1gYrXQQJVKkOe7gDjoI2gmRLt2WBdmHLP7quRowIlHk9gkAH68CLK/ZKWlz+x93Wpm6t9NKVW4KZPgukGEJ5UxJ1g6VyhR75JnAHjKkwAGeg2oXIpNrBT9kukYL/jOxFEeYz6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRooXtLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRooXtLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIilrITen3j6h2UdykL6+krdKSEM+7zphzcJTBn/bso=;
	b=cRooXtLB+G/fUMfnsP0VU1+5f2A2WqiRi7x5V+zN2dFYWyFDRp2aXg9DtzEUZE0MF2ueWv
	dqX6SBcWPhsu2c5f9L+9b+fTWYI/4qekX2Fa60nd0IeYijZSGmI0MOgRop2OiNNr3qR/W2
	5Du1x0kqApnGL43en/zWy5Alj+ieVDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-4u4Sd3ATPOaS_BmS42RCTw-1; Wed,
 12 Nov 2025 04:41:17 -0500
X-MC-Unique: 4u4Sd3ATPOaS_BmS42RCTw-1
X-Mimecast-MFC-AGG-ID: 4u4Sd3ATPOaS_BmS42RCTw_1762940476
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CB741956096
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAB9C196B8F7
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 3/6] mptcp: consolidate rcv space init
Date: Wed, 12 Nov 2025 10:41:03 +0100
Message-ID: <c47f74f0d2e80d6734afe9a3607ad2537fcf9987.1762940290.git.pabeni@redhat.com>
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vcuANEYRBh0MHT-BTHp2i1rng1oIWQWMDcoNT9Oj-DI_1762940476
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP uses several calls of the mptcp_rcv_space_init() helper
to initialize the receive space, with a catch-up call in
mptcp_rcv_space_adjust().

Drop all the other strictly not needed invocations and move constant
fields initialization at socket init/reset time.

This removes a bit of complexity and will simplify the following patches.
No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - split helper consolidation out of v1 patch
  - additionally move 'copied' and 'rtt_us' initialization out of
    mptcp_rcv_space_init()
---
 net/mptcp/protocol.c | 34 +++++++++++++++++-----------------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  |  2 --
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9bff316558b4..06eabad05784 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2052,6 +2052,19 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	return copied;
 }
 
+static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
+{
+	const struct tcp_sock *tp = tcp_sk(ssk);
+
+	msk->rcvspace_init = 1;
+
+	/* initial rcv_space offering made to peer */
+	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
+				      TCP_INIT_CWND * tp->advmss);
+	if (msk->rcvq_space.space == 0)
+		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
+}
+
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
  * Only difference: Use highest rtt estimate of the subflows in use.
@@ -2938,6 +2951,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3381,6 +3396,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
@@ -3518,23 +3535,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	return nsk;
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
-{
-	const struct tcp_sock *tp = tcp_sk(ssk);
-
-	msk->rcvspace_init = 1;
-	msk->rcvq_space.copied = 0;
-	msk->rcvq_space.rtt_us = 0;
-
-	msk->rcvq_space.time = tp->tcp_mstamp;
-
-	/* initial rcv_space offering made to peer */
-	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
-				      TCP_INIT_CWND * tp->advmss);
-	if (msk->rcvq_space.space == 0)
-		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
-}
-
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 49f211e427bf..7c9e143c0fb5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -918,7 +918,6 @@ static inline u64 mptcp_stamp(void)
 	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 294645e88684..32f06510ba7a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -462,8 +462,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
 
 	subflow = mptcp_subflow_ctx(ssk);
 	__mptcp_propagate_sndbuf(sk, ssk);
-	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, ssk);
 
 	if (sk->sk_state == TCP_SYN_SENT) {
 		/* subflow->idsn is always available is TCP_SYN_SENT state,
-- 
2.51.1

