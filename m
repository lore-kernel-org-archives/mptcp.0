Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2621A76BC
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325509; cv=none; b=ANA38TLhZZJU08m+MOVRHLo/534p009sVMdfVTbQm6+653WDCfCJiKuEMayrk4oRSJ+Bh46m3I49SCPdspui7vG7sc89zW65dLEDX1WFOzmuSIHFd0GQ2GoD9bZWsMjtEhLuAzmgf9YU77dgIaQOgAsTzjqwPbqKzYqSC+Sew4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325509; c=relaxed/simple;
	bh=ToG1MF7uW2QUuMDYIFMQfrYfVuMV41rdERJmIk7VGKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o72qx0TNEX9VZQnYD0Idq3EkW6P9sXtMcin0vbZpgEYi7Knq5MkJq/dx8t/KAjLz4DQv/o63M1f8lNTn/gPe0stxIlvhJPpv8imbB9X0FgLE//bDJ9u+WO6/Qe+o0Ls4Sza4SnbdFwk6LyW3B7RsiI/wokRdW5zeO7cyzIOjbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHCB9fgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHCB9fgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6309CC4CEE1;
	Wed,  8 Jan 2025 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325508;
	bh=ToG1MF7uW2QUuMDYIFMQfrYfVuMV41rdERJmIk7VGKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHCB9fgvdvDFLXhJ+4vxhQdM+Z+At9VG2OYH34roVdGqqxYPgwJ8YqYEfhNvqe2RP
	 r4SmS6ugedSLhPC3h72jpYZwIeRTe227zreWl5v/UR1+KOGsAP/OoPOfNPq2v32iJe
	 WeLIIzZB2EVgwKGyZ+/TefhXSlVTH1/Ia6DJtA4iSDSW/S7rsT8AuEI1CgNtEPXb04
	 9wtb2PXfGAYvlO/fNTmuwV6M791phv2szPJ25/d1F5UXkCAhA3a6nx/PbCZ69EHB+f
	 8RH6So+oQ1rbG5qMDSI5mjBg40+0sMEQE6cQED6mY9HZZkjTMwO6g6yx6yjxkF+DVz
	 gMfOppSjJbT4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
Date: Wed,  8 Jan 2025 16:38:10 +0800
Message-ID: <10551d58b505f20754a13302ce2340e220a3e7a5.1736325184.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like the mptcp_subflow bpf_iter used to implement the MPTCP
BPF packet scheduler, another bpf_iter is also needed, named
mptcp_userspace_pm_addr, to traverse all address entries on
userspace_pm_local_addr_list of an MPTCP socket for implementing
the MPTCP BPF path manager.

In kernel space, we walk this list like this:

	mptcp_for_each_userspace_pm_addr(msk, entry)
		kfunc(entry);

With the mptcp_userspace_pm_addr bpf_iter, bpf_for_each() can be
used to do the same thing in BPF program:

	bpf_for_each(mptcp_userspace_pm_addr, entry, msk)
		kfunc(entry);

This bpf_iter should be invoked under holding the msk pm lock, so
use lockdep_assert_held() to assert the lock is holding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 923895322b2c..c7f5d208f6cc 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -220,6 +220,15 @@ struct bpf_iter_mptcp_subflow_kern {
 	struct list_head *pos;
 } __aligned(8);
 
+struct bpf_iter_mptcp_userspace_pm_addr {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_mptcp_userspace_pm_addr_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __aligned(8);
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
@@ -273,6 +282,46 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_userspace_pm_addr_new(struct bpf_iter_mptcp_userspace_pm_addr *it,
+				     struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_userspace_pm_addr_kern) >
+		     sizeof(struct bpf_iter_mptcp_userspace_pm_addr));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_userspace_pm_addr_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_userspace_pm_addr));
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	if (!spin_is_locked(&msk->pm.lock))
+		return -EINVAL;
+
+	kit->pos = &msk->pm.userspace_pm_local_addr_list;
+	return 0;
+}
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_iter_mptcp_userspace_pm_addr_next(struct bpf_iter_mptcp_userspace_pm_addr *it)
+{
+	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos,
+				      &kit->msk->pm.userspace_pm_local_addr_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_pm_addr_entry, list);
+}
+
+__bpf_kfunc static void
+bpf_iter_mptcp_userspace_pm_addr_destroy(struct bpf_iter_mptcp_userspace_pm_addr *it)
+{
+}
+
 __bpf_kfunc static struct
 mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 {
@@ -310,6 +359,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.45.2

