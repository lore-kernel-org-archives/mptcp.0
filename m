Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150618EA2
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320834; cv=none; b=Wk0419mKP5QUflnW76o0w8KPhUlEyXM+lbqxT1e1VF3NLh50S6SAJLM57IOfCDibe8wavbzEU2i2jSIi50m0OmVievxi31WGCVOp9TAsp9USCLqW/B8xK9fPkL4WJnap7emJGeBb5kXNhoPPK6H5Qn71GpH+nZ/giS0uPWdXpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320834; c=relaxed/simple;
	bh=mC7H3aG+h1s33nerifzrjdGPji+Z890hZ+BO7dhM1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X081UCNJBGxDfCOAeM3/UWo6UAjLKAjtPkmc3JTr8kB8xF9LKxoJnmp0fC38m1xt4dYIYEcNqNSXUw73RxKEGbfAFj78fy1knKOZQ4fVrnI4qRLN6x4Uz25hmCbNRoALV221RF8s6o+CXYSHLvK3YFbDNy5HO/qXaSxwafiBH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWd98Kba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWd98Kba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDD1C4CEDD;
	Sun, 23 Feb 2025 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320833;
	bh=mC7H3aG+h1s33nerifzrjdGPji+Z890hZ+BO7dhM1HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWd98Kba5M/wo+xfK1iuutcXck4Yl6ZG5TCg0kt5hUpQpqHfcU9cqmVichgNnmPER
	 CpwRD2gAV2dlaCleUyV0dSxjlET0z5zO6FmPivWJCqvAGH8slTR8Q3FIs2is5FRIEa
	 UTSpA7u2phiDffrwME85/wC3JeUAyKuWbIdamTGAMIoGJTHBO1DjgB/+B0rFMyKvoO
	 tLYJlTJ0VGdUwqTco8J67WQSRtGT0O3VqxdrrA7ZIChQ2BtmIlD4JkhDr7kP6uNZ/3
	 opPkbsqS16B7K5eECh5tk3bBnkgtnJ+Qcm3MKpWinA40FzFi1VRZf9dFcDxSb29JI5
	 3c8BjqL0hViQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/13] mptcp: pm: initialize and release mptcp_pm_ops
Date: Sun, 23 Feb 2025 22:26:12 +0800
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
Message-ID: <20250223142612.4i2qaF696tB4x5X9R38lBGbeftOzWgy4hUy1CPJJc4s@z>

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

