Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3AB80C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169004; cv=none; b=qez13kd93XvNkzCu1ztsOYnRD8zBa41NCACgm2GcCLNmiXxHY7MFSnC3u+Runin8sD2hl1wI2FyjrRu+jf/XHc1TJHimLXbuyiohImuH0Ttv78/BDA5qg16mjuMAsRj5xDzVHuzn4N7pHxFqREcW/aLDskHXi/yHsEoRcqHRO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169004; c=relaxed/simple;
	bh=AgV7K5szJxnDHwt6AY+DRY0novdmT9FMnxZuD9bvMQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw3pAJpvupmLN1aNXCEdipHNEAnJ7q7Kd0CwQ/v1HRxmAp7FcjqfAg2jNFhfC+iJOAZtBsHSA53Y2D1t92SXMfCRXZ+xcjWgOpXlLWQYOECHIvRVCTA5bPl7NJfllEEddWGA7EmHffg/hRxJmXCjYXzitjs82HygxkTgfUf1GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9F1qRls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9F1qRls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E898C4CEC6;
	Tue, 24 Sep 2024 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169003;
	bh=AgV7K5szJxnDHwt6AY+DRY0novdmT9FMnxZuD9bvMQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9F1qRlslgchG1vWs9AFoRdC4EAfaAgH6QuX+sYXrZgT8HCHFI9uncHbHY4/x/8zs
	 ypTNxxNPs42Zt/RjP4r/43m4Ayn8FGL2fkr8QznrPNaqB/lrEr0DMPE/P+MCNRpetH
	 JPJ8bu6HNCvMcnLOnU7Pf43sI4FeAgiOJYjnF0o8ywVKt2Sn7vPFgJq8Ixle48QzJU
	 ZCv7FxQlJbMBhq3RTLYj5cbUoxnM7nRBrvis4M/MKitnUE+fbCNirv7onprE39AFpN
	 4o4C0u2DWQuQsxeHOZYbYi5fsoENWzKM+FXv77FNxTRvLJc0WAYCxDwJAaDhCFGWuw
	 TzOcchbBV90NQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 01/10] bpf: Register mptcp common kfunc set
Date: Tue, 24 Sep 2024 17:09:45 +0800
Message-ID: <fefa530dae14052a7c64bc07fd5f6512b4f48cf7.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp kfuncs mptcp_subflow_active(), mptcp_subflow_set_scheduled()
and mptcp_sk() are going to be used in BPF selftests, so put them into
mptcp common kfunc set and register it with BPF_PROG_TYPE_UNSPEC.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..959d1d6af036 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -205,6 +205,11 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -220,10 +225,19 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -241,6 +255,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

