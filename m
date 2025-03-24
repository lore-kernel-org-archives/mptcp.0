Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44121459F6
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804403; cv=none; b=o8jN5zU1GjzNC/9w/39c+Fz44PvmVOxliMI8b3/dUDirvV/div+488/obel22wPvnaKsS5nqkvk/R6+nHpaK3sHqCgfXE1YvC3Ia+6mBwQEXbKTgAUOQLZnlEKkBecR+KAX2ldouKv9XwuOroMJnbdiev8uZPVoj9b2c6LMxMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804403; c=relaxed/simple;
	bh=Vs5W0eCJ66/TbuvTa03eadua1h1TPprvSgcYWrrq3L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhaHX+dUOj6WMunzKH9cwDdaP4D7T+8Ly9HILfq0PrBngJHh1DL6oLZJfs6kAE/561G4qAjt5CtRMDGrMPCxepOR+GiYHF0zdkqVut3btRyirwHXBId04+oyjkF9atl+0IGgmVtrwE2g939P7qFg4rKNEtPNnDr4o9Hyv0RAZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW+LLuv8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW+LLuv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37693C4CEDD;
	Mon, 24 Mar 2025 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804403;
	bh=Vs5W0eCJ66/TbuvTa03eadua1h1TPprvSgcYWrrq3L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW+LLuv8I8AUs+coOUHt93yjXxOW/YNTf9L6VOWRYJE+dYQBo95VWzhR2v4yz6swZ
	 2dUD1cVWFv1uVnhZWT9yhUeBkdnodyb0UpLkTvEAxhhvKlsA1/ponheq3IUhJKanqE
	 mVKswUJK1iViKlnrd5bZ5gAJdoCoTyOAVD42IYO895YyY845Wt5rFTTdf2UO9hwlqp
	 DZUXjptZZgueYdTcHmHR/kOUULtGfRQ/qETf5bfL3WFkhPw2Xy6bLYMcYnuLXVWp/u
	 cz7lumGrS06V5r0CBEKZ6kdA88ljszrhwjls4P5160qkhBZPbch+IjgZePbXuc0nRC
	 LNBjvGeKlfSZg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/9] mptcp: pm: add add_addr_echo() interface
Date: Mon, 24 Mar 2025 16:19:41 +0800
Message-ID: <f5dacf8e5b6491509a6df16dc448e172b1963807.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h      |  4 ++++
 net/mptcp/pm.c           | 20 +++++++-------------
 net/mptcp/pm_kernel.c    |  9 +++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     |  2 ++
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3f06fbd2a908..18d3679a752c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -130,6 +130,10 @@ struct mptcp_pm_ops {
 	void (*add_addr_received)(struct mptcp_sock *msk);
 	void (*rm_addr_received)(struct mptcp_sock *msk, u8 id);
 
+	/* required */
+	bool (*add_addr_echo)(struct mptcp_sock *msk,
+			      const struct mptcp_addr_info *addr);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bf3c19defe98..d37f89bf0180 100644
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
 
@@ -595,16 +595,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 
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
 	} else if (pm->ops->add_addr_received) {
@@ -612,6 +603,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			pm->remote = *addr;
 		else
 			ret = -EINVAL;
+	} else {
+		ret = -EINVAL;
 	}
 
 	if (ret)
@@ -1063,7 +1056,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
-	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
+	    !pm_ops->add_addr_echo) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a71676bdf43..9d159196afe5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1396,6 +1396,14 @@ static void mptcp_pm_kernel_rm_addr_received(struct mptcp_sock *msk, u8 id)
 	mptcp_pm_nl_rm_addr(msk, id);
 }
 
+static bool mptcp_pm_kernel_add_addr_echo(struct mptcp_sock *msk,
+					  const struct mptcp_addr_info *addr)
+{
+	/* id0 should not have a different address */
+	return (addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
+	       (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr));
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1423,6 +1431,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
+	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..3f7778ab064b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,6 +683,12 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
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
@@ -691,6 +697,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
+	.add_addr_echo		= mptcp_pm_userspace_add_addr_echo,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7fa26c49fbed..a886e89a806c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1014,6 +1014,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
-- 
2.43.0

