Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902B339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095340; cv=none; b=mag28/Kl2/LldKK2oALF1i1gqoOQSjGMkSE/hsx9GjxdgZOtK/b1UTi0cxZzI/TGv1QS/8xVy7VZgN2zIt6f7vppMeFKTwCajeUxma7X3V/MlRTyu2amYeaRzf7TsOyN7kWn2XXQiTT+z4SiSgsDp9dmHuMxCvJv6RCcS3itl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095340; c=relaxed/simple;
	bh=VqTVAsqhSGUXZftE1OL9j2P0yI9has7rAi/l33rfbGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbK2GARp20AsKgMPfFnSWBa5PxlmJg4GX8XegV9vj11cFykJaF3qYIZtSDoh0DkBW4pO4xcBFRa8y9K5OLBHZmuLSWaYLZH94gppqEt855hXFAfCrC2/nHP1B2tI3eQnRdboBAlAsZjxRCLW1Oyt4Rzokgq/yzGWMGEQOUpFK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRAO85/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRAO85/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13C5C4CEDD;
	Sun,  9 Feb 2025 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095339;
	bh=VqTVAsqhSGUXZftE1OL9j2P0yI9has7rAi/l33rfbGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRAO85/tCZLvHMYs1cxLHsqbBw7EOXKCKrxn+uQ3yqiYptMbFvuHPRUgcDP1j7YxE
	 BlCsFXYAVK0+QIe0A4aYFnQP/IaVNOQmXlbBhcmunV4AspAS+JPCi5Vlk4zCcb7PoJ
	 YTpiQalFwQ1wPrtH/IOX2Jk8sEtDy/mi+hZjdNnH+bwgFNTVaLGIXASfTwDgxN1kYb
	 ac4pk+aWoBW7f/SUEZUuxitSzUqv6n+6lQ1w2nkQRy43Hlca1w0o7kZ0jl0Wh/abVk
	 UnDgfHQIRYNcEYzyitAP+V14hecFKsUCUsrhQLJPlhdyYeg6P+a3Z0hA7ziC+i+q/O
	 KK5hcozpLxP2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 2/8] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Sun,  9 Feb 2025 18:02:01 +0800
Message-ID: <4b4167eb1a323539e842c243ef5a70e85695edcd.1739083794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Instead of adding a new BPF function bpf_mptcp_send_info_to_ssk() in
v12, this patch uses a much more simpler approach, which using '__ign'
suffix for the argument of bpf_mptcp_subflow_ctx() to let BPF to
ignore the type check of this argument.

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.
Drop bpf_mptcp_sched_kfunc_set, use bpf_mptcp_common_kfunc_set instead.
Add new helpers bpf_mptcp_subflow_tcp_sock() and
bpf_sk_stream_memory_free().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2e713076af5e..a987cecd787b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -224,8 +224,10 @@ struct bpf_iter_mptcp_subflow_kern {
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(const struct sock *sk)
+bpf_mptcp_subflow_ctx(const struct sock *sk__ign)
 {
+	const struct sock *sk = sk__ign;
+
 	if (sk && sk_fullsock(sk) &&
 	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_subflow_ctx(sk);
@@ -233,6 +235,15 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 	return NULL;
 }
 
+__bpf_kfunc static struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	if (!subflow)
+		return NULL;
+
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
 __bpf_kfunc static int
 bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 			   struct sock *sk)
@@ -281,34 +292,37 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
+__bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
+{
+	const struct sock *sk = sk__ign;
+
+	if (sk && sk_fullsock(sk) &&
+	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+		return sk_stream_memory_free(sk);
+
+	return NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
-BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_common_kfunc_ids,
-};
-
-BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, tcp_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
-BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
+	.set	= &bpf_mptcp_common_kfunc_ids,
 };
 
 static int __init bpf_mptcp_kfunc_init(void)
@@ -319,7 +333,7 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					       &bpf_mptcp_sched_kfunc_set);
+					       &bpf_mptcp_common_kfunc_set);
 #ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
 #endif
-- 
2.43.0

