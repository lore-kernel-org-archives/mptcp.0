Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DB23D7F0
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554403; cv=none; b=rZ3Ofe6Ur+o+JscQ+/jPe8Dyx6LSdRV00EgaiSrse53ZKq/DsP62BcwA8tjLWG0Rrc+DcX0NsJzp+8p1a9YdgVxAkh1dYXwUhbZlLTINTVN8uC2mqwGIEueUrhDfzqy/ySkBNwYI76wVvH766MV6mjgFJiuw+qubqCnH0YGqrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554403; c=relaxed/simple;
	bh=wY6jximG58M4HN20afKe6OzucXoRpoED2gZNfFLFwHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OdL/nNqILiTfUkxGiO++Cbhmimcw7SJwyJoeGqJSFzuQJsPT21xdBiaMLHlUngkUamxJUJGLMidlVijzuE3b13ZK2ifFxX2YlESf8F/GmEiEjwLaqn9cKXR7SBClIWx1TR/tK6ChBneIMFtGW0Dy15rsfMZAmHeEt8FJ+64ZNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPvX5sob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPvX5sob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQAgKXMcgv6SyVdQKQXJD3BBmf5HI4AxzEGObTaoYWY=;
	b=NPvX5sobVEcs3itn3W9QSg8JzCq7v9U78ovlcSVMIL9KpJWXx7YNwLB5n2dYJvhRJv+Krl
	/Z8Jf3nsoD4GnSpIrdbVR5ZjdYVO6mgHUniCWQMxOFvSxvlGrcArwEIocbRkh3lTQik0uO
	VZACFdlI52Zeb8i6N7PE+j3kY6IDbMo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-y-3WkWgANUiJ-o8nNWRPuA-1; Wed,
 19 Nov 2025 07:13:08 -0500
X-MC-Unique: y-3WkWgANUiJ-o8nNWRPuA-1
X-Mimecast-MFC-AGG-ID: y-3WkWgANUiJ-o8nNWRPuA_1763554387
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3DE418AB406;
	Wed, 19 Nov 2025 12:13:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96BD2195608E;
	Wed, 19 Nov 2025 12:13:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v5 3/5] mptcp: consolidate rcv space init
Date: Wed, 19 Nov 2025 13:12:56 +0100
Message-ID: <59152266d5ed10c8b47da33cc5f087f2fcfaeb68.1763553361.git.pabeni@redhat.com>
In-Reply-To: <cover.1763553361.git.pabeni@redhat.com>
References: <cover.1763553361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F9vt2m-4cIRBRs3JopUKsFuCZ5H-m3Zn03fRPVmzYIY_1763554387
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP uses several calls of the mptcp_rcv_space_init() helper to
initialize the receive space, with a catch-up call in
mptcp_rcv_space_adjust().

Drop all the other strictly not needed invocations and move constant
fields initialization at socket init/reset time.

This removes a bit of complexity from mptcp DRS code. No functional
changes intended.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
  - reworded the commit message

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
index 8b2824834b10..bfda2dce956c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2067,6 +2067,19 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2960,6 +2973,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3403,6 +3418,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
@@ -3540,23 +3557,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
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
index 95c62f2ac705..ee0dbd6dbacf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -922,7 +922,6 @@ static inline u64 mptcp_stamp(void)
 	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86ce58ae533d..23f439853a7c 100644
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

