Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD61DE2C5
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924575; cv=none; b=uLMWiv9TMvuQFExdHVOEqPjCHeTORNS86QOMKFKO+kl8Pfod3WqtbxsV/vdh7qKKI4svrwfW5mTy5gSLDCKVltFFKB4aQA1D/muzKsbu5VEd1bllGQU53m4mwi8b6EnjBzKHCroGXfD0Y0hsarvUTEH3RfO8wtEMuq4HczizAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924575; c=relaxed/simple;
	bh=lOQqi5nBIAmLi+wWnd2UtkF7u56gHu2FxKPN1i7XxC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjMOO21BFXuXoD1mq2xKJEuYVb022QKR7k6HPkZR8oTq5MqFSQRGho7s0/U3QVZ24QP92JGeh1cs9qKpLN4DKAaZFB4RSH0Bq9TU7FiCsiowNpszk696EyDbpR0e9KHdG1Nww6cBc3xQ8vNX+GQ8hx8MxUZI3LoP002dyi1ypns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF4Zz8YB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF4Zz8YB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598DBC4CED1;
	Fri,  7 Feb 2025 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924574;
	bh=lOQqi5nBIAmLi+wWnd2UtkF7u56gHu2FxKPN1i7XxC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rF4Zz8YBU7QQnx2GMIYTB2a5uhlFjwo9CkJ2URHYt0ZUU6BwuWVUm+K1cn0umexXT
	 pyfqiDBpsu1HBnc8y1u37piVxerIZsjCgric2TBLfnaeTu8rzhqhFS0PMO1xSQapFk
	 OfskLuyDHZzuUPpvtXzD273FDrmClDPOoHsK9nySxlhXqm/E5Lb9ECJvETjZVKhw9Z
	 aZG/E4vjOMmLiiQOsB1xtzVjFboAdfQSQNG5cLUCNyLi/eMxxZa99DjqDtUV6Kpi/I
	 YN7D09Ek2yGaD0xKnaOGjJHnDxRgvIHLf0dTLGpPxrsBfRpxZdZTzIJGsTyAbhzfF4
	 vJhkdOkTQL78A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
Date: Fri,  7 Feb 2025 18:36:00 +0800
Message-ID: <d549f35c4e18ce58081386682fecc3dce1f58e3b.1738924354.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924354.git.tanggeliang@kylinos.cn>
References: <cover.1738924354.git.tanggeliang@kylinos.cn>
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

        bpf_for_each(mptcp_userspace_pm_addr, entry, sk)
                kfunc(entry);

This bpf_iter should be invoked under holding the msk pm lock, so
use spin_is_locked() to check whether the lock is holding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index be222fa5f308..21f736f2ff30 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -227,6 +227,15 @@ struct bpf_iter_mptcp_subflow_kern {
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
@@ -305,6 +314,48 @@ bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int p
 	return data->contexts[pos];
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_userspace_pm_addr_new(struct bpf_iter_mptcp_userspace_pm_addr *it,
+				     struct sock *sk)
+{
+	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void *)it;
+	struct mptcp_sock *msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_userspace_pm_addr_kern) >
+		     sizeof(struct bpf_iter_mptcp_userspace_pm_addr));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_userspace_pm_addr_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_userspace_pm_addr));
+
+	msk = bpf_mptcp_sock_from_sock(sk);
+	if (!msk)
+		return -EINVAL;
+
+	if (!spin_is_locked(&msk->pm.lock))
+		return -EINVAL;
+
+	kit->msk = msk;
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
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -317,6 +368,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
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
2.43.0

