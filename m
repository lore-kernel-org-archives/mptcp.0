Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C9C8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055474; cv=none; b=WkDq+3d+VEjj4M2pNOnovcIk6o6Gz+0mi16FZo324sFpqCZUw1pLJM+/qi+X6WqxfGDByjbUlWJJ4fvF/vrw5Iet0m9pK1+Bv6mWgJPebODeIy+IUxsSVYb6Q6nPK6KP1pdf88ioR964/R7ZesVNQSPusJ4mwCkrlwwIGZF7Pkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055474; c=relaxed/simple;
	bh=1k/huxBnM1D/03P0mcln7JXj/UhUtsveeAbMIKCgPq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHHGTnFpGdgjatGK1MCgCZbpHHJJrP887g5LmDiieUvvdaDqA3cICRo3S+ME+DQqVgfAMw1kWcI/Ruc8hONzJ6IffezT82+hqt/hmMxUBLILyo+KxNi+B0NA+3bHBWM1j+YMwbzZKloitkhP039TrJpNLCFEYiga9+6O241Y0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6XdoBY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6XdoBY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07376C4CEEB;
	Thu, 27 Mar 2025 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055474;
	bh=1k/huxBnM1D/03P0mcln7JXj/UhUtsveeAbMIKCgPq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6XdoBY+xpld9HfqsGkw1Mdy704Pl3IekOo5NATwxH0CwQlDXgq3JPfGivFfIG6Vy
	 8uw1qPoxenUB5ZN/JKVZ6cxSUa6VNC95OUAOJKMgLRBqlSu81aJ21T7lPyapkgnzvS
	 BikZzT+WTVGCHBI+rf85sKo0Ku5QRZjTduJMAUoY9+K/DxEfE00l3UJb8Wv3deEpwM
	 NT2MqzE1Qka1hm09P6yelN6avgHA/eBA9U8KmPgnZM/G6WhoJ6+Y/9Kx8jC8oIxaps
	 0M1hCWh7DoMl3IICil5LyepSkp7kQuSNJEmXpC8EORtSmv4BGQ/59/woMrj8P24Mys
	 elIGkgB6T4t8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/7] mptcp: pm: add accept_new_subflow() interface
Date: Thu, 27 Mar 2025 14:04:12 +0800
Message-ID: <bb1346672d021bedf325489364b6c2eea16928b9.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
operations from in-kernel PM in mptcp_can_accept_new_subflow(). It seems
reasonable to add a mandatory .accept_new_subflow interface for struct
mptcp_pm_ops.

The boolean type 'allow' parameter is used to control whether to allow new
subflow unconditionally.

A new helper mptcp_pm_accept_new_subflow() is added in pm.c to ensure that
pm->ops is only used in pm.c.

This interface of the in-kernel PM is implemented as a wrapper of
READ_ONCE(pm->accept_subflow), and this interface of the userspace PM is
implemented as a wrapper of mptcp_userspace_pm_active().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  1 +
 net/mptcp/pm.c           |  8 +++++++-
 net/mptcp/pm_kernel.c    | 15 +++++++++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     |  1 +
 net/mptcp/subflow.c      |  6 ++----
 6 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..549b8075cc86 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,7 @@ struct mptcp_pm_ops {
 			    struct mptcp_pm_addr_entry *skc);
 	bool (*get_priority)(struct mptcp_sock *msk,
 			     struct mptcp_addr_info *skc);
+	bool (*accept_new_subflow)(struct mptcp_sock *msk, bool allow);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index be1e27ee393e..1c8395d3baa9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -453,6 +453,11 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
 }
 
+bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow)
+{
+	return msk->pm.ops->accept_new_subflow(msk, allow);
+}
+
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
@@ -1050,7 +1055,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d4..ee3915d33e04 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1399,6 +1399,20 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
+					       bool allow)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool ret = false;
+
+	if (READ_ONCE(pm->accept_subflow)) {
+		if (allow)
+			return true;
+	}
+
+	return ret;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1422,6 +1436,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..c6f67c5e2353 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,6 +683,12 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+static bool mptcp_pm_userspace_accept_new_subflow(struct mptcp_sock *msk,
+						  bool allow)
+{
+	return mptcp_userspace_pm_active(msk);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -691,6 +697,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
+	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 64aa091cb685..6d1d57beb5d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1008,6 +1008,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
+bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d..b13a679bdf05 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -58,12 +58,10 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 	mptcp_crypto_hmac_sha(key1, key2, msg, 8, hmac);
 }
 
-static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
+static bool mptcp_can_accept_new_subflow(struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-		((mptcp_pm_is_userspace(msk) &&
-		  mptcp_userspace_pm_active(msk)) ||
-		 READ_ONCE(msk->pm.accept_subflow));
+		mptcp_pm_accept_new_subflow(msk, true);
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.43.0

