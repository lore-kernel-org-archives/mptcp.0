Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34742195FD5
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588551; cv=none; b=Puvi5v3I4/L65CzDqx0llQ7mvsuvjrL9fYcwt+bX6vFBFVXja/YFYq3Q4Txbk3SvNZItnqpo4ZpY80x1q8XJo+1CJihwgmMpVyYRXm1A7mzZMpMu2/sBxGU/QplZYcFy67IBmdZ4+vs6nh5EV5g8tBacQq7rf87jpL8ai4Y3ILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588551; c=relaxed/simple;
	bh=+G7u5i3oyTvmm3RrFJYhexnPs1uFQZO03dOfTElsGIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1kDyu8bQonIb/Uz8syJw9G2/mwkFXorWrCy5mAaK5CxDsyrxzfjEyWyCeWzL4olcZZNr718PgkS64ZmTW5CEYLrGRGW8iqlkfUf+qhn4bc+QP3hw2H5XSh8X9x0Z8CgRPsi9xf5RK7VICTkkn2m27+qDWl/o63EP2diXymyYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u16RZrCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u16RZrCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1CC4CEC3;
	Tue, 22 Oct 2024 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588551;
	bh=+G7u5i3oyTvmm3RrFJYhexnPs1uFQZO03dOfTElsGIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u16RZrCpteZKNcS8Mcjb4I285AnE9Yw5MKh/gBfwd3hm9vbkCwifNTQswurg7pxJl
	 U/CENfmIvwajzYthA6s3fbFcNkS4Fux7N+xtx2SeP8x+GqSXJ3iMRAi+taS4Rp7c3L
	 v8++wM6QfnCO3vB8AlHv/dHVF3xb4llXBw3yXXCsWrjR17r3bI9l3tSjYBGabVYLWV
	 dxKFMaa3fQ1cs++gvT/U9sgpZuQq32ova/kEyqEm678CJKeT2IRrrlOGN/+OsuSbvo
	 06orOtc2WlOETOh3MNS9eOKrOoSLQuzRwd8Mo7xvi2yQrTLbc2edRVrMAIXHkuc7XZ
	 qMBp52HikP/6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 36/36] selftests/bpf: Add mptcp bpf path manager subtest
Date: Tue, 22 Oct 2024 17:14:44 +0800
Message-ID: <8f1235fb4cc810baaab31ad239828717c64b442a.1729588019.git.tanggeliang@kylinos.cn>
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

This patch adds an mptcp bpf userspace pm example program, implements
address_announce, address_remove, subflow_create, subflow_destroy,
get_local_id, get_flags, get_addr, dump_addr and set_flags interfaces
using almost the same logic as the userspace pm in kernel.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  61 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  71 +++
 .../bpf/progs/mptcp_bpf_userspace_pm.c        | 409 ++++++++++++++++++
 4 files changed, 542 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..278d62c4a16b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -58,6 +58,7 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_MPTCP_IPV6=y
 CONFIG_NET_ACT_SKBMOD=y
 CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 2e8f4e458430..45d6448c2235 100644
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
+	MPTCP_PM_TYPE_BPF,
 
 	__MPTCP_PM_TYPE_NR,
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
@@ -1039,6 +1041,63 @@ static void test_userspace_pm(void)
 	cleanup_netns(nstoken);
 }
 
