Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198A1DED5B
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267236; cv=none; b=hLGf3idrtjsNbVZfNxn9DUlK5Xnyg0sG9qX2gWDyy0Lmyx+K5U4JBDgl9EGNrKpETj4I6HtYFepR0CHrZnKk+D8LUCWRnuzV9+x//qyeejzNRbstgkosft2ujhHJBBDCL7AXvleT/u1x0bkqqV5fpoM/0Dc/U+lLzN8FOthfrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267236; c=relaxed/simple;
	bh=O/aDW83wsVpbVBtm3apBXP+i5+MgUJPEBFLiPHCpwps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqj2cdv4hZcWZvk11pMxsM95HHOE1hwYtR3ZRXQlKl0u4Zo/dNeftOHe5bd97uWmDvCON4fMa2PFoTNPxCizcTEsQPZCuLwrbmDQac3Rl/cpJxa43V7mnIVBMDWxY13/vqVI3Mp1VWQ1sYKkZXFP17J4QMdQWPXIhIz/6+vGy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha+Ndawn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha+Ndawn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273BFC4CEC7;
	Fri, 18 Oct 2024 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267236;
	bh=O/aDW83wsVpbVBtm3apBXP+i5+MgUJPEBFLiPHCpwps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ha+NdawnexMXytLP/Ghwhua5/iYoXJzYIeMZc8bf9FRHSqyYyEY/4O6TBZ9vXxeC/
	 3eO9vlc5mKWeXUDvNRQnl8Fy/z/BVRb3xJm4FhD768ouRgZKtwiWr8MdqjnN16iZ7N
	 Za9tzxF5LwCHHGUrX/tCIkHr1j2Zb1GtgE8tWZ8Ih0dc0rzIgyO0UF8DpNR3HO0QiJ
	 YjkVJ8UtbvnDkgV58YAzzv4W0n4vkZzbhqLE1KkKlefFHrSqoZE/bsEiDFpDlZvM1J
	 Yeb0wtopMad6GwyxQdRBTcFDGphSDtmvPjfcUh14WEQl4h6KIcchHc8ZC+Ds7efZA4
	 uo0hQgqRu6pOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 1/8] bpf: Register mptcp common kfunc set
Date: Sat, 19 Oct 2024 00:00:21 +0800
Message-ID: <b8de99def444044d8a6d134bfdaf945be21cd9f6.1729267039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
convert between struct mptcp_subflow_context and sock. They all will
be used in MPTCP BPF programs too. This patch defines corresponding
wrappers of them, and put the wrappers into mptcp common kfunc set
and register the set with the flag BPF_PROG_TYPE_UNSPEC to let them
accessible to all types of BPF programs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index a9d6b5b939a2..efab2e6e28ef 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -209,6 +209,23 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
 
+__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
+{
+	return mptcp_sk(sk);
+}
+
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk)
+{
+	return mptcp_subflow_ctx(sk);
+}
+
+__bpf_kfunc static struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
+{
+	return mptcp_subflow_tcp_sock(subflow);
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -224,6 +241,17 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 
 __diag_pop();
 
+BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_mptcp_sk)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
+BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_common_kfunc_ids,
+};
+
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
@@ -245,6 +273,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_mptcp_common_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

