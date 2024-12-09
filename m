Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAE1EB3D
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734048; cv=none; b=UtYLiqvoMkB4VdqPyIZ1AoCwB0078/7aYYGvTY0LAR6AFl+MiNpPJlU3cWBZ708lnhuSgKm00vbhQ6A5QtUBUEm5k8tF7/Pz5Amahyl0sQb+NmRZd9CVyaQ9+Au3uAT/wlXhHnTojblmHYDn70lr5sMesT56IOFT312AnZrbM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734048; c=relaxed/simple;
	bh=EKbFdwz3S9dXyILkw0Qq2CPn84MHoOZ5plQHQU1nvrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/k+d/hf5JSuO53uZa+CxuyQQW4WDSBUnH92kxrsbM+LF4Bo+qkd85Jhsu1/3P6mJ4WsU0ZnnjnYB2SXDnxa+ZxxT1YvqIxOrhSB5Yy2+fy9NZar0oiCFjJRTu6vIUIeHHwHcjvYEz2/ePfyQ03EbKq+heU+u7+QXC7oBevcjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPrXldX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPrXldX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBE3C4CED1;
	Mon,  9 Dec 2024 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734046;
	bh=EKbFdwz3S9dXyILkw0Qq2CPn84MHoOZ5plQHQU1nvrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhPrXldXF96kGylFUzFGdL6HXhC07mYQl6gUlZvBZO2ODfiGGDuGkpl0BSfbS9Skg
	 V9guxyUG/LbrqZIIRQIyBKNGsGg+qlOReen5YhD60c6bP85dRd1TI4tmc6SXk1Usvv
	 bvj517ho8I5R6V1/W00VvZ0qHwoF48PKoQzAqhEjpF+VaU1pMoYdnyj7D793K1RObr
	 vGeg5pSocDsz59If4kJ7IlyWJUv7N1sNGJqvAFVzOKjl6H3HMo4XbopqTV3/I9TWmi
	 p2cd7l+YpcfPTmGhEnE5UmiokD4s4vytBQ0ex9QzvgKMy1da01O31I+/S9n/ZrP5jA
	 WWij3NGv0ck3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] Squash to "bpf: Register mptcp common kfunc set"
Date: Mon,  9 Dec 2024 16:47:14 +0800
Message-ID: <1de02f9ee30ee67ec5eb4bfd9bdef9737e6cd4d8.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock() definitions. Use
bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() in mptcp_subflow
bpf_iter selftests instead.

Address Martin's comments in v1:

- add null-check for bpf_mptcp_subflow_ctx.
- add KF_RET_NULL flags for bpf_mptcp_subflow_ctx.
- register this kfunc set to BPF_PROG_TYPE_CGROUP_SOCKOPT only,
  not BPF_PROG_TYPE_UNSPEC.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a0f49af85d57..f9ba0a46a9f1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -218,21 +218,13 @@ struct bpf_iter_mptcp_subflow_kern {
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
-{
-	return mptcp_sk(sk);
-}
-
 __bpf_kfunc static struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk)
 {
-	return mptcp_subflow_ctx(sk);
-}
+	if (!sk)
+		return NULL;
 
-__bpf_kfunc static struct sock *
-bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
-{
-	return mptcp_subflow_tcp_sock(subflow);
+	return mptcp_subflow_ctx(sk);
 }
 
 __bpf_kfunc static int
@@ -301,9 +293,7 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_sk)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
@@ -337,7 +327,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
-- 
2.45.2

