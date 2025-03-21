Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E935947
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521547; cv=none; b=B3fyD0/aKrWDpqK82pFKFj6M1SLAEEU6vJDD78vVJRmP/XKXw9cjPnEsy+3C9n265jZbRwAKJs5mUg8p0NijruVu1HjFLbm6LdiiORSGlbbroa3/6dROkZcVXO8VO4eBwWs6M7r3+nrBS9vCDjxd9/K7hVHHOqCLoNiq4DHx7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521547; c=relaxed/simple;
	bh=0/xIY8AEkeapaK9hzqEXQ4ZYS/gJJhSpQVmnkZuW4VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0JLdzRW0sZ7qZzWHmUy1nAVgJYg1ZXe17uO1FZIxvgiDkX0uNrpOQjyvwyb411zn27JBPDa9X1hJmhDz8JdcV6v5+Op5x/PCDHCaahS6viwMNjiMgPVipf6/5JKJDNYE/lDzLSvwDYC4N74giJPHrmYEMIVEchnvgAZ7hRiEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCPQE/ZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCPQE/ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7569DC4CEE7;
	Fri, 21 Mar 2025 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521547;
	bh=0/xIY8AEkeapaK9hzqEXQ4ZYS/gJJhSpQVmnkZuW4VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCPQE/ZKjH3SWiwgylPe1njm8vA08kt7UaZp71HGd2RhfGe8LJhzuuLgvR8B7jcBt
	 ibaUrPZBc93JIxHt8/ECxPBYlKGYwrEx5YSbdGiKpH0i47/HSWLt5Ufz2s3Cag6TYC
	 GmKo2a5WRPUQH6FTT5E7nIymxUWxrlXw8v78lMzaoxm+ppWZZ8nf9XbFgSMfcz371W
	 71/HFnQT7w2ll3A6ZvAzPcKWZ87lYnuPIyhqo7nSbRPSaenKRTgwxuEzVkSXi8uqi0
	 sz/ZhJr15bEGMWWuE6sA+6HE8PwuO0FQ68wCzPxiBg2sfkI1t3N+WOdivpyokGy3vk
	 /lXMoasgb+VRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/10] mptcp: pm: add allow_new_subflow() interface
Date: Fri, 21 Mar 2025 09:44:59 +0800
Message-ID: <4d9a9346c45d11da1d04c029970e7fd6f008b45b.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h      |  3 +++
 net/mptcp/pm.c           | 36 +++---------------------------------
 net/mptcp/pm_kernel.c    | 27 +++++++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 14 ++++++++++++++
 4 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4ac936e4ce0d..e15d6b5680f6 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -128,6 +128,9 @@ struct mptcp_pm_ops {
 	void (*established)(struct mptcp_sock *msk);
 	void (*subflow_established)(struct mptcp_sock *msk);
 
+	/* required */
+	bool (*allow_new_subflow)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 35361d525101..0696d58c61ac 100644
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
@@ -1067,7 +1036,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->allow_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index bd17b1afee2c..520c1c029607 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1395,6 +1395,32 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
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
@@ -1420,6 +1446,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.established		= mptcp_pm_kernel_established,
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
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

