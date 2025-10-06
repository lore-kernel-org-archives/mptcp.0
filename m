Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEB19C553
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738346; cv=none; b=lIYU2U5Mk0x1zhmx9DS82ivFS6n4Dhv/Mm5LSQu2Xg542M9ZvvBTHQuXHSOwftaRzg1oi8hsnEj1H01UOv0MbismZ/d6BVTdHxbtAGlAZN/FbTmVkhK1fN0WJIj9Ail2WtxOawcQEZV6r0it+SZuSoGDdtXTGCrtxkfbp/9sO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738346; c=relaxed/simple;
	bh=dj8c/JN7HqwDUiohLe/fpbEFg0BYKJICKZ8rVg4upAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=vBc6FTgjoAJKEDo/9y8y5s6/LE0ImOklYWienE4xDCb7zSRQE/MGwu7tUbsAEaRTPVeUXO6QyXXn3NkLdXdsNvhV8IyaoxKzMaEB7xmIBqdIe/Al2oCTkXpW+BGSZ4vc71gK70sSBlKz+k6YbpcDtZWIMWJ5hvV5EFJbM2tXoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzJL9I3L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzJL9I3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QO8GCeWsLtWh9fJUyB8zOtH8wdvB6AApkaM+V13SaDA=;
	b=ZzJL9I3Lr70d7/igrfmskw3G+fvFdD6678ZIeOhoPW9uIRJg9LEbwCzQgbl6vumfIYeoX1
	lkFAsJmuvUiZeBACfp/dvFAIKc1+qOwUhR/OXePCyO3ffr9LDp9H0tH/5jmdZOYvDfNnUs
	NSxnLF1VOli2MKAc1bUrqcHj2UiDI/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-JLMI5KikN1mepwSLYxt7hg-1; Mon,
 06 Oct 2025 04:12:23 -0400
X-MC-Unique: JLMI5KikN1mepwSLYxt7hg-1
X-Mimecast-MFC-AGG-ID: JLMI5KikN1mepwSLYxt7hg_1759738342
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F3CE180034D
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96AAD180035E
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 05/10] mptcp: ensure the kernel PM does not take action too late
Date: Mon,  6 Oct 2025 10:12:04 +0200
Message-ID: <8793483bbd42a8be40ccef7a94c0a2a447ffe828.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: POpjrm0srs8ww6AeTtJrKCryg-Iva_IoEYDBGXFiYxQ_1759738342
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
index daf6dcb806843..eade530d38e01 100644
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
index da431da16ae04..07b5142004e73 100644
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

