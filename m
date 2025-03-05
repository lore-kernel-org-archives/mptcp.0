Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98F22AE5E
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172415; cv=none; b=HiB3+AR06rGG8VqvEwqwop7FWSNMIeDrXW1F9zY60DdJibO8aZM4zw1DQerg8Lv5+ZhC3IyTGJTaR/j76zTrau1L0FqwyPt1mxAzeywV1x519WwxJZ2OY1b6as3wWMBIZxbjQLC51PMDxI3i44Eq14GgtHGvYX+oa2L4ztH1Lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172415; c=relaxed/simple;
	bh=WPM0IBE+9dT+2lkbkB5+IsH8/4hucIS1ihkj2nvGWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGkudaRoaAV7YZSUHbKGObHniuhjKvagPPZN002ouaYpd5/KHidlwT3ItkyZw7zyll4JJ/qzgQAqgWYw79+XS6e0DKHNMYOn7TnZRS2+DjOUVHXYqDlC2j+rrx/XD5TZOyOS9FrXL7pbtY+iv5JvBVzCgdWID1+0znzPV60H58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHm7lHC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHm7lHC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC01EC4CEE2;
	Wed,  5 Mar 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172414;
	bh=WPM0IBE+9dT+2lkbkB5+IsH8/4hucIS1ihkj2nvGWFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHm7lHC5HJeWD5GcNeTmPGVPkz6VriRLyS/ZT75cVnStEDDkuykYm/5LPmmc/mLOo
	 CFf6542NhqlL6a4Cc/bWp+RsuTgIHPs5VDJyOWQS12+/eMIByONnWS0jrY1bSciQN9
	 lShvnRbAx9a6Dad6KFY4Kg4611ku8sqD5p3tGMYOKifTtEI8ucwvmBDtvb+qnLDR/b
	 PpwXtBIBJ0z75ewVok7Su8itYxLIGTzIS7Ku84Y8Vc2bWQ1emGOfJevrfLQRmssTdB
	 4lXrfXHo9WhFsuf3/B9pNlyDLIv/rvjohSsGPoT5+CX0KOPSpZwB/cfFB7a+Ewy3G3
	 aOvykQKkMoy8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 06/12] mptcp: pm: in-kernel: register mptcp_pm_kernel
Date: Wed,  5 Mar 2025 18:59:47 +0800
Message-ID: <b8a211dceadeb0e5b241e1111974cfaf0942a243.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a
new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
mptcp_pm_kernel_register().

This mptcp_pm_ops will be skipped in mptcp_pm_unregister().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        |  4 ++++
 net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h  |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a2b210873b23..28ea8bdaa8b0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 {
+	/* skip unregistering the default path manager */
+	if (pm == &mptcp_pm_kernel)
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 806a9b5b3c07..8bd4431d8656 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,8 +1398,34 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
+{
+	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	/* pm->work_pending must be only be set to 'true' when
+	 * pm is the default path manager
+	 */
+	WRITE_ONCE(pm->work_pending,
+		   (!!mptcp_pm_get_local_addr_max(msk) &&
+		    subflows_allowed) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->accept_addr,
+		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+		   subflows_allowed);
+	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+}
+
+struct mptcp_pm_ops mptcp_pm_kernel = {
+	.init			= mptcp_pm_kernel_init,
+	.name			= "kernel",
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_kernel_register(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	mptcp_pm_register(&mptcp_pm_kernel);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 246b44db9775..f700cb55bf49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+/* the default path manager, used in mptcp_pm_unregister */
+extern struct mptcp_pm_ops mptcp_pm_kernel;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
-- 
2.43.0

