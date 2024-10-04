Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F269D2B
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046796; cv=none; b=RqDCT2A71VIFz54rH5QItUk7Q68qOVDFDjGgkSEg6qBbOFWKl6HAEsyXP14FLCHmtOt7Tc29dqK4z12EsHjhhdACdumE2/a3nvxfEnEAS7lXYN7E+lUe5tyd80nyjgfG5SRVU8atASaP2o/d6Lm3MmWXaJnmdsAXJKzCaDLJPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046796; c=relaxed/simple;
	bh=8uqrbsw5F3PKe8wZQNJKINzZyfH7oTc5Z/90atNIVpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2PBCgfBWHkpOO/xEOjwf65VnkxRL7ZV+Mtzljc04OiVW7lvuFnupW9eUtYrmZ95V9g1BClZkoILf0ec57nNflnV7aFcXSfne/b4IKr1h/FO5/AOZQDYHR9aIa/n9/GItHObkb3eQbOQf0m14tSl74FaGl0lcpHoxjj+yEbq7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqMkoZOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqMkoZOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAAAC4CEC6;
	Fri,  4 Oct 2024 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046796;
	bh=8uqrbsw5F3PKe8wZQNJKINzZyfH7oTc5Z/90atNIVpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqMkoZOK3VIAWKtgsXy1WO0W2g3HJfFHJGECH71U6VUF1LbLBEIC2PSbfajemky/P
	 3b6C+cd6UH4djl896IRSpPBxKUNZmjkW6KJ7iv+Y/DQKfLK04eOGbbKnvYH7y705Sa
	 5/o0WKsVWAJGyFgIRPnG4lcX5xrOcNm6xyUJPEYbJddEA6GPmDE5OyzJuwMMhZtbQB
	 yvjlNScj/nvyYuTGpEBid055j9ot5FP6NebLiXrt8bzU+0UHogbcnOOAXW7lR7O/3Z
	 SgPfZXTYK1nfBPy8QDYtqbLPwe9UbsSiIBL+7elUi0UnJ40e4AMwvfVHvmHuIejjcv
	 W0EcscOQ+GbzA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/9] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri,  4 Oct 2024 20:59:41 +0800
Message-ID: <e3cf7e776dcda27feacbe0e498656c5c8d5947ac.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please update the subject to

        "bpf: Register mptcp struct_ops kfunc set"

Rename bpf_mptcp_sched_kfunc_set to bpf_mptcp_struct_ops_kfunc_set, since
this kfunc set will not only use in bpf packet schedulers, but also in
other struct_ops like bpf path managers.

Rename bpf_mptcp_subflow_ctx_by_pos to bpf_mptcp_lookup_subflow_by_id.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 1dd98765e2d1..02f5fadd0f89 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -309,18 +309,18 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_struct_ops_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_END(bpf_mptcp_struct_ops_kfunc_ids)
 
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_mptcp_struct_ops_kfunc_set = {
 	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
+	.set	= &bpf_mptcp_struct_ops_kfunc_ids,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -331,7 +331,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_struct_ops_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.43.0

