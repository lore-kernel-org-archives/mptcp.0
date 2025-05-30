Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6A19D8BE
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592237; cv=none; b=RRv6wfxQolMpXbCD4LKZZs/O5txK/wTg8BdhBdpSr/C8k8K7yw+12a4WgmBVKDS8Hg49oyZDDgaOGPrK7+Fx8gAvPBbIKRnvqSymNZ4hwsN3Yz7c+9Qm+weybrxApcJEBKbZDLuKgjyd/+ulMlV5BGxeiiw08XckRIo0pjzfBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592237; c=relaxed/simple;
	bh=R7OcBtNr9GD56pS0bOUU1qz3Te3ubEJ5YHSKFmUb33k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwHWty5iF7mBgej+uY8ypSU4OC5u5yDdKBIhQK9KA/FnOk1rKqT0k0aoO25+QNC4WStRVh9yCVTwHci0so4I9/8/n0+2eKqTZko9UQ0eMizGKRPzrF3vhr9nRQUJWamCxFt4kNo6019/IgnJ/1qVsMshZ68x+NpoK48VLTbxGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYgUYWyC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYgUYWyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA0C4CEEB;
	Fri, 30 May 2025 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748592236;
	bh=R7OcBtNr9GD56pS0bOUU1qz3Te3ubEJ5YHSKFmUb33k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYgUYWyCZzdlvZPZHJtCB/6NxFWgCx4V6lXb7oFnK1nTQUaaQV0eBMITtRqK8R8VE
	 j5gPAfwV0TENEoMvHzEpxSFZTKPFHJoIvg4H05TAJLofRR9w4HNfrlTOOaZ1aKExRN
	 6qgNtMtsCcqVFJ8jECtt3o/zoVg6cnLXweVJcz8fxcojggY19Mi6aOPE6m7kLx8dZv
	 SSFVmJxOvtOKgPKSJvA5hFHsuJ/Yp+et8guw0LpexZBe/RVr4Pu/VV2OYjvijVqCVy
	 4svFlomYlb2cAK6LX6fNvSr4MlSQ1aUwnsBbkdevnfIR+F8IFKuDKDvgsX9rAKCDbr
	 2zv2yKwh3kZDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] Squash to "bpf: Register mptcp common kfunc set"
Date: Fri, 30 May 2025 16:03:45 +0800
Message-ID: <645521eb435c9bb11f2ebb488391e98b245c500a.1748592117.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2b0cfb57df8c..113aad086b37 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -317,9 +317,25 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
+static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		return -EACCES;
+
+#ifdef CONFIG_BPF_JIT
+	if (prog->aux->st_ops == &bpf_mptcp_sched_ops)
+		return 0;
+#endif
+	return -EACCES;
+}
+
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
 	.set	= &bpf_mptcp_common_kfunc_ids,
+	.filter	= bpf_mptcp_common_kfunc_filter,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -327,8 +343,6 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
-					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

