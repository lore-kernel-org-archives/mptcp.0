Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCA28EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467170; cv=none; b=iFdzLt43cgyaNBbfmkiA5w+LoeKllwRNITpBQvdAOcdmPrBKn6m2c7/PEfB7ael2yCatRvoipBkNTbgrB30rEOofDYXA/dLcllhGMW9rnxZNKl9ZHZwqJglDa4pT/CsbcD8E6fi7fLjTi3N8QTSzAlIAgJLBAHDgBu0skrxdp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467170; c=relaxed/simple;
	bh=74jBSBcHvOpkLfR6IEqnDXq65A8v4eN1I0BZfS1W0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhGQ7nV+f2CnuqVm3z0jcZkl+ij/z88/xt6CxTqnCjCjp9+Erlnk9J8XSY+JkRefen8m+x4IUyZUxiPNMMa8sERk5QULh/fvaD7N8pVdJRuLDXDlqcdm0fL4bkBrKMi+cIi96IoZ1O2YFRIngMdYsLqZWeUldJVy8ZAFdKRdgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Nj61Ac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Nj61Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56B3C4CEC5;
	Wed,  9 Oct 2024 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467170;
	bh=74jBSBcHvOpkLfR6IEqnDXq65A8v4eN1I0BZfS1W0/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3Nj61AceFI2yzBT9VyNgZHLgiYzFbjf2WJC0dFAIuB4wEk/hCzNYNTwIDBVkzBGz
	 7QEmy592LmWYumldv4HBnjlYpf8igq+sOC8XPFVO6MGnlPEY8/vd+0sf6AavIQWNzu
	 nCXRnZ9X9y620I4S7vmexcijisZudFpE2CbwwipkMk01aWvT7tKR00S39mTJt+AGpT
	 eW4ZkODS/H9NWe4PvmnmiQGwRa4YCnQyRMoQgipBInt1t6nuF/cz1/r0HCh/V2ZapJ
	 nRPsg5Bq3atyelQSNPXxko4V0gVJJjcy0nVlmynp/rvlO4KArE5VGTwX9j6VhTgWLY
	 XSz9ndYBb7cAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/7] bpf: Register mptcp common kfunc set
Date: Wed,  9 Oct 2024 17:45:43 +0800
Message-ID: <0eb5e6ed76fd06c2b7638f9c1adf0d72454b770e.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are useful in
MPTCP BPF programs. This patch defines corresponding wrappers of them,
and put the wrappers into mptcp common kfunc set and register the set
with BPF_PROG_TYPE_UNSPEC.

Two other kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are going to be used in mptcp_subflow bpf_iter selftest, put them into
mptcp common kfunc set too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..71ab1efeed40 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -205,6 +205,18 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk)
+{
+	return mptcp_subflow_ctx(sk);
+}
+
+__bpf_kfunc struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -220,10 +232,20 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
+BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -241,6 +263,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

