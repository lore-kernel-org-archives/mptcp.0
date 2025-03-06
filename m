Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A31FECB8
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258915; cv=none; b=bgLJePWIkOTGCIDV+aqhR+rbcTqPyn0BRvhECmnpPi8G6GigkeTiR3/GVQb5Qeflxww7jzLS5BGMx4z0A4VFaOalARyipjTW1zrk6KjvgqCK0UNTnEiWuKzbV7dpe5xhjxRROwMm6reYXwO0C1+/fnCfKNY/6S/yLB54UeGK27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258915; c=relaxed/simple;
	bh=aptOxRU4sHVclwEhwzfyW8h2D9ps2xm8wTK4603DRjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laGPPNJa/dA5QwBOvvu7oylrAUGVF3YNXe34vwP+XZVnhE+CJ8mdL4UScPOayGnAPJu+rrFkoFFu9lP1RfeSnKv2hI8ojeI+QaQOlkmYvigM6Am2V0tk37QKC6cn+61Ov25tik9fNWDajtbMFRyKwNWe7l+FvQpeLwgIu/MF3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oom4Vl4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oom4Vl4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BB9C4CEE2;
	Thu,  6 Mar 2025 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258914;
	bh=aptOxRU4sHVclwEhwzfyW8h2D9ps2xm8wTK4603DRjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oom4Vl4gNiGAGu5VP5TU6qGeLS63u74nsq+su6HdbVe1sKTbBlDj4d5aW0W5X7Kjr
	 vpzL5xUBj9Jk9sW/eJLfJi3yWY0dlvyFAVLqgmfx0dVF5KBKdzE0bpJJeOcxic5S+h
	 QeF6554fSlbG9x9fqCLORfzfHvNaai87kHVeinTsis91n4zyM8c9TSGe2p2Bsyh38D
	 33cpthduOjW9f3yrAByXhMg4UVmBSEqsCMQZxWqh7tasmB/+yoA4lVGubY4UvZNSrc
	 fgkfAP8703xCdZ4i7KyKJpuGO8u4mJg6V9jwUffO/Hn4Zbpa5+sSV5KMZgl2RQ4it2
	 MkoMGmNA5QsSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 01/12] mptcp: pm: define struct mptcp_pm_ops
Date: Thu,  6 Mar 2025 19:01:36 +0800
Message-ID: <47180d967e11e89e565f17dee0844d6bf98dd553.1741258415.git.tanggeliang@kylinos.cn>
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

In order to allow users to develop their own BPF-based path manager,
this patch defines a struct ops "mptcp_pm_ops" for an MPTCP path
manager, which contains a set of interfaces. Currently only init()
and release() interfaces are included, subsequent patches will add
others step by step.

Add a set of functions to register, unregister and find a given
path manager struct ops.

"list" is used to add this path manager to mptcp_pm_list list when
it is registered. "name" is used to identify this path manager.
mptcp_pm_find() uses "name" to find a path manager on the list.

mptcp_pm_unregister is not used in this set, but will be invoked
in .unreg of struct bpf_struct_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 12 ++++++++++++
 net/mptcp/pm.c       | 39 +++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 55 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e9832a8f981e..69f7b35e57c3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -112,6 +113,17 @@ struct mptcp_sched_ops {
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
index 04a156395aad..5ea5048dfd9b 100644
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
@@ -1025,3 +1030,37 @@ void __init mptcp_pm_init(void)
 	mptcp_pm_kernel_register();
 	mptcp_pm_nl_init();
 }
+
+/* Must be called with rcu read lock held */
+struct mptcp_pm_ops *mptcp_pm_find(const char *name)
+{
+	struct mptcp_pm_ops *pm_ops;
+
+	list_for_each_entry_rcu(pm_ops, &mptcp_pm_list, list) {
+		if (!strcmp(pm_ops->name, name))
+			return pm_ops;
+	}
+
+	return NULL;
+}
+
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	if (mptcp_pm_find(pm_ops->name)) {
+		spin_unlock(&mptcp_pm_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&pm_ops->list, &mptcp_pm_list);
+	spin_unlock(&mptcp_pm_list_lock);
+
+	pr_debug("%s registered\n", pm_ops->name);
+	return 0;
+}
+
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	list_del_rcu(&pm_ops->list);
+	spin_unlock(&mptcp_pm_list_lock);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3492b256ecba..dfb981a83f31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1047,6 +1047,10 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

