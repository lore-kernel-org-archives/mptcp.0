Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8F1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088463; cv=none; b=QkF3ImMy6/AYf3Kr5Xg9Neugra61wCw4+2uHcTajf9kjOBxemRsQxTBWpeC1/p72G7XjZ07hmgT19z+bf6/AWwQ7mTGDrQqD8UFuf0I6F1nnQDko/GNX7GzC85Qc9rwxV/VX2mesomFTJiKdGVevt7465oAH6Jv7bzVArq2MNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088463; c=relaxed/simple;
	bh=EyKbL7SnzXKnLyYnEuduV54mDm8OzZ9tfSUO3WocoMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlo6xyEAuf7XbkNF9yUqc7YEWl53zvKnplvnNoGuu65wDAEs1Fo5V0xXJy91KT8l/EnMP6R5eKwvm8uuDh9+9qlzoerI91qscJ1GILXDlQdJYFHx03a/MhwPA0MSBx+p78vsjF06wrTACMNOboSW3SbzK4z6wnRJ75pHSdVaQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPJfMaDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPJfMaDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57128C4CEE5;
	Tue,  4 Mar 2025 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088463;
	bh=EyKbL7SnzXKnLyYnEuduV54mDm8OzZ9tfSUO3WocoMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPJfMaDW1NT2+fxTpMpOwCn3DYPydw3UVQ9iSWggCSPbqgisM6+ahtkT3hNATP/W1
	 uoVGrK91mqm6Bi5iMJXZpWAZeCSK5P7+e1p6twZC1oZ4huarSezGXv//b84EEfrFXz
	 vysoJTxOOftDb1yeB0ZiEW+trEzFiMexATC4oJR1vQJN8LUtI7CQe32eUwX4R94StE
	 MW6L9t9zhktN4JMFhvNeKfByJ6+0DyP3fFmndJJjZvek6FE5bZp4gv+r8h5RMwmGJ2
	 cjyZIiBkbEL+W48IYeYwutCbpgqVDQybgj7Giyeuws8jC6cSIs1b3n4daS4VzjEvSa
	 1mLZE35Y5FURQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 10/12] mptcp: pm: add get_priority() interface
Date: Tue,  4 Mar 2025 19:40:37 +0800
Message-ID: <c260ed4002ed62a90b7cbdee7efe11a9888e4da2.1741088339.git.tanggeliang@kylinos.cn>
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

Now mptcp_pm_is_backup() can directly invoke get_priority() interface
through "ops" of "msk->pm". Instead of using mptcp_pm_is_userspace()
to check which is_backup() helper to invoke.

Then mptcp_pm_nl_is_backup() and mptcp_userspace_pm_is_backup() helpers
can be static.

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
index 1e92bd470fdc..51866bf16d02 100644
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
index f134acc39101..8d661084daf3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -722,7 +722,8 @@ static int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1418,6 +1419,7 @@ static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_nl_get_local_id,
+	.get_priority		= mptcp_pm_nl_is_backup,
 	.init			= mptcp_pm_nl_initialize,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c41ae9cb41df..e219a2d37429 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,8 +145,8 @@ static int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+					 struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
@@ -699,6 +699,7 @@ static void mptcp_userspace_pm_release(struct mptcp_sock *msk)
 
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_userspace_pm_get_local_id,
+	.get_priority		= mptcp_userspace_pm_is_backup,
 	.init			= mptcp_userspace_pm_init,
 	.release		= mptcp_userspace_pm_release,
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

