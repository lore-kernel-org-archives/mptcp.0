Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D8146D59
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170125; cv=none; b=MEKxQ9JUykBHBg/CyKB8EncSBWLyXflW2Z2VQZTJo6p4T+H1fWPagZzbWnR31NUVIeiDoDIIyGZqMVXSVjKiQ4+sK/TKsrcjhoAM0WYVQeO1ASpB9UOIYiZW64ZnnHqMJrUPFzmQvKuBggJMPVU35bT85+Ejn/rcgj8CzIUwVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170125; c=relaxed/simple;
	bh=VZrjVpvjHQqoJi15H9JsGJT+wrzfq547tdmgftY2cJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APCA5YDEvyFXClI7Iatyj9fkp/IlguX78zwwQPXkRFYIWFjdssJYM1ULcCN70Tqoeezu2152sbC8Bd8wfL6koqHufHpninemoXdHYCcs30swhbzKE/7L4cwZ0VQHoQaDBQ0+bCK3OvQN1WuWCF7JgQlE9ljLf8Y8bXQzPUIjbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHTly4fA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHTly4fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0ACC4CEC4;
	Tue, 24 Sep 2024 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170125;
	bh=VZrjVpvjHQqoJi15H9JsGJT+wrzfq547tdmgftY2cJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHTly4fA71ftUANZpoK8vBt5dLdKZZEzpr9/zXhaSsnJ0uPSHgC4IH25ot1wgIGaw
	 c5oIYniQRZ28+jswklYg5dJIKxX2jGO7B8UyvBlwsTrDkjQCThg11GROZ8gogn3r5U
	 u3fYP42qp09nPesgUlRw6f/iSxc1wAWkkAAnDBctx0zxNmRBMhBzupUPR5EhquYam0
	 UIEMrde4+yuLUP0P4liHQ8T3EcuQj48ojt9IHlAXj2C2tzBddgvLS8j9HnIXm/Ho3d
	 NzIENwyy0SFd1RDXxwVen1Z8EGz7g4aBGC4RlYtXu1visJ/v+BX8Oct0waBkNrvcpa
	 hhIGNPIXJ1YIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue, 24 Sep 2024 17:28:30 +0800
Message-ID: <5b4cd68a6c2761c437cdb6d9e5c7b6a0fd4b9c28.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ff2589b5edbb..a133bf50330d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -299,19 +299,19 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_struct_ops_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, bpf_mptcp_lookup_subflow_by_id)
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
@@ -322,7 +322,7 @@ static int __init bpf_mptcp_kfunc_init(void)
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

