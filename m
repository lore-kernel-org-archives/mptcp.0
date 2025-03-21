Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C31C84BF
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521767; cv=none; b=DRtB7Ij+iVfYM1x39Uz37g10aczJAadsJ3exjKNQ9thTrEbNkJgYltlkmoflcSNRPhuDRydQxayB60w50MOC/eMPGBe+YfH3GUTk+60KSp5ZBdjjxhs8rWDVTZBnKcuaNnW6jIdzkhyy2btQ1GHbPg1IqfZYGhPbpdL+UEXnbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521767; c=relaxed/simple;
	bh=NwQ2ZrePdycqSz9krQSAuwnz1skNScibMGwVHXBjl/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5xOxg1BUcggzYRUmMCOwFH13sogAugjJTNe1AVCwGz/Nr0KFfwFtIO8NVLhDodx3syeuERoZXNy4YtJ2Y04O3rKahCBRVQzCgph7oL4As60fbPEmpDpPgh2r5wkqJJ5ciWm9R/6rJ1OvRvMOtrwfg2RG2nar5+z3deE50QdZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN2je9wa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN2je9wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39585C4CEE7;
	Fri, 21 Mar 2025 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521767;
	bh=NwQ2ZrePdycqSz9krQSAuwnz1skNScibMGwVHXBjl/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lN2je9waULQIfZYFjAMWrxBqHWPzylYH+nq/H+YGHc+LHhyzMYWDot82y6PKrcAHX
	 FteJz9AcudaF5SyXEzDKK5Af6zsn0yYfy13luvYEZDuMsSFRyp06/09fsT7rMATbYp
	 5Ssw6Hxm/9FsqoPrd1kdKFPcC1RpWPC2USpuFRW1iS+87QqwPjsiYh/Ukywxo32nM2
	 NlNbAM33/7DPkqvmzw9hqKFr4xHRj0AIlLdCdhKt+ayiF0UstGRE6cBVzMi70RFjz3
	 5PoZWQXhopjcZpQ4lkPRRSU0imkH0JcAVT/MROTXOb8mTknkgGrXrv3Vuw/Wu6wkVB
	 JGLmyL0jb4bqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/4] bpf: Add mptcp path manager struct_ops
Date: Fri, 21 Mar 2025 09:49:15 +0800
Message-ID: <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
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

This patch implements a new struct bpf_struct_ops for MPTCP BPF path
manager: bpf_mptcp_pm_ops. Register and unregister the bpf path manager
in .reg and .unreg.

Add write access for some fields of struct mptcp_sock and struct
mptcp_pm_addr_entry in .btf_struct_access.

This MPTCP BPF path manager implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 259 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2b0cfb57df8c..596574102b89 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -17,10 +17,266 @@
 #include "protocol.h"
 
 #ifdef CONFIG_BPF_JIT
-static struct bpf_struct_ops bpf_mptcp_sched_ops;
+static struct bpf_struct_ops bpf_mptcp_pm_ops,
+			     bpf_mptcp_sched_ops;
 static u32 mptcp_sock_id,
+	   mptcp_entry_id,
 	   mptcp_subflow_id;
 
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
+		case offsetof(struct mptcp_sock, pm.remote.id):
+			end = offsetofend(struct mptcp_sock, pm.remote.id);
+			break;
+		case offsetof(struct mptcp_sock, pm.remote.family):
+			end = offsetofend(struct mptcp_sock, pm.remote.family);
+			break;
+		case offsetof(struct mptcp_sock, pm.remote.port):
+			end = offsetofend(struct mptcp_sock, pm.remote.port);
+			break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		case offsetof(struct mptcp_sock, pm.remote.addr6.s6_addr32[0]):
+			end = offsetofend(struct mptcp_sock, pm.remote.addr6.s6_addr32[0]);
+			break;
+		case offsetof(struct mptcp_sock, pm.remote.addr6.s6_addr32[1]):
+			end = offsetofend(struct mptcp_sock, pm.remote.addr6.s6_addr32[1]);
+			break;
+		case offsetof(struct mptcp_sock, pm.remote.addr6.s6_addr32[2]):
+			end = offsetofend(struct mptcp_sock, pm.remote.addr6.s6_addr32[2]);
+			break;
+		case offsetof(struct mptcp_sock, pm.remote.addr6.s6_addr32[3]):
+			end = offsetofend(struct mptcp_sock, pm.remote.addr6.s6_addr32[3]);
+			break;
+#else
+		case offsetof(struct mptcp_sock, pm.remote.addr.s_addr):
+			end = offsetofend(struct mptcp_sock, pm.remote.addr.s_addr);
+			break;
+#endif
+		case offsetof(struct mptcp_sock, pm.work_pending):
+			end = offsetofend(struct mptcp_sock, pm.work_pending);
+			break;
+		case offsetof(struct mptcp_sock, pm.accept_addr):
+			end = offsetofend(struct mptcp_sock, pm.accept_addr);
+			break;
+		case offsetof(struct mptcp_sock, pm.accept_subflow):
+			end = offsetofend(struct mptcp_sock, pm.accept_subflow);
+			break;
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
+		case offsetof(struct mptcp_pm_addr_entry, addr.port):
+			end = offsetofend(struct mptcp_pm_addr_entry, addr.port);
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
+	case offsetof(struct mptcp_pm_ops, name):
+		if (bpf_obj_name_cpy(pm->name, upm->name,
+				     sizeof(pm->name)) <= 0)
+			return -EINVAL;
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
+static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *skc)
+{
+	return 0;
+}
+
+static bool __bpf_mptcp_pm_get_priority(struct mptcp_sock *msk,
+					struct mptcp_addr_info *skc)
+{
+	return false;
+}
+
+static void __bpf_mptcp_pm_established(struct mptcp_sock *msk)
+{
+}
+
+static void __bpf_mptcp_pm_subflow_established(struct mptcp_sock *msk)
+{
+}
+
+static bool __bpf_mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
+{
+	return false;
+}
+
+static bool __bpf_mptcp_pm_accept_new_subflow(const struct mptcp_sock *msk)
+{
+	return false;
+}
+
+static bool __bpf_mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
+					 const struct mptcp_addr_info *addr)
+{
+	return false;
+}
+
+static int __bpf_mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+					    const struct mptcp_addr_info *addr)
+{
+	return 0;
+}
+
+static void __bpf_mptcp_pm_rm_addr_received(struct mptcp_sock *msk)
+{
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
+	.get_local_id		= __bpf_mptcp_pm_get_local_id,
+	.get_priority		= __bpf_mptcp_pm_get_priority,
+	.established		= __bpf_mptcp_pm_established,
+	.subflow_established	= __bpf_mptcp_pm_subflow_established,
+	.allow_new_subflow      = __bpf_mptcp_pm_allow_new_subflow,
+	.accept_new_subflow     = __bpf_mptcp_pm_accept_new_subflow,
+	.add_addr_echo		= __bpf_mptcp_pm_add_addr_echo,
+	.add_addr_received	= __bpf_mptcp_pm_add_addr_received,
+	.rm_addr_received	= __bpf_mptcp_pm_rm_addr_received,
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
 /* MPTCP BPF packet scheduler */
 
 static const struct bpf_func_proto *
@@ -332,6 +588,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
+	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_pm_ops, mptcp_pm_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
 
-- 
2.43.0

