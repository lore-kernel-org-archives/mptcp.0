Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B319DF45
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676445; cv=none; b=aQ7Yqaa91DE9huTl31YseKdOWufPiUnEiRzQPsHHEdHym0CRVyb2TgdV2uIEEcSR29FMCQQQ6qrjMXTxh8lDMshey7T0yoLGASfOn3bQdUpoxzwDp36kCS7U1aN6wl0fzCHrA7UmgMk2ErrBCP/O8Lsvs9cdvAvS+0w0IvnZAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676445; c=relaxed/simple;
	bh=xstGsLWkRX78HXPUtsHSW/9ilKSi2k8OOPzhf0416bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIxZap9kFDfx49Sw5l8wl2isom29aPwoc8gF4X+u0we9Y3erfRfqsZ+oSHp91cKq92ds3yWfbrtf8ku7qa6rFILxzaJfTEX+NRjxINHP5/NFf/S+1UR1iCh7WcuOdX4Ls85T8iOHFaa3Kqv5acypd0GIyzxnLEW7R6OR1mmJKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aREUchFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aREUchFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E12C4CEE5;
	Wed, 23 Oct 2024 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676445;
	bh=xstGsLWkRX78HXPUtsHSW/9ilKSi2k8OOPzhf0416bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aREUchFP8qESpCi9gQxEyZDwYFIDeo/EiptSMTAnm94fzwYlOQ8u4Im5f35v0eqn4
	 fiO2cxWC/EZJWIICAktIu8Hr/6RtiYXqrtErMJv1+1K/ktKUKx0V4SrPrS5ZJFrOQm
	 vT2QiwchksSZJ20lFTRpWpmvoJ/nJXIZV9LTYDkB+VpMPzYUD7n+xjKrg/ax+naCAL
	 YYwxkCtWnskVgdBtDdqhCcqIuKttJjH6x/fWSuBOjbqLnMTiAZ14t2r7dI9cSkRmJu
	 rrBKJmCKbYYLjgmfyuqlkP+fm8BGFxsR+SMcUnHWzhjLOrueZphJIOuX0GlUarhnXW
	 EMNOSlD8MEChg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 08/13] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed, 23 Oct 2024 17:40:18 +0800
Message-ID: <8c1f637783212ae2f764bfeed58ca96a4f2c1ca5.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 33 ++++++++-----------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cb0090bafe57..3d5290b48084 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -726,7 +726,7 @@ static void test_rr(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: rr"))
 		return;
 
-	test_bpf_sched(skel->obj, "rr", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.rr, "rr", WITH_DATA, WITH_DATA);
 	mptcp_bpf_rr__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..c901ed045fdc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,42 +34,37 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *next;
 	struct mptcp_rr_storage *ptr;
-	struct sock *last_snd = NULL;
-	int nr = 0;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
 		return -1;
 
-	last_snd = ptr->last_snd;
+	next = bpf_mptcp_subflow_ctx(msk->first);
+	if (!ptr->last_snd)
+		goto out;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
-			break;
-
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd) {
+			subflow = bpf_iter_mptcp_subflow_next(&___it);
+			if (!subflow)
 				break;
 
-			nr = i + 1;
+			next = subflow;
 			break;
 		}
 	}
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
-	if (!subflow)
-		return -1;
-	mptcp_subflow_set_scheduled(subflow, true);
-	ptr->last_snd = mptcp_subflow_tcp_sock(subflow);
+out:
+	next = bpf_core_cast(next, struct mptcp_subflow_context);
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-- 
2.45.2

