Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E561F09AB
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685564; cv=none; b=bnJfzW4QZm3YSyp1YghjNewL2HEnKPkeQU0/WeoI3l8BjC32K0eBBoTa6xr36tnqXQ5T5vBzAXqQ3o2iJrT3OJm97UiEmTyNGB9/KN+08P96dDKrrVOM/40ZKviqJCeDW3HGBihTkrUfg592KcqeP6oBpAh4J6ZN4sYXPV/OQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685564; c=relaxed/simple;
	bh=ZAVyGnuY0mgldBjHDNWZi1/pllLxbY+xCxTlclrawxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roTBvx0HdbTwxtnokurQrMVhb+3o3OF6oOBiT/wn+BejiC/fZ8namidChOcFVtTMOEIdNqc90/QZTQ4yq8jnyZ+/VYI7hzu6LwshXpPiZuD25UogfoFOPtrJltH+/qqGd1upoK+BhOCwj/UPBY/GyDCS7WsNJSJyV9L6YIpLG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7sJILff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7sJILff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13311C4CEEB;
	Tue, 11 Mar 2025 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685564;
	bh=ZAVyGnuY0mgldBjHDNWZi1/pllLxbY+xCxTlclrawxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7sJILffgTtywvMczmf2lZQX7dXY+bZg3I21rkLVzdxyXn639MYRzDDtr17jtxk3Q
	 jplN25WBvUmxeiu0GYnpwv4rdJ8GI0dB7HA/uevgzqJvsIYcYCHNmbEJce3PT5wofa
	 dHuIY2doFRpWu24cyuisJw7Czyo34uhDnkI1NglXbqXGH39uJw9ONk5J6mcq0XgVTo
	 MfJbUFjM2X0ojykZud81eZLYLYaZAfdyDaiOqNZGbnm7DehhQ6tW57xwuSWgEDbF/A
	 NCNtw+9Y+ugBSL5DFcaVwZkSQ6x2aK5lUIS9P+Q5sXx9SZF3iN+wfY2v+UmwxXRwpr
	 P/cD6/mFUEdJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/6] mptcp: pm: add subflow_check_next() interface
Date: Tue, 11 Mar 2025 17:32:27 +0800
Message-ID: <2e7dd2f26852e4d5b5cd0434e13069b9461a3f32.1741685260.git.tanggeliang@kylinos.cn>
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
operations from in-kernel PM in mptcp_pm_subflow_check_next(). It seems
reasonable to add a mandatory .subflow_check_next interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  3 +++
 net/mptcp/pm.c           | 31 +++----------------------------
 net/mptcp/pm_kernel.c    | 20 ++++++++++++++++++++
 net/mptcp/pm_userspace.c | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6f9bc0ca4d37..5f2d94b2f97f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -15,6 +15,7 @@
 struct mptcp_info;
 struct mptcp_sock;
 struct mptcp_pm_addr_entry;
+struct mptcp_subflow_context;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -125,6 +126,8 @@ struct mptcp_pm_ops {
 
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
+	void (*subflow_check_next)(struct mptcp_sock *msk,
+				   const struct mptcp_subflow_context *subflow);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 31a2c66a1af3..d8a5c2c06500 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -526,33 +526,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_pm_data *pm = &msk->pm;
-	bool update_subflows;
-
-	update_subflows = subflow->request_join || subflow->mp_join;
-	if (mptcp_pm_is_userspace(msk)) {
-		if (update_subflows) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows--;
-			spin_unlock_bh(&pm->lock);
-		}
-		return;
-	}
-
-	if (!READ_ONCE(pm->work_pending) && !update_subflows)
-		return;
-
-	spin_lock_bh(&pm->lock);
-	if (update_subflows)
-		__mptcp_pm_close_subflow(msk);
-
-	/* Even if this subflow is not really established, tell the PM to try
-	 * to pick the next ones, if possible.
-	 */
-	if (mptcp_pm_nl_check_work_pending(msk))
-		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
-
-	spin_unlock_bh(&pm->lock);
+	msk->pm.ops->subflow_check_next(msk, subflow);
 }
 
 void mptcp_pm_add_addr_received(const struct sock *ssk,
@@ -1017,7 +991,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
+	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow ||
+	    !pm_ops->subflow_check_next) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 708a96951cba..b40d39232f70 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1430,6 +1430,25 @@ static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.accept_subflow);
 }
 
+static void mptcp_pm_kernel_subflow_check_next(struct mptcp_sock *msk,
+					       const struct mptcp_subflow_context *subflow)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool update_subflows;
+
+	update_subflows = subflow->request_join || subflow->mp_join;
+
+	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+		return;
+
+	spin_lock_bh(&pm->lock);
+	if (update_subflows)
+		__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&pm->lock);
+
+	mptcp_pm_subflow_established(msk);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1455,6 +1474,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_priority		= mptcp_pm_kernel_get_priority,
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.subflow_check_next	= mptcp_pm_kernel_subflow_check_next,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4cd9a84477c8..68247ec4cdaa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -701,6 +701,20 @@ static bool mptcp_pm_userspace_accept_new_subflow(const struct mptcp_sock *msk)
 	return mptcp_userspace_pm_active(msk);
 }
 
+static void mptcp_pm_userspace_subflow_check_next(struct mptcp_sock *msk,
+						  const struct mptcp_subflow_context *subflow)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool update_subflows;
+
+	update_subflows = subflow->request_join || subflow->mp_join;
+	if (update_subflows) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+	}
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -711,6 +725,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_priority		= mptcp_pm_userspace_get_priority,
 	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
+	.subflow_check_next	= mptcp_pm_userspace_subflow_check_next,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
-- 
2.43.0

