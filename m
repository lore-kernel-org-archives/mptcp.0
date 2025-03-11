Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A7EC5
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685561; cv=none; b=ez/BE3pCASmEQCIaPYr27RNXmhjj81oTMin/9gJx4NCiK7gFpa0aaCLXQb1EdEThCRXYVXV1JKGEgTVwjJx4mgM48R5xPyzfme8IKg/OGAFw/JnedV14rAFkMCfpI9iDJmzzOUH8pTNGj0BD6QhqToToCJZwJ/aZRAvgDSEb+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685561; c=relaxed/simple;
	bh=dCz4T5AElh58zU61d5J78jmKtcCGBlxD81xMuXlYsP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI0CU/e9bKkVLJS2DVxE3LKiUDIy+9mKZj62YIPCooJX6SNkvhwT7wHXpulrUtvK1kxGdxdcsEjhDcu7Mau3nlcu21so4U9PMtNL5YPKvO+zt/TRCN9VArOTrauC2yOqhAMKqWr25f+bg1+PUdW9rBIPH6B7/qPgkz6xb1CHMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqKxo5rC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqKxo5rC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF7C4CEEB;
	Tue, 11 Mar 2025 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685560;
	bh=dCz4T5AElh58zU61d5J78jmKtcCGBlxD81xMuXlYsP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqKxo5rCrNw4aFvrTr93X+GDTnOhtjNj1hx2Ly8ysvXCTDTcoEgbSscGaNQG7KWK1
	 cJIpKQOrWKSNUWnXuFIcewhuCAcY6TGF9evisgQvHYkVa5yKSMDIZsrDrDjP+Ge5Kz
	 KK0g9KrIcDA9TSq1N5c693yYhm+pBxWDcO7p1dmqDpkbg8Ohfg/Dk1xr+guBUAfzNf
	 yb24TrlA5K6rpYTSl6Ms9snbXpQ8Yevj7xvSL9+lb5wpPWtEp4dS/DkD/3ojTdOSbb
	 Tpdm8Xtza/DXsAXJXxgVDOYq5vZFlC6Eyd1Pm+86a+Eqw+H7nScR9q/2ZrUFm3Y1IR
	 JLZJI/lJOS7vQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/6] mptcp: pm: add allow_new_subflow() interface
Date: Tue, 11 Mar 2025 17:32:25 +0800
Message-ID: <afd03e1f1f0972d695c6fbd603699fbbe6cda3ff.1741685260.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741685260.git.tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
operations from in-kernel PM in mptcp_pm_allow_new_subflow(). It seems
reasonable to add a mandatory .allow_new_subflow interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  2 ++
 net/mptcp/pm.c           | 36 +++---------------------------------
 net/mptcp/pm_kernel.c    | 27 +++++++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 14 ++++++++++++++
 4 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6a08ac862bbe..af995387248b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,8 @@ struct mptcp_pm_ops {
 	bool (*get_priority)(struct mptcp_sock *msk,
 			     struct mptcp_addr_info *skc);
 
+	bool (*allow_new_subflow)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7424582ebf..80293c823a3a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -452,38 +452,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_data *pm = &msk->pm;
-	unsigned int subflows_max;
-	int ret = 0;
-
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows++;
-			spin_unlock_bh(&pm->lock);
-			return true;
-		}
-		return false;
-	}
-
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
-		 subflows_max, READ_ONCE(pm->accept_subflow));
-
-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->accept_subflow))
-		return false;
-
-	spin_lock_bh(&pm->lock);
-	if (READ_ONCE(pm->accept_subflow)) {
-		ret = pm->subflows < subflows_max;
-		if (ret && ++pm->subflows == subflows_max)
-			WRITE_ONCE(pm->accept_subflow, false);
-	}
-	spin_unlock_bh(&pm->lock);
-
-	return ret;
+	return msk->pm.ops->allow_new_subflow(msk);
 }
 
 /* return true if the new status bit is currently cleared, that is, this event
@@ -1047,7 +1016,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->allow_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..af69f736c7c7 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1399,6 +1399,32 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static bool mptcp_pm_kernel_allow_new_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	unsigned int subflows_max;
+	int ret = 0;
+
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
+		 subflows_max, READ_ONCE(pm->accept_subflow));
+
+	/* try to avoid acquiring the lock below */
+	if (!READ_ONCE(pm->accept_subflow))
+		return false;
+
+	spin_lock_bh(&pm->lock);
+	if (READ_ONCE(pm->accept_subflow)) {
+		ret = pm->subflows < subflows_max;
+		if (ret && ++pm->subflows == subflows_max)
+			WRITE_ONCE(pm->accept_subflow, false);
+	}
+	spin_unlock_bh(&pm->lock);
+
+	return ret;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1422,6 +1448,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..3a9962ac77b2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,6 +683,19 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+static bool mptcp_pm_userspace_allow_new_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	if (mptcp_userspace_pm_active(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows++;
+		spin_unlock_bh(&pm->lock);
+		return true;
+	}
+	return false;
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -691,6 +704,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
+	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
-- 
2.43.0

