Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B722E3E9
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172418; cv=none; b=ebr2M3RdsG8F7yekPdLU18R0lYmdnXI+cVmNwa5oIhZ9tIo2RGotA4ZR1TiizGPbpi8v/IayJNNOZM9hLjVyWoWm1d+uwYkuREwUoV5hBL1c8ty9eQfhjqWVq00UNzYRxFPpQJ5hVZq9BJNrtTodKdUvikeZ7mWw71TG8n9avDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172418; c=relaxed/simple;
	bh=o6x5OpLX869vSVjiJS5uVh+MzsowDYAK40fP3KBW39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWbB/FPZUP5423InhAULcG7VVEl3Qi7PIevBL1ggs5v9u3J6Ek0tYeERTEv+IJTKHUm5VBrKDmOiR/75iHHDLCxLIPqWkJYpO9waJoO9MqL6sGY9IcrhwvjgsFo7ZMpQtR5807Ct5Blp1bT82HDLBtONKJXibD5ObpZoVOmff6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/2zbXPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/2zbXPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B07C4CEE8;
	Wed,  5 Mar 2025 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172418;
	bh=o6x5OpLX869vSVjiJS5uVh+MzsowDYAK40fP3KBW39Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/2zbXPYmFKAY1ecBqeF/EfPBJ8lz3Zfsy2C2yNpL9tFBiSAP2TByNxB7hgLM3Zd5
	 Z/KTGjEfdfj8N6ENT9gmGh9Ihmlcgl/AV5UeFtgPJgNYivGkcSlclWLg1qDp3ms8Hr
	 6NgixzCXxhq6jSJs0p+NF7843dNRuiwzR3RsVlyRO5DuNAj3NCPsWAoq7t/abRNEB+
	 8eEJOHnAnMElINZ8tqHOI/eKevnyEMY0Cwr7faLVod1J2exAKOhjcNKDVGUtCgz6cE
	 /l5dS6xgXy8mdHaXpEcHb+pKKtH2SYQ2PTjZjZ3srlzmO+tkekiKJnUU1rG6OJME4H
	 TriePTrI99iZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 08/12] mptcp: pm: init and release mptcp_pm_ops
Date: Wed,  5 Mar 2025 18:59:49 +0800
Message-ID: <edce38148914a02dac4cecaaeae2efb574101cf8.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
helpers mptcp_pm_ops_init() and mptcp_pm_ops_release(), to set and release
this pointer. mptcp_pm_ops_init() is invoked in mptcp_pm_data_reset(),
while mptcp_pm_ops_release() is invoked in mptcp_pm_destroy().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 57 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5018ed3c575f..fc728c55cda5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -970,16 +970,45 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static void mptcp_pm_ops_init(struct mptcp_sock *msk,
+			      struct mptcp_pm_ops *pm)
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
+static void mptcp_pm_ops_release(struct mptcp_sock *msk)
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
+	mptcp_pm_ops_release(msk);
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
+	mptcp_pm_ops_init(msk, mptcp_pm_find(path_manager));
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

