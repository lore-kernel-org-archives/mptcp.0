Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AE21B9E1
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521735; cv=none; b=s/dYr3r7o1p2Zw5ySwVXytHFvH4FRNaG8gnfK/aO68cvQ9ETNvZ3yr/vgyNu23N00Ohe9KcvfQhcA/pa7rx+soS4AIphzDeVMK47kN9n88w0D+8nLGZYnPpbh0zzQQogitrX3QNtMoGCeES4QyvuNMVN0ZNxKogsqBEfjzzXALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521735; c=relaxed/simple;
	bh=aohSAAx++SR7aJC5DnKRcFR7m6KlhJnbrv8dtMgVw5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH+da3ZxzqHKCHdZioQOGX1sqTvgCJ5KSC+cTQnSLiwviRsHnEAPGz+3zyCeJ1hx3mxW57bBRgqZHANZay31TzOXLTJO0ztZJye5cN80lyvzPZ/lLFiVxtyuuTu53q6b51I/bLQGiF91ALiI4Vil7N/GLfhM5pvFweSXuEKjvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeVJ9BT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeVJ9BT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F05C4CEED;
	Tue,  6 May 2025 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521735;
	bh=aohSAAx++SR7aJC5DnKRcFR7m6KlhJnbrv8dtMgVw5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeVJ9BT7EgmHGa6I7KGXDlXSIjXSlvDGT3j8FznE9dunbtGJKCNcE8AsgJbhXM+ez
	 1yNpnLco2EFV0ezgL2t/R20VgNw//Mf8vZaFPQ2sbpYWehIregB0rzvXIinje4J528
	 Ae93FBWRZK4cMZVlYW41zY/UeGcy8GovGS0GRQgeGq9NvrhW4ZWeA7vt03ygEFHyj1
	 KwB4ctpl7mS8Zmg+soq+VGm2zVkt/3dBTw4/Caukordx06OD/JhdPkgC4xh1rXqiGt
	 jQspT3YzrTv6A2LgV8qtDKUhNxeucWlUACs3Xx5rAvMFD1hcyNX471PgnnThkbPxUo
	 01MZ2lo1rQu+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 2/5] mptcp: pm: add accept_new_subflow() interface
Date: Tue,  6 May 2025 16:55:23 +0800
Message-ID: <aaef0afef89c8689383865dff1313aa0fb913929.1746521233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746521233.git.tanggeliang@kylinos.cn>
References: <cover.1746521233.git.tanggeliang@kylinos.cn>
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

To reduce the dependency on mptcp_pm_is_userspace() to identify userspace
PM from in-kernel PM by using mptcp_pm_accept_new_subflow() helper in
mptcp_pm_allow_new_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  1 +
 net/mptcp/pm.c           | 38 +++++++++++++-------------------------
 net/mptcp/pm_kernel.c    | 16 ++++++++++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     | 25 +++++++++++++++++++++++++
 net/mptcp/subflow.c      |  6 ++----
 6 files changed, 64 insertions(+), 29 deletions(-)

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
index 448ac6c42880..1abe3a3a86f2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -453,38 +453,25 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
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
-	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows++;
-			spin_unlock_bh(&pm->lock);
-			return true;
-		}
-		return false;
-	}
-
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
-		 subflows_max, READ_ONCE(pm->accept_subflow));
-
-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->accept_subflow))
+	if (!mptcp_pm_accept_new_subflow(msk, true))
 		return false;
 
-	spin_lock_bh(&pm->lock);
-	if (READ_ONCE(pm->accept_subflow)) {
-		ret = pm->subflows < subflows_max;
-		if (ret && ++pm->subflows == subflows_max)
-			WRITE_ONCE(pm->accept_subflow, false);
+	ret = mptcp_pm_accept_new_subflow(msk, false);
+	if (ret) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows++;
+		spin_unlock_bh(&pm->lock);
 	}
-	spin_unlock_bh(&pm->lock);
 
 	return ret;
 }
@@ -1057,7 +1044,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 61b457a6b7a8..a1c5dabb6e56 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1391,6 +1391,21 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
+					       bool allow)
+{
+	bool ret = false;
+
+	if (READ_ONCE(msk->pm.accept_subflow)) {
+		if (allow)
+			return true;
+
+		ret = mptcp_pm_accept_subflow(msk);
+	}
+
+	return ret;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1414,6 +1429,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1911fe1799fa..5e259cef8975 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -687,6 +687,12 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
@@ -695,6 +701,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
+	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b2ee751ce4c9..d006ef042a15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1009,6 +1009,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
+bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
@@ -1185,6 +1186,30 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static inline bool __mptcp_pm_accept_subflow(struct mptcp_sock *msk)
+{
+	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool ret;
+
+	ret = pm->subflows < subflows_max;
+	if (ret && pm->subflows + 1 == subflows_max)
+		WRITE_ONCE(pm->accept_subflow, false);
+
+	return ret;
+}
+
+static inline bool mptcp_pm_accept_subflow(struct mptcp_sock *msk)
+{
+	bool ret;
+
+	spin_lock_bh(&msk->pm.lock);
+	ret = __mptcp_pm_accept_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+
+	return ret;
+}
+
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15613d691bfe..c842684eb85a 100644
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

