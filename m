Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E317B51B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588546; cv=none; b=rGCuPiMs1VEQ2uEMGZ6CWk+4dMrX/Yc1/eK0YLzplsI2sKJaz13HmB6RYqpqSk1xqT3K8NYHybiOjHd1/x9GMAsSlilvVYfA4ridY5sDx9fgGaO7Z2ZJ9HzI2yNplzifdl56hQzSs3UAFQTs4u9mJcrBlk0E/TNa0f0QDLuG6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588546; c=relaxed/simple;
	bh=PzXG3Llyceth7mtardx3TqBjjr9jAG4LyHd+FoOJAhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTFi9GJuApFPy/YiMMEmZcCv0Nysz/gCJuJupknjqPY+WBYUWSBQ0fqOgAfVd6FhAk6Zc+LfA2HLOxoxQyaHyB67tpRshS0fNNqTh2vYMjGzIrNOz8nOvoI/l/QLdW9j69fMS1YlX9lvgQZAG6IuE1MQ6W3lZZjdnxOh+gWYtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu2JhQ6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu2JhQ6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C84FC4CEEB;
	Tue, 22 Oct 2024 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588546;
	bh=PzXG3Llyceth7mtardx3TqBjjr9jAG4LyHd+FoOJAhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu2JhQ6OEiF6QfPLpopNBXmWtn5o1NMBjpUCJuZ0tBgh6ISrHibzpUmbNQiM5NKXq
	 HmGPTI9E67MwW0XQ9TNH4OMzNTYA8oDY25X3CS4R/fsaIGiXkY+ILljsymli4LHsGI
	 dttglWH+uDfjUSSPpNeKiNejG7t7aVC+Z2fMBvaVzfl6qQuQaZJ0UWshfLW55tzDHn
	 5v1MgcadIaR7nb2YmZpks6nULcqbxYuEOeudm+qwjxnhQ8Hp6IHhBEO+rgZLhalrIt
	 YavSE7o+DHUtxXnmxSaPzOcAZG4rF8/cn+pSuxh+J1wU6HB9jtkHDVvYFOw04U3JuU
	 cGSVFSrejh4CQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 33/36] bpf: Register mptcp struct_ops kfunc set
Date: Tue, 22 Oct 2024 17:14:41 +0800
Message-ID: <4de272204b229e44548cde9b44a3de4f6333483c.1729588019.git.tanggeliang@kylinos.cn>
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

This patch exports mptcp path manager helpers into BPF, adds these
kfunc names into struct_ops kfunc_set and register this set with
BPF_PROG_TYPE_STRUCT_OPS type.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 89ff8d5b55bb..8ce3a48c27e5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -598,6 +598,91 @@ __bpf_kfunc static bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a)
 	return false;
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
+bpf_pm_alloc_entry(struct sock *sk, struct mptcp_pm_addr_entry *entry)
+{
+	struct mptcp_pm_addr_entry *e;
+
+	e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+	if (!e)
+		return NULL;
+	*e = *entry;
+
+	return e;
+}
+
+__bpf_kfunc static void bpf_pm_free_entry(struct sock *sk,
+					  struct mptcp_pm_addr_entry *entry)
+{
+	sock_kfree_s(sk, entry, sizeof(*entry));
+}
+
+__bpf_kfunc static bool bpf_mptcp_addresses_equal(const struct mptcp_addr_info *a,
+						  const struct mptcp_addr_info *b, bool use_port)
+{
+	return mptcp_addresses_equal(a, b, use_port);
+}
+
+__bpf_kfunc static void bpf_bitmap_zero(struct mptcp_id_bitmap *bitmap)
+{
+	bitmap_zero(bitmap->map, MPTCP_PM_MAX_ADDR_ID + 1);
+}
+
+__bpf_kfunc static bool bpf_test_bit(__u8 id, struct mptcp_id_bitmap *bitmap)
+{
+	return test_bit(id, bitmap->map);
+}
+
+__bpf_kfunc static void bpf_set_bit(__u8 id, struct mptcp_id_bitmap *bitmap)
+{
+	__set_bit(id, bitmap->map);
+}
+
+__bpf_kfunc static __u8 bpf_next_bit(struct mptcp_id_bitmap *bitmap)
+{
+	return find_next_zero_bit(bitmap->map, MPTCP_PM_MAX_ADDR_ID + 1, 1);
+}
+
+__bpf_kfunc static bool bpf_mptcp_pm_addr_families_match(const struct sock *sk,
+							 const struct mptcp_addr_info *loc,
+							 const struct mptcp_addr_info *rem)
+{
+	return mptcp_pm_addr_families_match(sk, loc, rem);
+}
+
+__bpf_kfunc static struct ipv6_pinfo *bpf_inet6_sk(const struct sock *sk)
+{
+	return inet6_sk(sk);
+}
+
+__bpf_kfunc static bool bpf_ipv6_addr_equal(const struct mptcp_addr_info *a1,
+					    const struct in6_addr *a2)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	return ipv6_addr_equal(&a1->addr6, a2);
+#endif
+	return false;
+}
+
+__bpf_kfunc static void bpf_ipv6_addr_set_v4mapped(const __be32 addr,
+						   struct mptcp_addr_info *v4mapped)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	ipv6_addr_set_v4mapped(addr, &v4mapped->addr6);
+#endif
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -635,6 +720,36 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
+BTF_KFUNCS_START(bpf_mptcp_struct_ops_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_list_add_tail_rcu)
+BTF_ID_FLAGS(func, bpf_list_del_rcu)
+BTF_ID_FLAGS(func, bpf_pm_alloc_entry)
+BTF_ID_FLAGS(func, bpf_pm_free_entry)
+BTF_ID_FLAGS(func, mptcp_pm_alloc_anno_list)
+BTF_ID_FLAGS(func, mptcp_pm_announce_addr)
+BTF_ID_FLAGS(func, mptcp_pm_nl_addr_send_ack, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_mptcp_addresses_equal)
+BTF_ID_FLAGS(func, bpf_bitmap_zero)
+BTF_ID_FLAGS(func, bpf_test_bit)
+BTF_ID_FLAGS(func, bpf_set_bit)
+BTF_ID_FLAGS(func, bpf_next_bit)
+BTF_ID_FLAGS(func, bpf_mptcp_pm_addr_families_match)
+BTF_ID_FLAGS(func, bpf_inet6_sk)
+BTF_ID_FLAGS(func, bpf_ipv6_addr_equal)
+BTF_ID_FLAGS(func, bpf_ipv6_addr_set_v4mapped)
+BTF_ID_FLAGS(func, mptcp_pm_remove_addr)
+BTF_ID_FLAGS(func, mptcp_pm_remove_addr_entry, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, __mptcp_subflow_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, mptcp_subflow_shutdown, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, mptcp_close_ssk, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, mptcp_pm_nl_mp_prio_send_ack, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_mptcp_struct_ops_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_struct_ops_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_struct_ops_kfunc_ids,
+};
+
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
@@ -658,6 +773,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					       &bpf_mptcp_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_mptcp_struct_ops_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.45.2

