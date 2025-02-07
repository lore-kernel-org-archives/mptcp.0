Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476B1DDC15
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920582; cv=none; b=QL5HfNEwcfxEM9f7ND5I4ENWf7DprzwUej58nsX0uLI2Rg2U06L3IO3pYlxA9D23KImVVxDPzW2VpFqoa5PFTib+yZWcK5pNCz6FIg2092WNjjrUknNoK0J+LSc4z/m2O45vIRI/trvHNuMDfTA6aWbiBqkBacMJHeBS2xMHWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920582; c=relaxed/simple;
	bh=K/jTEAETklBrnH1Q/VZzMTqksGs/yeYRrG/6rfRtqFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYiuDea9C2tkx+SnPHotRaLAxQP5fob8f0iY0xQM1iH9N0V7SZOJbgffnBHYvpkZ8kfYS8zVzC3iExeOAySrlWl/zQxqlDNR/kSNC0eVDUQcYaAUmxd/05JHdW9qL0f2bW4Q0Sx9f81pEucM/qYVUpl8qg0uXDLuM5q236o8kTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfucwOkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfucwOkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EE9C4CED6;
	Fri,  7 Feb 2025 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920581;
	bh=K/jTEAETklBrnH1Q/VZzMTqksGs/yeYRrG/6rfRtqFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfucwOkw1IcTa4oH218wPiPuNvBmdcqeBck5neJ30z3Wb0GQeugSJs+ATdn4fOnrg
	 cvQCwLjatW/16uJTQ/+bD2drgx/AQ8CI0Mwhln+yz4kgiwGOHY3MVJ/ISZE7q/TEgc
	 JJYgUUgkMG2D8xBH9Zk6cIZOR6202B5juzTatGGpOUIr9RGYmb8uPlxRQ7fSWYAeYg
	 lUwjbMk6cOvUjBTMV8/GlIoEdaZZhZm+6LaUMw++k05koCvR/ZiS+Wl8pNH+YZWLpi
	 wO5VNhZ9NPUyMViq+7o0lRfk1TV/BLwmfTLkdbZJxuhiujyGIq8mEztoCtdF2wvxWU
	 rocQx5GlGH9tg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/4] mptcp: define struct mptcp_pm_ops
Date: Fri,  7 Feb 2025 17:29:31 +0800
Message-ID: <c49ce8acc078af821c7214c3a3484344ab51fd3f.1738919954.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738919954.git.tanggeliang@kylinos.cn>
References: <cover.1738919954.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h  | 32 ++++++++++++++++++++++++
 net/mptcp/pm.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 ++++
 3 files changed, 96 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..d629da5f8e8b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -121,6 +122,37 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+struct mptcp_pm_ops {
+	int (*created)(struct mptcp_sock *msk);
+	int (*established)(struct mptcp_sock *msk);
+	int (*closed)(struct mptcp_sock *msk);
+	int (*address_announced)(struct mptcp_sock *msk,
+				 struct mptcp_pm_addr_entry *local);
+	int (*address_removed)(struct mptcp_sock *msk, u8 id);
+	int (*subflow_established)(struct mptcp_sock *msk,
+				   struct mptcp_pm_addr_entry *local,
+				   struct mptcp_addr_info *remote);
+	int (*subflow_closed)(struct mptcp_sock *msk,
+			      struct mptcp_pm_addr_entry *local,
+			      struct mptcp_addr_info *remote);
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
+	int (*set_priority)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *local,
+			    struct mptcp_addr_info *remote);
+	int (*listener_created)(struct mptcp_sock *msk);
+	int (*listener_closed)(struct mptcp_sock *msk);
+
+	u8			type;
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
index 16cacce6c10f..344bc477c502 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -6,12 +6,17 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include <net/mptcp.h>
 #include "protocol.h"
 
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -644,3 +649,57 @@ void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
 }
+
+/* Must be called with rcu read lock held */
+struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
+{
+	struct mptcp_pm_ops *pm;
+
+	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
+		if (pm->type == type)
+			return pm;
+	}
+
+	return NULL;
+}
+
+int mptcp_pm_validate(struct mptcp_pm_ops *pm)
+{
+	if (!pm->created && !pm->established && !pm->closed &&
+	    !pm->address_announced && !pm->address_removed &&
+	    !pm->subflow_established && !pm->subflow_closed &&
+	    !pm->get_local_id && !pm->get_priority && !pm->set_priority &&
+	    !pm->listener_created && !pm->listener_closed) {
+		pr_err("%u does not implement required ops\n", pm->type);
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
+	if (mptcp_pm_find(pm->type)) {
+		spin_unlock(&mptcp_pm_list_lock);
+		return -EEXIST;
+	}
+	list_add_tail_rcu(&pm->list, &mptcp_pm_list);
+	spin_unlock(&mptcp_pm_list_lock);
+
+	pr_debug("userspace_pm type %u registered\n", pm->type);
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
index bac5c925a72f..93445c24de93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1047,6 +1047,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm);
+int mptcp_pm_register(struct mptcp_pm_ops *pm);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

