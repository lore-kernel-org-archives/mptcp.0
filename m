Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF4745E4
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946661; cv=none; b=lsirrPbDKr3GJGbF0ncAUw/90RRhCinqbjfBkchptKKWfxmQVFg53xqMp2KuAcn9O9UlQ2TYvRQLplVN2qXajT05ovLDmRDPte4KImQBUZkYP5SCV0qAObWUGxstA1NcnMPYN2UYjg2NbcWbAE8sVP0RBatxQZknCM08SGnGtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946661; c=relaxed/simple;
	bh=ctGM5HNGWg+TWVqntqqihBJb2GadXoWB4w1z564E9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxmuZSiw22ym6sKseqyvaQ2s0IusTl8qdxxGNhc4wm+NIwbQsox4MwjFuZyZ4IgjkfmW5hZ91QGMnR3TO1cZsmoyVc7eOdj2bvgPw73/1YBS9CkStDzsVBo1erK0Tf1CfAEqX3fBrgOG4AElpzEm4+qNhnab5GI15cLSb0aDh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz2DVOdr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz2DVOdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FEC4CEC3;
	Tue, 10 Sep 2024 05:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725946660;
	bh=ctGM5HNGWg+TWVqntqqihBJb2GadXoWB4w1z564E9+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz2DVOdr+VvI7/44iJslvxhy3ZTzW7IDr2RrikdlefATT0aLt/fS0FU9HhNdaIhMd
	 mqqwIKf6U5EKk+GicXOjdQi8vjdwuQ2kTlUxfsz9DKJLIYvu+Ur4lFrP9O9H05rTML
	 IsX1cWMgDbvEtjbsRObcc/KrqP750QkHE1mVn3c0Lu8bAa7DA37XAwtxyUOfS2TiTk
	 93YGxAFtm54xPUh1VNMmfvWE9gYIn8EhEjMDyMR98IVj9Nd9IKvwtZYgeHh5jVY3FD
	 bSJya0rPMnl7NNr3SJbnzoFC/54kjayVhVXf84Cz3vaBNSfavHsRMESvQ8+/qAE+ub
	 DwHgR8OUDudHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] bpf: Register mptcp tracing kfunc set
Date: Tue, 10 Sep 2024 13:37:25 +0800
Message-ID: <868a19c46b7ec5592d1173e52470bb62c9a0344d.1725946276.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725946276.git.tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since the kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are invoked in the mptcp_subflow bpf_iter test in a ftrace hook for
mptcp_sched_get_send(), it's necessary to register them into a
BPF_PROG_TYPE_TRACING type kfunc set together with the bpf_iter
mptcp_subflow helpers bpf_iter_mptcp_subflow_new()/_next()/_destroy().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 350672e24a3d..0b7a0c2634c4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -260,9 +260,12 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
@@ -280,6 +283,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_mptcp_sched_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

