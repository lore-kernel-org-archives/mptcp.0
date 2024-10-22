Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A52209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588540; cv=none; b=J+3p9A/lsHxc/bJxask3W7nM8yvb1mu0lJcHzjxyYh5fCgb2/P5swd+Uhs3pOWOf1SqBO6uJt1vAyrIn1RDD9zEJJpG4JB9FpTNIHE6ZRJUpp9BR50tn/rvR2FCLS5kNVTgUmoKtYvQ4OzKScVrgwRAGhxbHtPJNo7uN5W+PGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588540; c=relaxed/simple;
	bh=T06g+pkobScdyb15NjAymw6apEa/xa2fOAvYzSxlRIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/PMX8N7iPX0cUIMFl0w0sPFWMU8yNrDCYKm6pL3n3yeh3D8uri9V+2PG80e2o/RAfkI7MxqKHKGbtAatoILDBp+aP6Zgi0znndEnjVvN/AkiB83jhnY8tHakY9tFXte7lDyq16GzfOy6ELpr5VaBlS1RtG2zv8+I6BSegjywRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0/GyRiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0/GyRiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392A9C4CEC3;
	Tue, 22 Oct 2024 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588540;
	bh=T06g+pkobScdyb15NjAymw6apEa/xa2fOAvYzSxlRIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0/GyRiOQWLC27k/3pE72VnSWqMQr1t/18yIoqRc4+E4H380F+haCMkU8Mc08HWJ2
	 R6vKyGMXzKXkoPC/9xHUV3PDHm7JSHJzRD1kL0VF37NHw9o7ddl50tnbXPs4aCODJY
	 B1xWpDsOrdWWAJFdFHgBtWRjZbw5AJCUc46Bj/luQABOOW5gtLgBd0MNBC9s/q7JKu
	 CASyHmxnzyaVYBBszrC14kt6AFvw5hX7V/HbKrpZ6y5w4U5eGN2DyxKu4wasTN/d5c
	 HBmF+rgVPyLMFT5jYAzgZnshzuWqbWS0/B0kCpxG9vHnpl3L+4OFfFbJ5dfqGK2PF0
	 MvKf2uqJitzNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 29/36] mptcp: define struct mptcp_pm_ops
Date: Tue, 22 Oct 2024 17:14:37 +0800
Message-ID: <394713618bbf80e6060f7a586c5a93d51397c878.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
 include/net/mptcp.h      | 32 ++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 58 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  5 ++++
 3 files changed, 95 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..38b5862f6d98 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -15,6 +15,8 @@
 struct mptcp_info;
 struct mptcp_sock;
 struct seq_file;
+struct mptcp_pm_addr_entry;
+struct mptcp_id_bitmap;
 
 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
@@ -120,6 +122,36 @@ struct mptcp_sched_ops {
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
+	struct mptcp_pm_addr_entry *(*get_addr)(struct mptcp_sock *msk,
+						u8 id);
+	int (*dump_addr)(struct mptcp_sock *msk,
+			 struct mptcp_id_bitmap *bitmap);
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
index e5dfa1a6db31..459532617663 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -4,10 +4,15 @@
  * Copyright (c) 2022, Intel Corporation.
  */
 
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
 #include "protocol.h"
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+static DEFINE_SPINLOCK(mptcp_pm_list_lock);
+static LIST_HEAD(mptcp_pm_list);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
@@ -635,3 +640,56 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
+	    !pm->get_local_id && !pm->get_flags &&
+	    !pm->get_addr && !pm->dump_addr && !pm->set_flags) {
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
index 13cd97f9e0f7..d6c9ca292bff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1054,6 +1054,11 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
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
2.45.2

