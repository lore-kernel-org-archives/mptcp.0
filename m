Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBA331A5D
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931770; cv=none; b=iGk1tasvjDEs2mq/anXOwyr4Gng+EY/DuSCSgsDYNMRZCqw2flqNNmpWFsrZZLOG/zbCSCdo1nPnGZtt1u7yWBxrnDz30UfyEC8/qoitcEXK+2qoZTtoWq+eevvNXO7kHmdOtMtgyzKZjMULsGRzU0gp1+mdg+HP3fRtUSM3tyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931770; c=relaxed/simple;
	bh=925QRmMF6Zjz3ppGM+y/mr/CYMs8bBov2XZYNg/czbE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JfkGtAt4mdL2sOEAlmg34JEaXdE8LvF12t90oSxr5CZtTptlOBlU2iJCw2HI3LOStKc8OGVH88IoBvn0eH4I5d35f5zSVFRii0q0vtEMMQbuUIieLSaRaxwb2qTFG8p6kGLvpdFog4AoHUF7GBayemoJj/uznXwLPkHEvgYe/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlpDqO84; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlpDqO84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761931767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwQsmS8ps/tg21yZh4cDIXl+G364XMwnREcj2nybW0Q=;
	b=ZlpDqO84BM1SUUcpodMFMaJJ63MSxwUEeflwma42hBmAp66HD94xpWwTflc9f85ctvsmJO
	IhZwxgm6fXMdXGb1XmUp3pd9FKxwmIUowLl2lIOxY1GyqONa4YO06++Nw26wNYchS7/OKC
	ZzawaWNTs3oJGX+nI9cL5CkWMP6P/Iw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-qggaT7cRM423RddxRJ-3Vw-1; Fri,
 31 Oct 2025 13:29:23 -0400
X-MC-Unique: qggaT7cRM423RddxRJ-3Vw-1
X-Mimecast-MFC-AGG-ID: qggaT7cRM423RddxRJ-3Vw_1761931762
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B44841800345
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B937330001A6
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/4] mptcp: fix receive space time initialization.
Date: Fri, 31 Oct 2025 18:29:08 +0100
Message-ID: <aaa94f08a1b84601ee030118c3240011c79e8bb9.1761931390.git.pabeni@redhat.com>
In-Reply-To: <cover.1761931390.git.pabeni@redhat.com>
References: <cover.1761931390.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2otR9WievFTUZ1aaBHYS8ONrid5yzZUmzGkaIcFHVVM_1761931762
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP initialize the receive buffer stamp in mptcp_rcv_space_init(),
using the provided subflow stamp. Such helper is invoked in several
places, with a catch-up call in mptcp_rcv_space_adjust().

For passive sockets, MPTCP ends-up accesses the subflow stamp before
its initialization, leading to quite randomic timing for the first
receive buffer auto-tune event.

Fix the issue using a fresh stamp.

Drop the all the mptcp_rcv_space_init() invocations except the catch-up
one: they add unneeded complexity for no good reason.

As a side effect, this avoid using a zero value for imsk->rcvq_space.time,
that made the first receive buffer auto-tune even quite randomic.

This will also make the next patch cleaner.

Fixes: 013e3179dbd2 ("mptcp: fix rcv space initialization")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 40 ++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  6 +++++-
 net/mptcp/subflow.c  |  2 --
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d16ad1a85411..e17abab7bab6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2047,6 +2047,21 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	return copied;
 }
 
+static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
+{
+	const struct tcp_sock *tp = tcp_sk(ssk);
+
+	msk->rcvspace_init = 1;
+	msk->rcvq_space.copied = 0;
+	msk->rcvq_space.rtt_us = 0;
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
@@ -2069,8 +2084,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3487,7 +3502,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
-	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3497,23 +3512,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
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
@@ -3703,6 +3701,8 @@ void mptcp_finish_connect(struct sock *ssk)
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 
+	WRITE_ONCE(msk->rcvq_space.time, mptcp_stamp());
+
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 84f2c51d776c..1f67d8468dfb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -908,7 +908,11 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
 
-void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
+static inline u64 mptcp_stamp(void)
+{
+	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
+}
+
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac8616e7521e..b64ab7649908 100644
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

