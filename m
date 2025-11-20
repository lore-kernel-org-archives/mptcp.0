Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0E309EE8
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628011; cv=none; b=Upj62H+3m+BjJ/RC22m7a5+qwJ7sdpKIcccgRttM0zO/Aj9QGeZFNGhJ3YEZ+xcSQWfQp+XN/dyB8SY21WXEMPX1V3fBtYPeI498GKWpCC29L5yXH2YnMXislwc7nDHoXl8vkAuP/CNLJBCcN5fFcA7dPcXiebgbB1GWLjNthIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628011; c=relaxed/simple;
	bh=nofP3u7zgg/MDwd7fZ1oQgkFajXrpDTrN7iAIaod4D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XP6Kclz+yX7+c1Q46te0UgWChzYzysCFhhcf4BZu9QtTrxBcVjtOoGZdR+8P5HjQ9Riwiq3mNH++9lBVylGuc5FaphIHIDhlT4/ajZbr4GHBqF+Mxmsrsm+iRcUzG+bs+dDyFLCQH8AWFLnkqGBgUBswcc4vbYt5seInax6QxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3QnUGHg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3QnUGHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763628008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqLmGrnunNaiTfmgkq+7KLGtOgqR3RypDXjcwvpOrNo=;
	b=R3QnUGHgF3GQqE1TCZ61Ceg2kxRdIzhQWIWItclrU0xS5dK/JlARWVP2Z9WmH8wKI2qDqy
	Kp2kshtqOzG1pfg6eMg/HNehSRjjFy+OANPO6H3liRK4enDdx282WE7+DXtvaAh2E0aUw/
	oHr2zkymfCBx2yFY9sOWU2YhL8qrY8Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-VwWQFwpFP8aL3s4mFXq5Ag-1; Thu,
 20 Nov 2025 03:40:05 -0500
X-MC-Unique: VwWQFwpFP8aL3s4mFXq5Ag-1
X-Mimecast-MFC-AGG-ID: VwWQFwpFP8aL3s4mFXq5Ag_1763628004
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF48E19560A7;
	Thu, 20 Nov 2025 08:40:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 880E230044DB;
	Thu, 20 Nov 2025 08:40:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH v7 mptcp-next 4/6] mptcp: consolidate rcv space init
Date: Thu, 20 Nov 2025 09:39:48 +0100
Message-ID: <e6168ef90e39201202f18ea6e8836425f6fb4b32.1763625391.git.pabeni@redhat.com>
In-Reply-To: <cover.1763625391.git.pabeni@redhat.com>
References: <cover.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xIc3YK88fsdF3rl5_MICF8uVjc4SjY1QsY4WrqVhGd0_1763628004
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
 net/mptcp/protocol.c | 30 +++++++++++++++---------------
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  |  2 --
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b25cc8d5c98d..40c90d841237 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2061,6 +2061,21 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -3535,21 +3550,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
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

