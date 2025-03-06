Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7890204F60
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258916; cv=none; b=KPPmfPb1cA9M0cMUAcRQsxCrhfsCJbl+YXDmVEtB4TvStbmf7OCNA2PZpbBmdOptRzSKgDm+15r8tE/ave8pVrwtQ+mswmYl29HWC1EwzrgmiTlqfAwNE4R5Hg2nMRoQfOxP8jYTEVv7KF+oPSHllXFljPNvyO4gMUy3BGrePdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258916; c=relaxed/simple;
	bh=XhgJT+bbhZy92wMKsJvboYTtpb5tayygQ0+UiNTfjlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEs6v8GyJTj4dMJXBdpun1jayZUSzra3n4EtfeNxeBQkBFgF6QcxWeSXqB49WSlukONq6nKpWvNOvhaRmRGJkVPYmRQd76f2dHrr8XlXhsgNKcC1aS0qxmGekDGEh+X3ukuUrPiRhX5M869hidGZryeAysbBUBIcvIqwJ+tIJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlDiCRse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlDiCRse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E55C4CEE0;
	Thu,  6 Mar 2025 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258916;
	bh=XhgJT+bbhZy92wMKsJvboYTtpb5tayygQ0+UiNTfjlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlDiCRseTfoQYEl1IVvb4To1rwZeewS2YOe10L4dDWch+bhBtHfNdUOzYOIWMgWI4
	 fNBlubMaSjDcsAgk2IlYVspsACjqPlaj6/ZsXqhakSyt5tKrJ9tmjzleaB92u76lsQ
	 RPkkwbWNS7ZunWzT6+r2nPZySJRS1vEtac5PqKhsSlzd+oDVJ8K9vrITYlm9aTFgTS
	 gkcNpxjMDSU/M9Fb7oGEd5Ry+IZ6aJUS5PJNEYVC4BuTNm2caxBCi7MdrUFI0tFFgl
	 olMKKFrGftg1Y6wyL8UXXKe5+pXS+nsBHClZy3bCBKNA7ejp1KcPxEDK0z08rRwjYY
	 Fts3/+fkcMc9g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 02/12] mptcp: pm: register in-kernel and userspace PM
Date: Thu,  6 Mar 2025 19:01:37 +0800
Message-ID: <f76b8ccc7c6b3a894225e190ff74ce096ab58aa1.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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
mptcp_pm_kernel_register(). Also define the userspace path manager
as a new struct mptcp_pm_ops named "mptcp_pm_userspace", and register
it in mptcp_pm_init().

To ensure that there's always a valid path manager available, the
default path manager "mptcp_pm_kernel" will be skipped in
mptcp_pm_unregister().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  5 +++++
 net/mptcp/pm_kernel.c    |  7 +++++++
 net/mptcp/pm_userspace.c | 10 ++++++++++
 net/mptcp/protocol.h     |  4 ++++
 4 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5ea5048dfd9b..eefed554dcc9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1028,6 +1028,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_kernel_register();
+	mptcp_pm_userspace_register();
 	mptcp_pm_nl_init();
 }
 
@@ -1060,6 +1061,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
 {
+	/* skip unregistering the default path manager */
+	if (WARN_ON_ONCE(pm_ops == &mptcp_pm_kernel))
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm_ops->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 806a9b5b3c07..d39e7c178460 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,8 +1398,15 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+struct mptcp_pm_ops mptcp_pm_kernel = {
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
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 13856df22673..2cb62f026b1f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -682,3 +682,13 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_pm_userspace_register(void)
+{
+	mptcp_pm_register(&mptcp_pm_userspace);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dfb981a83f31..3f820a9e453f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1047,6 +1047,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+/* the default path manager, used in mptcp_pm_unregister */
+extern struct mptcp_pm_ops mptcp_pm_kernel;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
@@ -1154,6 +1157,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_kernel_register(void);
+void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-- 
2.43.0

