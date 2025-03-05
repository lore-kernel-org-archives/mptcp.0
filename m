Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A6221F1E
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172406; cv=none; b=VEujVjr41syAUodrrVHWmdHhUcsj29Ljjy3R3Zz+iikytGGp4mAMWPs+04Uh2MCKLR0Qn+RH/Ax6knsIejjCSWx0rd/FIZ3br01TkYkobn8NhCJDNtDsTqFYXX8Z/YVLHw8HRH+lbeNnBZKOJW8AhBYb8tEebvMfn6Cj8q4AAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172406; c=relaxed/simple;
	bh=sYnrSigWaWAheOO3wnenOB+tbc+oqDuX+T2QUS6eE5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkISN4UDYWwm1NoLHAUtP1Eht/To0d4onpk5feZkrKBxabHU/D+Qqs0Bm1erXjqhKCPsR2eARhoFKDGR8JxwqEZDhxH2k8SuaE9GEqHVVO7fNzNR1srMgZquAPa98HkRlypwLQwo3buVIK++Zo9+M5/hndWDcsDWyNdBzgyBF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1BOXmzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1BOXmzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C3C4CEE8;
	Wed,  5 Mar 2025 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172406;
	bh=sYnrSigWaWAheOO3wnenOB+tbc+oqDuX+T2QUS6eE5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1BOXmzgJ1ljpQW9YcD+hBkQFKuLoiWiy0G0kAoIA4zl5w+9ia26hsK4CE0xfxmI+
	 Tw0HkmRap8giIT11b1m3DBNx5CGk8oymwNaxxo/Pc1oSkePewE2lIl3vn42yE7wZpJ
	 kHH7JFj5RxmhgWUXPq643XWXo1H3+6YTgwpI+ZpajOb4KVIcPoiljRbEm2dcuhTUpj
	 p2PRmlGNcS5GuxcihpOO+o+z6Jt0jozSv9NDgsNfHRLB/G1YthC0ETfuAn4nALrUil
	 Xd/RmsbVDXRRqK6PFe66scDGThw9jk9pPDm7YHYAJF4P55Li9xHUmf4PNFU/3ZLZvS
	 2W5qHT+OhXUmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 01/12] mptcp: pm: define struct mptcp_pm_ops
Date: Wed,  5 Mar 2025 18:59:42 +0800
Message-ID: <fbf3405bf1dfe532040c73f9a734b87c6d716da3.1741171898.git.tanggeliang@kylinos.cn>
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

In order to allow users to develop their own BPF-based path manager,
this patch defines a struct ops "mptcp_pm_ops" for an MPTCP path
manager, which contains a set of interfaces. Currently only init()
and release() are included, but subsequent patches will add other
interfaces.

Add a set of functions to register, unregister, find and validate a
given struct ops.

"list" is used to add this path manager to mptcp_pm_list list when
it is registered. "name" is used to identify this path manager.

mptcp_pm_find() uses "name" to find a path manager on the list, and
mptcp_pm_validate() is used to check whether required ops are defined.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 12 ++++++++++
 net/mptcp/pm.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 ++++
 3 files changed, 72 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..aeb3b1e4d8f2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -121,6 +122,17 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+#define MPTCP_PM_NAME_MAX	16
+
+struct mptcp_pm_ops {
+	char			name[MPTCP_PM_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+} ____cacheline_aligned_in_smp;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 04a156395aad..1af42c6a24c6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -5,6 +5,8 @@
  */
 #define pr_fmt(fmt) "MPTCP: " fmt
 
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include "protocol.h"
 #include "mib.h"
 
@@ -18,6 +20,9 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
 /* path manager helpers */
 
 /* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
@@ -1025,3 +1030,53 @@ void __init mptcp_pm_init(void)
 	mptcp_pm_kernel_register();
 	mptcp_pm_nl_init();
 }
+
+/* Must be called with rcu read lock held */
+struct mptcp_pm_ops *mptcp_pm_find(const char *name)
+{
+	struct mptcp_pm_ops *pm;
+
+	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
+		if (!strcmp(pm->name, name))
+			return pm;
+	}
+
+	return NULL;
+}
+
+int mptcp_pm_validate(struct mptcp_pm_ops *pm)
+{
+	if (!pm->init) {
+		pr_err("%s does not implement required ops\n", pm->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mptcp_pm_register(struct mptcp_pm_ops *pm)
+{
+	int ret;
+
+	ret = mptcp_pm_validate(pm);
+	if (ret)
+		return ret;
+
+	spin_lock(&mptcp_pm_list_lock);
+	if (mptcp_pm_find(pm->name)) {
+		spin_unlock(&mptcp_pm_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&pm->list, &mptcp_pm_list);
+	spin_unlock(&mptcp_pm_list_lock);
+
+	pr_debug("%s registered\n", pm->name);
+	return 0;
+}
+
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	list_del_rcu(&pm->list);
+	spin_unlock(&mptcp_pm_list_lock);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99b848de5229..e1cd69d376d1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1049,6 +1049,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm);
+int mptcp_pm_register(struct mptcp_pm_ops *pm);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

