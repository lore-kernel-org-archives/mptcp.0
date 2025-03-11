Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881F13C3C2
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674738; cv=none; b=U7S44xEOYKIz0dlquTN72ouP5xijxeISLrrbzB3Kq73FikRS8UOUEPVj9rJ9H5hM/55J99jOz9cMb5Nm4q+/lm7MkTNs/ybbqtF0DA0f0GQsS2B00SMIJF5RTb3MzzBMQ+N0Q0kzIyaDUkHG8t9a1GCyEFb9MzQ63YJSxQaue9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674738; c=relaxed/simple;
	bh=OhwYR31+IhA2KME5QZm3e1i7HD/AKq4Nksok1oesewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVH+pZLdZx+7vwPp0+oyJ/4BpjWU9Jn7Tvqkeo6D8j8X+tu7S3nQp4UHFcAtrfPGNM0M5wbKu9zijOVJK8iRaNP5/Y/uwLjG4EUNDPOg8FBSylO0vHnOSUJjZL9BD8eeybQCfYxWl5mkm3AvREUDIPqQqtT2GXRwW6StDAQ7ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdF0E1/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdF0E1/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2937CC4CEEA;
	Tue, 11 Mar 2025 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674737;
	bh=OhwYR31+IhA2KME5QZm3e1i7HD/AKq4Nksok1oesewY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdF0E1/2shi64LRZpRTFvRF7TaV55tYE/kJ+NNAUdUDvkEGBfmlfbbcDGrUy8ASA5
	 hwe9AVqZjHxkT2iyDB5QDdfcOWPnx4ypjwTWFtRs/hERq1uLdwX2Pnz6UaNw3B/nqe
	 yOlUtJ/ikf0srTQ4fxJgNUw7+DUN17PmEoMXFXWYXorOOCvGM2u/oBzJqXZj0nJj9D
	 Pm8Fr8Zomhz0rs6YbRTHGw4+2XG6hClO2TbHOQKHcKM90Wq3aP7ZTnS+i2M35ELrh5
	 9irJtJuC1/CI7+12GD0rlREatzQgVV6eWOskqHQ6SodQ29jB/3rA6UCpgpdZ7S0KPi
	 Sr6xCYr2Z25Lw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 01/10] mptcp: pm: define struct mptcp_pm_ops
Date: Tue, 11 Mar 2025 14:31:53 +0800
Message-ID: <c974979c2a69ec69c676e4ca7a9b713bbd2390db.1741674285.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
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

Add a set of functions to register, unregister, find and validate a
given path manager struct ops.

"list" is used to add this path manager to mptcp_pm_list list when
it is registered. "name" is used to identify this path manager.
mptcp_pm_find() uses "name" to find a path manager on the list.

mptcp_pm_unregister is not used in this set, but will be invoked in
.unreg of struct bpf_struct_ops. mptcp_pm_validate() will be invoked
in .validate of struct bpf_struct_ops. That's why they are exported.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 12 +++++++++++
 net/mptcp/pm.c       | 50 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 +++++
 3 files changed, 67 insertions(+)

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
index 85ee999729a1..f4948a2cf9be 100644
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
@@ -1015,3 +1020,48 @@ void __init mptcp_pm_init(void)
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
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
+{
+	return 0;
+}
+
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
+{
+	int ret;
+
+	ret = mptcp_pm_validate(pm_ops);
+	if (ret)
+		return ret;
+
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
index b5c945064baf..2307f2fcbe9d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1052,6 +1052,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops);
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

