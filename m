Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03027282F7
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023788; cv=none; b=OyFzJB36q4eV++O84L8n4vCbrEfduCfdMZ9DcK/MVJ+uq+lQwyD92VZtRKPzsWs8Y8Y+v3U/V4jVEqw4yxzJr8743I8uYXs+RPK1rYVbtZIPy0u8873tKU0ZFhNR61cI3hHHUysMTRUNwBpg3fjwo7gsd03QBsDuqYk3tT+DgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023788; c=relaxed/simple;
	bh=KIS4caqoNjH0E4BAyvWDRRI/oxQI0k/8jBq6pMbjszw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn2WkxJzuX0Z2d+foM6/sHST6mKk1fD215/v/8W46mOUdBsptmAyJGyWsIZV2UIv7oZkqkHkuojGX9ntoK3qngLGet8E2gLsg6WtMNutbLJLhh5KLTnIu7yepS1e/l9rlYMtOG5k4jwaPNGhZy83YoOh2ma4LIdLiMmY01wUvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+Zsv5WD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+Zsv5WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3697C4CEC3;
	Wed, 11 Sep 2024 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023787;
	bh=KIS4caqoNjH0E4BAyvWDRRI/oxQI0k/8jBq6pMbjszw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+Zsv5WDF5JrGUutoZ2ryC13EKT5oEmO3vclLyuIXsFVOG2xLD4udtTFEIYBfSAXn
	 lozSkrUAbq/3gyvo5u41lK8BZRXe37K5j2FG1uSVdgmT88mw/Jr0gEVqrtuenr/qtZ
	 JEINFilT6+W2LLxDJG7NohAA7BggYutZMl1HkkIh5CTvKZWa+zHXkZsK4hGVr0SNnV
	 FkwHj2/ffIWbkQo/I2z6CRDk7hA+eXk7fe7uvFP+OG1kSxkbQBuWa2Jr6330b43fZK
	 YsLc2coriE7U++NQ2NUWIx5NrKkKBOIGbF9ggbGf6SFuDCJJJ5qdlb+pkxkP/AEhrc
	 OS6iiMrdPr3Dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v4 1/5] bpf: Add mptcp_subflow bpf_iter
Date: Wed, 11 Sep 2024 11:02:55 +0800
Message-ID: <34159d5cb4df8168bc7613ef651b714ba2762d80.1726023577.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
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
usage fits the bpf_iter use case. So this patch adds a new bpf_iter
type named "mptcp_subflow" to do this and implements its helpers
bpf_iter_mptcp_subflow_new()/_next()/_destroy().

Since these bpf_iter mptcp_subflow helpers are invoked in its selftest
in a ftrace hook for mptcp_sched_get_send(), it's necessary to register
them into a BPF_PROG_TYPE_TRACING type kfunc set together with other
two used kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled().

Then bpf_for_each() for mptcp_subflow can be used in BPF program like
this:

	bpf_rcu_read_lock();
	bpf_for_each(mptcp_subflow, subflow, msk)
		kfunc(subflow);
	bpf_rcu_read_unlock();

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6..0b7a0c2634c4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,9 +201,48 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
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
+
+__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+					   struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+
+	if (!msk)
+		return -EINVAL;
+
+	kit->msk = msk;
+	kit->pos = &msk->conn_list;
+	return 0;
+}
+
+__bpf_kfunc struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = kit->msk;
+
+	subflow = list_entry((kit->pos)->next, struct mptcp_subflow_context, node);
+	if (!msk || list_entry_is_head(subflow, &msk->conn_list, node))
+		return NULL;
+
+	kit->pos = &subflow->node;
+	return subflow;
+}
+
+__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
 
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
@@ -218,12 +257,15 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
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
@@ -241,6 +283,8 @@ static int __init bpf_mptcp_kfunc_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					       &bpf_mptcp_sched_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					       &bpf_mptcp_sched_kfunc_set);
 #ifdef CONFIG_BPF_JIT
-- 
2.43.0

