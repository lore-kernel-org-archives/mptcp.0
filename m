Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377726AC3
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134505; cv=none; b=kLuJTBdyZmXKHgCmkBpJyAZwha8OMHqi2f0hHN8zc6BY1LwTLkEHTHNbWIyiaSmc60t7UQzyVBLw9zVQTfGk/w8Nl811uzXJPH5y8qZloeVEdK38nTJHrPQ10xFd7nHqysabU/ilZCqyjaNKhcv7j+I9HTAY7VVTV5nZW7GiQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134505; c=relaxed/simple;
	bh=RiBbyTjYRJEaIcJbhWn7VLTL4x5wpbkqXseWb7Fg16E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtF16MvPEyQ1gc4ZClVwBMhMlFEnKyFRQ2pm/kX1SsapQdCtmpHyKldc1W3q9g+AyQKImjzuE7EJ6vE0XScNNSjAzBt1bKOVq+h2NmkSVo1YuuhhO3DNmC5NWkclStvEyqy8Laofhi1jCJCbr1vhUEIUWxsXenKyJ7JMqir0cGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFhBN2lO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFhBN2lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC58C4CEE4;
	Fri, 28 Mar 2025 04:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134504;
	bh=RiBbyTjYRJEaIcJbhWn7VLTL4x5wpbkqXseWb7Fg16E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFhBN2lOmBhcq/7592wQcdt2HFiH6MWeyuyEi3EsNAJgSHea6bwiKFHQEZf+bbaAh
	 BHO+hNh82JSFXGcuQ6u8kQorZTNBcZ3Nqb5YXa1+Olh5rO+5m6pz00DuB5e/qB64qU
	 MZSb8vQRKATShMHbp0R0Xa2zLD33ogFxRXT6B3vE1caeFETw8qzMYHYzAESE8J/jeE
	 /gQsIFK0y/yH0Sta9peFYBnN6ShYdqqto5RWoWM9DZYh7lPhyHFmvD40/UCZGLmQ7n
	 SnMHX8IbMPJBEbDWgo/gce5aDvIhF7DC9aZc7M7pkwjyXWvqaeLMZJvFl1UN4E86j7
	 GUzdPsFOBxEnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/5] mptcp: pm: add accept_new_subflow() interface
Date: Fri, 28 Mar 2025 12:01:32 +0800
Message-ID: <2c5a2dc15229df637c5523fd63b2b5dd88619615.1743133948.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743133948.git.tanggeliang@kylinos.cn>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
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
index 4ed6a2ccb112..a96f3495d220 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -460,38 +460,25 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
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
@@ -1060,7 +1047,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8935df61aa50..eaf73c4cedd3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1399,6 +1399,21 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
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
@@ -1422,6 +1437,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
+	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d9b0a93e42f6..31da3b9f4cc8 100644
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
index 3d51898a2781..134b46b53014 100644
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
@@ -1184,6 +1185,30 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
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