+static void test_bpf_pm(void)
+{
+	struct mptcp_bpf_userspace_pm *skel;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+	int err;
+
+	skel = mptcp_bpf_userspace_pm__open();
+	if (!ASSERT_OK_PTR(skel, "open: userspace_pm"))
+		return;
+
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.mptcp_pm_address_announce,
+		BPF_F_SLEEPABLE), "set pm_address_announce sleepable"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.mptcp_pm_address_remove,
+		BPF_F_SLEEPABLE), "set pm_address_remove sleepable"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.mptcp_pm_subflow_create,
+		BPF_F_SLEEPABLE), "set pm_subflow_create sleepable"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.mptcp_pm_subflow_destroy,
+		BPF_F_SLEEPABLE), "set pm_subflow_destroy sleepable"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.mptcp_pm_set_flags,
+		BPF_F_SLEEPABLE), "set pm_set_flags sleepable"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(mptcp_bpf_userspace_pm__load(skel), "load: userspace_pm"))
+		goto skel_destroy;
+
+	link = bpf_map__attach_struct_ops(skel->maps.userspace_pm);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto link_destroy;
+
+	err = userspace_pm_init(MPTCP_PM_TYPE_BPF);
+	if (!ASSERT_OK(err, "userspace_pm_init: bpf pm"))
+		goto close_netns;
+
+	run_userspace_pm(skel->kconfig->CONFIG_MPTCP_IPV6 ? IPV6 : IPV4);
+
+	userspace_pm_cleanup();
+close_netns:
+	cleanup_netns(nstoken);
+link_destroy:
+	bpf_link__destroy(link);
+skel_destroy:
+	mptcp_bpf_userspace_pm__destroy(skel);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -1226,6 +1285,8 @@ void test_mptcp(void)
 		test_iters_address();
 	if (test__start_subtest("userspace_pm"))
 		test_userspace_pm();
+	if (test__start_subtest("bpf_pm"))
+		test_bpf_pm();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 52bc8ac03508..a8c1d679942a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -2,11 +2,30 @@
 #ifndef __MPTCP_BPF_H__
 #define __MPTCP_BPF_H__
 
+#include <string.h>
 #include "bpf_experimental.h"
 
 /* mptcp helpers from include/net/mptcp.h */
 #define MPTCP_SUBFLOWS_MAX 8
 
+extern bool CONFIG_MPTCP_IPV6 __kconfig __weak;
+
+#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
+
+#define AF_UNSPEC	0
+#define AF_INET		2
+#define AF_INET6	10
+
+#define RCV_SHUTDOWN	1
+#define SEND_SHUTDOWN	2
+
+#define	ENOMEM		12	/* Out of Memory */
+#define	EINVAL		22	/* Invalid argument */
+
 /* list helpers from include/linux/list.h */
 static inline int list_is_head(const struct list_head *list,
 			       const struct list_head *head)
@@ -36,6 +55,9 @@ static inline int list_is_head(const struct list_head *list,
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 
+#define mptcp_for_each_address(__msk, __entry)			\
+	list_for_each_entry(__entry, &((__msk)->pm.userspace_pm_local_addr_list), list)
+
 static __always_inline struct sock *
 mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
@@ -57,6 +79,55 @@ extern void bpf_spin_unlock_bh(spinlock_t *lock) __ksym;
 
 extern bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a) __ksym;
 
