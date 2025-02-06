Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257F225A2B
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832712; cv=none; b=JI50Syn/mJBNenmx4w1PTkkot2Gj7MxR+IhWz1XmYfveG+mibHdJykI30Vdh42xWoL5EmodAk+As5upXrJD54Mti0HnuuzCR+CxzMCyXX3F5SuMBZ8ZcjFfOPrzxtJoU3TfzVMpNlu9EBRDMT5qIztirb7A9HB+Nq2CA577TFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832712; c=relaxed/simple;
	bh=zs++kNZUDyiUfjYrXi2A8zXJqhZ1CIyo4SHfazh+tj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZClLX2riUmLzDE+fGmzWDeqEby9ciJXOgki5r0YbBgfXtevPpz08dgyazFLG4PxCA8ifCIXdYMSDWAbxSFi9guMkhjScj+jrFOxBxsr4Mb8kIKmCc9xPepZmDx/kV4uVFMMTBhCBLnZNbrQqMZx8dnM7Lzuai5/zOEUFOAB9hPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRNFKmYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRNFKmYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FF2C4CEDD;
	Thu,  6 Feb 2025 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832712;
	bh=zs++kNZUDyiUfjYrXi2A8zXJqhZ1CIyo4SHfazh+tj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRNFKmYHJt0RCKzCiSgzRo5nOI40j3cOfNVMZNYShzDnsCxS3wdSVVwdP1JlQ5xjL
	 QxET/jBJExotVPCV8xoaidf+sLlhNttIOryOsnqQlgSiq49nAuJgAJilOoCsxifkf6
	 f439W6Rk/pzOP7nGL11NCZBbHsCWPQs81rNQ+TiYMqbWyUe7RdM3KMn9/HOZcg50NZ
	 7Y+fhGoeP+ZtTAXmtjU1gBnNiVap8KfpizsAhU9aIS7wxTcs3uB0ggUVQkx7I+kHkr
	 Ymb6zgdEz3+JtO4B9lpUjrODzyUPJJfpNWKayEgD2fVNqeBfamdXBQXbWluQsynYTY
	 g0s0vKZ56huLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 3/9] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Thu,  6 Feb 2025 17:04:53 +0800
Message-ID: <55948ff7f8df83e08a3a34e430c4e4cd9f411cd5.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.
Drop bpf_mptcp_sched_kfunc_set, use bpf_mptcp_common_kfunc_set instead.
Add new helpers bpf_mptcp_subflow_tcp_sock() and
bpf_sk_stream_memory_free().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 76fe99ffe10a..3f67a24ef372 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -233,6 +233,15 @@ bpf_mptcp_subflow_ctx(const struct sock *sk__ign)
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
 			   struct sock *sk)
@@ -281,34 +290,35 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
+__bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
+{
+	if (sk__ign && sk_fullsock(sk__ign) &&
+	    sk__ign->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk__ign))
+		return sk_stream_memory_free(sk__ign);
+
+	return NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_common_kfunc_ids,
-};
-
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, tcp_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
-BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
+	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -319,7 +329,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.43.0

