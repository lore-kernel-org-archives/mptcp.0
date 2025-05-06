Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F11C84C5
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521736; cv=none; b=scYpvf7ZzFp54S9rOHtBBp1J9EPaQYvSFUjkvWq4OgfymEN5jWHe/VV0sMTZNKcsD2CmjN9k9equ3YaduOngQtrnxicHFM9XKaNxGIDMpIS+3iuQTD7BMs3nwAg8vhmo6gvX85fBUE0Gszqwgodv8Iyiz/uu9D5ok6ShJ+AzZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521736; c=relaxed/simple;
	bh=Qo1a5Xd+hREOGdBrgNJy6XK7vsGEq6SLq1fYGi9vTTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+eZhPP5FY+laccmnv8SFNnl+1ZvUQsPANsa0fT6gXqSwcH4cYIpQ46vtkS+pg9Fg39F039XcX+hKsddLxIM6yNP7DlRubu5Ja5otyqecMyhn2uizIY7/JxnTyEdrxEttKyQRQ4sgcsIJjtARrosdrCUNNpzndOb148rWlx4lZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Vu5R2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Vu5R2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D8EC4CEE4;
	Tue,  6 May 2025 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521733;
	bh=Qo1a5Xd+hREOGdBrgNJy6XK7vsGEq6SLq1fYGi9vTTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1Vu5R2oOrf7iIPJs7Fef/RHBiV9UjC8PvP4WQ4uxuhQiusz7yPgbweSxTqDn75mb
	 Es52cwpyRUyJ2yr66qbL79doW9swEr+HSJnMlT94ExERAp4NXCJynvAeWV2iLEpJ7g
	 72o5Rzz1zF8tomjyQyFlKlcXE4/pJ93LqN+jeUYa+2IFIxV/oklFx+sp6n9uGvF0MY
	 bYnbGooO3snAV7iFuUjtA1eftQp+nU6dAiWlDJci/pOxa4hwGj1y/Jg8ePdL9LsPZw
	 man3R8G1DymlqdYRo+2BPv5jOycwZcDfX08844TPte+y4P9Q9OeSRNwDZIrrdSMuOC
	 i4Ze9isGPcl0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/5] mptcp: pm: call pm worker handler without pm lock
Date: Tue,  6 May 2025 16:55:22 +0800
Message-ID: <9bc0479546c550c4ec7a9e000e6a19a8d74939ac.1746521233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746521233.git.tanggeliang@kylinos.cn>
References: <cover.1746521233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Later functions that cannot hold the mptcp pm lock will be called from
the PM worker, so this patch modifies the order of holding the lock
at the beginning of this function and releasing the lock at the end.

The new order is to obtain a copy of pm->status and clear the flags of
pm->status while holding the mptcp pm lock, then read the copy after
releasing the lock.

For each PM status flag, call each handling function without locks.

Finally, hold the lock before calling __mptcp_pm_kernel_worker() and
release it afterwards.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        | 21 ++++++++++++++-------
 net/mptcp/pm_kernel.c | 16 ++++------------
 net/mptcp/protocol.h  |  2 +-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index dfca70d361e1..448ac6c42880 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -946,24 +946,31 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	u8 status;
 
 	msk_owned_by_me(msk);
 
 	if (!(pm->status & MPTCP_PM_WORK_MASK))
 		return;
 
-	spin_lock_bh(&msk->pm.lock);
+	spin_lock_bh(&pm->lock);
+	status = pm->status;
+	pm->status &= ~MPTCP_PM_WORK_MASK;
+	spin_unlock_bh(&pm->lock);
 
-	pr_debug("msk=%p status=%x\n", msk, pm->status);
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+	pr_debug("msk=%p status=%x\n", msk, status);
+	if (status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		spin_lock_bh(&pm->lock);
 		mptcp_pm_addr_send_ack(msk);
+		spin_unlock_bh(&pm->lock);
 	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		spin_lock_bh(&pm->lock);
 		mptcp_pm_rm_addr_recv(msk);
+		spin_unlock_bh(&pm->lock);
 	}
-	__mptcp_pm_kernel_worker(msk);
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_kernel_worker(msk, status);
 
 	spin_unlock_bh(&msk->pm.lock);
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..61b457a6b7a8 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1340,22 +1340,14 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 }
 
 /* Called under PM lock */
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk, u8 status)
 {
-	struct mptcp_pm_data *pm = &msk->pm;
-
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+	if (status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED))
 		mptcp_pm_nl_add_addr_received(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+	if (status & BIT(MPTCP_PM_ESTABLISHED))
 		mptcp_pm_nl_fully_established(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+	if (status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED))
 		mptcp_pm_nl_subflow_established(msk);
-	}
 }
 
 static int __net_init pm_nl_init_net(struct net *net)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 91aaed17fe56..b2ee751ce4c9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1165,7 +1165,7 @@ void __init mptcp_pm_kernel_register(void);
 void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
-void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+void __mptcp_pm_kernel_worker(struct mptcp_sock *msk, u8 status);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.43.0

