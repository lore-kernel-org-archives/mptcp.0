Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56146148FF6
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046263; cv=none; b=kHRxyoHdeSMaiyB1+BSvPJNwr0FJ6i0/aSuCmfcO2APtKhigq4zX9SWWjSbNYvn28xf/9jAgcsv146lspr8V+C0jbC4ViQSw9Tyv9hzK62tArmrSb8q8MXHvOpzfGVtNWO+EureXFtY9MsRjjWgkia1ANKp2hjXaJ9CtMwNtYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046263; c=relaxed/simple;
	bh=TNhoiMjMuRV0q6ikbbbcSagg77q1gkuJcavG4tqvUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXRDT+Bu3D8txH84NGRVN4GFF6g3Vijt4OFHqWYS6+HkR1KQe6lCzlwVe8CII5n0QWL5g44vcGNXA9tlCPV+b5rL7qH3NOpwcqdQch8LlhQK2kSLcmpsWfyWPIZqbPs5dURRf92t5mdxktegGmzSnBafOzlMrVwt5Ie4Y29K6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J07ILc6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J07ILc6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25365C4DE13;
	Fri,  4 Oct 2024 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046263;
	bh=TNhoiMjMuRV0q6ikbbbcSagg77q1gkuJcavG4tqvUnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J07ILc6//jG540YEN6d2mGbsnSRGXyf2pCiY7cFxila1TPZbXgAYBsSvlQ4jFroyO
	 c3uqO2c9ib9tLSDk6KiRiyJmfMNjFKi77a+nxO5EuvwnwrBGI3MkkCtjSK6zsvjqNe
	 K8Lv05wON+C0vpgMNDU/xhlFyheVRaEaIBRyTjxMmumC4BC0g/Q/kXL0kslgSGxPLj
	 3eFdL9PGwc1ytXzou16m0kQMCRD3xOiqSkdeq2HRApiN9RvJIFnUZmt13Q6XrP8mCJ
	 IRckZGeTaxiLd1hKoK8FA5yClAtuokCU0GqWhrGnjO9C0bJSXGJY9Kz43+8zXtVulZ
	 WdH7xeYDJwJAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/7] bpf: Register mptcp common kfunc set
Date: Fri,  4 Oct 2024 20:50:47 +0800
Message-ID: <123f59dc2484dabb2552f0fe49a69983d327683f.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Helpers mptcp_sk(), mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are
useful in MPTCP BPF programs. This patch defines corresponding wrappers
of them, and put the wrappers into mptcp common kfunc set and register
the set with BPF_PROG_TYPE_UNSPEC.

Two other kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are going to be used in mptcp_subflow bpf_iter selftest, put them into
mptcp common kfunc set too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..c8bc18dff85d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -205,6 +205,23 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
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
@@ -220,10 +237,21 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
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
@@ -241,6 +269,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

