Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660592B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925377; cv=none; b=rWDWnEFVN5EiXZWAlpFN70ZoIiHt5b4IVDKO9upjatIsTZnPK03ngTpfI1OOXd9RFiK3Qb5xDCX3vvWPJX1DUeAaVOE3b2drDHGFnv8XUnnKK7tQmNgThhwFTEX6DqUovNDB70IKrj8BAK6qui+ECD20OVBZKJ7HHlpZPJS/u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925377; c=relaxed/simple;
	bh=5dLVV+WaAjRc0+IkEshtURdok0xhhbHnBqAq2GUfkdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mrl79BKuWctbViFOauGF/HEqqly0DssBpRBLEROJzJYv08LQYn/O00v4Ayx53FCExvd8Jp8lu5qCYf3PlqS6z4ig0M4x6HuLQUbvdGS5B8UYNYwRUf/eL0TGBD7TKuxOGQpBVc+LV1yNKekcw6ycY9BLneBEvV9dZvuwSYnWV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA8XmgrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA8XmgrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD957C4CED6;
	Fri,  7 Feb 2025 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925376;
	bh=5dLVV+WaAjRc0+IkEshtURdok0xhhbHnBqAq2GUfkdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA8XmgrOwiwr0vBxpkJFRuBD40vuUjKQgB7ltV4Z4W5oliGfKVcOom7OaxWRUdtuM
	 AHbAJp7niRajY5YSAL+vqnB5zLnm9FxBbxUgwGtK/MepdkBMdvC30OOpbxVlDjuB5l
	 q4A5vmgKyEobgkwnkxO8/KGC89Z3Q8S7YFpolVlysLw8yKTCmou1isoIivwDtq20vf
	 3f4wDiqgEQxdMZojDPashTcO7+KWyknmwMQm0Y4ac3nUWWKtOyUuHbzr03y+G2Zk1o
	 DanZfH+B1pHs7ylsf4+ONUY4yZ0C3Qtl3zznu6DcM9gnNeH/h3HpV7wI393Ts3dDzE
	 COyKeYMPWUsvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/5] bpf: Add mptcp path manager struct_ops
Date: Fri,  7 Feb 2025 18:49:24 +0800
Message-ID: <da33eb37113073016ad5ae48d5998001c7359780.1738924875.git.tanggeliang@kylinos.cn>
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

This patch implements a new struct bpf_struct_ops for MPTCP BPF path
manager: bpf_mptcp_pm_ops. Register and unregister the bpf path manager
in .reg and .unreg.

Add write access for some fields of struct mptcp_addr_info, struct
mptcp_pm_addr_entry and struct mptcp_sock in .btf_struct_access.

This MPTCP BPF path manager implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 276 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 4854160c25df..2676d6c64908 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -17,9 +17,282 @@
 #include "protocol.h"
 
 #ifdef CONFIG_BPF_JIT