+extern void bpf_list_add_tail_rcu(struct list_head *new,
+				  struct list_head *head) __ksym;
+extern void bpf_list_del_rcu(struct list_head *entry) __ksym;
+
+extern struct mptcp_pm_addr_entry *
+bpf_pm_alloc_entry(struct sock *sk, struct mptcp_pm_addr_entry *entry) __ksym;
+extern void bpf_pm_free_entry(struct sock *sk,
+			      struct mptcp_pm_addr_entry *entry) __ksym;
+
+extern bool bpf_mptcp_addresses_equal(const struct mptcp_addr_info *a,
+				      const struct mptcp_addr_info *b, bool use_port) __ksym;
+extern bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr) __ksym;
+extern int mptcp_pm_announce_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr,
+				  bool echo) __ksym;
+extern void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk) __ksym;
+
+extern void bpf_bitmap_zero(struct mptcp_id_bitmap *bitmap) __ksym;
+extern bool bpf_test_bit(u8 nr, struct mptcp_id_bitmap *bitmap) __ksym;
+extern void bpf_set_bit(u8 nr, struct mptcp_id_bitmap *bitmap) __ksym;
+extern u8 bpf_next_bit(struct mptcp_id_bitmap *bitmap) __ksym;
+
+extern int mptcp_pm_remove_addr(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list) __ksym;
+extern void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *entry) __ksym;
+
+extern bool bpf_mptcp_pm_addr_families_match(const struct sock *sk,
+					     const struct mptcp_addr_info *loc,
+					     const struct mptcp_addr_info *rem) __ksym;
+extern int __mptcp_subflow_connect(struct sock *sk,
+				   const struct mptcp_pm_addr_entry *local,
+				   const struct mptcp_addr_info *remote) __ksym;
+
+extern struct ipv6_pinfo *bpf_inet6_sk(const struct sock *sk) __ksym;
+extern bool bpf_ipv6_addr_equal(const struct mptcp_addr_info *a1,
+				const struct in6_addr *a2) __ksym;
+extern void bpf_ipv6_addr_set_v4mapped(const __be32 addr,
+				       struct mptcp_addr_info *v4mapped) __ksym;
+extern void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how) __ksym;
+extern void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+			    struct mptcp_subflow_context *subflow) __ksym;
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
index 000000000000..9aedbafe9b7c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_init, struct mptcp_sock *msk)
+{
+	bpf_printk("BPF userspace PM (%s)",
+		   CONFIG_MPTCP_IPV6 ? "IPv6" : "IPv4");
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_release, struct mptcp_sock *msk)
+{
+}
+
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
+{
+	struct mptcp_pm_addr_entry *match = NULL;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_id_bitmap id_bitmap;
+	struct mptcp_pm_addr_entry *e;
+	bool addr_match = false;
+	bool id_match = false;
+	int ret = -EINVAL;
+
+	bpf_bitmap_zero(&id_bitmap);
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	bpf_for_each(mptcp_address, e, msk) {
+		addr_match = bpf_mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		if (addr_match && entry->addr.id == 0 && needs_id)
+			entry->addr.id = e->addr.id;
+		id_match = (e->addr.id == entry->addr.id);
+		if (addr_match && id_match) {
+			match = e;
+			break;
+		} else if (addr_match || id_match) {
+			break;
+		}
+		bpf_set_bit(e->addr.id, &id_bitmap);
+	}
+
+	if (!match && !addr_match && !id_match) {
+		/* Memory for the entry is allocated from the
+		 * sock option buffer.
+		 */
+		e = bpf_pm_alloc_entry(sk, entry);
+		if (!e) {
+			ret = -ENOMEM;
+			goto append_err;
+		}
+
+		if (!entry->addr.id && needs_id)
+			entry->addr.id = bpf_next_bit(&id_bitmap);
+		bpf_list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
+		msk->pm.local_addr_used++;
+		ret = e->addr.id;
+	} else if (match) {
+		ret = entry->addr.id;
+	}
+
+append_err:
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_address_announce, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local)
+{
+	int err;
+
+	if (local->addr.id == 0 || !(local->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		return -EINVAL;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
+static int mptcp_pm_remove_id_zero_address(struct mptcp_sock *msk)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	bool has_id_0 = false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		subflow = bpf_core_cast(subflow, struct mptcp_subflow_context);
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0)
+		return -EINVAL;
+
+	list.ids[list.nr++] = 0;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
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
+	bpf_for_each(mptcp_address, entry, msk) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_address_remove, struct mptcp_sock *msk, u8 id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+
+	if (id == 0)
+		return mptcp_pm_remove_id_zero_address(msk);
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	if (!entry)
+		return -EINVAL;
+
+	mptcp_pm_remove_addr_entry(msk, entry);
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	bpf_list_del_rcu(&entry->list);
+	bpf_pm_free_entry(sk, entry);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk, const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_for_each(mptcp_address, entry, msk) {
+		if (bpf_mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+	return NULL;
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
+	bpf_pm_free_entry(sk, entry);
+	msk->pm.local_addr_used--;
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_subflow_create, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	int err = -EINVAL;
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+		return err;
+	local->flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+
+	if (!bpf_mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		return err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	err = __mptcp_subflow_connect(sk, local, remote);
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
+static struct sock *mptcp_pm_find_ssk(struct mptcp_sock *msk,
+				      const struct mptcp_addr_info *local,
+				      const struct mptcp_addr_info *remote)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (local->family != remote->family)
+		return NULL;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		const struct inet_sock *issk;
+		struct sock *ssk;
+
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+
+		if (local->family != ssk->sk_family)
+			continue;
+
+		issk = bpf_core_cast(ssk, struct inet_sock);
+
+		switch (ssk->sk_family) {
+		case AF_INET:
+			if (issk->inet_saddr != local->addr.s_addr ||
+			    issk->inet_daddr != remote->addr.s_addr)
+				continue;
+			break;
+		case AF_INET6: {
+			const struct ipv6_pinfo *pinfo = bpf_inet6_sk(ssk);
+
+			if (!bpf_ipv6_addr_equal(local, &pinfo->saddr) ||
+			    !bpf_ipv6_addr_equal(remote, &ssk->sk_v6_daddr))
+				continue;
+			break;
+		}
+		default:
+			continue;
+		}
+
+		if (issk->inet_sport == local->port &&
+		    issk->inet_dport == remote->port)
+			return ssk;
+	}
+
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_subflow_destroy, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	int err = -EINVAL;
+	struct sock *ssk;
+
+	if (local->addr.family == AF_INET && bpf_ipv6_addr_v4mapped(remote)) {
+		bpf_ipv6_addr_set_v4mapped(local->addr.addr.s_addr, remote);
+		local->addr.family = AF_INET6;
+	}
+	if (remote->family == AF_INET && bpf_ipv6_addr_v4mapped(&local->addr)) {
+		bpf_ipv6_addr_set_v4mapped(remote->addr.s_addr, &local->addr);
+		remote->family = AF_INET6;
+	}
+
+	if (local->addr.family != remote->family)
+		return err;
+
+	if (!local->addr.port || !remote->port)
+		return err;
+
+	ssk = mptcp_pm_find_ssk(msk, &local->addr, remote);
+	if (ssk) {
+		struct mptcp_subflow_context *subflow = bpf_mptcp_subflow_ctx(ssk);
+
+		bpf_spin_lock_bh(&msk->pm.lock);
+		err = mptcp_userspace_pm_delete_local_addr(msk, local);
+		bpf_spin_unlock_bh(&msk->pm.lock);
+		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+		mptcp_close_ssk(sk, ssk, subflow);
+	}
+
+	return err;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_get_local_id, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local)
+{
+	const struct inet_sock *issk = bpf_core_cast((struct sock *)msk,
+						     struct inet_sock);
+	__be16 msk_sport = issk->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
+	if (local->addr.port == msk_sport)
+		local->addr.port = 0;
+
+	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
+}
+
+SEC("struct_ops")
+u8 BPF_PROG(mptcp_pm_get_flags, struct mptcp_sock *msk,
+	    struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 flags = 0;
+
+	bpf_spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	if (entry)
+		flags = entry->flags;
+	bpf_spin_unlock_bh(&msk->pm.lock);
+
+	return flags;
+}
+
+SEC("struct_ops")
+struct mptcp_pm_addr_entry *
+BPF_PROG(mptcp_pm_get_addr, struct mptcp_sock *msk, u8 id)
+{
+	return mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+}
+
+static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
+					 struct mptcp_id_bitmap *bitmap)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	mptcp_for_each_address(msk, entry) {
+		entry = bpf_core_cast(entry, struct mptcp_pm_addr_entry);
+
+		if (bpf_test_bit(entry->addr.id, bitmap))
+			continue;
+
+		bpf_set_bit(entry->addr.id, bitmap);
+	}
+
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_dump_addr, struct mptcp_sock *msk,
+	     struct mptcp_id_bitmap *bitmap)
+{
+	return mptcp_userspace_pm_set_bitmap(msk, bitmap);
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_set_flags, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 bkup = 0;
+
+	if (local->addr.family == AF_UNSPEC ||
+	    remote->family == AF_UNSPEC)
+		return -EINVAL;
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
+	.address_announce	= (void *)mptcp_pm_address_announce,
+	.address_remove		= (void *)mptcp_pm_address_remove,
+	.subflow_create		= (void *)mptcp_pm_subflow_create,
+	.subflow_destroy	= (void *)mptcp_pm_subflow_destroy,
+	.get_local_id		= (void *)mptcp_pm_get_local_id,
+	.get_flags		= (void *)mptcp_pm_get_flags,
+	.get_addr		= (void *)mptcp_pm_get_addr,
+	.dump_addr		= (void *)mptcp_pm_dump_addr,
+	.set_flags		= (void *)mptcp_pm_set_flags,
+	.init			= (void *)mptcp_pm_init,
+	.release		= (void *)mptcp_pm_release,
+	.type			= MPTCP_PM_TYPE_BPF,
+};
-- 
2.45.2

