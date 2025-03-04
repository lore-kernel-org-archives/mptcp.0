Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58B1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088460; cv=none; b=ZdeuFTKiHruPUg+lLJuUcNIxn5JHNaree/eeLnIERB193f8SXvQSPPFUnztFJM2k5Ds1vCm7dQGJsSZdgiV8fOh/MbtazgnEk1QlPlKD8NvL8Pgl34S/1SxX/ScoSoOPNRfPPRXa1m0pugCL+YdWwPMzRsZjJe7pLm/oXw+c/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088460; c=relaxed/simple;
	bh=7kmuYrhl2Xl4uqSRERyCWJy8xKADI41slbAAHA0FDLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvHZQCbBKjDEMfIeO7POIQE3sCb7MnuS6ULr6ZN1Xwxjhc45REJjOac5KjH4BoEr6M1EYch1daeyvbKyiSO+dYaIAZf2p1xZZgeQI3x4tM5qnaicNjHpmam8R2Gl5lyGoza14VMV9BHdmeHUqKj81l1S4AWbTknNKPR6cskTAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stXjk3Ws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stXjk3Ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68DBC4CEE9;
	Tue,  4 Mar 2025 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088460;
	bh=7kmuYrhl2Xl4uqSRERyCWJy8xKADI41slbAAHA0FDLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stXjk3WsvHupByLkbaCcTNDHUYxZGq9dxHjhE9Ap6V4JAcxYAGkZRjFM9eG1bAYBS
	 yP2WV38423JkDevLHQR50HZ5aFZr8TFQxaIL3cbqRFS4ekL75gkV5tNY+h2MM+K+/x
	 C3kOSrDigZO1mSY59bGkqvVpNT+3mddQcsf38LHH2u6+Algsf+tUVNlKVoZfn1EhAu
	 eB0YBPhQNqJAX8DLoVUWHzZfeKcq3zz7PwNyKHcuSjWcT2mUrJzGPHfN/5s9Oo+/AN
	 QUH7yLfjeay6NIpNr6EssWHBk/RvuW21DNxrbpQhA/joU0Fqm1L+CA5ipVgc8rSuf6
	 +CXJH5BS6TcmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 08/12] mptcp: pm: initialize and release mptcp_pm_ops
Date: Tue,  4 Mar 2025 19:40:35 +0800
Message-ID: <0fd4e42c04c60d63c11463c792084b751c4e2e48.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
functions mptcp_pm_initialize() and mptcp_pm_release(), to set and release
this pointer. mptcp_pm_initialize() is invoked in mptcp_pm_data_reset(),
while mptcp_pm_release() is invoked in mptcp_pm_destroy().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 57 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5018ed3c575f..e4d84aad3795 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -970,16 +970,45 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static void mptcp_pm_initialize(struct mptcp_sock *msk,
+				struct mptcp_pm_ops *pm)
+{
+	if (!pm || !bpf_try_module_get(pm, pm->owner)) {
+		pr_warn_once("pm %s fails, fallback to default pm",
+			     pm->name);
+		pm = &mptcp_pm_kernel;
+	}
+
+	msk->pm.ops = pm;
+	if (msk->pm.ops->init)
+		msk->pm.ops->init(msk);
+
+	pr_debug("pm %s initialized\n", pm->name);
+}
+
+static void mptcp_pm_release(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_ops *pm = msk->pm.ops;
+
+	if (!pm)
+		return;
+
+	msk->pm.ops = NULL;
+	if (pm->release)
+		pm->release(msk);
+
+	bpf_module_put(pm, pm->owner);
+}
+
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
 	mptcp_pm_free_anno_list(msk);
-
-	if (mptcp_pm_is_userspace(msk))
-		mptcp_userspace_pm_free_local_addr_list(msk);
+	mptcp_pm_release(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
+	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
@@ -991,25 +1020,9 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
 
-	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
-		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
-
-		/* pm->work_pending must be only be set to 'true' when
-		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
-		 */
-		WRITE_ONCE(pm->work_pending,
-			   (!!mptcp_pm_get_local_addr_max(msk) &&
-			    subflows_allowed) ||
-			   !!mptcp_pm_get_add_addr_signal_max(msk));
-		WRITE_ONCE(pm->accept_addr,
-			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
-			   subflows_allowed);
-		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
-	} else {
-		WRITE_ONCE(pm->work_pending, 0);
-		WRITE_ONCE(pm->accept_addr, 0);
-		WRITE_ONCE(pm->accept_subflow, 0);
-	}
+	rcu_read_lock();
+	mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
+	rcu_read_unlock();
 
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 658bc60d4cd8..2a264124cb17 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
-- 
2.43.0

