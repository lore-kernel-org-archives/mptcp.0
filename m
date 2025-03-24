Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EB25D1F4
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804406; cv=none; b=kAngXQACcNeU5e21KESUVmtdVCnLF6pOWL6Ewb46u9PJYprSiS4iBrRuQ7K19KEY6R8dOwg++6hXi6kWTbCqxKKkODHZFQlYMCtFeRndNYe2IyztkwEUtqoPvcTJ9pfEhDp36ZBvXWGJ/j29V0heRY9oSoojrTKl6yQ2dzTbB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804406; c=relaxed/simple;
	bh=ypWK0g/41W5KkprWUyENDwgY5QquaWvNznN8V8Z0lDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUQrReTCrxAIqgz5GT04HrzhPAtxLI8JaovcDnsEEE34KxU6TWHP3GMNDtWjHMM+dgavGpgObnb+JrORyjXDUOFoDCffnMYUqQovhsdC2ZrOgs84A4x6iE53exa06ERrPBNffuhlmKhFOZQkQG8CT85hodVOgjSZ4WPNv0eMSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfOwzWy0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfOwzWy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46932C4CEED;
	Mon, 24 Mar 2025 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804406;
	bh=ypWK0g/41W5KkprWUyENDwgY5QquaWvNznN8V8Z0lDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfOwzWy0s5/12AL98kDmNvmA2KUCykii1F7//Q+DT9nCVowFTmwIiSEhGs71YZQHd
	 4F92OnOm8DH5FIgJzhQCpYl/mwRuLZhEdQ4bJiu3UYGsn4rmd548lI4K4xWjksl1sD
	 sEyVexipxn6km+85FrEle9ZTGKN56Vsq7Yx8F/bzTWjVUbKZaJehUA1nu+qh3PcTtR
	 4l6EfQr557wgRHLueXUjxr8ZarItvFj6UM5CQMPdHYn+7zXp1hMuKhTGShOMGWEGgz
	 TyQ/f8TdS9+scujGmDHOQjW9ew5tkE8aviuD2/ojtEk8KyKkKE0Xp6RrYlWJezIfOT
	 ppvUwI9zbZkSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 9/9] mptcp: pm: add allow_new_subflow() interface
Date: Mon, 24 Mar 2025 16:19:43 +0800
Message-ID: <cd3f073e7d78588fa5ece014ff4f929946223aa8.1742804266.git.tanggeliang@kylinos.cn>
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
operations from in-kernel PM in mptcp_pm_allow_new_subflow(). It seems
reasonable to add a mandatory .allow_new_subflow interface for struct
mptcp_pm_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h   |  3 +++
 net/mptcp/pm.c        | 13 ++-----------
 net/mptcp/pm_kernel.c | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8c1ac7368693..aedabc7f4190 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -135,6 +135,9 @@ struct mptcp_pm_ops {
 			      const struct mptcp_addr_info *addr);
 	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
 
+	/* optional */
+	bool (*allow_new_subflow)(struct mptcp_sock *msk);
+
 	char			name[MPTCP_PM_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ca105bbd03ea..215b3a4d24be 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -453,23 +453,14 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
-	unsigned int subflows_max;
 	bool ret = true;
 
 	if (!pm->ops->accept_new_subflow(msk))
 		return false;
 
 	spin_lock_bh(&pm->lock);
-	if (!mptcp_pm_is_userspace(msk) && READ_ONCE(pm->accept_subflow)) {
-		subflows_max = mptcp_pm_get_subflows_max(msk);
-
-		pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
-			 subflows_max, READ_ONCE(pm->accept_subflow));
-
-		ret = pm->subflows < subflows_max;
-		if (ret && pm->subflows == subflows_max - 1)
-			WRITE_ONCE(pm->accept_subflow, false);
-	}
+	if (pm->ops->allow_new_subflow)
+		ret = pm->ops->allow_new_subflow(msk);
 	if (ret)
 		pm->subflows++;
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec8fafeda0e..5ae64392a316 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1409,6 +1409,26 @@ static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.accept_subflow);
 }
 
+static bool mptcp_pm_kernel_allow_new_subflow(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	unsigned int subflows_max;
+	bool ret = false;
+
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
+		 subflows_max, READ_ONCE(pm->accept_subflow));
+
+	if (READ_ONCE(pm->accept_subflow)) {
+		ret = pm->subflows < subflows_max;
+		if (ret && pm->subflows == subflows_max - 1)
+			WRITE_ONCE(pm->accept_subflow, false);
+	}
+
+	return ret;
+}
+
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
 	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -1438,6 +1458,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
 	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
 	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
 	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
+	.allow_new_subflow	= mptcp_pm_kernel_allow_new_subflow,
 	.init			= mptcp_pm_kernel_init,
 	.name			= "kernel",
 	.owner			= THIS_MODULE,
-- 
2.43.0

