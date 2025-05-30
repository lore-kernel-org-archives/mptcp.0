Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64319D8BE
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592238; cv=none; b=lt3qReYG8zr+89kKcmyGcGqSoWo/EVoZfieRzBj47bFmQZy5qtpzaRsAj7fSj//90l8CHxiJgfjuQSgssKppoXS9wq4J7wurj6gc1JqqOoxaJmksnlGJyapI+N5cT3Ne57a3imvEnWSS9qxhtlxqbrITOJJsXulEYR9EzkNpgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592238; c=relaxed/simple;
	bh=Ny6PyKWOwcmzdbiONiwseNXId6pHr0PyiKHYxRMbKko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6s4FOot0Ji97CmD7WaWE6ZvaXyT6AlRlbYpZvqqb6C5P6u2VjuUonBfEoRCevQmxfb/EyxEz35kEZTxa7787N22Uq9iODEHZtrCyUGqzbMIWOBDGhLoTENC7/TR71XOYtd1tnrJ7xn4K9/G8vy2mEtlIyJ0Ie359ooGD4o92w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD6Mk6NA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD6Mk6NA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3483DC4CEE9;
	Fri, 30 May 2025 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748592238;
	bh=Ny6PyKWOwcmzdbiONiwseNXId6pHr0PyiKHYxRMbKko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD6Mk6NAwevfYBtta//9P0QYeV8rVgprrZ50NfIKPguSEvlVPnWrQ4Oyk+vm0ymzv
	 6SB/l9xRRqyoEFuqCOmmFuaF4/MA3V9kg9ep/m5/Ix3Q5w9o6bb66J8EaYbpXe4ql1
	 n5tp94LEDHa40UzoVMYcHNRbW72K5gJ8bsuyy1mufCMPXK6hXSJIyjBI+CA2ou/5ej
	 orxeGsdCRiteizZjvRQHqMiFlY9E5yDQ3GdSZHNJj38aRtMC1yveEXbfhqDdCx5jgm
	 T4DTh/Ndhj+iYCCB7Z6JGfRFoqTPXmlhOKqCM4UrWjekmgovR2Ogukqy3iwXs2grSQ
	 3W+aDwklTGH8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Fri, 30 May 2025 16:03:46 +0800
Message-ID: <844a8399d77722ad06eb11751c468c7f46d3f3cd.1748592117.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748592117.git.tanggeliang@kylinos.cn>
References: <cover.1748592117.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Define .filter as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 113aad086b37..e52821bae49c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -305,9 +305,6 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
@@ -338,6 +335,31 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.filter	= bpf_mptcp_common_kfunc_filter,
 };
 
+/* .filter is called sometimes before prog->aux->st_ops is set,
+ * then prog->aux->st_ops is NULL. If return -EACCES in this case,
+ * an error occur:
+ * 	bug: bad parent state for iter next call
+ */
+BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_KFUNCS_END(bpf_mptcp_iter_kfunc_ids)
+
+static int bpf_mptcp_iter_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&bpf_mptcp_iter_kfunc_ids, kfunc_id) &&
+	    prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		return -EACCES;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_mptcp_iter_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_iter_kfunc_ids,
+	.filter	= bpf_mptcp_iter_kfunc_filter,
+};
+
 static int __init bpf_mptcp_kfunc_init(void)
 {
 	int ret;
@@ -345,6 +367,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_mptcp_iter_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.43.0

