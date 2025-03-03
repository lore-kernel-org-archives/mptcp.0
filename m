Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E613C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975921; cv=none; b=Vz8p8ze6qw+JKT+CQby7N37J8MaMbUAcBP/EvRs1vHY8B/1cpsHtbGip9eJGY1fA+qF8QVUHHwX56ynivJb0ljSgSlL0RnfAWtx1K1tNhmJL3zYLB383PM8o1YFEt9a/qiqquNaTLxdA85MljvyMFGR1ym1AuVzh/6vTTxCtHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975921; c=relaxed/simple;
	bh=FRPlnFLuC0H/LJP2vH/epPIswB4mGMu+4cInAMfg2r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4izGVFhXGnpOJzpZ9MvfD1Gj7p9SsCJtauOWZsNhEWh15YBBiUCynZ65Lq7WYGI6/cbzgUm9Dif4qAt1SwswJlsJMebAwmbW37ilQ5kHC3i8iPIQl3MUnNkJdX9C4vWjk6foQq+wnqXYfrsfGa4VVEM77crwQylczbLXzq45Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3Hqqj/z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3Hqqj/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5748C4CEE4;
	Mon,  3 Mar 2025 04:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975921;
	bh=FRPlnFLuC0H/LJP2vH/epPIswB4mGMu+4cInAMfg2r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3Hqqj/zeAi14B2UZkkKLWeMAT9xtlVfMCu72B8MWZk89MV4dJofPLbXcHz4LBa1Z
	 7omjnMEyGiaZqut5d1RDhtQAXA/Lxea56hy+iQdydYImavuTgOmG+ykm6CPfUOWET4
	 43bX1mjSiArVdhf30onS5koH9GzQ2qknrIlEBHCIwyJBL4/Yq6t61HBlHDow+LKa3t
	 cUxDrK10V/9V2rR/pkKzla5/ZPfqXvzkD73J9+v32b7wBVtldlv/cXCSJQsBaMnUlu
	 5M2F+J7n5GPgf8iXFz5wZxMPRCd1lSFsO9H2KvzC1KBCWDLK1B4pvJDlKEFqlecw72
	 ibYt3KgoNMd3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 01/11] mptcp: pm: define struct mptcp_pm_ops
Date: Mon,  3 Mar 2025 12:22:49 +0800
Message-ID: <993dd206cd1b29d4347514e3590bba675927f29a.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h  | 17 ++++++++++++++
 net/mptcp/pm.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 ++++
 3 files changed, 77 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..53e67b90c37a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -121,6 +122,22 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+#define MPTCP_PM_NAME_MAX	16
+
+struct mptcp_pm_ops {
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
+
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
index 833839d7286e..53a29adf7cae 100644
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
@@ -1024,3 +1029,53 @@ void __init mptcp_pm_init(void)
 {
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
+	if (!pm->get_local_id || !pm->get_priority) {
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
index 9bdfd915d62f..090592c108d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
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

