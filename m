Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C51C84BF
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521769; cv=none; b=pHIz8hY0Pn6Pxsv0R+iRSYWkAbA8pnqcbnlo36Sz+na3en+lzNYNFmbE9mKlSfE5CcNJBwe5pqd35TdCfYI1tvBV8xvDCACgL5CZsZ2/pNkYeo2AyTpSDEwU8r2RgDBLy+bbX2BSPwuL+xJmToZ+LmHXIDNGcJceQv3yfCFc+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521769; c=relaxed/simple;
	bh=cVRBhtjh4QRXKFlACtdoKvNyaCAjxylpxBgHnfg2BbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/YY1i5bPlxkRJ4746nCFb7thFUl2oaLhpiNzTTjXWOlwZR7nmwLdPP1N3ZGnPkFfocbP1Mhjff1rlDmGrcl4d+jZ50I8YIoY25u30K+mjby+RPYEkdKrEWa6FC9sDSF9DZImwJzWLzyOBFBhrSIWHSEap9cJpvnEsnPYRRFtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDcbomWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDcbomWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD70C4CEEF;
	Fri, 21 Mar 2025 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521768;
	bh=cVRBhtjh4QRXKFlACtdoKvNyaCAjxylpxBgHnfg2BbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDcbomWTTzH1gi775+/qXunGgXcSHft5v0wtpD+WBr7LiLT7XlhgbUjtf+NyxEEKf
	 rpng17vdVEcBIV8V/FscJwf4kcmuJeYGuiCzTccE7rC2X2WCP/raD0erNgwZeTJXxy
	 NueD03kzK34Dj2nZgeiCeTtnK8/kBzsogKGDZ6MnaBIUilUlTEJ1wvn7T4xd9XPTYf
	 B0necN9wuMsU5LBKNjr7yUlf3F7aS9tOgKMXG/FuujYZStukpvz5x1b7UAyeLFm355
	 PlOgE9EUAPrI3831v7TY+uIsKEB3qVp31KIYO8KtP6tlI6rYmMAOxf3ZZ1OQupDnVC
	 6g8pIbEiepuDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/4] bpf: Export mptcp path manager kfuncs
Date: Fri, 21 Mar 2025 09:49:16 +0800
Message-ID: <0c324baa241000f32a1b97017da8e96a383767ad.1742521587.git.tanggeliang@kylinos.cn>
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

This patch exports mptcp path manager helpers into BPF, adds these
kfunc names into mptcp common kfunc_set.

bpf_kmemdup_entry() and bpf_kfree_entry() are wrappers of kmemdup() and
kfree(), using to alloc and free an mptcp address entry.

bpf_set_bit() and bpf_bitmap_fill() are wrappers of __set_bit() and
bitmap_fill(), using for mptcp address ID bitmap.

bpf_spin_lock_bh() and bpf_spin_unlock_bh() are wrappers of spin_lock_bh()
and spin_unlock_bh(), using to lock and unlock the mptcp pm lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c       | 48 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm_kernel.c | 27 ++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 596574102b89..e411ae8382f2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -540,6 +540,38 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_kmemdup_entry(struct mptcp_pm_addr_entry *entry, int size, gfp_t priority)
+{
+	return kmemdup(entry, size, priority);
+}
+
+__bpf_kfunc static void
+bpf_kfree_entry(struct mptcp_pm_addr_entry *entry)
+{
+	kfree(entry);
+}
+
+__bpf_kfunc static void bpf_set_bit(unsigned long nr, unsigned long *addr__ign)
+{
+	__set_bit(nr, addr__ign);
+}
+
+__bpf_kfunc static void bpf_bitmap_fill(unsigned long *dst__ign, unsigned int nbits)
+{
+	bitmap_fill(dst__ign, nbits);
+}
+
+__bpf_kfunc static void bpf_spin_lock_bh(spinlock_t *lock)
+{
+	spin_lock_bh(lock);
+}
+
+__bpf_kfunc static void bpf_spin_unlock_bh(spinlock_t *lock)
+{
+	spin_unlock_bh(lock);
+}
+
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -564,6 +596,22 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_kmemdup_entry)
+BTF_ID_FLAGS(func, bpf_kfree_entry)
+BTF_ID_FLAGS(func, bpf_set_bit)
+BTF_ID_FLAGS(func, bpf_bitmap_fill)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, mptcp_pm_nl_lookup_addr)
+BTF_ID_FLAGS(func, mptcp_pm_nl_append_new_local_addr_msk)
+BTF_ID_FLAGS(func, mptcp_pm_get_add_addr_signal_max)
+BTF_ID_FLAGS(func, mptcp_pm_get_add_addr_accept_max)
+BTF_ID_FLAGS(func, mptcp_pm_get_subflows_max)
+BTF_ID_FLAGS(func, mptcp_pm_get_local_addr_max)
+BTF_ID_FLAGS(func, mptcp_pm_add_addr_recv)
+BTF_ID_FLAGS(func, mptcp_pm_is_init_remote_addr)
+BTF_ID_FLAGS(func, mptcp_pm_create_subflow_or_signal_addr)
+BTF_ID_FLAGS(func, mptcp_pm_rm_addr_recv)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 4f7b2e0e998d..3cf81986c70d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -253,6 +253,9 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -367,6 +370,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
+__bpf_kfunc_end_defs();
+
 static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
 	spin_lock_bh(&msk->pm.lock);
@@ -1493,3 +1498,25 @@ void __init mptcp_pm_kernel_register(void)
 
 	mptcp_pm_register(&mptcp_pm_kernel);
 }
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+mptcp_pm_nl_lookup_addr(struct mptcp_sock *msk, const struct mptcp_addr_info *info)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return __lookup_addr(pernet, info);
+}
+
+__bpf_kfunc static int
+mptcp_pm_nl_append_new_local_addr_msk(struct mptcp_sock *msk,
+				      struct mptcp_pm_addr_entry *entry,
+				      bool needs_id, bool replace)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return mptcp_pm_nl_append_new_local_addr(pernet, entry, needs_id, replace);
+}
+
+__bpf_kfunc_end_defs();
-- 
2.43.0

