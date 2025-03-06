Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B389204F60
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258922; cv=none; b=JbCBXn9DGlXF7WNhyxquim9Zp1b++vwQ7sNGB/TNmUtc6HHyTlJT5/+tW3avMaFHKyAQ/l480R2lbNky2N5PWqJF4TBdjjMwHiInNPZPWdpxiX5tZHrVVxHWctM2lBEnKx/zBqe1mGjnZN/axBuwXdG8Q1iPERhZfFv/rKTOAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258922; c=relaxed/simple;
	bh=hMgZt8POX1f28Bm6MsdYaB6PFVPalRi0PBpws+J8yCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lcx2e1ccTo4rKCyE4qCCiN2QLMkFe0qBC0yFJVUy4hckNDHqgb1nnXWKYjfprjy/FEa/3orTTtVwR1WmBX0PRHsiVdfiXSXoCXCmHVsoGpO+/oVSKS0Qlud7pXLFHDhAcwtth5iuzs6MTzyZ//e9lLiNh8mttPjpdx76JQm3X5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3axl4Le; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3axl4Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF4C4CEE2;
	Thu,  6 Mar 2025 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258921;
	bh=hMgZt8POX1f28Bm6MsdYaB6PFVPalRi0PBpws+J8yCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3axl4Le2wNcPaQik9VcEtnYPQcC+bR1uN/iC61ElRsvB6XIpXt8DR7EVhgR9Bhwi
	 x0QAcZHIZtDnZOSrXp8cq7sWfF6QMqNRYDmHme8ZRqt3iQVOvXa52To3P+5ZtqGedL
	 iow6Rr15ZY0BUlDxTMNpTw2HTVgyulL7CWH4s3mbFMbPR5MtYFeFurHtxZluf8Nwi2
	 8m5AzIDZUJx3+EIBpK3rPPkx5c3WUnveFlPtmc33eXm9RxKXOA1QBgqXRwsRAt4djN
	 kj0m5ZwpOrE9VN2Hir9YmE8oRv7I8hei4QwKkk9eVYudEluYGZtK5t3riU+6X7ZxoA
	 wy/4USoVRfUjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 05/12] mptcp: pm: init and release mptcp_pm_ops
Date: Thu,  6 Mar 2025 19:01:40 +0800
Message-ID: <e1a69a1ee9ca25f12a244e5470341c23364de424.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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

mptcp_pm_kernel_init() is defined as init() interface of the in-kernel PM,
which sets work_pending, accept_addr and accept_subflow.

mptcp_pm_userspace_is_release() is defined as release() interface of the
userspace PM, which is a wrapper of userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 55 ++++++++++++++++++++++++++--------------
 net/mptcp/pm_kernel.c    | 19 ++++++++++++++
 net/mptcp/pm_userspace.c |  6 +++++
 net/mptcp/protocol.h     |  1 +
 4 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1400bfed4b0d..1a2f1715871c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -970,37 +970,54 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static void mptcp_pm_ops_init(struct mptcp_sock *msk,
+			      struct mptcp_pm_ops *pm_ops)
+{
+	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
+		pr_warn_once("pm %s fails, fallback to default pm",
+			     pm_ops->name);
+		pm_ops = &mptcp_pm_kernel;
+	}
+
+	msk->pm.ops = pm_ops;
+	if (msk->pm.ops->init)
+		msk->pm.ops->init(msk);
+
+	pr_debug("pm %s initialized\n", pm_ops->name);
+}
+
+static void mptcp_pm_ops_release(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_ops *pm_ops = msk->pm.ops;
+
+	msk->pm.ops = NULL;
+	if (pm_ops->release)
+		pm_ops->release(msk);
+
+	bpf_module_put(pm_ops, pm_ops->owner);
+
+	pr_debug("pm %s released\n", pm_ops->name);
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
-	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
+	const struct net *net = sock_net((struct sock *)msk);
+	const char *pm_name = mptcp_get_path_manager(net);
+	u8 pm_type = mptcp_get_pm_type(net);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	memset(&pm->reset, 0, sizeof(pm->reset));
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
-	}
+	rcu_read_lock();
+	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
+	rcu_read_unlock();
 
 	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d39e7c178460..03c4584cca7a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,7 +1398,26 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
+{
+	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	/* pm->work_pending must be only be set to 'true' when
+	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
+	 */
+	WRITE_ONCE(pm->work_pending,
+		   (!!mptcp_pm_get_local_addr_max(msk) &&
+		    subflows_allowed) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->accept_addr,
+		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+		   subflows_allowed);
+	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+}
+
 struct mptcp_pm_ops mptcp_pm_kernel = {
+	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
 };
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cb62f026b1f..6afab631580f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,7 +683,13 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
+{
+	mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
 static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
 };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 47710db243f4..fa9bb385feb9 100644
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

