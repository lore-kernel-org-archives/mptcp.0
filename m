Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0534EC5
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685563; cv=none; b=pS0pqNA1ksZadBhl1XenqIDzTNdg3JxfMVhVJJMCliZAVLdmAYzCd/Ez+9zEsLcQA1zLPImP95RVveEQLv2auFc1/gmSOE8B2HNdgoy4HCBWQy8fyLRKheJ0pPLZrpSSRMM/Z75yx0PDVn7Fy7OCfjFeZkEh8E0zDTM9FwD70e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685563; c=relaxed/simple;
	bh=qD6HVfTwDFTHVKMekkXWVaBB37R6NfQTAhz1Y374fak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KltuuojXR9D1W7IaviX3Ewc2PHte+vWx3akyfYg5U7iStt5BO+qpG2QS5NnctJm+vFu7rHGUxrJDLguap+H1j/bOs1ez4+S6UPI/7Cf0wrUa8dOP/9W98CdNLnjAXHrSOk0+x+O2tCKJu882Q5EoU0rCr8s5KmWs9/VfboK1U6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv/rI9rH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv/rI9rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39079C4CEE9;
	Tue, 11 Mar 2025 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685562;
	bh=qD6HVfTwDFTHVKMekkXWVaBB37R6NfQTAhz1Y374fak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gv/rI9rHTUuMiFAVAu1c8x/+Oi/ruIMBv7WTeOkLirShNJcXvatYKc4qYCt84/OzW
	 fTnG401P0QN8rRALU3+yuYFxWxgQARQAyLoeN9J6mgzVUScxzPi9CE3itU4A7cqv35
	 SyisXqjzq1yU85YbNTVrBzZXHBCbaqjszwFb3f21qQIEhlZK3rpVP4uiEh2YqPyNy3
	 pXcQ8K+v7F3HFzlgg27jCRQrdZanPE/quiPy+Up/MZXCUzQsofPvmgPoHlLV28GXIs
	 nb8PGXH1V3fh8fsGC6X8aZX/eWbqMzUHm6wXhVoVDAClneKAvMyhWszrK2IymOssQS
	 DI3Had/t4qtJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/6] mptcp: pm: add accept_new_subflow() interface
Date: Tue, 11 Mar 2025 17:32:26 +0800
Message-ID: <72854cb564464ced16eb19ab4bbe6e0cde4ec4ea.1741685260.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741685260.git.tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
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
index af995387248b..6f9bc0ca4d37 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -124,6 +124,7 @@ struct mptcp_pm_ops {
 			     struct mptcp_addr_info *skc);
 
 	bool (*allow_new_subflow)(struct mptcp_sock *msk);
+	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 80293c823a3a..31a2c66a1af3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1017,7 +1017,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
 {
 	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
-	    !pm_ops->allow_new_subflow) {
+	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
 		pr_err("%s does not implement required ops\n", pm_ops->name);
 		return -EINVAL;
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index af69f736c7c7..708a96951cba 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1425,6 +1425,11 @@ static bool mptcp_pm_kernel_allow_new_subflow(struct mptcp_sock *msk)
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
@@ -1449,6 +1454,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.get_local_id		= mptcp_pm_kernel_get_local_id,
 	.get_priority		= mptcp_pm_kernel_get_priority,
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
2.43.0

