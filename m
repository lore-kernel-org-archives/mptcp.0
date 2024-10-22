Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C3185E53
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588544; cv=none; b=q+6g/goPwAhz1ImcUVWyLo4FzRPmprWymVgCq3sj2jj4M+/5+DatE+kK4R3SP39TljWE/8zEfyOYkDLUk7fblfyEqszsKnMCsOf80ANJUJ2WYCd4xKWr6xw1QMuo1hwqzRASLTxezofDojcsn/wA7VkjUqLmzKosewmGf7E1qQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588544; c=relaxed/simple;
	bh=k0hHOubkZba51UV9TUkldz0EsFfyjvFcRXGqwnaWqT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3XdgVN2XdrL+wqsySYj5jyRRZH4uWKEmOE9U+BQSqUh+S2X0m9WhyoosqlBMG023iCt+fhpXvDX2Ih5LnFQpgwIa7C6DMy4zdQTfO+Mjf6HbOLrA8LEsyAEgse8fM8/Cysr0EQyL8AvxTGelQsH4qBiybH6mCrel+xrtGc69X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIbZK9iF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIbZK9iF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EF7C4CEE6;
	Tue, 22 Oct 2024 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588544;
	bh=k0hHOubkZba51UV9TUkldz0EsFfyjvFcRXGqwnaWqT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIbZK9iFsEcMA+QnkYPjj5R2OJIX3vUxFb8jhHBy6xtt/cJZRMi5wA+HxbZ4kISoR
	 wl3Snb7dNG8r60siiAGDl31wf9fBV7pkKH4M+eJViD/Hp1Y9/uv0kus51jGSxJyRfl
	 9+LoIW/DD4lyAOhjM4VCr8aDkeHfu18Q6wrEERpEjt9Zxcc7hmP5mHyByC/mdSRYKg
	 sdMS+doeZQ1zD9jjQJTq5l5y+mKWJsAwFDPAS12GRMA8/XrTkLiuZ8ZUxmfY6I+Ae0
	 i+8W9qW/lEtQocqZjyuOjBH+KzymSD2jFrdpkBn1EfsC+v5cCvnHW2RawMortnBQvX
	 +i4fmp4PhlzRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 32/36] bpf: Add mptcp path manager struct_ops
Date: Tue, 22 Oct 2024 17:14:40 +0800
Message-ID: <d9c2862c905568aaa10b78232903b5910d496a18.1729588019.git.tanggeliang@kylinos.cn>
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

This patch implements a new struct bpf_struct_ops for MPTCP BPF path
manager: bpf_mptcp_pm_ops. Register and unregister the bpf path manager
in .reg and .unreg.

Add write access for some fields of struct mptcp_addr_info, struct
mptcp_pm_addr_entry and struct mptcp_sock in .btf_struct_access.

This MPTCP BPF path manager implementation is similar to BPF TCP CC. And
net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c      | 260 ++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |   3 +-
 2 files changed, 260 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 057017d3f5c0..89ff8d5b55bb 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -17,9 +17,264 @@
 #include "protocol.h"
 
 #ifdef CONFIG_BPF_JIT
-static struct bpf_struct_ops bpf_mptcp_sched_ops;
+static struct bpf_struct_ops bpf_mptcp_pm_ops,
+			     bpf_mptcp_sched_ops;
 static const struct btf_type *mptcp_sock_type, *mptcp_subflow_type __read_mostly;
-static u32 mptcp_sock_id, mptcp_subflow_id;
+static u32 mptcp_sock_id, mptcp_entry_id, mptcp_addr_id, mptcp_subflow_id;
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
+		case offsetof(struct mptcp_pm_addr_entry, flags):
+			end = offsetofend(struct mptcp_pm_addr_entry, flags);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_pm_addr_entry at off %d\n",
+				off);
+			return -EACCES;
+		}
+	} else if (id == mptcp_addr_id) {
+		switch (off) {
+		case offsetof(struct mptcp_addr_info, id):
+			end = offsetofend(struct mptcp_addr_info, id);
+			break;
+		case offsetof(struct mptcp_addr_info, family):
+			end = offsetofend(struct mptcp_addr_info, family);
+			break;
+		case offsetof(struct mptcp_addr_info, port):
+			end = offsetofend(struct mptcp_addr_info, port);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_addr_info at off %d\n",
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
+	return mptcp_register_path_manager(kdata);
+}
+
+static void bpf_mptcp_pm_unreg(void *kdata, struct bpf_link *link)
+{
+	mptcp_unregister_path_manager(kdata);
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
+	type_id = btf_find_by_name_kind(btf, "mptcp_addr_info",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	mptcp_addr_id = type_id;
+
+	return 0;
+}
+
+static int bpf_mptcp_pm_validate(void *kdata)
+{
+	return mptcp_validate_path_manager(kdata);
+}
+
+static int __bpf_mptcp_pm_address_announce(struct mptcp_sock *msk,
+					   struct mptcp_pm_addr_entry *addr)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_address_remove(struct mptcp_sock *msk, u8 id)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_subflow_create(struct mptcp_sock *msk,
+					 struct mptcp_pm_addr_entry *entry,
+					 struct mptcp_addr_info *addr)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_subflow_destroy(struct mptcp_sock *msk,
+					  struct mptcp_pm_addr_entry *local,
+					  struct mptcp_addr_info *remote)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *local)
+{
+	return 0;
+}
+
+static u8 __bpf_mptcp_pm_get_flags(struct mptcp_sock *msk,
+				   struct mptcp_addr_info *skc)
+{
+	return 0;
+}
+
+static struct mptcp_pm_addr_entry *
+__bpf_mptcp_pm_get_addr(struct mptcp_sock *msk, u8 id)
+{
+	return NULL;
+}
+
+static int __bpf_mptcp_pm_dump_addr(struct mptcp_sock *msk,
+				    struct mptcp_id_bitmap *bitmap)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_pm_set_flags(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *local,
+				    struct mptcp_addr_info *remote)
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
+	.address_announce	= __bpf_mptcp_pm_address_announce,
+	.address_remove		= __bpf_mptcp_pm_address_remove,
+	.subflow_create		= __bpf_mptcp_pm_subflow_create,
+	.subflow_destroy	= __bpf_mptcp_pm_subflow_destroy,
+	.get_local_id		= __bpf_mptcp_pm_get_local_id,
+	.get_flags		= __bpf_mptcp_pm_get_flags,
+	.get_addr		= __bpf_mptcp_pm_get_addr,
+	.dump_addr		= __bpf_mptcp_pm_dump_addr,
+	.set_flags		= __bpf_mptcp_pm_set_flags,
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
 
 static const struct bpf_func_proto *
 bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
@@ -406,6 +661,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
+	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_pm_ops, mptcp_pm_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 26950be3b37c..b8ce6507be49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -194,6 +194,7 @@ enum mptcp_pm_status {
 enum mptcp_pm_type {
 	MPTCP_PM_TYPE_KERNEL = 0,
 	MPTCP_PM_TYPE_USERSPACE,
+	MPTCP_PM_TYPE_BPF,
 
 	__MPTCP_PM_TYPE_NR,
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
@@ -1102,7 +1103,7 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 
 static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+	return READ_ONCE(msk->pm.pm_type);
 }
 
 static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
-- 
2.45.2

