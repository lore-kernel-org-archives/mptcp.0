Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9F13C3C2
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674746; cv=none; b=DwGCjAz3LG+OohO6sqYumoky2yzx9GiTWCgls2KYoyIiHjjrziYehayeIhUFPsIm3aVSUlwVlXCc9m3J+ICjJU8YgV3NvLXYw5IdA3zkZC21cYCgfNNKD9DZuolC8uwd5YCg1FkGNF8bDeEQVdSFQ4rwnv9+iVdGqiF1O03qatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674746; c=relaxed/simple;
	bh=AQFh4s/EcQE+bgtcyIcEhQ5u9U/Ae8UL0tkLZRS2I9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSUk3ZUMfDE6xQwCfUVioTyMfmXO7j6akmMalGURz3F7uNcTfXURujh6JSi0Z3q2tQU6L6Z10WCzaDjWASjLlKk0H7JvCeqvLZFhK04hj0ZGykO3URe7N37jORZL4fSv2/R4iFchpcxuiQy51xOaWB+hhK+aJh9tjiKgUjMHCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkWRfb+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkWRfb+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137C2C4CEED;
	Tue, 11 Mar 2025 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674746;
	bh=AQFh4s/EcQE+bgtcyIcEhQ5u9U/Ae8UL0tkLZRS2I9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkWRfb+5ogIqmSZRLJ/XBIqoofM8AzGCzuo8bTwAu/egmH6c321ctqGcRaElYyfQb
	 UK7OPQlI7BP0qD2YRlRITS1w2v/MCPz33p8hdCwEUwC9VKBfrKrr4iKcoJK2c1kXYJ
	 aATG7FccITerVsuDTb9YSMuwkJ646W6eF4A+3yOIm+SKGvvGLTuHvZkgJTjp6h5W96
	 uCKpqiaLxRTdCgxxgP5Gzdw5cCjF3LUSM9rsOHRdr9k/Hr6AegL/qvQTIQJT7aqsoT
	 x7n8aZSV6LQte32oFbDnKU69GktYtwy1lpjM4j5zdGp2bEOrvLBSknsntC2gXsb1T5
	 KzExXz1NgOoAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 06/10] mptcp: pm: add get_priority() interface
Date: Tue, 11 Mar 2025 14:31:58 +0800
Message-ID: <f0b66ba901e27a5418a0c5b3997827a8c2075144.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
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

Also rename mptcp_pm_nl_is_backup() to mptcp_pm_kernel_get_priority()
and mptcp_userspace_pm_is_backup() to mptcp_pm_userspace_get_priority(),
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
index 169e19440b03..b344b909e749 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -118,6 +118,8 @@ struct mptcp_sched_ops {
 struct mptcp_pm_ops {
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6eaf072a472a..e4d790ecfe27 100644
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
@@ -1050,7 +1047,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1380e529aa02..7ec81d5195d4 100644
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
@@ -1420,6 +1421,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
+	.get_priority		= mptcp_pm_kernel_get_priority,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 81ddc14bc273..7fc19b844384 100644
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
@@ -690,6 +690,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
+	.get_priority		= mptcp_pm_userspace_get_priority,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 282067717b39..d69c9e07e6e6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1140,8 +1140,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
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

