Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7535947
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521549; cv=none; b=luqdGGyJlN8yzfz9bRnfpmLdMWeE1wjbxHbYoYYBjCCOpBEhfhWAwbQhNrMqOFSjCRCC2wbD/Ld4qFkvn86q6YqodbjlJQ6IrOlEJRrkoPRYeSMMmkjwV5dbUnXLHiLgwAeQ/dSrpFJOY5q9WjkVj5EB3y6gTXeYceu0J9VdGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521549; c=relaxed/simple;
	bh=unHztUMG5SqQqvsiAB7ubVoFGJBLs0TYAUvUYPZFR3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8IJSDhcUYeTHmkcBrnZejp71yMKwkTY+u/rTJtZcgR4vD78e2AMjHY9AWzquFYuVcIaGAj5Mnyy0yC1MCjoZlebYtNn6P7kzGo9Y7qdQSFqbwJ4WrC/bo1EgPTdNoNFbrpu8HkxKLqLqsesPaUhI4kKQ5XfgXikbCG6Em4/xiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCV2ZpAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCV2ZpAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4E0C4CEDD;
	Fri, 21 Mar 2025 01:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521549;
	bh=unHztUMG5SqQqvsiAB7ubVoFGJBLs0TYAUvUYPZFR3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCV2ZpAV0wpFjvKMA0olMk0oBAh6erR2DtbaKTeNvt29FBk2g8I8HdWq3VqmowHWs
	 rakOmgVV/ENMwYlTPr2p7XUdH/jogmUuiNnPvocCXPm2MFhkA24pK11cma22VV7CuO
	 vt4+Ntm9PeB0vekizIqdhlV6/H+/DM1on6/tkMu1lDuYQOYDpUWXrktm/8H8PhWqjk
	 p0AcYpoTavh8MpyJk7aCuZBdCtQMco7svR3wlb+SWOYhR7VQQstNZKFNrd6tYMJqmg
	 dcS4s0snuJYafoxE2FbsPTFwZyQhsIz1CxpH7Ix64KHeWqZldef+ZDg/olp3yjYM4c
	 iRRB1GTYjTjKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/10] mptcp: pm: add accept_new_subflow() interface
Date: Fri, 21 Mar 2025 09:45:00 +0800
Message-ID: <977e479a4c82993eb89fd1b2db4142aa88e2dc33.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h      | 1 +
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_kernel.c    | 6 ++++++
 net/mptcp/pm_userspace.c | 6 ++++++
 net/mptcp/subflow.c      | 4 +---
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e15d6b5680f6..de9838ea37c4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -130,6 +130,7 @@ struct mptcp_pm_ops {
 
 	/* required */
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
+	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0696d58c61ac..d2e72e36d80e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1037,7 +1037,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->allow_new_subflow) {
+	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 520c1c029607..c89a8524e70e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1421,6 +1421,11 @@ static bool mptcp_pm_kernel_allow_new_subflow(struct mptcp_sock *msk)
 	return ret;
 }
 
+static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.accept_subflow);
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1447,6 +1452,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.established		= mptcp_pm_kernel_established,
 	.subflow_established	= mptcp_pm_kernel_subflow_established,
 	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
+	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3a9962ac77b2..4cd9a84477c8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -696,6 +696,11 @@ static bool mptcp_pm_userspace_allow_new_subflow(struct mptcp_sock *msk)
 	return false;
 }
 
+static bool mptcp_pm_userspace_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return mptcp_userspace_pm_active(msk);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
@@ -705,6 +710,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
 	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
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

