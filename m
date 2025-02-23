Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA926AF3
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320459; cv=none; b=qgfgT7VPP5IEPCVqt7s4FcAJrabMGVGAveYMV3FlMu/AVCfd8aiLj+uuppHINmR9X8pRX9ZP4P0Ob9cbGEITYaYIfLxBKwZlJgSSNe4mQh9BC5E3ow3XB36iyfZsnO+n+cwEQXsjgsHW2Omi93RTILykbMNWZLv0H5eaPwPXFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320459; c=relaxed/simple;
	bh=mC7H3aG+h1s33nerifzrjdGPji+Z890hZ+BO7dhM1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWvwpKnXSQo2ykS/jUFStNSl4w6I5IGrvnnxkfymGvMGQWkouaw0WNMBJ1sUqx/OJxO8b97e4DIRWRq8yIMZ/j5Y86eoSv8rtm1DuSPoOMF2PK2gPAUOwDQp8K+AlYdT/fN945HVeeUefB3+q5mcqSNok5+f3fFHmzQQbJhzqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucFwYvnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucFwYvnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1EC4CEDD;
	Sun, 23 Feb 2025 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320458;
	bh=mC7H3aG+h1s33nerifzrjdGPji+Z890hZ+BO7dhM1HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucFwYvnVApQdW+xghc3n8DRLx39X6Yry6XCpWmTKkVU90abmPgh7sdxvLBdi/wEJn
	 C9ueG1UPFL322LRwjnwIRHTBasCDm/zDmqGUMR1DLQS9FdYqjKLopwAhZJXoY5fAJK
	 5szieEYEyvrcvUkrr3f1SNBjhsjz7EWw9IJ7B9wloQrxIBAgecELSiTC6fM2lXFBWO
	 ioiVKmZ1Zxp/qTgqmR1sJYazVPkAMyM0tRZczsDMfMfWwMr+1aBmcKuJa2eRB5H7TY
	 FvnYopI9AUsrwi3mYX5c4HPE3BnDpMe8oSg6pNVgF5IjM3TQLCdTq2uNpLlSZb67AI
	 mh4YR95xndtUw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/13] mptcp: pm: initialize and release mptcp_pm_ops
Date: Sun, 23 Feb 2025 22:19:55 +0800
Message-ID: <41eb1ea07d50f942e1cdca81cfc4cd07688b689f.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
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
while mptcp_pm_release() is invoked in mptcp_destroy_common().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 38 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9e1a2e6d9c03..147d9289e477 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -603,8 +603,10 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
+	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -614,6 +616,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
 
@@ -706,3 +714,33 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
+{
+	if (!pm)
+		pm = &mptcp_in_kernel_pm;
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b48cf648346..b5cfe0a6e594 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3307,6 +3307,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
+	mptcp_pm_release(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 301a0f192305..1fea29f52c35 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1054,6 +1055,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_pm_release(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

