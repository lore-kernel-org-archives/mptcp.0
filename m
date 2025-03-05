Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5A23027C
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172421; cv=none; b=KVUkbtnu642NlprHiXI6Ytz4XN4Lx5KVzqjJFD6aQeY3PI1kw/hYGPCYP52D6LG+ixFJheZgbktEY/U/YMgHkpnqAnO7PGOQl51G+9tbW2ztatLNRVW9/2BTnp5bGvPr1M7Sry1CPLheM/4n0j/e+jY+qdAW18vNZpRDyAAqGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172421; c=relaxed/simple;
	bh=dvgdTum6q7jsEZnsSwIb78JuDJXsd/2oo2C5O56lxH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrNjS5ECAJRTokleTv7nNxOohZWkzSsbvnqDaPLaVIMaIPFS+XWl5hfAYaYuE6L8bNlQ08GySypsNcjjpqqG11mZgv1vO4/jVJJ/Hk2vW/kUEVzFw7+fKCNEh27ta2AAmpPy/RwKOdrGp/H3V6+EAiBu3yFRKTeQP6D0b9JfWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek+vFU1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek+vFU1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F32C4CEE9;
	Wed,  5 Mar 2025 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172420;
	bh=dvgdTum6q7jsEZnsSwIb78JuDJXsd/2oo2C5O56lxH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ek+vFU1yFkhaHW9vUZK8Evidc97Ng12+ZK+F0p2Jr13UoLeTQCoTte9IZwjJyjI+2
	 K8lRaL93DFdQdvKh8FWmskfScqkXtMZ9Mp4M+0iPibsB4jotQHlBSniD3FVy3oe2yS
	 mxUHkOErgsztwoybxCcf1aXOp+VCfUou89mZ4BOj1rsOgEPIwijadORV3AzjuHGLhe
	 OtfeWHxwcR/wdCd00Gk355x/iXnmXYw2opT0VxnX8dFsY2Dyx3zml3x0KqR60/hEWZ
	 wlMe7Vh4OZCVXc4cJdNb6lXlgXjeebG4uFtRLLOqN9Wj7m1eSUur7LLpZHyt/fPx6i
	 fgl3Edm3hWMrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 10/12] mptcp: pm: add get_priority() interface
Date: Wed,  5 Mar 2025 18:59:51 +0800
Message-ID: <13286c165869d4e567caf9ca74db69aca14f0125.1741171898.git.tanggeliang@kylinos.cn>
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

This patch adds get_priority() interface for struct mptcp_sched_ops,
then mptcp_pm_is_backup() can directly invoke get_priority() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace()
to check which is_backup() helper to invoke.

Rename
	mptcp_pm_nl_is_backup()/mptcp_userspace_pm_is_backup()
to
	mptcp_pm_kernel_get_priority()/mptcp_pm_userspace_get_priority()

and make them static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      | 2 ++
 net/mptcp/pm.c           | 7 ++-----
 net/mptcp/pm_kernel.c    | 4 +++-
 net/mptcp/pm_userspace.c | 5 +++--
 net/mptcp/protocol.h     | 2 --
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6090a9853f45..83977fe3dd30 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -129,6 +129,8 @@ struct mptcp_sched_ops {
 struct mptcp_pm_ops {
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 20eee0dcb369..d1f2b3bf9af8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -881,10 +881,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
-
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return msk->pm.ops->get_priority(msk, &skc_local);
 }
 
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
@@ -1058,7 +1055,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm)
 {
-	if (!pm->init || !pm->get_local_id) {
+	if (!pm->init || !pm->get_local_id || !pm->get_priority) {
 		pr_err("%s does not implement required ops\n", pm->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5f04dad4efc8..f81926f7b821 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -722,7 +722,8 @@ static int mptcp_pm_kernel_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_kernel_get_priority(struct mptcp_sock *msk,
+					 struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1418,6 +1419,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
+	.get_priority		= mptcp_pm_kernel_get_priority,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1753210941a4..2274f02dd8f4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,8 +145,8 @@ static int mptcp_pm_userspace_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_pm_userspace_get_priority(struct mptcp_sock *msk,
+					    struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
@@ -699,6 +699,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
+	.get_priority		= mptcp_pm_userspace_get_priority,
 	.init			= mptcp_pm_userspace_init,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 85c5a5bd3657..776a4bc3e5af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1138,8 +1138,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

