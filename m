Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B182C60
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920356; cv=none; b=bAExpS2XVTJUtwEqlMinAzZGqIPNauMSnUVXvx/w7NSenoa0YyJGOwQdkXfYYlmKirz2CyzZXojFRXwL6ICmEp6RkfGB29MHOgd0ao8QdDdQBx2PbtqFgA/+zp01fsh4DbCq6yYYvOwTnF+FN0I/qYRZLfZbFDIoSuaADdAnor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920356; c=relaxed/simple;
	bh=n55XM3TVAxG2MrcD3UvQHSj7BM32SHOwLVwPts6bc10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBEtDBOuDOCjIggw6TTHTthI/iLaxyYnYUZ593oBUs7QWy9zrEwHHbECXgf34kxas/YUFo5wkE8pllgTdAITirW5kTF+V9/25zfy7CSmKfhW3wcKDY6NC3lTtdlpZiUn2Pp1GDJtIqXVzJ4Tq1hJ4XZ7v7kNwDaExKRvLOKcfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCDNmHZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCDNmHZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9DC4CEEA;
	Fri, 14 Mar 2025 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920356;
	bh=n55XM3TVAxG2MrcD3UvQHSj7BM32SHOwLVwPts6bc10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCDNmHZwa4zwnNMbz15she8ly9WVwWnSRJML82xsK5qmgj2erY/pUQglncGa/PMLv
	 AsD08xe/2osB+8AgiUEg64Nv6+JgG/lNpTTT+kBLsDpY8NkGPJ8lnaFHowWsxlxE/0
	 jqqt34J5tzanBuw4MS7fa40TvFhQOcaUKBYZl/MmfuvWoJk6xmc875r9eBSB0rk1om
	 bDJUw7N9BOps9OoaYM35cByoK85OHHYf+CxCw4SLIsP13b2iCYctVyE7DgcG0ZoSSE
	 pa2YNKrmGsB1/jFficbfYgymkG9QwsEamttI4gsbPo+CtCcNU9APIBcNM62Zj5HbGQ
	 gZRsqrLazaCHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/10] mptcp: pm: add accept_new_subflow() interface
Date: Fri, 14 Mar 2025 10:45:27 +0800
Message-ID: <b66fe9a7e9bdc7df2482de7ab176ed65a54f6fe7.1741919893.git.tanggeliang@kylinos.cn>
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
index 03152a1a157e..7ae706669c80 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1033,7 +1033,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->allow_new_subflow) {
+	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index eb498b17e67f..38542d62767d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1417,6 +1417,11 @@ static bool mptcp_pm_kernel_allow_new_subflow(struct mptcp_sock *msk)
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
@@ -1443,6 +1448,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
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
index efe8d86496db..defef7aa5b28 100644
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
2.45.2

