Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49819C573
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544339; cv=none; b=mPuEq34C0W9uL8dtRj4IJMcz9Zv60yuGGA0yBKyUrs+7k6FSUvYGXPIxcCUnB4iltHlI2a8t06n2JiiooD3NqPBl6zAAKTvVP8OlB/alXIg/IWRo6WXnRny1rGxVkYb+hTPqgyIUnFtOtYJBK8cye4/uqCftZU+LMs9kg4vImxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544339; c=relaxed/simple;
	bh=3Iiw/ev4v7xyR8PryT/7z/c5DPHsx1sWHSFO9gPA1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chIrbPCnaCT1bTiQgUihDnnl78N4OMCvT6cdjFAcX3JPUSCVzn4XJQA/JBEgiVmqdAWQt6pBR0TnU46SBgkaLyPeSLZGlw2TmEqkN1tSaTMsZmKDzSuzsIugk79eqLtfgCMbI6IUWFruetQtEm+fp553CjFb59HfPcBVbTxBUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNYK29vu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNYK29vu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C774C4CEC5;
	Thu,  5 Sep 2024 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544338;
	bh=3Iiw/ev4v7xyR8PryT/7z/c5DPHsx1sWHSFO9gPA1p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNYK29vuwyjSd6Vtj6xCL+zeDJx9/T704AC9SETPGum+XZJLWm6WxYHt4R4Wfcjx+
	 moYJYJJUZNHKQiDRzGruqL7tt5QZ4ZiRCt4EX8ewFRXofysWvF1GeHnJUHP7PQQPcu
	 t9Gsird8CCpKhVjZzZJU+MCTjR7wOnXpYQxcWz8DCyuXT+U0wENxRGAzRGzM74K3x2
	 8f0PIAQ335Cldcq/lbroanTgdWGoBrioQhFQ8ZXrbSvpZyoZoXvuUkyS3nhi4dI3vi
	 WUE5jK4Zd4DsrsJwFsGNpUll8vxZKDS+JuG4GOO58Ab9DIfPa5t0NdXZ14byPcgOcV
	 Ls+XtkRUeGYKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next 1/4] bpf: Add mptcp_subflow bpf_iter
Date: Thu,  5 Sep 2024 21:52:09 +0800
Message-ID: <a75fc3e8df7141ce582448d3f092871a4943fbf4.1725544210.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725544210.git.tanggeliang@kylinos.cn>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
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

This patch adds a new bpf_iter type named "mptcp_subflow" to do this.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/helpers.c |  3 +++
 net/mptcp/bpf.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..2340ba967444 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3023,6 +3023,9 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9672a70c24b0..cda09bbfd617 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -204,6 +204,63 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+struct bpf_iter__mptcp_subflow {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct mptcp_sock *, msk);
+	__bpf_md_ptr(struct list_head *, pos);
+};
+
+DEFINE_BPF_ITER_FUNC(mptcp_subflow, struct bpf_iter_meta *meta,
+		     struct mptcp_sock *msk, struct list_head *pos)
+
+struct bpf_iter_mptcp_subflow {
+	__u64 __opaque[3];
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
+	kit->msk = msk;
+	kit->pos = &msk->conn_list;
+	spin_lock_bh(&msk->pm.lock);
+
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
+	if (list_entry_is_head(subflow, &msk->conn_list, node))
+		return NULL;
+
+	kit->pos = &subflow->node;
+	return subflow;
+}
+
+__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
+{
+	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct mptcp_sock *msk = kit->msk;
+
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+__bpf_kfunc_end_defs();
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
-- 
2.43.0

