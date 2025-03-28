Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A619E98A
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134503; cv=none; b=uBAuda7B+CV91jn8LpxskT56Y/p4v8V8bYc5IyrglkR1h1erXFQ5UO1AO3BuNDPrjIka6cyjxPez9wMnusOtegd6a/cOcnRNLG4ZgkADMG682gE7mVHYGCzk41xJxsylXUTgwr19cKR9ZM2jdTpmMN/P3LaSHFV2ppOhKghPZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134503; c=relaxed/simple;
	bh=opAU8zbreorxWH8gBC0bjMkyESD1mn1JirG02lh2/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFP3eduVOV13p4sn7AXaASgEoTw2HJnfMc9QKkLGJYePA3t7mjI7aDimssYdUYnPeehwBezbZe2Mop5VqT/XFChaafd8Cw/EnzyC5x8q22a2NEMcL8u14H2i2ECAx97qpTTb7skG1V4PBsd3mlSRApdzOTfv7LP+kmQTcoa0F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVkX0x+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVkX0x+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8155BC4CEE5;
	Fri, 28 Mar 2025 04:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134502;
	bh=opAU8zbreorxWH8gBC0bjMkyESD1mn1JirG02lh2/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVkX0x+1tcXrI42J9SfQ0GcX3IXiC+TBSD0htQQheADYDrq5KWRaQWo/y66mnaC0F
	 RxMAGLuXqOp8/jzMvQv43TbmL/YJBme/jDgCuhmpYdKQzdUZfCmhRQx157DTkkPTcM
	 lyC3LArrE/VmsVGIlojvaxuouMX3rwzWbfpWH2vjLlVPlMp4GxgSgpVq6byd9aASlj
	 Cwz6AxHLmxfsB1Vkdu07FayC++qmXbPCtDVmtMEsJEhpU1y28s370c7QM+z4YZWe9J
	 LoaBLPiwAwbAwhagyy+s4QqBQFtEEiAvRcqkSEckEmhAxicuCdVYJAFTdTxB6EHhEe
	 VaHwa6ZeoLPbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/5] mptcp: pm: call pm worker handler without pm lock
Date: Fri, 28 Mar 2025 12:01:31 +0800
Message-ID: <ce4d4550167bea737bf80607fd1f6e9b8aa2c253.1743133948.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743133948.git.tanggeliang@kylinos.cn>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
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

Rename mptcp_pm_addr_send_ack() with "__" prefix to indicate that the
mptcp pm lock is not held.

Hold the mptcp pm lock inside mptcp_pm_rm_addr_recv().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 34 ++++++++++++++++++++++------------
 net/mptcp/pm_kernel.c    |  4 ++--
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  2 +-
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index be1e27ee393e..4ed6a2ccb112 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -211,7 +211,7 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+void __mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *alt = NULL;
 
@@ -238,6 +238,13 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
+static void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_addr_send_ack(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr,
 			      struct mptcp_addr_info *rem,
@@ -437,7 +444,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack(msk);
+	__mptcp_pm_addr_send_ack(msk);
 	return 0;
 }
 
@@ -715,7 +722,9 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
@@ -945,6 +954,8 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
+	u8 status, mask = BIT(MPTCP_PM_ADD_ADDR_SEND_ACK) |
+			  BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	msk_owned_by_me(msk);
@@ -952,20 +963,19 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	if (!(pm->status & MPTCP_PM_WORK_MASK))
 		return;
 
-	spin_lock_bh(&msk->pm.lock);
+	spin_lock_bh(&pm->lock);
+	status = pm->status;
+	pm->status &= ~mask;
+	spin_unlock_bh(&pm->lock);
 
-	pr_debug("msk=%p status=%x\n", msk, pm->status);
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
-		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+	pr_debug("msk=%p status=%x\n", msk, status);
+	if (status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK))
 		mptcp_pm_addr_send_ack(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
-		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED))
 		mptcp_pm_rm_addr_recv(msk);
-	}
+	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
-
-	spin_unlock_bh(&msk->pm.lock);
+	spin_unlock_bh(&pm->lock);
 }
 
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..8935df61aa50 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -326,7 +326,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			local.addr.id = 0;
 
 		mptcp_pm_announce_addr(msk, &local.addr, false);
-		mptcp_pm_addr_send_ack(msk);
+		__mptcp_pm_addr_send_ack(msk);
 
 		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			signal_and_subflow = true;
@@ -460,7 +460,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_addr_send_ack(msk);
+	__mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		return;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..d9b0a93e42f6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -231,7 +231,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_addr_send_ack(msk);
+		__mptcp_pm_addr_send_ack(msk);
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 64aa091cb685..3d51898a2781 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,7 +1022,7 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
+void __mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 			 const struct mptcp_rm_list *rm_list);
-- 
2.43.0

