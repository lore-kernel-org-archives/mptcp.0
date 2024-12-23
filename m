Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF043D561
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948373; cv=none; b=qXgTzAOYZwgm+EpNeB7o6DD+JX2+NwxNG9PL3uu8kGoUcZ2r+h0Jo2ejMvcxHGeJGXb8JzU2941fDLjntp1gP2GzktDDK805zgbj1jIzg6hLpyJxFC7lX+qeU4wkC39DTh3dbtLJTYEMJAUqHVZfqSDvIWD4siAmyMusMiOdAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948373; c=relaxed/simple;
	bh=ZKed6Z6Ub38fqUBJ3cheopo9QiT8qYIWUJniS1BkXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgvTAjUFTO2NGNW57meyXCn5hINWtcJ8Y0cW+bfpBUJl2C4qsvngjh88gLYYlyUpNRwze77exEx9ldOgUVbS3WnHLTIUEeVtd5Oa2eLuEUT67wG+p4CC9ZkX0jh77FAeyDppuIe3TS/xHPVXcDZa0dmco2IBOldbv7o/9PBY6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KndyN7Ix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KndyN7Ix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75915C4CED3;
	Mon, 23 Dec 2024 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948373;
	bh=ZKed6Z6Ub38fqUBJ3cheopo9QiT8qYIWUJniS1BkXXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KndyN7Ixa1JUdNXrbCDfgBWfBw0lRIb5kwAvfFauDCCMYkppFxK6l9zBBVEp7EO4J
	 ctg3d9FRK6yXN8QKtkzrSQACujQ4ExO2b6WJikh4DHH4hUgpQNtHDqpL1Ac/DYVZOt
	 uyrWCOERQoSL8h7Ud7V9Op9h3fJZ5Ntlono4bVnNABdPRVs0c8mtx4sCyApe7asNgJ
	 j7Cl35MNTsZcHxbxwrQz2/hRsDbbT2+iTWziRHZzDbMtN2SyClXXWdG3QB3/6KqQba
	 R92RTIaoCQZTBIClsFSFfXOSpkhqTBS3b817EfnU9yiMs/HOI0nu6KKboojoYPfFYZ
	 kaLGPvDnI9buA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 05/10] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon, 23 Dec 2024 18:05:47 +0800
Message-ID: <5557033ced24659b2f9c6dd6eae841389497ac16.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ea8098c6add9..de6d61d47211 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -317,6 +317,15 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
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
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -331,27 +340,19 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
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
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
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
@@ -362,7 +363,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.45.2

