Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EC190045
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588548; cv=none; b=XztqK2zDZgK7WHiazzCzn4eu2dxfv4J7XAF6xRBIci65lAjv3T6MorB4x5caKEYNkOkmz1EHWvH/uWRvZ82X60m0G7C24yrqHkJlAvoYF8diiGsJPgGG8eqmQRAYAPKPKopFWHP02ecbWElSHMxBHANHvl8FrJFa/XS5bALqUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588548; c=relaxed/simple;
	bh=+5tJQvWjVJdlQv8PGWR/P4nNtl2dDlaiqMOGzaK4huY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx/BnZqMdofra+kxvwo3130k/nsl1VDdev6SlVuqfPmbJYjd3bnQVGqudkHaI2830hYn1s9vG8FA7vBqQ62dD8bLCh9Hni+bEfGnvyC5pSwS4nRU61lnjDit0wuJ3x8/T+H3L2WCARsgDoLyxItWCZiqudtBbGbLln8RPUxomZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPaYReXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPaYReXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3062C4CEE7;
	Tue, 22 Oct 2024 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588548;
	bh=+5tJQvWjVJdlQv8PGWR/P4nNtl2dDlaiqMOGzaK4huY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPaYReXjbkx2Lpqszkvy96HwhC3f2F773CGYVLyRiSE3q74V86xKcnsjtneDnSGap
	 sHzZkldIGHhC/PHZIP38vrcgIYJOu+ilC+CuUd9po5SPtABeInLyYQQkdBv02j8AGy
	 nqKBDLHhp4Cg9tYNWiFP7aIykNiCcJDGMt+WeYKqFq6jpC8KNi3vL6du2zy0VKHRnR
	 tNxjFELJyVMxjbvW+FKQ/kXxmpPGuslS1Q3yN4RqqSXxzkViEcjDrT0INz2gO3mhHx
	 3o0dMmA27cYtDC17FlqGYNOAZ7BH9DgESTPZ6MgRKZmgdCfnvhu3NGOosbzbaZ1ryj
	 okOJnUFLT0Cjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 34/36] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Tue, 22 Oct 2024 17:14:42 +0800
Message-ID: <e2613f1223bcc1e881604207c32a8c6a7afbbd3a.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_mptcp_struct_ops_kfunc_set has been added, no need to add a new one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8ce3a48c27e5..2583a6af6628 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -743,14 +743,6 @@ BTF_ID_FLAGS(func, __mptcp_subflow_connect, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, mptcp_subflow_shutdown, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, mptcp_close_ssk, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, mptcp_pm_nl_mp_prio_send_ack, KF_SLEEPABLE)
-BTF_KFUNCS_END(bpf_mptcp_struct_ops_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_struct_ops_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_struct_ops_kfunc_ids,
-};
-
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
@@ -759,11 +751,11 @@ BTF_ID_FLAGS(func, mptcp_wnd_end)
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
@@ -775,8 +767,6 @@ static int __init bpf_mptcp_kfunc_init(void)
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_struct_ops_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_pm_ops, mptcp_pm_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
-- 
2.45.2

