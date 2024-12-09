Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405F14AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724763; cv=none; b=raztFwmoAnllpNo65p7t0c5lU01QykFWX+VAQdtlJM9NZFkjt6WvbBht7SzhaJMYIeRYbKNDAhKRpt/Z2i4GLm8WbaUHp6yOVK4TopcHp5Uyh2OCr2f22KssohW7DGXsJkWhE032oeljalfGIitOd7SNSPuiNXwBCD7PFaaebes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724763; c=relaxed/simple;
	bh=EKbFdwz3S9dXyILkw0Qq2CPn84MHoOZ5plQHQU1nvrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSSXzdAhYYj6DQqrT1aGxghF/4nl2ODYs9cza9AW3X1quZofLJHiVVxXL3MR4FYOS244IMeoxpK5ViSt/1a6ruGtoiASMlo5EAlUIDykgZEZX4qWEx+XQ7rElepC7mwjuLLZsrgtP8j4PBYMBCbeFejhPJnivoYiqh6ERslZAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMqvkmbz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMqvkmbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA56C4CED1;
	Mon,  9 Dec 2024 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724762;
	bh=EKbFdwz3S9dXyILkw0Qq2CPn84MHoOZ5plQHQU1nvrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMqvkmbzP9WoZhc6mPff++BV1sTCU8zBn5HZmj5Wr2Wty0N6Q/1HN182AN+W4BJlw
	 WuurWsANGIoGHorZW7T75YctbV+H1JQX5xcKhkr/dv+OBti4kixsKOKHWvz/UwLUFD
	 kdib6jWmG/BOkuGciCCItmkN4oljrdWnC5tZlcPfTjqaA2DuDhKdpZOIEfCgQaHv5N
	 nvUQvWoupCz0YklumoJQ3YYT0jv5O9aBOja52qG4CPlLbNh0mu6/EeK7Wn5NsqZl2x
	 PHiEvaWRiz0cT59JN/wUE1MMhru6l4DsCpQKLL1gWh8U06vKAj7KOcHAOHfZcgZBiz
	 R9xYpQHg67WQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] Squash to "bpf: Register mptcp common kfunc set"
Date: Mon,  9 Dec 2024 14:12:28 +0800
Message-ID: <32f730106c25cd3b2f3d63b664efb144161952cd.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
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

