Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31153207
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504355; cv=none; b=JKkbzd4rjPLiYVNKIKgscHW+lY2za61DrDkvmAYA5UNCUaCTPHMH1nwzyCAygM6mMEFPV5V+BDkZARr28TWXXBxjg0UqasDfXvhlaqOdEwSZAlzAASlpAkhecJgpO06WZfyR3g37eHLaWUPvcaqGK8rqr7386oRJwtZjcjS4j1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504355; c=relaxed/simple;
	bh=5ZZ42pkvcFTNUCJkKAzkbA7MlC6IBkdCEii7uKaEnFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XqclXjq9Df5aD2GpElr08ov2U/zJVbTnMQd7vX/CgwOOxFzvWd+S/27Mb1WjT273SA72WDClrSwOMQbjg9F7YVJD9G1L0dgr/MmSPfl3nYNB6CY/puUV6ICDltNl7oeTWmZ3zHIG1T4/6+MqlABW4x4ugdVDaBaGQU8qm2rI1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpfjXURB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpfjXURB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762504352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4jfUAc1QqIDF2/Y+3vzjkYbK3ZKCq9FCzVU8+iI2Bo=;
	b=NpfjXURBtgJD5ubENd1vj7M1uewsAQN9WadSjeRMIO2P3I8/ZCH+3UjKpipzw2lXd3kIhv
	i1eZsJauYn0vwecFlC5viL75s4/cyCPie4P3OzuDxV1pgldYSA1P2in8o2PCjanVHdw9Be
	N00FF07mRPZIcwWSXxO0KUK82SVKh50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-UFGeTjHVO-2btPC8PeDpPA-1; Fri,
 07 Nov 2025 03:32:28 -0500
X-MC-Unique: UFGeTjHVO-2btPC8PeDpPA-1
X-Mimecast-MFC-AGG-ID: UFGeTjHVO-2btPC8PeDpPA_1762504348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78A3018001FE;
	Fri,  7 Nov 2025 08:32:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5119B18002A6;
	Fri,  7 Nov 2025 08:32:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH v3 mptcp-next 4/7] mptcp: consolidate rcv space init
Date: Fri,  7 Nov 2025 09:32:08 +0100
Message-ID: <4f0905e86d18d95bfbd99fb83e9c329dd8c41840.1762504059.git.pabeni@redhat.com>
In-Reply-To: <cover.1762504059.git.pabeni@redhat.com>
References: <cover.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFPDEZ44M47B47QsxZ5yFLWnMQ3LlhUYmPedgSWzAec_1762504348
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
index 9dfec22694cc..0bdb86ed8e5e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2050,6 +2050,19 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2935,6 +2948,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	msk->backlog_len = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
@@ -3378,6 +3393,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
@@ -3515,23 +3532,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
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
index 7eef4aaf78e2..caf6772d43e4 100644
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
2.51.0

