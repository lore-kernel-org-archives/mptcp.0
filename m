Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1834F49F
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739226; cv=none; b=ONfbPGGm1X+o0rrCiNaLbpHJE0UIIXD0S5xrI8DPx4dsO3nIFACIIjFY+8hrHm487eAl7ibz7ICpQaPtRNY/wH32ShvkiTR3LXNciz82CIikDPmC+IY9xfoycHFJQ34IaoN7vb/ATIFVrpZkIwgazfw/934fVo/HKznNLdM+kY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739226; c=relaxed/simple;
	bh=EgqNMMx6Kivnfp6AJr0t5C0BbfGEk+uEiwvP1h/x5TI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UhRJq9gW1S8SyXz10VR4dlm/cOONN0VMPBRKidx3xrtz/EhlDQqYAHs8ZyFAb60ztgN32U/2iKi7E5kYMIwQRWLBL+/B6VvVFrlGmY/AOifoTNwL6UGfKyi4rPCCEn+Pl3kG+NJevJ8sAb4dT7MFlIlYocL7jF7fgrSVNEdOzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaSIbZU+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaSIbZU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787739223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=au2/HMbpMivqfRKp7eRqZ6ekval74X3bO/BxYxyizyk=;
	b=KaSIbZU+Jbw5+8p9ejrx4d5JY8ahQSZRwexZuJRLuYdTalpQ3IRlWLbJbtNAXq4X2Tnf7J
	KCkvlEHbiWW4PGstiM7Yu5a7JU0TpSBRTogDooAARRlDYvG45lQF/suQWb6FMca/WOP0Li
	AxFUzzFKzte7BqD9CN1dmFVu5N2MftY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-4sA9y1TPO2--MpjJQYP98g-1; Wed,
 26 Aug 2026 06:13:42 -0400
X-MC-Unique: 4sA9y1TPO2--MpjJQYP98g-1
X-Mimecast-MFC-AGG-ID: 4sA9y1TPO2--MpjJQYP98g_1787739221
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 807EB190A356
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.61])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBEAA5B1
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:13:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"
Date: Wed, 26 Aug 2026 12:13:30 +0200
Message-ID: <3d8a1534a8b0609c6ddcd593f4ed8957be019657.1787739122.git.pabeni@redhat.com>
In-Reply-To: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
References: <f1e8ffe44c3756195391a25ecf60e56e02e0f34f.1787739122.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uRwXDaep-ONaIlwHZTcnHDvDGtHScyKX52weKOcCgjU_1787739221
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Sashiko noted that the 'RTX disabled' status is carried over
across connect() failures, potentially to subsequent successful connect()
or listen().

Explicitly control the RTX enabling status across the whole msk life-cycle.
To make the code more straight forward switch the newly introduced flag
semantic.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 net/mptcp/protocol.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e7e59d497c5..db745d9dde59 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -96,7 +96,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
-	set_bit(MPTCP_RTX_DISABLED, &msk->flags);
+	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
@@ -1126,7 +1126,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 	unsigned long tout;
 
 	/* Prevent rescheduling on close and in case of fallback. */
-	if (test_bit(MPTCP_RTX_DISABLED, &msk->flags))
+	if (!test_bit(MPTCP_RTX_ENABLED, &msk->flags))
 		return;
 
 	tout = msk->timer_ival;
@@ -3363,7 +3363,7 @@ void mptcp_set_state(struct sock *sk, int state)
 		 */
 		break;
 	case TCP_CLOSE:
-		set_bit(MPTCP_RTX_DISABLED, &mptcp_sk(sk)->flags);
+		clear_bit(MPTCP_RTX_ENABLED, &mptcp_sk(sk)->flags);
 		fallthrough;
 	default:
 		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
@@ -3785,6 +3785,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
 
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
@@ -4190,6 +4191,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		return PTR_ERR(ssk);
 
 	mptcp_set_state(sk, TCP_SYN_SENT);
+	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d5..482d4a549881 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -116,7 +116,7 @@
 #define MPTCP_WORK_RTX		1
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
-#define MPTCP_RTX_DISABLED	4
+#define MPTCP_RTX_ENABLED	4
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
-- 
2.55.0

