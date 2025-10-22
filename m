Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74E34C99B
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143538; cv=none; b=MItNIDFUxk+ouikHwsEt5z4udvCdfiz/atEEkPWNAvkoBGpk74Px8oV/1lmMdXsqUqC/NRzVOKuwHLzuIQY+jhS5sGGkAuAbSnED21HzUqgj1JMpzlnZDXQCAT2f0pBhU03iYMbY/Mb0fq9mGW1M1bkXalLXkvILUf+y+dPlbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143538; c=relaxed/simple;
	bh=hmnn5v67eRtqPqqo82oKNOc5mkPji0VO3J+OwYb+UIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GFmryMS91BdCgVM/icCmaudQUwWs5veGYGnCKnU7XoTwUumNGjZWruXE53OZzHKf0iEPtkviDZshCrshKLkN2xxd1RnFmSRwOrhMdJWe6Z5ZRhANOi6qYsvjOHr4kdjzc9FUGynESCTHvJTryew+hUJMLRSTbT2PfgtAdYwfc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZR67Tvx8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR67Tvx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJKnA934wjcnyia+ooZM/93BjVChre+fjCJQ/3BTBvg=;
	b=ZR67Tvx8POCqoCQ90Bv9SgKpMYdpRo0M+nq6Os4IL/yd0qisa1rFbFHQ3r4cWVhSueBAPd
	10LqSzSOhGVaIerBx0WIg4Yzr12BIgS/vECtxN4rHXs26HNVQQSs4Y2odlDUo0mZt+yyGn
	Yx/wzFEpO/ewCbryEuzKKWen/Gcc+9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-qdgB9tN1Pt2BVARhn4fPpw-1; Wed,
 22 Oct 2025 10:32:13 -0400
X-MC-Unique: qdgB9tN1Pt2BVARhn4fPpw-1
X-Mimecast-MFC-AGG-ID: qdgB9tN1Pt2BVARhn4fPpw_1761143532
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B736180121B;
	Wed, 22 Oct 2025 14:32:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FBE11956056;
	Wed, 22 Oct 2025 14:32:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 06/11] mptcp: ensure the kernel PM does not take action too late
Date: Wed, 22 Oct 2025 16:31:49 +0200
Message-ID: <fb7ee9348e8db2394ce9ca2f6fd9929ebff15d34.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4U1hYGfsfbksT94bUaTjDmWlctVYlf4fS0n973ZKurc_1761143532
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The PM hooks can currently take place when when the msk is already
shutting down. Subflow creation will fail, thanks to the existing
check at join time, but we can entirely avoid starting the to be failed
operations.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c        | 4 +++-
 net/mptcp/pm_kernel.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index daf6dcb8068431..eade530d38e018 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -588,6 +588,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
@@ -611,7 +612,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
 	 */
-	if (mptcp_pm_nl_check_work_pending(msk))
+	if (mptcp_is_fully_established(sk) &&
+	    mptcp_pm_nl_check_work_pending(msk))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index da431da16ae04c..07b5142004e73e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -328,6 +328,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct mptcp_pm_local local;
 
 	mptcp_mpc_endpoint_setup(msk);
+	if (!mptcp_is_fully_established(sk))
+		return;
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, endp_subflow_max,
-- 
2.51.0