+static struct bpf_struct_ops bpf_mptcp_pm_ops;
+static u32 mptcp_sock_id,
+	   mptcp_entry_id;
+
+/* MPTCP BPF path manager */
+
+static const struct bpf_func_proto *
+bpf_mptcp_pm_get_func_proto(enum bpf_func_id func_id,
+			    const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
+static int bpf_mptcp_pm_btf_struct_access(struct bpf_verifier_log *log,
+					  const struct bpf_reg_state *reg,
+					  int off, int size)
+{
+	u32 id = reg->btf_id;
+	size_t end;
+
+	if (id == mptcp_sock_id) {
+		switch (off) {
+		case offsetof(struct mptcp_sock, pm.add_addr_signaled):
+			end = offsetofend(struct mptcp_sock, pm.add_addr_signaled);
+			break;
+		case offsetof(struct mptcp_sock, pm.local_addr_used):
+			end = offsetofend(struct mptcp_sock, pm.local_addr_used);
+			break;
+		case offsetof(struct mptcp_sock, pm.subflows):
+			end = offsetofend(struct mptcp_sock, pm.subflows);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_sock at off %d\n",
+				off);
+			return -EACCES;
+		}
+	} else if (id == mptcp_entry_id) {
+		switch (off) {
+		case offsetof(struct mptcp_pm_addr_entry, addr.id):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.id);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, addr.family):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.family);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, addr.port):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.port);
+			break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[0]):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[0]);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[1]):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[1]);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[2]):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[2]);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[3]):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.addr6.s6_addr32[3]);
+			break;
+#else
+		case offsetof(struct mptcp_pm_addr_entry, addr.addr.s_addr):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.addr.s_addr);
+			break;
+#endif
+		case offsetof(struct mptcp_pm_addr_entry, flags):
+			end = offsetofend(struct mptcp_pm_addr_entry, flags);
+			break;
+		case offsetof(struct mptcp_pm_addr_entry, ifindex):
+			end = offsetofend(struct mptcp_pm_addr_entry, ifindex);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_pm_addr_entry at off %d\n",
+				off);
+			return -EACCES;
+		}
+	} else {
+		bpf_log(log, "only access to mptcp sock or addr or entry is supported\n");
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond %s at off %u size %u ended at %zu",
+			id == mptcp_sock_id ? "mptcp_sock" :
+			(id == mptcp_entry_id ? "mptcp_pm_addr_entry" : "mptcp_addr_info"),
+			off, size, end);
+		return -EACCES;
+	}
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_mptcp_pm_verifier_ops = {
+	.get_func_proto		= bpf_mptcp_pm_get_func_proto,
+	.is_valid_access	= bpf_tracing_btf_ctx_access,
+	.btf_struct_access	= bpf_mptcp_pm_btf_struct_access,
+};
+
+static int bpf_mptcp_pm_reg(void *kdata, struct bpf_link *link)
+{
+	return mptcp_pm_register(kdata);
+}
+
+static void bpf_mptcp_pm_unreg(void *kdata, struct bpf_link *link)
+{
+	mptcp_pm_unregister(kdata);
+}
+
+static int bpf_mptcp_pm_check_member(const struct btf_type *t,
+				     const struct btf_member *member,
+				     const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int bpf_mptcp_pm_init_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    void *kdata, const void *udata)
+{
+	const struct mptcp_pm_ops *upm;
+	struct mptcp_pm_ops *pm;
+	u32 moff;
+
+	upm = (const struct mptcp_pm_ops *)udata;
+	pm = (struct mptcp_pm_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct mptcp_pm_ops, type):
+		pm->type = upm->type;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_mptcp_pm_init(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_sock",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_sock_id = type_id;
+
+	type_id = btf_find_by_name_kind(btf, "mptcp_pm_addr_entry",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_entry_id = type_id;
+
+	return 0;
+}
+
+static int bpf_mptcp_pm_validate(void *kdata)
+{
+	return mptcp_pm_validate(kdata);
+}
+
+static int __bpf_mptcp_pm_address_created(struct mptcp_sock *msk)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_established(struct mptcp_sock *msk)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_closed(struct mptcp_sock *msk)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_announced(struct mptcp_sock *msk,
+					    struct mptcp_pm_addr_entry *addr)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_removed(struct mptcp_sock *msk, u8 id)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_subflow_established(struct mptcp_sock *msk,
+					      struct mptcp_pm_addr_entry *local,
+					      struct mptcp_addr_info *remote)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_subflow_closed(struct mptcp_sock *msk,
+					 struct mptcp_pm_addr_entry *local,
+					 struct mptcp_addr_info *remote)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *skc)
+{
+	return 0;
+}
+
+static bool __bpf_mptcp_pm_get_priority(struct mptcp_sock *msk,
+					struct mptcp_addr_info *skc)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_set_priority(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *local,
+				       struct mptcp_addr_info *remote)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_listener_created(struct mptcp_sock *msk)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_listener_closed(struct mptcp_sock *msk)
+{
+	return 0;
+}
+
+static void __bpf_mptcp_pm_init(struct mptcp_sock *msk)
+{
+}
+
+static void __bpf_mptcp_pm_release(struct mptcp_sock *msk)
+{
+}
+
+static struct mptcp_pm_ops __bpf_mptcp_pm_ops = {
+	.created		= __bpf_mptcp_pm_address_created,
+	.established		= __bpf_mptcp_pm_address_established,
+	.closed			= __bpf_mptcp_pm_address_closed,
+	.address_announced	= __bpf_mptcp_pm_address_announced,
+	.address_removed	= __bpf_mptcp_pm_address_removed,
+	.subflow_established	= __bpf_mptcp_pm_subflow_established,
+	.subflow_closed		= __bpf_mptcp_pm_subflow_closed,
+	.get_local_id		= __bpf_mptcp_pm_get_local_id,
+	.get_priority		= __bpf_mptcp_pm_get_priority,
+	.set_priority		= __bpf_mptcp_pm_set_priority,
+	.listener_created	= __bpf_mptcp_pm_address_listener_created,
+	.listener_closed	= __bpf_mptcp_pm_address_listener_closed,
+	.init			= __bpf_mptcp_pm_init,
+	.release		= __bpf_mptcp_pm_release,
+};
+
+static struct bpf_struct_ops bpf_mptcp_pm_ops = {
+	.verifier_ops	= &bpf_mptcp_pm_verifier_ops,
+	.reg		= bpf_mptcp_pm_reg,
+	.unreg		= bpf_mptcp_pm_unreg,
+	.check_member	= bpf_mptcp_pm_check_member,
+	.init_member	= bpf_mptcp_pm_init_member,
+	.init		= bpf_mptcp_pm_init,
+	.validate	= bpf_mptcp_pm_validate,
+	.name		= "mptcp_pm_ops",
+	.cfi_stubs	= &__bpf_mptcp_pm_ops,
+};
+
 static struct bpf_struct_ops bpf_mptcp_sched_ops;
 static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
-static u32 mptcp_sock_id, mptcp_subflow_id;
+static u32 mptcp_subflow_id;
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -424,6 +697,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
+	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_pm_ops, mptcp_pm_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
 
-- 
2.43.0

