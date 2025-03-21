Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17C4C85
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521772; cv=none; b=i9KXnmqMUeUpLW7VMacOSMtvh0dbJNW+2htfFbAvi+J9rgE9jCLcTJfuo4oJV223nswEwsRaBCo7vYXdzK9ykCf2Qn9wtLF5IWUTfhFRy2yipQF7wMXPemqFgCroIGSo8DcAHRwkEmKmjwe5PTBfzRgOU7Ql45HDsnE33Ju+mKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521772; c=relaxed/simple;
	bh=EFee2ntjFGH7YMVUwIWXGED6yPXrojIfOdVJvpyDtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTB9NnZNVf+jLv8QK/iEQae9ZPX5k9ZHJlq3phmM+TLGFW1vEvj5I/OmyZ3ApnmGgB/OaslPbaWhb0ly/zxWwt+06pr/nWDi1wWSRn0MECDmNFVqn52T6+r/0LH6cepG7ZExCOO03D+4PPHkPRhoKw1Ohis/ZD7kFhM4i+uWM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMgE5IWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMgE5IWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2D9C4CEDD;
	Fri, 21 Mar 2025 01:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521771;
	bh=EFee2ntjFGH7YMVUwIWXGED6yPXrojIfOdVJvpyDtZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMgE5IWzSBqro1x5UA8KuKXBZKBp+MDyFtiJuy8hV6YzU+CSlnNDReF1bhP+EAOBL
	 jmyw3Bh2goso+cXoErcfS+n0A1sWzel6YsvRJMfo1a8afWb1a85knzJ/rN3fFli/EB
	 qbyo0YtnO/Ff2A5cbcyfUT212+XGVxas4Y73NgAIcqRMKsSZwZHXPuZov5h0+z9pC9
	 RbSjpmuc2bANzzNAChfofj31yHJkeXqFgY9IFD5HXHrzHItXh6tcv/SHc60vnzstnn
	 /aE3s5QJ0pyv5UwEOCyDM1kCEdBRUIJZN+xPcm4jlEUVnDCK23KV8VdoxyFDpsYir1
	 joDtlSsJRYbPQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/4] selftests/bpf: Add mptcp bpf_netlink pm subtest
Date: Fri, 21 Mar 2025 09:49:18 +0800
Message-ID: <1360ae99ba7d866451098b9465037e62e601ca13.1742521587.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521587.git.tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds an mptcp bpf netlink pm example program, implements
all interfaces of struct mptcp_pm_ops using almost the same logic as
the netlink pm in kernel.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  48 +++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  27 +++
 .../bpf/progs/mptcp_bpf_netlink_pm.c          | 204 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_pm.h        |  52 +++++
 4 files changed, 331 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_netlink_pm.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_pm.h

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 5303cbf38a44..c0bc4cfb24d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_iters.skel.h"
+#include "mptcp_bpf_netlink_pm.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -796,6 +797,51 @@ static void test_netlink_pm(void)
 	netns_free(netns);
 }
 
