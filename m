Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12781CB32F
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181803; cv=none; b=I7zGIMt6aXubIFPmF9PuqDPQQk+szbIlL0XVR+aaWfnW6BkCH0O/7IO/36twnhB20olyNXRg+lEv8lqIMG1F5+aAGGD+1B/7uPSGMCpbhuz1jal3Yr93y94PWmuMxdQ/0cZX+3m6WM7J8oZd4bbuYg4/ok9AiWoJ6cyziZZZY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181803; c=relaxed/simple;
	bh=UTSmcN6aOzBKWoWmfTdjkRmeqFIiQofXOe7xIuOSwbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdQ0KvhbrSbB1es5CQUd12o6uARYx2GkfmC8XjgyxIPBW1vPXNpQ49lKm5cVsaRCpPoryYwmw3bQhUj0PTumizllZwfvs+Ouj9Xw+/yRIzgJUbrpbVAaNkE7LLoWQ6Gr5jV0ycbyOW7G5PaYPZCDK40Rbco/rpM2cMQKFxqWvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwINKoR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwINKoR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52379C4CED0;
	Thu, 21 Nov 2024 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732181802;
	bh=UTSmcN6aOzBKWoWmfTdjkRmeqFIiQofXOe7xIuOSwbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwINKoR0dkHwc1AkvtmkK378Veqn8JHjA+sT0CxEMRM1SEK5eqduxtrHoacJYPDQV
	 Hg6y6yDh4vwipoYiew6MOgkgm2UlWx6G93vBC8hr7Q1wFt5bvsT50M3ui8aBqg56bU
	 Hd4CZOFRQV70n2tpsX85uvZlnUB9f9kS238O/8XSLz8f358iOy4eK7tRa62QXI0lhy
	 bt/dtPMsgpefJ12eTX724HPh1GsjRR+h2qrEN9ME+afQrx9Hbcn7dSPzaDaDs3mpFq
	 lzZPZqp74fut/eBsqD/UEy325BLV/5zhF0mRGtsCtQKY4aRNA+RBQ5Jq1QXVQCCvae
	 mD3GWp/kCLRUQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] Squash to "bpf: Register mptcp common kfunc set"
Date: Thu, 21 Nov 2024 17:36:33 +0800
Message-ID: <a8dd1ea380706bf21677f99d283d4b2838db4fba.1732181419.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732181419.git.tanggeliang@kylinos.cn>
References: <cover.1732181419.git.tanggeliang@kylinos.cn>
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

