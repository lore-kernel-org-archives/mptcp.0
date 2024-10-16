Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB818205E00
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070017; cv=none; b=FdY0v64t/9tdOT2Ccc4Y1q+LGifhGTyCJvA+zPG95kXV9380IobNkdoADL0hmGo7RPNVX7UgddIVy1fdqDtPjf7fUbfL6CivdQeBEdzO+unfEWJv0+iNGSmDxckc1AZWhnp8prMCmvvFX1kNktq9Uip2yFVpkO2abTHnO0FNZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070017; c=relaxed/simple;
	bh=C1O7C8fTcnZ0Wg4df1YR5DCWCFMa8SFujLnWeevShHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbjvBTnsxZaUrAEpxr3TIrt0wmyZ2RwVX5mjGCgpwsxqtbH67G/aSy/U/UVmWnUbHQQZxyDqdGWDGmcnn4bFmFToq/FpYKg+wRK3rymyZec7e7gQo56+kChcC8DxYDMS9JmKGwXYRUNZhnUPCuLRTvkAJkbPMJ9unu1hdJb0LhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el2P3hI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el2P3hI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70710C4CEC5;
	Wed, 16 Oct 2024 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070017;
	bh=C1O7C8fTcnZ0Wg4df1YR5DCWCFMa8SFujLnWeevShHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=el2P3hI7FPaueKiH620cy7qOzyHlbAAEeo8U6ixOvDIXeuH1Sv8k3QHy1OWjwN/nF
	 JrTpzMW0MLBU4ql7kQVlWTX3COinlbc0BLSBijOK0vF3pZWmNSk/+1LO40FB3ruePr
	 wM9559Wf/X3Rp3n8oXrf7C4NzwjU0KtCLfybPPrwp4wKYaix7yQa8mJS9T53mMBCEg
	 Ae2jdVMula8Jka9e0/9aAYIgKKBwMByaZLGY0wdNK3ksuEFSJg1y53E8NF1DM4pVBT
	 0rdjX+ZA3dBGWlg6XTrw/8I8KRZJb/0ZYqwxnS+kKW6i7puIEob+CEDDf9vZx/iPB1
	 Fu3LjGgK0Zk4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 29/33] mptcp: define struct mptcp_pm_ops
Date: Wed, 16 Oct 2024 17:12:33 +0800
Message-ID: <09a555ce0fcab9201871335652ad8d1c0e658a95.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to allow users to develop their own BPF-based path manager,
this patch defines a struct ops "mptcp_pm_ops" for an userspace path
manager, which contains a set of interfaces.

Add a set of functions to register, unregister and find this struct
ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      | 32 ++++++++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 45 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  4 ++++
 3 files changed, 81 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 84d67947a517..b00ad7665d71 100644
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
@@ -118,6 +120,36 @@ struct mptcp_sched_ops {
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
index e5dfa1a6db31..3cc8bf26ffb0 100644
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
@@ -635,3 +640,43 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
+{
+	if (!pm->address_announce && !pm->address_remove &&
+	    !pm->subflow_create && !pm->subflow_destroy &&
+	    !pm->get_local_id && !pm->get_flags &&
+	    !pm->get_addr && !pm->dump_addr && !pm->set_flags)
+		return -EINVAL;
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
index b1669c36a3a8..5b21d1f1ba16 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1052,6 +1052,10 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
+int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
+void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- 
2.43.0

