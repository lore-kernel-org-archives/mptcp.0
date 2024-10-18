Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAD1F4266
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267238; cv=none; b=HD7dnKVzQ3bGWheA9a8IToOu9KFAAl7+XbvQnyys4VjuiyeQyap4URrsomYF3Wylv5DmmJIFXKsHQzcG8u1K8EdVIcPac8GmMacrYmcpXJMm8L7gkPqForJvj+ZtKcQGRBJbtRSsmNrWgJNUuuAFPLSY+FGGFBg4C0KVE1z2ftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267238; c=relaxed/simple;
	bh=/UWS8+VBjYFrqdOw4KZJINWR8TNN98J/VAUIMhPLzWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUZMm/3NGUEOo9mMCYe/OfSr9VLWf0c9qoXbgsK9oXb4psZqBJdcau2Ww9pCkZID/rogHAaNvAKhep+z0tlda5jcrcMS2L9bIrjDj2PrbWldAiWl+ZapHUBLTnPt0fUDRTMK3E5M47IU25e6A92d/NStgzaaXlcATh31QnPoG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syOxTWs0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syOxTWs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05133C4CEC3;
	Fri, 18 Oct 2024 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267238;
	bh=/UWS8+VBjYFrqdOw4KZJINWR8TNN98J/VAUIMhPLzWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syOxTWs0oGN5w1dAaZqkN0QmXXXWn1wrB+sUIB/UeQWFTWcWSGok+ECQOX/G7fIaE
	 DtmCMYOnl+TdSMLW0Tb3eN45jlwhHJTRh7GCcrTRqVxVw1Ln+0NgtuNK5iu0sahNW7
	 Zvfpq3NzN+WntEzjUd/K1adIczeU/ZirMHXZZoxLbdf+7c+BxwtW+ZyEWvZmkrFAVt
	 LwSU0+Ous51SDMHp2iNoQhqtdV0hbbhNgr9/qQqsXChFzw5LNKFTiZuhelyegw+PeV
	 JGnlwFh+REqkuqOf2ATgfe7xUlHwIt4p3roVI0dUSQZTOzxnmFKO2W2WTRD/lgIB8b
	 4pJ+uujq0EgXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 2/8] bpf: Add mptcp_subflow bpf_iter
Date: Sat, 19 Oct 2024 00:00:22 +0800
Message-ID: <f4e7a274aef4adbb0d1a2666cf435fc19b779eb2.1729267039.git.tanggeliang@kylinos.cn>
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
index efab2e6e28ef..65fa84d1e745 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -205,9 +205,16 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
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
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
 {
@@ -226,6 +233,37 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return mptcp_subflow_tcp_sock(subflow);
 }
 
+__bpf_kfunc static int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+						  struct mptcp_sock *msk)
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
+__bpf_kfunc static struct mptcp_subflow_context *
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
+__bpf_kfunc static void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -239,12 +277,15 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__diag_pop();
+__bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_sk)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

