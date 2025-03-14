Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E782AF19
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920358; cv=none; b=Pug/uCf24ESjzYfeYaWfQUq6f9NASUb1maNIm6NEn1wRx815UJNdV+01wtdJ1NDydjiBNwo1mZFln5YtQJwHPq+p2rk8jt5lQhvC7sodV0US4+7PSPNrwLMyYquZufv4nyMEBaZDJUkffwqKwOpAyPO5WMHO+o8pML7ZMqCYgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920358; c=relaxed/simple;
	bh=ubu6yVYvrAY1v0Xmrs2obxU2nU7RAEMVb1catBGiU8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBOLSlBms70d6CxrOrgzW+/HHvbGhj12U3lXgK1/LCSYIS0CCWn82w4R0MYjoxR15NdG+8/KuZJcNCVNAjzxjwKvQsWZkzpTQs+7T+wE4M4gBAm0YXzQmcoS8G6L/9Ue/vlQ/KWOFzTMaZ8NCcMy5A3RgShOKhkWtmy3zSTGLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAIDh1yo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAIDh1yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE98CC4CEDD;
	Fri, 14 Mar 2025 02:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920358;
	bh=ubu6yVYvrAY1v0Xmrs2obxU2nU7RAEMVb1catBGiU8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAIDh1yoLPr5ZW+cCa9+JEpwRAgIMow6wJlIdAsMJelxavKZ0CLzvcG7fSzfgXQOW
	 lwzhMQyF492FwG6BN/DDbhGxw337GS07uPvngm10fOvIXdlVcAcXqKzw79i8n6yokc
	 +zMLKIx/QsSGnZhyzH3IK50icgE6NGjg9rgXlT2c/VH91NykBSjBVKaonEmAd58dA5
	 cVhiSzi33vl2/A2PuItD35QZbtc82v0tam1iqYFxJMeLTqCX04IPBJUK51VOX0Q068
	 P7lVGoEdH1tc6OrLdIjCCy05YxyWVIun8tI3cZ7DL3nfBIX4TQRSa89zblf9LiXqJk
	 K2DfQSEYyJ17g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/10] mptcp: pm: add add_addr_received() interface
Date: Fri, 14 Mar 2025 10:45:28 +0800
Message-ID: <98316342c985b097b352535a53a2b00c0788580e.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds an optional .add_addr_received interface for struct
mptcp_pm_ops and invokes it in mptcp_pm_add_addr_received(). A new helper
mptcp_pm_add_addr_recv() is added to allow the MPTCP_PM_ADD_ADDR_RECEIVED
worker can be invoke from the in-kernel PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  4 ++++
 net/mptcp/pm.c        | 10 +++++++---
 net/mptcp/pm_kernel.c | 12 ++++++++++++
 net/mptcp/protocol.h  |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index de9838ea37c4..37a84b4c661e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,10 @@ struct mptcp_pm_ops {
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
+	/* optional */
+	int (*add_addr_received)(struct mptcp_sock *msk,
+				 const struct mptcp_addr_info *addr);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7ae706669c80..522dd2df4097 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -559,6 +559,11 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk)
+{
+	return mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -586,10 +591,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->remote = *addr;
 	} else {
-		ret = -EINVAL;
+		ret = pm->ops->add_addr_received ?
+		      pm->ops->add_addr_received(msk, addr) : -EINVAL;
 	}
 
 	if (ret)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 38542d62767d..6a5d6d374b0d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1422,6 +1422,17 @@ static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.accept_subflow);
 }
 
+static int mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk,
+					     const struct mptcp_addr_info *addr)
+{
+	if (mptcp_pm_add_addr_recv(msk)) {
+		msk->pm.remote = *addr;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1449,6 +1460,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d9ca3a19a218..d65fe3748427 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,6 +1013,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-- 
2.45.2

