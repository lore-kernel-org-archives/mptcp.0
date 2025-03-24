Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311C1459F6
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804404; cv=none; b=SKe1wxuMEFiH4nyuMbYV7lDondWNcU2Xv/ZruB88cje03jMvDI5XWryjKptJy5UzFw64u+G1LwufjH3OGQEz+eNgXyspwihbJI3ufHF2zyx8mFYbKeFVUuGRB2chn+zjXuOZ38wrgc1/66x2qPLmN45tWcs9tbzPDDTReQPqChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804404; c=relaxed/simple;
	bh=CRoX+qm2vj4ArF/cz4+27Me7C0xt0bOrrm/utoSzNPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaOiZStKWfHx2TqQdHvkDeKzfBx+K3AbCNTohGwFcuv9g/nTH/J2rorQ9Rij2hYnMBWg/cD/8/6OgwJFS4jubrVACWvadVelyQ/KooQQ2wUoVmben+0Y0LWul2CIqF6TB1K4/Fz9Su2dB5bANe68+cGl5FlGAxFwKnCc8LlkT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOHDG+xH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOHDG+xH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E02C4CEE4;
	Mon, 24 Mar 2025 08:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804404;
	bh=CRoX+qm2vj4ArF/cz4+27Me7C0xt0bOrrm/utoSzNPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOHDG+xHLcIH/f459MP3eN/Zrikukib4ic8vvXO0Aw2NyxQshXT0HVHd8xdKA4dQa
	 xijzxmAdQhirW9qchb9696QB/29X0pf7BIpl4xHpmWSHHX++m/AeLfa3Ncqimi5t/t
	 8OKwngI4BTeDhhyYc+TA+1Y3gEvcHJm3Dbi+FcBOd7Vxdwa6WLllyRpriXHUuichHN
	 20wD8FcaA/YxjSOATF0oC3/cpscJ2HWNDPfWxbGYfRVd2puHA3SiMgvx4W/71VFA7E
	 fzYWYTns0gguMaeMSM0VOZk999t/C5Y7N/QoGomsd1pcd+ffXGWmbggwKr7oS29Zpy
	 gSHIc55zfe+Mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 8/9] mptcp: pm: add accept_new_subflow() interface
Date: Mon, 24 Mar 2025 16:19:42 +0800
Message-ID: <44138a92dbf1965a898c209d70ec32c34f784f9b.1742804266.git.tanggeliang@kylinos.cn>
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
operations from in-kernel PM in mptcp_can_accept_new_subflow(). It seems
reasonable to add a mandatory .accept_new_subflow interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  1 +
 net/mptcp/pm.c           | 31 +++++++++++--------------------
 net/mptcp/pm_kernel.c    |  6 ++++++
 net/mptcp/pm_userspace.c |  6 ++++++
 net/mptcp/subflow.c      |  4 +---
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 18d3679a752c..8c1ac7368693 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -133,6 +133,7 @@ struct mptcp_pm_ops {
 	/* required */
 	bool (*add_addr_echo)(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
+	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d37f89bf0180..ca105bbd03ea 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -454,33 +454,24 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 	unsigned int subflows_max;
-	int ret = 0;
+	bool ret = true;
 
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows++;
-			spin_unlock_bh(&pm->lock);
-			return true;
-		}
+	if (!pm->ops->accept_new_subflow(msk))
 		return false;
-	}
-
-	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
-		 subflows_max, READ_ONCE(pm->accept_subflow));
+	spin_lock_bh(&pm->lock);
+	if (!mptcp_pm_is_userspace(msk) && READ_ONCE(pm->accept_subflow)) {
+		subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->accept_subflow))
-		return false;
+		pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
+			 subflows_max, READ_ONCE(pm->accept_subflow));
 
-	spin_lock_bh(&pm->lock);
-	if (READ_ONCE(pm->accept_subflow)) {
 		ret = pm->subflows < subflows_max;
-		if (ret && ++pm->subflows == subflows_max)
+		if (ret && pm->subflows == subflows_max - 1)
 			WRITE_ONCE(pm->accept_subflow, false);
 	}
+	if (ret)
+		pm->subflows++;
 	spin_unlock_bh(&pm->lock);
 
 	return ret;
@@ -1057,7 +1048,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->add_addr_echo) {
+	    !pm_ops->add_addr_echo || !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 9d159196afe5..7ec8fafeda0e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1404,6 +1404,11 @@ static bool mptcp_pm_kernel_add_addr_echo(struct mptcp_sock *msk,
 	       (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr));
 }
 
+static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.accept_subflow);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1432,6 +1437,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
 	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
+	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f7778ab064b..d6301d809376 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -689,6 +689,11 @@ static bool mptcp_pm_userspace_add_addr_echo(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_active(msk);
 }
 
+static bool mptcp_pm_userspace_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return mptcp_userspace_pm_active(msk);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -698,6 +703,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
 	.add_addr_echo		= mptcp_pm_userspace_add_addr_echo,
+	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
 	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d..be79940da424 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -61,9 +61,7 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-		((mptcp_pm_is_userspace(msk) &&
-		  mptcp_userspace_pm_active(msk)) ||
-		 READ_ONCE(msk->pm.accept_subflow));
+		msk->pm.ops->accept_new_subflow(msk);
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.43.0

