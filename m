Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A597EEE1
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626330; cv=none; b=YxCLtlU9lLm/7QSUN2tTT7tmmJZm99n+dPNks16D1sL/qZQAya8eygFRz07zrk+J5muhcKF/toQNYdWCbaE5nYVAUWmAcAZ92Z2H7sSkpUPtXz8IUje+byJyAK1NWW4CsZLJQXPmHw4X2E8rRBaCzWU8rxjkJH+s7/jknLrgfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626330; c=relaxed/simple;
	bh=yjcLUA+DTZMVqbR68A+6gTLzYnn5cOHxXa0JcrEP/rw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThZ2esCazltkRdcakg+f4o8JzysWLde2OnW+CV8MYVOCnWO+uBS5zPHVIr2CCntwc214lhLibG5+gCQV4aMkRZ0k1QTyRGdoulfamnhGqgUoz2gdcREmY5N9pjaV4aeinsvpSnupEDOr4QVmm1iEMAFCcByWbWl2TqcGh/fyu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVYj/X2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVYj/X2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC21C433F1;
	Tue,  5 Mar 2024 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626329;
	bh=yjcLUA+DTZMVqbR68A+6gTLzYnn5cOHxXa0JcrEP/rw=;
	h=From:To:Cc:Subject:Date:From;
	b=PVYj/X2qoxwOlJDFTIfb2Zma5xE7zpQA9YKfBf3kRlIRbEH7u3zcQB9aMvAO/8p4s
	 BzGrI3BclkfJAznCvCdYffALWDP5jU83vG2RRuwr+rAh0XDwdukU9ByelOTcUlw2eC
	 /dc5sgttu4bfI2G/nJo91YYHs2F3txERiz2qI80oJapujOaiEFrbjSGNV3FeRvx+0N
	 PQSiGK4sD4mMLckxgVDO/9AbEDZFQ3mKNdJLKY5k9NHxlNf6VcAhTTiG08OSFGWYHi
	 p7vIuHYwBgehJzO2UI9n4Y+rUMwzaWWwJO230HRgqIMg/IbXZyhP9wmk+FKhTcYjww
	 24fiw0Xyibo3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue,  5 Mar 2024 16:12:02 +0800
Message-Id: <93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the error reported by CI:

[    2.292207] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    2.292735] RIP: 0010:register_btf_kfunc_id_set (kernel/bpf/btf.c:8185 (discriminator 1))

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/bpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6ba531032fce..208e5d3f066f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -215,7 +215,7 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
-BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
@@ -224,7 +224,7 @@ BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
 	.owner	= THIS_MODULE,
@@ -237,7 +237,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-						&bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.40.1

