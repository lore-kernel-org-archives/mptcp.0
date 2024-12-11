Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D58CA4E
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886730; cv=none; b=pSLQJz6ob+1bupfgpxQAOaFLsdfvluSjKIBykRAvaKqHi6fL5RkgM6dDbpuSRJsFebuB22VfLcx/yViYhMV/F7ewYPTX3OjKkAJVcCNaDHss8V9FCLWWsQpZafgFbWbOv++i+AV/iQvRrThzs4Ku3lUKN61esKeOoHmKr/dMEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886730; c=relaxed/simple;
	bh=fTLi544gDaKxmJ1r9ykIJA+VWbYGcQfmHnEBCq8NdV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0NQv+EXkhCv2FmGJAtrhHdN9hvD+d5c8gQDz+PwyOCzwwyQBLivxpcNAUoN1eadwSUCrQe9fU9Q49BileqNIEiEb73mQ9Rmc/u2S9fPO+ilcLfb4OA6LnSK6wkcfpsAH4S/kPLGpf0dSVDYPy1urxzOrqj/8ANyIjf56jBnPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5tgJp+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5tgJp+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C03C4CED6;
	Wed, 11 Dec 2024 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886729;
	bh=fTLi544gDaKxmJ1r9ykIJA+VWbYGcQfmHnEBCq8NdV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5tgJp+95d41zUXTCyWV3ocEedZRZbU3QYOg20AnRSze4ylNumZRVOfPwfKEuCd/J
	 enRRukfUbPTd2lja6DITlbUj0i351o0f3HTJbzxNH6PaGD97rbV6T/akVSuNN4j5cA
	 ut9siHQLCurmkFpiTfBoaojXP4Zhi3xeWs29IWdHrbpuCvgAAztI/0mC5MTYCwMwS0
	 XIY/L78JRxY5rUDKw0aeD6AsUauz4nSrM/lyjFsRVuAQmroO5aF+yKC6CCIouVOXEJ
	 6e+Y3fEw49hI8P56c6WtJks+Xxq2Cbi0dXSipbOcOV4JkbwvUgP4DFzjy8wGfmzukz
	 Xn10ZejBPaD7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/5] Squash to "bpf: Register mptcp common kfunc set"
Date: Wed, 11 Dec 2024 11:11:54 +0800
Message-ID: <09a1b24f12b97f7c5737da1e2a0d1ff1e9c35fde.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
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
 net/mptcp/bpf.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 1e8efe9cd4ff..e2a85ada213e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -222,21 +222,14 @@ struct bpf_iter_mptcp_subflow_kern {
 
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
+	if (sk && sk_fullsock(sk) &&
+	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+		return mptcp_subflow_ctx(sk);
 
-__bpf_kfunc static struct sock *
-bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
-{
-	return mptcp_subflow_tcp_sock(subflow);
+	return NULL;
 }
 
 __bpf_kfunc static int
@@ -305,9 +298,7 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_mptcp_sk)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
@@ -341,7 +332,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
-- 
2.45.2

