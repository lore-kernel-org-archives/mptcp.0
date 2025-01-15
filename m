Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2B1DB132
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935778; cv=none; b=BHIYHXSkrL3vwevPoSV6jLi8PHaPRBC1QuG8ascdQ+S359tFS+OjsC27ifjK34dS6EisCBlYQKZllpwPlhh24AV9XTqOO4jXlEGZLtzD48/tyMAAOFVWr4UraygXEkxBW+IQ26gVFB5ccnc0BPlPpe9gs48Cfh2MwMPV5mHA8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935778; c=relaxed/simple;
	bh=MjyZSJpyoaS2nd3YM3mjHj/X1yM587w5+3T/UcU+7gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6mqWWwdYdlTYKEZQK0fN9EHQIggzIOJog/O4aUxq18EVSsAXHhkKuAszBaqkNi1GVacZ4IWQ7yKBSpbQY5Yny65iJvITTUyWMom//2tS3u1J1JLvDpFS8csyoTislKlQ/fdAqC6cEAJT/fjoD93c3FiSFseNIU8qFuJBEASYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2UZyOhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2UZyOhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DF4C4CEE1;
	Wed, 15 Jan 2025 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935777;
	bh=MjyZSJpyoaS2nd3YM3mjHj/X1yM587w5+3T/UcU+7gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2UZyOhdDqLCX8RZ2oKDSXzbsK1W9vZEo1AoDgBzqLY0V/Q38HXnJQ/dMslnECIqE
	 4Lob8ZEcKiqL6MEq5X7azP4OmIN13XaVbFHOLTNygAQB9iztspEKN4kQUhcMAo3lLU
	 7LcgZ1gmfqWsxi5F93gb8+xeASYbJjJ3+a/2BJFoeTeXI+CX9WUB/YJoQXRGnmOWsA
	 c+841r7uPykK+x6kNrbWg86KKyvzyGX6TJf5cqggt/ibaEdC87jL3XQ9fgSPJu2be6
	 tGnQ7oJI06HHm/s8qAur5TssmWWy7+wMXRwl+cA5JNHQTz2Zn+8Cs79ZTOTX7kWHa9
	 vkGYFkKrD15hA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] mptcp: define struct mptcp_pm_ops
Date: Wed, 15 Jan 2025 18:09:26 +0800
Message-ID: <f37b6e58956de930fdd96b463b438983503b1e25.1736935433.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935433.git.tanggeliang@kylinos.cn>
References: <cover.1736935433.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h      | 27 +++++++++++++++++++
 net/mptcp/pm_userspace.c | 57 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  5 ++++
 3 files changed, 89 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 94d5976f7b8d..0918b91a29ab 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,6 +14,7 @@
 
 struct mptcp_info;
 struct mptcp_sock;
+struct mptcp_pm_addr_entry;
 struct seq_file;
 
 /* MPTCP sk_buff extension data */
@@ -120,6 +121,32 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+struct mptcp_pm_ops {
+	int (*address_announce)(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *local);
+	int (*address_remove)(struct mptcp_sock *msk, u8 id);
+	int (*subflow_create)(struct mptcp_sock *msk,
+			      struct mptcp_pm_addr_entry *local,
+			      struct mptcp_addr_info *remote);
+	int (*subflow_destroy)(struct mptcp_sock *msk,
+			       struct mptcp_pm_addr_entry *local,
+			       struct mptcp_addr_info *remote);
+	int (*get_local_id)(struct mptcp_sock *msk,
+			    struct mptcp_pm_addr_entry *local);
+	u8 (*get_flags)(struct mptcp_sock *msk,
+			struct mptcp_addr_info *skc);
+	int (*set_flags)(struct mptcp_sock *msk,
+			 struct mptcp_pm_addr_entry *local,
+			 struct mptcp_addr_info *remote);
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
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1713e9bb6945..2fdee6f22113 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2022, Intel Corporation.
  */
 
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include "protocol.h"
 #include "mib.h"
 #include "mptcp_pm_gen.h"
@@ -12,6 +14,9 @@
 	list_for_each_entry(__entry,						\
 			    &((__msk)->pm.userspace_pm_local_addr_list), list)
 
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
@@ -681,3 +686,55 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
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
+int mptcp_validate_path_manager(struct mptcp_pm_ops *pm)
+{
+	if (!pm->address_announce && !pm->address_remove &&
+	    !pm->subflow_create && !pm->subflow_destroy &&
+	    !pm->get_local_id && !pm->get_flags && !pm->set_flags) {
+		pr_err("%u does not implement required ops\n", pm->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
+{
+	int ret;
+
+	ret = mptcp_validate_path_manager(pm);
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
+void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
+{
+	spin_lock(&mptcp_pm_list_lock);
+	list_del_rcu(&pm->list);
+	spin_unlock(&mptcp_pm_list_lock);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e8d8236a40e1..64254c57be01 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1048,6 +1048,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
+int mptcp_validate_path_manager(struct mptcp_pm_ops *pm);
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
+void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

