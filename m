Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97441D89FD
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020267; cv=none; b=l2HA1xlDMuU6GC2rnJDJUB1YhCWn9/d33rRZ8Mw2GCkpfZCrdXYO47bjLwGOl8DxKpmD2hc/uBD34Q30gBad76FAWiNBAdfuYC+ChyePSRGu6lnCJDOA++xm7BmMt/LWcLSkNx4Nx9Kvk1G1jzh/yqht9LMYqzzqT1cwrF3MO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020267; c=relaxed/simple;
	bh=9duXCSVpsOsVIcRSOo3WLC2kYJWoM5cGbKSXZ6U+bQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umyij6okJ0YLBkzlHd249MZTxePnVwpeGYxDpJbfLQjqtD2CmnFHWm6e2+FiOFssOrSphWzhCNoMXtDspXC9SJNEZA1dfPXmHfyU6Np+H2bcZAPgqcT+t7TDwuDkD2WwJuZrXF98K/8fFCgd6Cgcuhc/b93LCfmO9jb3CUnNhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKhloYND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKhloYND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF0C4CED6;
	Thu, 20 Feb 2025 02:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020267;
	bh=9duXCSVpsOsVIcRSOo3WLC2kYJWoM5cGbKSXZ6U+bQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKhloYNDtsUuLBStjSyA6dEJx/qqSF/ZJTVvWwusQsMJRC/UVDtRgX6SVHCjVWPpa
	 kskXA2kukN7qKn9QjNrEsIFM/JQ0x2LU2xhzuYFfQCMDAtwNOmGXEoIIwUxZ5poyyS
	 /vWmBfahTTlXzWRV6gBydwxPfxxlFyGfrwaKWnhdVfxDkhkMt1alhqwnyqxw83KNi8
	 mPQ1LZNMwVG0G7nINHEb+6LxtE/PedIajfyA0AesNd21wsOTkALR0hVcBZSpn+X6yC
	 4YSKVDL6FpKpY+T9pQXlnwa/gbmeUPGoeSTyOU8AzcX0wf6yuq4xyVnoFeSqB3G65c
	 nIV7bZmFAYbug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/9] mptcp: pm: define struct mptcp_pm_ops
Date: Thu, 20 Feb 2025 10:57:28 +0800
Message-ID: <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h  | 29 ++++++++++++++++++++++
 net/mptcp/pm.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 ++++
 3 files changed, 93 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a41d6c74760f..f51e75d3882d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -134,6 +134,35 @@ struct mptcp_pm_param {
 	struct mptcp_addr_info		addr;
 };
 
+struct mptcp_pm_ops {
+	int (*created)(struct mptcp_sock *msk);
+	int (*established)(struct mptcp_sock *msk);
+	int (*closed)(struct mptcp_sock *msk);
+	int (*address_announced)(struct mptcp_sock *msk,
+				 struct mptcp_pm_param *param);
+	int (*address_removed)(struct mptcp_sock *msk,
+			       struct mptcp_pm_param *param);
+	int (*subflow_established)(struct mptcp_sock *msk,
+				   struct mptcp_pm_param *param);
+	int (*subflow_closed)(struct mptcp_sock *msk,
+			      struct mptcp_pm_param *param);
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_param *param);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_pm_param *param);
+	int (*set_priority)(struct mptcp_sock *msk,
+			    struct mptcp_pm_param *param);
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
index e3457f34621c..f56b2d1e3409 100644
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
@@ -661,3 +666,57 @@ void __init mptcp_pm_init(void)
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
index 7987beaa730e..f3e04927e214 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1039,6 +1039,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
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

