Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897195223
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920360; cv=none; b=fk4YyUnFEiaDQwel0k5HLJGWDhKSzmKL6h2W4EESs+IqDys/czTQ/HY3acgD9dsayebgrCihdJN32oiMzGQZFRlNTjJQVZWX0MHg/JGASPeBnCyw3hW4/CpIRRH93JETf7ZkLh4LzVBEyckTqW0fQNPmrXlM4iu5nOCFiHwlF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920360; c=relaxed/simple;
	bh=uqYM/HF/uxFQ+yf3qc7k3oTxKmA8Y++BMczq9BRoGGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLdmgg5FFRKmVnNIpRhyK2EljyIpApz1tg2QV8NC5HLIjRqF8O5gBrtSAZXuKBhB0SBtm1DvCwDxc3nia2UthMz9QjL5lzYiDKBRlVQKJ8p93JRph248zk0W1DXH7j4KHAFobFbWRXgBtMgYj3InPOGHsTuEv8Z/eq1wksndmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlijyGF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlijyGF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBDEC4CEEE;
	Fri, 14 Mar 2025 02:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920360;
	bh=uqYM/HF/uxFQ+yf3qc7k3oTxKmA8Y++BMczq9BRoGGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlijyGF9XfH/nWn0GzvhghP12PFQqexK7Gxv4SjgHfCwFQCGXrCHi36o4ZACSLI+a
	 PxcPAOsQemxXfcPTk4LKAQfe/NVkDgtxoEZi5MZ2C37lDPyaP60EDlIRqOkcveYz1+
	 B3LNa3qBjmSG582bjm7SyGBAlmqjLV93K0losqtjOj/BU5FuwylikYV92HXN0VzVvj
	 NQCPIKSz03qh1cQ8yH+rE6WigjWXiPRBpRkO0Hp7dJCoiKe0by4+iESWvj7mQYLM+Z
	 N7hjNtnAmfsoj4NA5xXqvdX6JNVq/aoxT4qzPXuXggognz20IAISzWWEtNsbqZUKQz
	 YXlHJKVxWBBXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/10] mptcp: pm: add add_addr_echo() interface
Date: Fri, 14 Mar 2025 10:45:29 +0800
Message-ID: <bf8a9d1c55bd294d4bd26d9815191f7ac822cdf1.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
operations from in-kernel PM in mptcp_pm_add_addr_received(). It seems
reasonable to add a mandatory .add_addr_echo interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  2 ++
 net/mptcp/pm.c           | 18 +++++-------------
 net/mptcp/pm_kernel.c    |  9 +++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     |  2 ++
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 37a84b4c661e..90fda6d1468c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -131,6 +131,8 @@ struct mptcp_pm_ops {
 	/* required */
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
+	bool (*add_addr_echo)(struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *addr);
 
 	/* optional */
 	int (*add_addr_received)(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 522dd2df4097..d5cb7c60d177 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -104,8 +104,8 @@ void mptcp_remote_address(const struct sock_common *skc,
 #endif
 }
 
-static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
-					 const struct mptcp_addr_info *remote)
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote)
 {
 	struct mptcp_addr_info mpc_remote;
 
@@ -579,16 +579,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			mptcp_pm_announce_addr(msk, addr, true);
-			mptcp_pm_add_addr_send_ack(msk);
-		} else {
-			ret = -EINVAL;
-		}
-	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+	if (pm->ops->add_addr_echo(msk, addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else {
@@ -1037,7 +1028,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
+	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow ||
+	    !pm_ops->add_addr_echo) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 6a5d6d374b0d..74838e2c66ba 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1422,6 +1422,14 @@ static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.accept_subflow);
 }
 
+static bool mptcp_pm_kernel_add_addr_echo(struct mptcp_sock *msk,
+					  const struct mptcp_addr_info *addr)
+{
+	/* id0 should not have a different address */
+	return (addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
+	       (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr));
+}
+
 static int mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk,
 					     const struct mptcp_addr_info *addr)
 {
@@ -1460,6 +1468,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4cd9a84477c8..6016d5669b9b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -701,6 +701,12 @@ static bool mptcp_pm_userspace_accept_new_subflow(const struct mptcp_sock *msk)
 	return mptcp_userspace_pm_active(msk);
 }
 
+static bool mptcp_pm_userspace_add_addr_echo(struct mptcp_sock *msk,
+					     const struct mptcp_addr_info *addr)
+{
+	return mptcp_userspace_pm_active(msk);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -711,6 +717,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_priority		= mptcp_pm_userspace_get_priority,
 	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
 	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
+	.add_addr_echo		= mptcp_pm_userspace_add_addr_echo,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d65fe3748427..8663350fac2f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,6 +1013,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote);
 bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
-- 
2.45.2

