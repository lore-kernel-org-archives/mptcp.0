Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AB18E379
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469800; cv=none; b=AKgMilGcOzqQmjtjWUqg8ia8KxxxLiWJMQIhwxnvnH/kwN+le/arVDP2BH07+h/VRzBT32a75xccsaCTv5x4fv1wIRP38ITgqBq85FKPXrr6Z6bNl4RqwRxa4BO7oMRChA1pratQSVESghIyoKlGP4RDI1gouCOpchjkBn00EWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469800; c=relaxed/simple;
	bh=BYLxj6HL1RF/l2Xs2VVebQy5sbOBtOhVuu61yZVtQDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/onG/kKi38o0jkAssAPYG2z0muJS1XBgWhmaZqUo5pZtA6PWHveCUrrH0DkC2tjcpcxXhUzy3iL6kwUeGh5hocJAfAI422qDLXIwyuGqBCr/Av0lcuZRFfShhJg4U77bmg3y5itYn4D1mUpuawoMJzX0D8RVamtLLIwDuimuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INhFN/p5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INhFN/p5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F9C4CEC5;
	Wed,  9 Oct 2024 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469799;
	bh=BYLxj6HL1RF/l2Xs2VVebQy5sbOBtOhVuu61yZVtQDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INhFN/p5msgqXutHnNvH6Lm6o3hLJ4OP7m7x36EnwlLdolZD3XpuUXt2vHRkJXklm
	 kZLWwlS6QARWeYhk6Ta38YcNgOk4PFk3Lz04GkJGa0HVHhTnVJ2Na6EUfvM7bPKysu
	 JsJMLZ6Bpi5ZNPKSCKut7Gs5uTYypDhMUJHNOBq5aLM5sPfcdvg4tKPdZ2LZCpPJlt
	 SDJ50NOo4pJ9ocdZoSwYgszKP2XrTL3iU79DoZKAW030D2sCzG3SrfuX7MW/r0DfXU
	 fdeN9F7ScMxR1+aUe4zErtKi+HNBvFOiLHWYjzQjnDsBmtmwowYnBwCcq1msgNNyv2
	 iyiig58XTsVZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 01/10] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Wed,  9 Oct 2024 18:29:42 +0800
Message-ID: <0d009264ed09e2988eadae3c98a1926dd981a353.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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
index 9b87eee13955..c9aefe9eec14 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -303,18 +303,18 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
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
@@ -325,7 +325,7 @@ static int __init bpf_mptcp_kfunc_init(void)
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

