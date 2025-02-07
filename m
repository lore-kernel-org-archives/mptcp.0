Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B82B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925383; cv=none; b=pridJqObyZyxeGJ49NcWWV8nMiNrgEedfUAyXlvuN6AqaD6v2xenQsKwZwHJx1kPAVKW4ThbmaXX6uE1++FbS0C8FxVoHB8e14gnkNDC2nYzyFqaWt+KEMev7qRdvJli2pI1xhr6/lG0iec9OkuFhqlNMCNED/wq2hUAqxK7aAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925383; c=relaxed/simple;
	bh=DQNMmzSTs1myTzu7XTVfAjAyJ0+npCjHGqgATb0s+5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McO+PYJdWm1pzpc+Y8UKn4tTacplvESPx0QAjOS2v4nsQMyOMwP58uXKZMo5hPZk+5zipVkqGO/BrBS9qrLOZlMX2TRZ2B735OkhJkeFhjNvaWPp9fRyOxATwaDXqgD+K3xIvHMOR5n8bRSVe4vz00UyW6ZaqNLikkZ35h3hw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8rpPsY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8rpPsY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7456C4CED1;
	Fri,  7 Feb 2025 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925383;
	bh=DQNMmzSTs1myTzu7XTVfAjAyJ0+npCjHGqgATb0s+5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8rpPsY8B4dqEOjiJnafxBdpOA3/iqzVQMIQ4WGx8I6rCYdnY1QA2/thqic3aFd4L
	 83H5dKeP00vwBGS1LSKvG9xXU6kUjW4r9gG/POYyw7mtd+nw3TXApb+ZkEpX5ZtY2m
	 YQ0C36AvGbBK1vdE09m4ptZH5665DVT8mel6jnNo0wFp47H6AN9Ue5eto8kR3eQiAq
	 d0L7tFiT6vWhYIJqligjfGEokM2kbroHqNe5PjgIv+vaJ0tu/F2LwlMxVNpKwZ99qq
	 EGrp9S+T9OSo/R3FXkeUZEgSw9hsnvlBS8sGWeEpeEqpRu0Qgyn3c4kUyXu/dGBTHH
	 wVSBUr4jxRTdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/5] selftests/bpf: Add mptcp bpf path manager subtest
Date: Fri,  7 Feb 2025 18:49:28 +0800
Message-ID: <87f7786b26b7d0d84938db34871d82293da19e10.1738924875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924875.git.tanggeliang@kylinos.cn>
References: <cover.1738924875.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds an mptcp bpf userspace pm example program, implements
address_announce, address_remove, subflow_create, subflow_destroy,
get_local_id, is_backup, and set_flags interfaces using almost the
same logic as the userspace pm in kernel.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  51 ++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  75 +++++
 .../bpf/progs/mptcp_bpf_userspace_pm.c        | 275 ++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cbe41bb39603..bed6d2dda337 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_iters.skel.h"
+#include "mptcp_bpf_userspace_pm.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -61,6 +62,7 @@
 enum mptcp_pm_type {
 	MPTCP_PM_TYPE_KERNEL = 0,
 	MPTCP_PM_TYPE_USERSPACE,
+	MPTCP_PM_TYPE_BPF_USERSPACE,
 
 	__MPTCP_PM_TYPE_NR,
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
@@ -937,6 +939,53 @@ static void test_userspace_pm(void)
 	netns_free(netns);
 }
 
