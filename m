Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF21FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088448; cv=none; b=DaI1kVJYcBc8xBgYAL79BAPhcYw9iyiLd43WX1ampHsuop1HF0PmraJN6ghenIpHR7OMbAmqbyxIGB4zwWh2W7qdWVWJcGrMbnsK8EfdNcwWV+/wO0PYAlC0hg7SSTGKY1VYt/xuC/d7TtUoDqxHU5P/rgUkTW2s890Dk732TYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088448; c=relaxed/simple;
	bh=AMoCLzwdQN8g4OTUtlZqh3gfR/+9q8YNFMizS0RV/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7gwZxYIWqGmsu0yezZ0fYiE0U9ZkbVSdCDXGG4TQimdi72LMea+5mVljzpboEyx11XSh9Lr4kCe3bY+Jfcd0gHrLfOgceWLpBIzpQaQKMcr9TILztBJ/QpIjg79OavxuxjlyactrMnO0BOTkDUjvWL1sY3Lb7MGGeiMCtsBFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFeOmL+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFeOmL+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F113C4CEE9;
	Tue,  4 Mar 2025 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088447;
	bh=AMoCLzwdQN8g4OTUtlZqh3gfR/+9q8YNFMizS0RV/Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFeOmL+SoyQaK+3jJD6XYgKWnKMUfPfZXSI4P7N63biEXL52i6Ak712YMUYr9E1Lo
	 1YlqF329ZKP51mgyOC4Lq1eyAXXfjbyKJtb3gSnDCV8GIIjZOnGH6dcISRePITSAO0
	 GMc42FXh93asVDVEDVamnWYdkyYuOOlEgzb3I4SyThNpCwo4Xvjam6qZL1dITjW3eQ
	 YIBojS94VrrJkibqgduSDybBpmppfLTnb5r2tCXbJZt5HaCooR2Xtgap4op6ZUL2XD
	 llYjdhsjTsD4IseHTpNW6wBu1eGw5TqA4Eb1bJ8L1fbMYscD/2Hkf+QCYQajglw36f
	 qMnodFc7xM2Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 01/12] mptcp: pm: define struct mptcp_pm_ops
Date: Tue,  4 Mar 2025 19:40:28 +0800
Message-ID: <4f1f5c350a67ac7116dd5b6daea1e57d891e8c52.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to allow users to develop their own BPF-based path manager,
this patch defines a struct ops "mptcp_pm_ops" for a userspace path
manager, which contains a set of interfaces.

Add a set of functions to register, unregister, find and validate a
given struct ops.

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

