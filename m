Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F637BA3D
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173025; cv=none; b=Oo5L5xq6fqZhBwUDwma0/tdPUPXmnOxD99I7XLe17NbsIOVHTjRihjwuoWN/vxutADQRpzJw+it5VS23TxDPfKpX2dMpyWAMf/TWN3lN/0SR1FmeXQLC20vKBvXHKNZptxhwjacxDCT0ct1+slIwDL8vJYhN28UyMGw2cYJ7ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173025; c=relaxed/simple;
	bh=UTSmcN6aOzBKWoWmfTdjkRmeqFIiQofXOe7xIuOSwbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfM4FUXuWX4SMAlw/KepVyOKtxyNk0OKPfZjhOWtkg1AtltZxdnHZk0qeb/gMSZ96EaUkjJAldXJ60gKtCSmc75+D9Au++foA6qqWqrIs+5q/xbcdp0n7al7Ex6acnbBL+zcXuswziSdhgfr/jfKrNVZf8uXcLkQpSA7A8WIm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op2nJckf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op2nJckf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD3FC4CED0;
	Thu, 21 Nov 2024 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173025;
	bh=UTSmcN6aOzBKWoWmfTdjkRmeqFIiQofXOe7xIuOSwbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Op2nJckfhGjNKiii6gbysuVE+O2T6f3KJQpWoEEhyxEu6nzlpeH1+YdTNU1gQougE
	 ZBGZqzO59XFnUMzoSFsP1oJGg6AaYfagZTCkmwM2Pd97QSyriPEsyk3DfLsTjJ3Y+W
	 jsWquH16+D1S4o1sNt9BoDnBUK9rrPycvjXjfSBnH2+i+31aPiECpsgd+dv+4bqTQD
	 po5KZygvH7+eJdK6BC3YVOLhrLXHQveZlxW5V0GB/HsJ7prjlpsQD0Pr8wZaEsiCwI
	 nO9onRXMXNMo9W+0KcG9Ezx3oNGAYEaPGa2kvCZM9hcVC3zpy6tbFLbCQZl/qUEDnZ
	 9/Jx8pEhICCWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] Squash to "bpf: Register mptcp common kfunc set"
Date: Thu, 21 Nov 2024 15:10:06 +0800
Message-ID: <a8dd1ea380706bf21677f99d283d4b2838db4fba.1732172851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732172851.git.tanggeliang@kylinos.cn>
References: <cover.1732172851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's comments in v1:

- check IPPROTO_MPTCP in bpf_mptcp_sk.
- add null-checks for the wrappers.
- add more BPF flags for the wrappers.
- register this kfunc set to BPF_PROG_TYPE_CGROUP_SOCKOPT only,
  not BPF_PROG_TYPE_UNSPEC.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..02038db59956 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -218,18 +218,27 @@ __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
 {
+	if (!sk || sk->sk_protocol != IPPROTO_MPTCP)
+		return NULL;
+
 	return mptcp_sk(sk);
 }
 
 __bpf_kfunc static struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
+	if (!sk)
+		return NULL;
+
 	return mptcp_subflow_ctx(sk);
 }
 
 __bpf_kfunc static struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
+	if (!subflow)
+		return NULL;
+
 	return mptcp_subflow_tcp_sock(subflow);
 }
 
@@ -299,9 +308,9 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_sk)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_ID_FLAGS(func, bpf_mptcp_sk, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
@@ -335,7 +344,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
-- 
2.45.2

