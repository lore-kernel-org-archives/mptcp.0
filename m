Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41C22E406
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924923; cv=none; b=FXAVFLUgGj6mqxCBuqd8L3WGmYjNl0RS2DUPpTduN4/d5AEQllwmN/x54UAGlBUAme9tz/vjY3ws/FKoM7P1VPsPoQuYdLgDBQ8W8IzWjBSkElcofojbjlFV1yIla1WGrUgEyza0+7Z58cRyBGKzLK9/sj8ey/kYJVNQR07jVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924923; c=relaxed/simple;
	bh=6JtPSofMynJwdChakfUTX9LL11rZmMBkN1FRhZl3pVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AltzRKkuosGVtpJjZv/YeR6275vrU4X7/YLM/tPrWEyKMaItShHMLuaKFVEKdSIfAp9qG97Z1vw86MClzZyIzD8UlXhpe3txBrEqXQ0ZThSJeH69EsP+wKRI5JQrmrXrdNuDTSu6IZvcCpbRlzMMolN+Cc4uAXJs2tT7Gl4FMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXmr+SsO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXmr+SsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC4EC4CEE1;
	Wed, 15 Jan 2025 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924922;
	bh=6JtPSofMynJwdChakfUTX9LL11rZmMBkN1FRhZl3pVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXmr+SsOu8q7WJd2nOEAotP5TNgCWGwP4RLCJw9wflQxdL12dOvyTkU1fcogp7g5S
	 9uY92+8VNPQm+VvANg7usFM0ftX/edwvh7vdLc7Ga0Gqr1DyDCYbe+Dhi3W2D2xCao
	 j4d9PKK0HhQpvLo2rhBl2IUXqn+dqVHklsIixxRkhekURYdLlDk5x3VCC4pxZFiUrN
	 GhngCpEK1H23IFaPkNcvSvHcSA3rGV8FFJbDL7QJelmySS1U3RrRvvNlOjFNiplrsj
	 1YX8RYHgtz56CMydk3GGs2z+Bn6JGMi9xVBdI9PE2UlNwyMd/ZzXmLbI6T2U300uJd
	 L2aHjeWm0Kg9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: define struct mptcp_pm_ops
Date: Wed, 15 Jan 2025 15:08:32 +0800
Message-ID: <a7606a505671fc6c6dc3dca7822b3652741dd8b0.1736924549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924549.git.tanggeliang@kylinos.cn>
References: <cover.1736924549.git.tanggeliang@kylinos.cn>
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
index a7b836309d2b..1530b0c9d0b4 100644
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
@@ -676,3 +681,55 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
index 80a18877e47d..10aa4820c5b2 100644
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

