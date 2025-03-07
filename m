Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C520764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347429; cv=none; b=u4rnTIIKlfsHP25CoFEQ6RFDHpKwYcnSUqS3koRy/SswQCtGanKEdGJpk7qkjk9TZVuqGRuO1LeMwkYNSh8E7kq9bmGV054tVE6J8VI4uMSRSpMs4cOOf2yZ1+RdjR6ZS1KE9/DyeIbBjyzzLrHnGuOg/A5JZGNFEDucCSCY8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347429; c=relaxed/simple;
	bh=xbEhIae6+cUr0/qPNbV2DDzI0yfracOJs8dci9P/Qw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef2ru7lemDJOfESrvIHuccKahcblAP9i/PAeem0f20hdJKUPro02yomrr9oLRErLZYPvp3WeKR917DPQ1i/nna0/wL+JG4uHYEOj4dNbcqnC3xR1SgaTRSWotzH0BUi24BNdYG9zlbuNlU/ocRFAe7TgAAzoEm7jHoleArFpojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfE745nW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfE745nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992BCC4CEE5;
	Fri,  7 Mar 2025 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347428;
	bh=xbEhIae6+cUr0/qPNbV2DDzI0yfracOJs8dci9P/Qw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfE745nWvrqOAJJHa742ZH1XuwWhHzwKg1pdopKVQ3rkl4LiPcEs0riKBXRE/rROJ
	 qpfyaIdoQJotSyydB1GHNCbEqZzENlKAzmMmb0N42qZmC2r0iRzrLZQDa2x3Zvmlxu
	 985+lfWkPGrjo4pAnO1no5c9jterLGG3bI3ePPBToCCuliWJpjNR3Dr6Q9f3K9NZsU
	 I2CE5NxA6OiPOMoC/0g156lr84z0GBrFDGMdgASVUDhf/9odTvC2O43F4Z0nDvkNCZ
	 ov6HWtHw6EyuL+eyFuzz8eKvAIkwyeX3Y92KDOc/kcinzx1og9bexFtu9tbHSWwDQ8
	 cVbF6AClb9Vkw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/11] mptcp: add mptcp_subflow_sched bpf_iter
Date: Fri,  7 Mar 2025 19:36:46 +0800
Message-ID: <e13f64bb99b08d8d64b9398e4684cd46f3c9de91.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new bpt_iter mptcp_subflow_sched, it's a wrapper of mptcp_subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 3921261b4fd4..c31f7b407b84 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -288,6 +288,31 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+struct bpf_iter_mptcp_subflow_sched {
+	struct bpf_iter_mptcp_subflow it;
+};
+
+__bpf_kfunc static int
+bpf_iter_mptcp_subflow_sched_new(struct bpf_iter_mptcp_subflow_sched *it,
+				 struct sock *sk, struct mptcp_sched_data *data)
+{
+	if (!mptcp_sched_check_bpf_iter_task(data))
+		return -EINVAL;
+
+	return bpf_iter_mptcp_subflow_new(&it->it, sk);
+}
+
+__bpf_kfunc static struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_sched_next(struct bpf_iter_mptcp_subflow_sched *it)
+{
+	return bpf_iter_mptcp_subflow_next(&it->it);
+}
+
+__bpf_kfunc static void
+bpf_iter_mptcp_subflow_sched_destroy(struct bpf_iter_mptcp_subflow_sched *it)
+{
+}
+
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -312,6 +337,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_sched_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_sched_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_sched_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
-- 
2.43.0