+static void test_bpf_path_manager(void)
+{
+	struct mptcp_bpf_userspace_pm *skel;
+	struct netns_obj *netns;
+	int err;
+
+	skel = mptcp_bpf_userspace_pm__open();
+	if (!ASSERT_OK_PTR(skel, "open: userspace_pm"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.mptcp_userspace_pm_address_announced,
+				     BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_userspace_pm_address_removed,
+					    BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_userspace_pm_subflow_established,
+					    BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_userspace_pm_subflow_closed,
+					    BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_userspace_pm_set_priority,
+					    BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "set sleepable flags"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(mptcp_bpf_userspace_pm__load(skel), "load: userspace_pm"))
+		goto skel_destroy;
+
+	err = mptcp_bpf_userspace_pm__attach(skel);
+	if (!ASSERT_OK(err, "attach: userspace_pm"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto skel_destroy;
+
+	err = userspace_pm_init(MPTCP_PM_TYPE_BPF_USERSPACE);
+	if (!ASSERT_OK(err, "userspace_pm_init: bpf pm"))
+		goto close_netns;
+
+	run_userspace_pm(skel->kconfig->CONFIG_MPTCP_IPV6 ? IPV6 : IPV4);
+
+	userspace_pm_cleanup();
+close_netns:
+	netns_free(netns);
+skel_destroy:
+	mptcp_bpf_userspace_pm__destroy(skel);
+}
+
 static struct netns_obj *sched_init(char *flags, char *sched)
 {
 	struct netns_obj *netns;
@@ -1134,6 +1183,8 @@ void test_mptcp(void)
 		test_iters_address();
 	if (test__start_subtest("userspace_pm"))
 		test_userspace_pm();
+	if (test__start_subtest("bpf_path_manager"))
+		test_bpf_path_manager();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 816917e59995..1abfd033b84f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -42,6 +42,41 @@ static inline int list_is_head(const struct list_head *list,
 #define	ENOMEM		12	/* Out of Memory */
 #define	EINVAL		22	/* Invalid argument */
 
+/* mptcp helpers from include/net/mptcp.h */
+#define U8_MAX		((u8)~0U)
+
+/* max value of mptcp_addr_info.id */
+#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
+
+/* mptcp macros from include/uapi/linux/mptcp.h */
+#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
+
+/* address families macros from include/linux/socket.h */
+#define AF_UNSPEC	0
+#define AF_INET		2
+#define AF_INET6	10
+
+/* shutdown macros from include/net/sock.h */
+#define RCV_SHUTDOWN	1
+#define SEND_SHUTDOWN	2
+
+/* GFP macros from include/linux/gfp_types.h */
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _UL(x)		(_AC(x, UL))
+#define UL(x)		(_UL(x))
+#define BIT(nr)		(UL(1) << (nr))
+
+#define ___GFP_HIGH		BIT(___GFP_HIGH_BIT)
+#define __GFP_HIGH		((gfp_t)___GFP_HIGH)
+#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
+#define __GFP_KSWAPD_RECLAIM	((gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
+#define GFP_ATOMIC		(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
+
 static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
@@ -62,6 +97,46 @@ extern void bpf_spin_unlock_bh(spinlock_t *lock) __ksym;
 
 extern bool bpf_ipv4_is_private_10(__be32 addr) __ksym;
 
+extern struct mptcp_pm_addr_entry *
+bpf_sock_kmalloc_entry(struct sock *sk, int size, gfp_t priority) __ksym;
+extern void
+bpf_sock_kfree_entry(struct sock *sk, struct mptcp_pm_addr_entry *entry,
+		     int size) __ksym;
+
+extern bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr) __ksym;
+extern int mptcp_pm_announce_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr,
+				  bool echo) __ksym;
+extern void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk) __ksym;
+
+extern void bpf_bitmap_zero(unsigned long *dst, unsigned int nbits) __ksym;
+extern void bpf_set_bit(unsigned long nr, unsigned long *addr) __ksym;
+extern u8 bpf_find_next_zero_bit(const unsigned long *addr,
+				 unsigned long size, unsigned long offset) __ksym;
+
+extern int mptcp_pm_remove_addr(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list) __ksym;
+extern void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *entry) __ksym;
+
+extern int bpf_mptcp_subflow_connect(struct sock *sk,
+				     const struct mptcp_pm_addr_entry *entry,
+				     const struct mptcp_addr_info *remote) __ksym;
+
+extern void
+mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how) __ksym;
+extern void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+			    struct mptcp_subflow_context *subflow) __ksym;
+extern struct net *bpf_sock_net(const struct sock *sk) __ksym;
+extern void BPF_MPTCP_INC_STATS(struct net *net,
+				enum linux_mptcp_mib_field field) __ksym;
+
+extern int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+					struct mptcp_addr_info *addr,
+					struct mptcp_addr_info *rem,
+					u8 bkup) __ksym;
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
new file mode 100644
index 000000000000..477d467a5ece
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Kylin Software */
+
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern bool CONFIG_MPTCP_IPV6 __kconfig __weak;
+
+extern void bpf_list_add_tail_rcu(struct list_head *new,
+				  struct list_head *head) __ksym;
+extern void bpf_list_del_rcu(struct list_head *entry) __ksym;
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_userspace_pm_init, struct mptcp_sock *msk)
+{
+	bpf_printk("BPF userspace PM (%s)",
+		   CONFIG_MPTCP_IPV6 ? "IPv6" : "IPv4");
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_userspace_pm_release, struct mptcp_sock *msk)
+{
+}
+
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_for_each(mptcp_userspace_pm_addr, entry, (struct sock *)msk) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+	return NULL;
+}
+
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
+{
+	struct sock *sk = (struct sock *)msk;
+	unsigned long id_bitmap[4] = { 0 };
+	struct mptcp_pm_addr_entry *e;
+	bool addr_match = false;
+	bool id_match = false;
+	int ret = -EINVAL;
+
+	bpf_bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	bpf_for_each(mptcp_userspace_pm_addr, e, sk) {
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		if (addr_match && entry->addr.id == 0 && needs_id)
+			entry->addr.id = e->addr.id;
+		id_match = (e->addr.id == entry->addr.id);
+		if (addr_match || id_match)
+			break;
+		bpf_set_bit(e->addr.id, id_bitmap);
+	}
+
+	if (!addr_match && !id_match) {
+		/* Memory for the entry is allocated from the
+		 * sock option buffer.
+		 */
+		e = bpf_sock_kmalloc_entry(sk, sizeof(*e), GFP_ATOMIC);
+		if (!e) {
+			ret = -ENOMEM;
+			goto append_err;
+		}
+
+		mptcp_pm_copy_entry(e, entry);
+		if (!e->addr.id && needs_id)
+			e->addr.id = bpf_find_next_zero_bit(id_bitmap,
+							    MPTCP_PM_MAX_ADDR_ID + 1,
+							    1);
+		bpf_list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
+		msk->pm.local_addr_used++;
+		ret = e->addr.id;
+	} else if (addr_match && id_match) {
+		ret = entry->addr.id;
+	}
+
+append_err:
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_address_announced, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local)
+{
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_for_each(mptcp_userspace_pm_addr, entry, (struct sock *)msk) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_address_removed, struct mptcp_sock *msk, u8 id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	if (!entry) {
+		bpf_spin_unlock_bh(&msk->pm.lock);
+		return -EINVAL;
+	}
+
+	bpf_list_del_rcu(&entry->list);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	mptcp_pm_remove_addr_entry(msk, entry);
+
+	bpf_sock_kfree_entry((struct sock *)msk, entry, sizeof(*entry));
+
+	return 0;
+}
+
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+
+	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
+
+	bpf_list_del_rcu(&entry->list);
+	bpf_sock_kfree_entry(sk, entry, sizeof(*entry));
+	msk->pm.local_addr_used--;
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_subflow_established, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	err = bpf_mptcp_subflow_connect(sk, local, remote);
+	bpf_spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, local);
+	else
+		msk->pm.subflows++;
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return err;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_subflow_closed, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct sock *ssk, *sk = (struct sock *)msk;
+	struct mptcp_subflow_context *subflow;
+
+	ssk = mptcp_pm_find_ssk(msk, &local->addr, remote);
+	if (!ssk)
+		return -ESRCH;
+
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (!subflow)
+		return -EINVAL;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, local);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, subflow);
+	BPF_MPTCP_INC_STATS(bpf_sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_get_local_id, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
+	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
+}
+
+SEC("struct_ops")
+bool BPF_PROG(mptcp_userspace_pm_get_priority, struct mptcp_sock *msk,
+	      struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return backup;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_userspace_pm_set_priority, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 bkup = 0;
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	}
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, remote, bkup);
+}
+
+SEC(".struct_ops.link")
+struct mptcp_pm_ops userspace_pm = {
+	.address_announced	= (void *)mptcp_userspace_pm_address_announced,
+	.address_removed	= (void *)mptcp_userspace_pm_address_removed,
+	.subflow_established	= (void *)mptcp_userspace_pm_subflow_established,
+	.subflow_closed		= (void *)mptcp_userspace_pm_subflow_closed,
+	.get_local_id		= (void *)mptcp_userspace_pm_get_local_id,
+	.get_priority		= (void *)mptcp_userspace_pm_get_priority,
+	.set_priority		= (void *)mptcp_userspace_pm_set_priority,
+	.init			= (void *)mptcp_userspace_pm_init,
+	.release		= (void *)mptcp_userspace_pm_release,
+	.type			= MPTCP_PM_TYPE_BPF_USERSPACE,
+};
-- 
2.43.0

