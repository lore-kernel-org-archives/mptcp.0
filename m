Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40492B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925379; cv=none; b=rrhraz3rNxykRof+/gPy2DQHBilbqtFTHsaB71wQayAcuFxxLVee4DMYJsmMUBECLYcD4TdHdfuSC2bPRNOMwcSqNPonLukklk4x63loeYCVjTUuVEM1yGpjCUl/5MhihsR0upK4pS50WV68SwR4aRznd91bAEa8G5R4lYV3j3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925379; c=relaxed/simple;
	bh=LWVquMCImtYFMCEXSDHJPCOgZQAcQQbXkcbEPXFPJqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPuZxLjtk1iZENZvqG+YP8E5dq6yW2jQ9dQQblSAda0EWYRG5Sn7Jxa6ufV6lWyFkVq0XV2HcoGVdX1U4vo0oeXHH2E68KapNviGZ1KIel4WD2VmuLcSiJRlo0ZKYh7ATPxveKMY/3pZ46pwJIzxSPgbsQMBK4OZOo+n8A3jH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnpvh5zU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnpvh5zU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E332C4CED1;
	Fri,  7 Feb 2025 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925378;
	bh=LWVquMCImtYFMCEXSDHJPCOgZQAcQQbXkcbEPXFPJqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dnpvh5zUEoigLX/xJKERy928bo4i98mVZYIY48hwnYbyEWlKQagaapInczaPTJr1S
	 EK778KmjX+nPDB+yEPlVJU6S0/EJ9RPX5xeHN2ZuReq0k47EJSOL9HKyQabZHv6U2u
	 r8v6Ox7Bee2xbPDdkvvboLssm+2veKUrDzLRuBgkPrqqxL/3S5Mu84Edmsslpt/f9+
	 FuDKDNOW1a1kXHdkMHEusWQmqTxIsn0fYeVevgnbkU9VqEnzYJtDPEUu0i0hWHGDmA
	 AxohgQeA3w1rCwrCPxwkDUf9eE1t/IPwrkU6BDhBKxB8JA1l+d/efN6+mPI1tEFnuc
	 Ea7bRcVcL0ymQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/5] bpf: Register mptcp struct_ops kfunc set
Date: Fri,  7 Feb 2025 18:49:25 +0800
Message-ID: <632c93b22ec0ec39fd65c4ca9f6cea359e8d885f.1738924875.git.tanggeliang@kylinos.cn>
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

This patch exports mptcp path manager helpers into BPF, adds these
kfunc names into struct_ops kfunc_set and register this set with
BPF_PROG_TYPE_STRUCT_OPS type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2676d6c64908..1f963c860f2e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -15,6 +15,7 @@
 #include <linux/btf_ids.h>
 #include <net/bpf_sk_storage.h>
 #include "protocol.h"
+#include "mib.h"
 
 #ifdef CONFIG_BPF_JIT
 static struct bpf_struct_ops bpf_mptcp_pm_ops;
@@ -521,6 +522,15 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 	return NULL;
 }
 
+__bpf_kfunc static struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	if (!subflow)
+		return NULL;
+
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
 __bpf_kfunc static int
 bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 			   struct mptcp_sock *msk)
@@ -644,6 +654,71 @@ __bpf_kfunc static bool bpf_ipv4_is_private_10(__be32 addr)
 	return ipv4_is_private_10(addr);
 }
 
+__bpf_kfunc static void bpf_list_add_tail_rcu(struct list_head *new,
+					      struct list_head *head)
+{
+	list_add_tail_rcu(new, head);
+}
+
+__bpf_kfunc static void bpf_list_del_rcu(struct list_head *entry)
+{
+	list_del_rcu(entry);
+}
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_sock_kmalloc_entry(struct sock *sk, int size, gfp_t priority)
+{
+	return sock_kmalloc(sk, size, priority);
+}
+
+__bpf_kfunc static void
+bpf_sock_kfree_entry(struct sock *sk, struct mptcp_pm_addr_entry *entry,
+		     int size)
+{
+	sock_kfree_s(sk, entry, size);
+}
+
+__bpf_kfunc static void bpf_bitmap_zero(unsigned long *dst__ign, unsigned int nbits)
+{
+	bitmap_zero(dst__ign, nbits);
+}
+
+__bpf_kfunc static void bpf_set_bit(unsigned long nr, unsigned long *addr__ign)
+{
+	__set_bit(nr, addr__ign);
+}
+
+__bpf_kfunc static __u8 bpf_find_next_zero_bit(const unsigned long *addr__ign,
+					       unsigned long size, unsigned long offset)
+{
+	return find_next_zero_bit(addr__ign, size, offset);
+}
+
+__bpf_kfunc static int
+bpf_mptcp_subflow_connect(struct sock *sk,
+			  const struct mptcp_pm_addr_entry *entry,
+			  const struct mptcp_addr_info *remote)
+{
+	struct mptcp_pm_local local;
+
+	local.addr = entry->addr;
+	local.flags = entry->flags;
+	local.ifindex = entry->ifindex;
+
+	return __mptcp_subflow_connect(sk, &local, remote);
+}
+
+__bpf_kfunc static struct net *bpf_sock_net(const struct sock *sk)
+{
+	return sock_net(sk);
+}
+
+__bpf_kfunc static void BPF_MPTCP_INC_STATS(struct net *net,
+					    enum linux_mptcp_mib_field field)
+{
+	MPTCP_INC_STATS(net, field);
+}
+
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -653,6 +728,7 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
@@ -662,6 +738,24 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_spin_lock_bh)
 BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
 BTF_ID_FLAGS(func, bpf_ipv4_is_private_10)
+BTF_ID_FLAGS(func, bpf_list_add_tail_rcu)
+BTF_ID_FLAGS(func, bpf_list_del_rcu)
+BTF_ID_FLAGS(func, bpf_sock_kmalloc_entry)
+BTF_ID_FLAGS(func, bpf_sock_kfree_entry)
+BTF_ID_FLAGS(func, mptcp_pm_alloc_anno_list)
+BTF_ID_FLAGS(func, mptcp_pm_announce_addr)
+BTF_ID_FLAGS(func, mptcp_pm_nl_addr_send_ack, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_bitmap_zero)
+BTF_ID_FLAGS(func, bpf_set_bit)
+BTF_ID_FLAGS(func, bpf_find_next_zero_bit)
+BTF_ID_FLAGS(func, mptcp_pm_remove_addr)
+BTF_ID_FLAGS(func, mptcp_pm_remove_addr_entry, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, mptcp_subflow_shutdown, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, mptcp_close_ssk, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_sock_net)
+BTF_ID_FLAGS(func, BPF_MPTCP_INC_STATS)
+BTF_ID_FLAGS(func, mptcp_pm_nl_mp_prio_send_ack, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
@@ -694,6 +788,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

