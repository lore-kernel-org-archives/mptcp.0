Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA823CE
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788887; cv=none; b=RXDzn3ER4TJS5PUMx0xw3fgCI8rrs1xTZZVRKZ0Jmd0+ZVirqss9EOhmQaY1XgK/6vmPd0yoB/nKMkA/RhZoy2BAas1IGUHUdyL8VqeUe+mGi1yFpHkN9ggTA3XEbTWtFS61lfPz5Bz1CyXni9crWnx9xwPO9aKByj2iXYDWEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788887; c=relaxed/simple;
	bh=Zb8VbAQ0w/tAIbpc9ZelYKxLlWng0X2pfbgu13dUC2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWCvvByp1H+bAxfBQbp2hA+lm0JN2xXLEgnI/AV1fkiYzMSHaf+GeUsLY+MSbeWNthJEng1HbjUdrJzm1+4xHBpg62fI1mGluXPaJhzsOl3ZHkOcda4rojBiS556V4YCnO2kydqcaHH64U9v/4gGJ2zUFHz3y8XOb6za/KHSWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBqfcayk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBqfcayk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E14C4CEE2;
	Mon, 17 Feb 2025 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788886;
	bh=Zb8VbAQ0w/tAIbpc9ZelYKxLlWng0X2pfbgu13dUC2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBqfcaykTUKIv1O5F41vPcR1DpiVbzFN5syYbrqXxsqbCm2wSSG1Ymy0X3dRpM5R2
	 VrpiZ+gEfBR3JcGBAzK4sNN2iVMCHBq/jY2HB+Xdr4KNxHI8A7TZ6/8F1PS8HmDgxs
	 fJ1621SomrcAPAOU71HQUzY7sJ9HjPDaPnEezb8yyVuB4DfnD9QdyC9hNVj8e2yA7U
	 e+pVaIhRiLMgZbRcjRwPjXb9pW4m93zy9IpDmmSOI/w+vu9ffb/RGey0URwGtdyeS8
	 E5LwQ1piiM/qcv8COhtiI6wvV2uMht1kKCyoXfDLQ9TskTySEE13MHl74tw98Y/P2P
	 e2K4ZlK0HmZKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 2/8] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon, 17 Feb 2025 18:41:12 +0800
Message-ID: <6a7fe51097cb3bdfb01aec206869dfefc5ca6258.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
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
index 2d2ad38ab1c1..80fb1799b067 100644
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
@@ -283,34 +294,37 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
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
@@ -321,7 +335,7 @@ static int __init bpf_mptcp_kfunc_init(void)
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