+static void test_bpf_netlink_pm(void)
+{
+	struct mptcp_bpf_netlink_pm *skel;
+	struct netns_obj *netns;
+	struct bpf_link *link;
+	int err;
+
+	skel = mptcp_bpf_netlink_pm__open();
+	if (!ASSERT_OK_PTR(skel, "open: bpf_netlink pm"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.mptcp_pm_netlink_established,
+				     BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_pm_netlink_subflow_established,
+					    BPF_F_SLEEPABLE);
+	err = err ?: bpf_program__set_flags(skel->progs.mptcp_pm_netlink_rm_addr_received,
+					    BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "set sleepable flags"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(mptcp_bpf_netlink_pm__load(skel), "load: bpf_netlink pm"))
+		goto skel_destroy;
+
+	link = bpf_map__attach_struct_ops(skel->maps.bpf_netlink);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops: bpf_netlink pm"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto link_destroy;
+
+	err = pm_init("bpf_netlink");
+	if (!ASSERT_OK(err, "pm_init: bpf_netlink pm"))
+		goto close_netns;
+
+	run_netlink_pm(skel->kconfig->CONFIG_MPTCP_IPV6 ? IPV6 : IPV4);
+
+close_netns:
+	netns_free(netns);
+link_destroy:
+	bpf_link__destroy(link);
+skel_destroy:
+	mptcp_bpf_netlink_pm__destroy(skel);
+}
+
 static int sched_init(char *flags, char *sched)
 {
 	if (endpoint_init(flags, 2) < 0)
@@ -992,6 +1038,8 @@ void test_mptcp(void)
 		test_iters_subflow();
 	if (test__start_subtest("netlink_pm"))
 		test_netlink_pm();
+	if (test__start_subtest("bpf_netlink_pm"))
+		test_bpf_netlink_pm();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 4e901941d5dd..0d5cf8426bc5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -4,6 +4,9 @@
 
 #include "bpf_experimental.h"
 
+#define READ_ONCE(x)  (*(const volatile typeof(x) *)&(x))
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+
 /* list helpers from include/linux/list.h */
 static inline int list_is_head(const struct list_head *list,
 			       const struct list_head *head)
@@ -33,6 +36,24 @@ static inline int list_is_head(const struct list_head *list,
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 
+/* errno macros from include/uapi/asm-generic/errno-base.h */
+#define	ESRCH		3	/* No such process */
+#define	ENOMEM		12	/* Out of Memory */
+#define	EINVAL		22	/* Invalid argument */
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
@@ -40,6 +61,12 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+extern void bpf_spin_lock_bh(spinlock_t *lock) __ksym;
+extern void bpf_spin_unlock_bh(spinlock_t *lock) __ksym;
+
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_netlink_pm.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_netlink_pm.c
new file mode 100644
index 000000000000..9a9a396bdf94
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_netlink_pm.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Kylin Software */
+
+#include "mptcp_bpf.h"
+#include "mptcp_bpf_pm.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern bool CONFIG_MPTCP_IPV6 __kconfig __weak;
+
+extern unsigned int
+mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk) __ksym;
+extern unsigned int
+mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk) __ksym;
+extern unsigned int
+mptcp_pm_get_subflows_max(const struct mptcp_sock *msk) __ksym;
+extern unsigned int
+mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk) __ksym;
+extern void bpf_bitmap_fill(unsigned long *dst__ign, unsigned int nbits) __ksym;
+
+extern bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+					 const struct mptcp_addr_info *remote) __ksym;
+extern bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk) __ksym;
+extern void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk) __ksym;
+extern void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk) __ksym;
+extern int mptcp_pm_nl_append_new_local_addr_msk(struct mptcp_sock *msk,
+						 struct mptcp_pm_addr_entry *entry,
+						 bool needs_id, bool replace) __ksym;
+extern struct mptcp_pm_addr_entry *
+mptcp_pm_nl_lookup_addr(struct mptcp_sock *msk,
+			const struct mptcp_addr_info *info) __ksym;
+
+extern struct mptcp_pm_addr_entry *
+bpf_kmemdup_entry(struct mptcp_pm_addr_entry *entry,
+		  int size, gfp_t priority) __ksym;
+extern void
+bpf_kfree_entry(struct mptcp_pm_addr_entry *entry) __ksym;
+
+static void mptcp_pm_copy_addr(struct mptcp_addr_info *dst,
+			       const struct mptcp_addr_info *src)
+{
+	dst->id = src->id;
+	dst->family = src->family;
+	dst->port = src->port;
+
+	if (src->family == AF_INET) {
+		dst->addr.s_addr = src->addr.s_addr;
+	} else if (src->family == AF_INET6) {
+		dst->addr6.s6_addr32[0] = src->addr6.s6_addr32[0];
+		dst->addr6.s6_addr32[1] = src->addr6.s6_addr32[1];
+		dst->addr6.s6_addr32[2] = src->addr6.s6_addr32[2];
+		dst->addr6.s6_addr32[3] = src->addr6.s6_addr32[3];
+	}
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_netlink_get_local_id, struct mptcp_sock *msk,
+	     struct mptcp_pm_addr_entry *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	int ret;
+
+	bpf_rcu_read_lock();
+	entry = mptcp_pm_nl_lookup_addr(msk, &skc->addr);
+	ret = entry ? entry->addr.id : -1;
+	bpf_rcu_read_unlock();
+	if (ret >= 0)
+		return ret;
+
+	entry = bpf_kmemdup_entry(skc, sizeof(*skc), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->addr.port = 0;
+	ret = mptcp_pm_nl_append_new_local_addr_msk(msk, entry, true, false);
+	if (ret < 0)
+		bpf_kfree_entry(entry);
+
+	return 0;
+}
+
+SEC("struct_ops")
+bool BPF_PROG(mptcp_pm_netlink_get_priority, struct mptcp_sock *msk,
+	      struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup;
+
+	bpf_rcu_read_lock();
+	entry = mptcp_pm_nl_lookup_addr(msk, skc);
+	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	bpf_rcu_read_unlock();
+
+	return backup;
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_netlink_established, struct mptcp_sock *msk)
+{
+	bpf_spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_netlink_subflow_established, struct mptcp_sock *msk)
+{
+	bpf_spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+	bpf_spin_unlock_bh(&msk->pm.lock);
+}
+
+SEC("struct_ops")
+bool BPF_PROG(mptcp_pm_netlink_allow_new_subflow, struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+	unsigned int subflows_max;
+	int ret = 0;
+
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	/* try to avoid acquiring the lock below */
+	if (!READ_ONCE(pm->accept_subflow))
+		return false;
+
+	bpf_spin_lock_bh(&pm->lock);
+	if (READ_ONCE(pm->accept_subflow)) {
+		ret = pm->subflows < subflows_max;
+		if (ret && ++pm->subflows == subflows_max)
+			WRITE_ONCE(pm->accept_subflow, false);
+	}
+	bpf_spin_unlock_bh(&pm->lock);
+
+	return ret;
+}
+
+SEC("struct_ops")
+bool BPF_PROG(mptcp_pm_netlink_accept_new_subflow, const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.accept_subflow);
+}
+
+SEC("struct_ops")
+bool BPF_PROG(mptcp_pm_netlink_add_addr_echo, struct mptcp_sock *msk,
+	      const struct mptcp_addr_info *addr)
+{
+	return (addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
+	       (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr));
+}
+
+SEC("struct_ops")
+int BPF_PROG(mptcp_pm_netlink_add_addr_received, struct mptcp_sock *msk,
+	     const struct mptcp_addr_info *addr)
+{
+	int ret = 0;
+
+	if (mptcp_pm_add_addr_recv(msk))
+		mptcp_pm_copy_addr(&msk->pm.remote, addr);
+	else
+		ret = -EINVAL;
+	return ret;
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_netlink_rm_addr_received, struct mptcp_sock *msk)
+{
+	mptcp_pm_rm_addr_recv(msk);
+}
+
+SEC("struct_ops")
+void BPF_PROG(mptcp_pm_netlink_init, struct mptcp_sock *msk)
+{
+	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	bpf_printk("BPF netlink PM (%s)",
+		   CONFIG_MPTCP_IPV6 ? "IPv6" : "IPv4");
+
+	WRITE_ONCE(pm->work_pending,
+		   (!!mptcp_pm_get_local_addr_max(msk) &&
+		    subflows_allowed) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->accept_addr,
+		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+		   subflows_allowed);
+	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+
+	bpf_bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+}
+
+SEC(".struct_ops.link")
+struct mptcp_pm_ops bpf_netlink = {
+	.get_local_id		= (void *)mptcp_pm_netlink_get_local_id,
+	.get_priority		= (void *)mptcp_pm_netlink_get_priority,
+	.established		= (void *)mptcp_pm_netlink_established,
+	.subflow_established	= (void *)mptcp_pm_netlink_subflow_established,
+	.allow_new_subflow	= (void *)mptcp_pm_netlink_allow_new_subflow,
+	.accept_new_subflow	= (void *)mptcp_pm_netlink_accept_new_subflow,
+	.add_addr_echo		= (void *)mptcp_pm_netlink_add_addr_echo,
+	.add_addr_received	= (void *)mptcp_pm_netlink_add_addr_received,
+	.rm_addr_received	= (void *)mptcp_pm_netlink_rm_addr_received,
+	.init			= (void *)mptcp_pm_netlink_init,
+	.name			= "bpf_netlink",
+};
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_pm.h b/tools/testing/selftests/bpf/progs/mptcp_bpf_pm.h
new file mode 100644
index 000000000000..0ba21c743a13
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_pm.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __MPTCP_BPF_PM_H__
+#define __MPTCP_BPF_PM_H__
+
+#include "bpf_tracing_net.h"
+
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
+extern void bpf_set_bit(unsigned long nr, unsigned long *addr) __ksym;
+
+extern int mptcp_pm_remove_addr(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list) __ksym;
+
+#define ipv6_addr_equal(a, b)	((a).s6_addr32[0] == (b).s6_addr32[0] &&	\
+				 (a).s6_addr32[1] == (b).s6_addr32[1] &&	\
+				 (a).s6_addr32[2] == (b).s6_addr32[2] &&	\
+				 (a).s6_addr32[3] == (b).s6_addr32[3])
+
+static __always_inline bool
+mptcp_addresses_equal(const struct mptcp_addr_info *a,
+		      const struct mptcp_addr_info *b, bool use_port)
+{
+	bool addr_equals = false;
+
+	if (a->family == b->family) {
+		if (a->family == AF_INET)
+			addr_equals = a->addr.s_addr == b->addr.s_addr;
+		else
+			addr_equals = ipv6_addr_equal(a->addr6, b->addr6);
+	}
+
+	if (!addr_equals)
+		return false;
+	if (!use_port)
+		return true;
+
+	return a->port == b->port;
+}
+
+#endif
-- 
2.43.0

