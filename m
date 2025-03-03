Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C513C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975932; cv=none; b=EdKyf8/hwFA91ttiUpvx3OkIE6f8vS1StwjO55rkb/Zczw+vnqC0TNzBgRVoMKMaprx4J+0zAsJwJpLhm7ehlkzXJ2dqMkOOLQ+Ba6PFmPChOABcE1iYhvfUmrLBv5Szx9UQGDmECFktVSfrmahExbuoucOAH8BCPP1tyfAyetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975932; c=relaxed/simple;
	bh=4Dejvqx1PnTP7sVztx1CiJVjWHqY2s9EfjnZw/El2ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOfsVMkoBAmP7wqoBARHyr1m96gCczeEb0BzVkSBy+yl3NiJrJyq8Ku/eMJTqUyjeZO/tZ0ZQYiBhkqCC600aZIjOO9Tz4JAdBwrv/ViBZ3w4ENOJqhDeVL4nVuWPjWSqQslidV0TjsVWsbA2mtN73HFSRobikySKWXuvkbEm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOQmcFpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOQmcFpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8DC4CEE4;
	Mon,  3 Mar 2025 04:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975932;
	bh=4Dejvqx1PnTP7sVztx1CiJVjWHqY2s9EfjnZw/El2ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOQmcFpBYoGjJgTHSKDsPCsC0C87tqolnszMxzCbCfQa9m8Dd1x30FyZwRXdOSQFH
	 0up5N7GqDzGZJ1xMIiWPnKpTncmZ4cHV6UVhasDZUigtPSBPYeiSSQdYipqkcduan6
	 yq5jBfoc52QnPIclm4/fc7d//hknstd9VaSZBxI8brF1aIjD1y/FpzvtTAVS2XZp76
	 nTfGvhU3PTAECJnCF1xuP48hEFK1eC8GGJNMU6gK5TApgoNbTCI5TNzzlY2uUG09KN
	 sYsfryRqRN757YYttMtdEZthdRorsAwDeOrxjiumXY4rcijF4P8gWi71Q7hKKm0FQu
	 mS8pYmL/TuJnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 07/11] mptcp: pm: initialize and release mptcp_pm_ops
Date: Mon,  3 Mar 2025 12:22:55 +0800
Message-ID: <7c65de17fee4c36d003684e730c1459542eedca8.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c       | 42 +++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 98f81221786f..e8b34f2ecb35 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -973,15 +973,15 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
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
+	int ret;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -991,6 +991,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
 
+	rcu_read_lock();
+	ret = mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
+	rcu_read_unlock();
+	if (ret)
+		return;
+
 	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
 		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
 
@@ -1102,3 +1108,33 @@ void mptcp_pm_get_available(char *buf, size_t maxlen)
 	}
 	rcu_read_unlock();
 }
+
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
+{
+	if (!pm)
+		pm = &mptcp_kernel_pm;
+
+	if (!bpf_try_module_get(pm, pm->owner))
+		return -EBUSY;
+
+	msk->pm.ops = pm;
+	if (msk->pm.ops->init)
+		msk->pm.ops->init(msk);
+
+	pr_debug("pm %s initialized\n", pm->name);
+	return 0;
+}
+
+void mptcp_pm_release(struct mptcp_sock *msk)
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 979ee8762fd4..172450455c2a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1058,6 +1059,8 @@ int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
 void mptcp_pm_get_available(char *buf, size_t maxlen);
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_pm_release(struct mptcp_sock *msk);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

