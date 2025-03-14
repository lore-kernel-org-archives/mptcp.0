Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CE7DA93
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920355; cv=none; b=e8IdUpTyF7kiHuH2mdIOhZgK7K3bajYmK2z7O1zY+y7I82bVVXot1ZpjMK2nLG0kuMPZJ1k7goEc4SayyPa1ExyQ6hJU0V+W4YQReHPpAZp8vq651Byenwd4nj4hemMpxOAOy6xMkMZCnZst3ZBUZLieUCYs9DuO2j//S2CB8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920355; c=relaxed/simple;
	bh=ZvJRU5Tzt99gW3U083XEXzYShqgCON9fSS6JBdZMlms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pj9i21Lu3OgPkm+qkFYQhYOJZdFF++9ZTScY8j/fVe5LtQsSGfDSvWh2HyRizFIs4VX6jQ3P3onp76v6mpPhihDlP7o8bIRtAAuVQvdZ+NM/nKfpM2pyRzDffK06IR7YKl036bXXC5S2pYDgxKPk3ZYVJactj9iDuMWgMCvdZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spvhkij1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spvhkij1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C14C4CEEE;
	Fri, 14 Mar 2025 02:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920354;
	bh=ZvJRU5Tzt99gW3U083XEXzYShqgCON9fSS6JBdZMlms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Spvhkij18vvc9i/8VvsuEVJqGZoiVesEeQYEXTJ2mhx9+V5wCfugkXH4ZtH5aJu8k
	 4nw5TXpGCoERBVmDf1rMRtGduUsEeMd+fQsueYPuZOIeg1p9NzrnGJSnnqg4ERzOSF
	 kShrCY+rXSwibMvyhmkyh0KII4Rkhrhz5dcOyEcYbxmZ+HDbwQiAVA0QLuBI84bRpG
	 yAquh2BgfoFgQ1owdfZJ2o2lHMf7P5jde+bqg6x0uFofbdwr2TFcN9fZ0au23SE1+5
	 MrEdsrpT5h0U4gYyVankMxxKnRYF62ns2cheIkJaJLL4o6gpKT4K7jzkvgQnR1rbVg
	 brEqu7VnyxebA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/10] mptcp: pm: add allow_new_subflow() interface
Date: Fri, 14 Mar 2025 10:45:26 +0800
Message-ID: <a49764a8792abfad4db4f2ca229970dbe0a572d1.1741919893.git.tanggeliang@kylinos.cn>
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
index b90134152b92..03152a1a157e 100644
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
@@ -1063,7 +1032,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->allow_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e21fefc0aca9..eb498b17e67f 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1391,6 +1391,32 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
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
@@ -1416,6 +1442,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
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
2.45.2

