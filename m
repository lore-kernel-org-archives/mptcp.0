Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6C34041B
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760693; cv=none; b=YqTtunxQlna8hUKeBxqp0faczthHy0ORT1xitovjrWk8mJCdYM4SJWgdeAVXDDCTR51Q12rOD77gvT169nRDMqjb6kzrNHnozWXAOQFjOrqlY6AtKa9tRewSaNzDr6jDwvmdGiDd4k+Kw4h9tGEPHuKodboOjRnQbPqxPtRKynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760693; c=relaxed/simple;
	bh=cPsL/st9FEJuFg0eSnqjAxNjKH+YXeo3ZsI3bkccyTQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=l8ojJw+81UOzVUHm6EoAtPNKIZzfauVzxsOvQKsy+SmqScIHpVWW+50mY6nSBZO9LmQBGP+ND//aul30ZSJV5eA1L82WDn+LEff7SFBwDTv4r5aD2Mlh5YM2mmiq2E64DVDAx0AoePpyavIqF6V8gSVLzVlcV0uoPLtXovOx2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbULMAKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbULMAKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787760691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzzFklAPcDriRgcb5cHYsOQnaMfwUj4o+am7k9WY8OQ=;
	b=AbULMAKDiemK+caJpyUVJ8+63vEhNH6BGCbKhsxOzqS264Ei4tewpLzBj9wYerBCa+pEDa
	fCKDDBoXDOu6oFzCxRatJctnX7g7piWa4zPyEdVOWaHxZj6Kn/y+Jed6FoofkLT2iDAdUX
	xxf/hGUaA5BNbfHz9QtKHGW+GRGRr1c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-xdZkgdOTMxSHWJjFwdG6wg-1; Wed,
 26 Aug 2026 12:11:29 -0400
X-MC-Unique: xdZkgdOTMxSHWJjFwdG6wg-1
X-Mimecast-MFC-AGG-ID: xdZkgdOTMxSHWJjFwdG6wg_1787760688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DA521944DEE
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAF0218005BB
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/2] Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"
Date: Wed, 26 Aug 2026 18:11:00 +0200
Message-ID: <134b1453d11ffac177571c72b7832a6c62fa06df.1787760635.git.pabeni@redhat.com>
In-Reply-To: <cover.1787760635.git.pabeni@redhat.com>
References: <cover.1787760635.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vkmykC76F_u9WuwkR8iFpsBmveW8Oq5tffdLrjGnbQA_1787760688
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
v1 -> v2:
  - consolidate enable, fix missing enable for fastopen
---
 net/mptcp/protocol.c | 7 ++++---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 7 +++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e7e59d497c5..d662ad5edec2 100644
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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..c776531fcd03 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -634,6 +634,13 @@ static int subflow_chk_local_id(struct sock *sk)
 	if (likely(subflow->local_id >= 0))
 		return 0;
 
+	/* Slightly unrelated, leverage this code path being called once per
+	 * connection before sending the first packet. Early fallback could
+	 * take place at mptcp_connect() time.
+	 */
+	if (!__mptcp_check_fallback(msk))
+		set_bit(MPTCP_RTX_ENABLED, &msk->flags);
+
 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
 	if (err < 0)
 		return err;
-- 
2.55.0

