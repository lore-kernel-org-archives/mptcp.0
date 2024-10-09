Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347928EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467172; cv=none; b=cw7ztoyeh6QoQ+useibEn9gGx8gFztUza7Ep2zXU2OGi+0NAdb7duo9eCxuziujARpkrVgG2VLUwXSCnh6bC2FPg+5n9BIPtNfbiaf4Q0Yc71KPyfSLswZ1ElVPy6CJ33AU8VNqydOR+Lp8ORyNNJoBc7K3o7hrX/73IY99Fbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467172; c=relaxed/simple;
	bh=im72GA1G2aINreZonOksExvqd1DIV9NNKzp1J7r61yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LErz8Q+eBL5a6S5wyQGpnwkoI3BjCQCmmMVpM7wbMyyG5WWza/qPOX98uVAtjlgIp5/pfM4H794XKXzdX4MJRXz0kqF6RvcQs4VaTbbT4KHjceE2Rl+9qNMfrb54tPqA4k7y0WiGobDee0T6yyTeil3djPP0cpone0cp/JkPznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5lKizju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5lKizju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D25C4CEC5;
	Wed,  9 Oct 2024 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467171;
	bh=im72GA1G2aINreZonOksExvqd1DIV9NNKzp1J7r61yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5lKizjuJFkcHFO8rzkALlz4HK5dVblyOJs6ZdsB4cs+1OpfeYel+MkqWC+F2BO6J
	 2Gfq0xjJYlpF20dtqVgchV0jLkAGskldhkDSEap+hp8iBZ0EFr9/nhRIyw5JLCByLF
	 QZ0OLWgHn0f2vKJlpry8BZLpRvwEXiIilavVQ6K5jBAua6DrKHOEauc2v1GblU3qd1
	 ERQZ+ndzKDtnCa9WbTjCmx2jNBegq1AYyywE8MArH2gJv/FsgEaW8+Owgv/hkB1xVC
	 Ns6naVxCBk/FbOlhvAdhVxVjhPnAFGteUr6Q1cu8xcxV/0EoH9S5tTtp++0uezp71K
	 FrbJFrxiJ2AQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 2/7] bpf: Add mptcp_subflow bpf_iter
Date: Wed,  9 Oct 2024 17:45:44 +0800
Message-ID: <523733b831449ba096084d3d5224d05b4fd5c8bf.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to traverse all subflows on the conn_list of an MPTCP
socket and then call kfunc to modify the fields of each subflow. In
kernel space, mptcp_for_each_subflow() helper is used for this:

	mptcp_for_each_subflow(msk, subflow)
		kfunc(subflow);

But in the MPTCP BPF program, this has not yet been implemented. As
Martin suggested recently, this conn_list walking + modify-by-kfunc
usage fits the bpf_iter use case.

So this patch adds a new bpf_iter type named "mptcp_subflow" to do
this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
_destroy(). And register these bpf_iter mptcp_subflow into mptcp
common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
in BPF program like this:

	bpf_for_each(mptcp_subflow, subflow, msk)
		kfunc(subflow);

v2: remove msk->pm.lock in _new() and _destroy() (Martin)
    drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
v3: drop bpf_iter__mptcp_subflow
v4: if msk is NULL, initialize kit->msk to NULL in _new() and check it in
    _next() (Andrii)
v5: use list_is_last() instead of list_entry_is_head()
    add KF_ITER_NEW/NEXT/DESTROY flags
    add msk_owned_by_me in _new()
v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)

"Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>"
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 71ab1efeed40..fe2ee03ff1ee 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,9 +201,16 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
+struct bpf_iter_mptcp_subflow {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_mptcp_subflow_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc_start_defs();
 
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk)
@@ -217,6 +224,37 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return mptcp_subflow_tcp_sock(subflow);
 }
 
+__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+					   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	msk_owned_by_me(msk);
+
+	kit->pos = &msk->conn_list;
+	return 0;
+}
+
+__bpf_kfunc struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_subflow_context, node);
+}
+
+__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -230,13 +268,16 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

