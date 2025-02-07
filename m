Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E153A7
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924577; cv=none; b=uMlK71IcwWLEElcrAwq7S03jDZASLxgIxIYiuwttF5Q3Xx4aGSrtY5qemGibNkdSkJderyuFDJYZGTVm087JWbrvpN+u5ymQp9uEFi+cWAleO4NYAeyy0AM5U5IJ5Aqw/LDemGW8hlqg1I07LuEytZ9nwW+i2BrwNy0/R/E5HGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924577; c=relaxed/simple;
	bh=7howCXoCMBX03RwiWqpxiNqoprDSrDEhluG9in23EQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcrT1QbNAMvG5yGA1uOq5tERdOFKTBPq4pwW0Btef1/roOqUnkFVp4DeTMihjQAxB6A0IzuYhk0Hfq2RQrbVT8TQzZ4UPTwsaKLuHA7/2wNWN15hL9ihMdl6bMDvNG0YdTFMikEyUGa+psibLrDLpMEQahP/lkbbHNP+WCp0AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdOW3ik+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdOW3ik+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BFC4CED6;
	Fri,  7 Feb 2025 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924576;
	bh=7howCXoCMBX03RwiWqpxiNqoprDSrDEhluG9in23EQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdOW3ik+warGONp54LPs4R7RORVg+hZiMPTAPnV3DwUuSX6z+aMZChlPfWUM/m9uF
	 3LAoim0o25Nvkz71KQiBQ2cA6m3gPIU1vW9b6NSJAfoKeYfQEfCc5O3pAD6jSGnp8H
	 iglvqE2aqSDVP2nqEThl18HuZKNj/Bzr8sOvo9Bt4dKzit5RN0gA0n0kGbcbZdW4LG
	 IcmpZhC+UoY5VVyey3UWdEMAwr53sCpSew0ZtqyfmpBl/Tw/dGs7CcRwHLy569PHIy
	 yQl0PGX0vYeUyibsw6WnKA32uwOGSk4vjbLuPnUs0FN46WXqS5ryv185YuMwBUCo9C
	 FvRmTaA13jNLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/5] bpf: Export more helpers for mptcp_userspace_pm_addr test
Date: Fri,  7 Feb 2025 18:36:01 +0800
Message-ID: <c5a1432ed7db04e4ca2d9422d07fe6057aea9bfa.1738924354.git.tanggeliang@kylinos.cn>
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

The mptcp_userspace_pm_addr bpf_iter should be invoked under holding the
msk pm lock, so spin_lock_bh() and spin_unlock_bh() are needed in BPF
program to hold or release the msk pm lock. And bpf_ipv4_is_private_10()
helper is also needed by the mptcp_userspace_pm_addr bpf_iter selftest
program.

This patch adds the corresponding BPF wrappers for these helpers and adds
them to the mptcp common kfunc_set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 21f736f2ff30..4854160c25df 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -356,6 +356,21 @@ bpf_iter_mptcp_userspace_pm_addr_destroy(struct bpf_iter_mptcp_userspace_pm_addr
 {
 }
 
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
+__bpf_kfunc static bool bpf_ipv4_is_private_10(__be32 addr)
+{
+	return ipv4_is_private_10(addr);
+}
+
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -371,6 +386,9 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, bpf_ipv4_is_private_10)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.43.0

