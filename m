Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937220011D
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320456; cv=none; b=T5QuD8v6tiS8ongGq54AVJKbOVFMGoaA3y9Khn3LvxmkaK33zrQJW5TvAj8THrDBGtBZa+wdVZvTWZfXaF36JHUk4bKSnStEmkPVVV367qbrBZuRMRvMEBirocmaKoF56wyqGTnxK55NfcM/h+j8Xble3iYEyqCoPoCGHptUUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320456; c=relaxed/simple;
	bh=tUo7fAUsUlVW9dhMcz6cWBTsNmCTkuaHucUn4GoXxz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxvxligoyf977th/yBWfHCEUy68vzSpF1+0JgE/oT9QGA+DvN/EP0KqI4Z4gy+VFHkoqdhWSa09muJsYnBTm7FFDXJbd3EsorSmQ4VAlSLYDTgeSyHOWAiNmDSTTfbrQ+uOK+nePUNz+Y/fLwAV0E8QiFvcRfSlJ8FlDRrZ7O5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE+1XCJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE+1XCJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A012AC4CEE9;
	Sun, 23 Feb 2025 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320454;
	bh=tUo7fAUsUlVW9dhMcz6cWBTsNmCTkuaHucUn4GoXxz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE+1XCJDxSPj97gPmQs+EPq9zkH4YTPnsblKiQ4rr8JooWBMs2a22M9n7WGMa4R2P
	 1wiBSH/o7HFHh6JZk+3sE2BgxLE2FQt2reG0DpIPohfrhUS8udktW7rLlj+36rFBDL
	 +jEJDyJnel6MfHzTWgrw9AssJcjX6WP0KhI/iqzZupq0OlCggIfLq30lH8OiX8fnMB
	 1jtN6bUfYmZKFLYYIFzVekm83m4yl2Sr3ptr089HXTA0CPLo4tXhErARO06EF90f4p
	 IFvsabY2UFfxf46tQzea1lhOj3Kt8SZSivjK1L4EqGUCRuHuIF34ymt4qxUmYQd9WT
	 K+boBWFSE4FEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 04/13] mptcp: pm: define struct mptcp_pm_ops
Date: Sun, 23 Feb 2025 22:19:52 +0800
Message-ID: <2e8ac1bb8447a52cd7fdf716076f0df3a2cfacb4.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h  | 37 +++++++++++++++++++++++++++++
 net/mptcp/pm.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  5 ++++
 3 files changed, 97 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..689926d1f39f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -121,6 +122,42 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+#define MPTCP_PM_NAME_MAX	16
+
+struct mptcp_pm_ops {
+	int (*created)(struct mptcp_sock *msk);
+	int (*established)(struct mptcp_sock *msk);
+	int (*closed)(struct mptcp_sock *msk);
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *skc);
+	bool (*get_priority)(struct mptcp_sock *msk,
+			     struct mptcp_addr_info *skc);
+	int (*address_announced)(struct mptcp_sock *msk,
+				 struct mptcp_pm_addr_entry *local);
+	int (*address_removed)(struct mptcp_sock *msk,
+			       struct mptcp_pm_addr_entry *local);
+	int (*subflow_established)(struct mptcp_sock *msk,
+				   struct mptcp_pm_addr_entry *local,
+				   struct mptcp_addr_info *remote);
+	int (*subflow_closed)(struct mptcp_sock *msk,
+			      struct mptcp_pm_addr_entry *local,
+			      struct mptcp_addr_info *remote);
+	int (*set_priority)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *local,
+			    struct mptcp_addr_info *remote,
+			    u8 changed);
+	int (*listener_created)(struct mptcp_sock *msk);
+	int (*listener_closed)(struct mptcp_sock *msk);
+
+	u8			type;
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
index ac7b39148bd3..97fccd930cd0 100644
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
@@ -647,3 +652,53 @@ void __init mptcp_pm_init(void)
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
index a6815d02706b..3c24e8e1bc13 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1048,6 +1048,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(const char *name);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm);
+int mptcp_pm_register(struct mptcp_pm_ops *pm);
+void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

