Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DB36124
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583291; cv=none; b=jGn4IYTBDRBaYO1mQncj7x4xWddcKrXYt6rp6AXWtPhSz4S7Gx8l8cRAGcKcoCIPwcYYjxzENQ1FZFTbcQz2J/Z/V3ZgcO0G2yTdyecLxtfpnKpyEAxOsVV30vrNcQ1udtrZRMtws5W6feyiuAr0zO49nmzUW4X3yP/PnuyIy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583291; c=relaxed/simple;
	bh=AgpknJVijjJyHhc4i7xj+d54hIAL5FcOm7XRITrl/MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt0X1+s00SpFHsVveMb1xN4a1ZoeuQaJKRg487/VsEc/VlnQ0taClqsjx3dcMBKel0fpvEGCdS1sgMOFfsBGnYwqPW6EnYI4CYcuPpKG1P+xg/BNKdQxidBAVAm+biQI0YsJUQsp5DR1CxIVUtJvWbvZl2dHROfiYkqJbASSkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXhDHhSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXhDHhSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC37C4CEC3;
	Tue, 22 Oct 2024 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583291;
	bh=AgpknJVijjJyHhc4i7xj+d54hIAL5FcOm7XRITrl/MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXhDHhShHlhjipceQjdlyyRzSMVY2chHhqcS5njAaNs4sRKZgF5i1gQrJrIpUvHUS
	 KcZjzJmnd6LejHdFf2E0wl05UlX7Sirg+vGplM+BtwvQ5c/2lxhPlEDUfcQET3pSzL
	 XjsfUG99T5Ehtsliml9dpdPnXNoLgyP0aPmTjdIiIU78Y0HyMaxxchIPp/YutKCGGT
	 D9fX6gFIStEmkQjrZgt4uzS4H0eMkpTLTGWcweV3KryraoHCEIKL8XsMcbXkOfR961
	 jmtXdVdF5wDFyGaHq04u/nduQh8d2R6KREerY8u9DUezFdLyLdDGtMepYs3or7w4Gj
	 3HIL1yHh65TQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/5] bpf: Add mptcp_address bpf_iter
Date: Tue, 22 Oct 2024 15:47:58 +0800
Message-ID: <d000583ad69a4f122552e3b06641d25f5200437d.1729582332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like the mptcp_subflow bpf_iter used to implement the MPTCP BPF
packet scheduler, another bpf_iter is also needed, named mptcp_address,
to traverse all address entries on userspace_pm_local_addr_list of an
MPTCP socket for implementing the MPTCP BPF path manager.

In kernel space, we walk this list like this:

 list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list)
	 kfunc(entry);

With the mptcp_address bpf_iter, bpf_for_each() can be used to do the
same thing in BPF program:

 bpf_for_each(mptcp_address, entry, msk)
	 kfunc(entry);

This bpf_iter should be invoked under holding the msk pm lock, so use
lockdep_assert_held() to assert the lock is holding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..8889e5351897 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -214,6 +214,15 @@ struct bpf_iter_mptcp_subflow_kern {
 	struct list_head *pos;
 } __aligned(8);
 
+struct bpf_iter_mptcp_address {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_mptcp_address_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __aligned(8);
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
@@ -266,6 +275,39 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_address_new(struct bpf_iter_mptcp_address *it,
+			   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_address_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	kit->pos = &msk->pm.userspace_pm_local_addr_list;
+	return 0;
+}
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_iter_mptcp_address_next(struct bpf_iter_mptcp_address *it)
+{
+	struct bpf_iter_mptcp_address_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos, &kit->msk->pm.userspace_pm_local_addr_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_pm_addr_entry, list);
+}
+
+__bpf_kfunc static void
+bpf_iter_mptcp_address_destroy(struct bpf_iter_mptcp_address *it)
+{
+}
+
 __bpf_kfunc static struct
 mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 {
@@ -305,6 +347,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.45.2

