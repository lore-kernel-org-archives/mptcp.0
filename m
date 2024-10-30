Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13521D0F51
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268670; cv=none; b=MJQhHmq5PlzD+T+oPn1xRNFOMIXaEAV2waAqD06Z/fW3IcKzS9WlkQEVm5lEpwIqs6MKWZQ+X+vpIa5+wWGo31is004I6KdVE9X5K7uOmBz2yaQ2AzFIh9cci+LSDMzbNOinyVZSvHmrOWiky5EQadazdNO+iyRQE0YWRz7zLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268670; c=relaxed/simple;
	bh=j6ENN/YA7zBot/DvaKGO32Z9qk2Hwh/KtfV0D8zWm6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7zpA4CqcwdhD10LkAHcqzmLmuUpMND/ox1vQ/u8kV0lutI3SP/qbFkkNHBtyIytclt5T1vRCUVEljSYm4iXJwlxgL93OwUiBWJFA0cdLq3UtJnTxnZHem/OCTaS8W+1X6WYVUunVbidd3RSVOMhhAqZJ4CR3Lcqcn71j5HDPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZX+iuSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZX+iuSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B3FC4CEE4;
	Wed, 30 Oct 2024 06:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268670;
	bh=j6ENN/YA7zBot/DvaKGO32Z9qk2Hwh/KtfV0D8zWm6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZX+iuSR1y2ocEPjaqlMdZgE1YHnU6EJsqQc1MhN+V/Eg9VNeSTCERLB1O9HURSwk
	 +3LJS6WjzyOBRP2l1BTHlQlfZv3nZ9gJOJkNcGHLm/rBYhmpv0z+bpwwE1NEcJcZTh
	 1CeKONgOU/PpYg6zQNWKATH3n2Chn/zAa+SMc175ZG8RbFd0+ycOk6j+GUiMAM8WB5
	 /QXbwWct2j4noBtZkwJACHdp/fV8TDxLh7zdl0CHUi4suvXTxtlMK3RbJBygn6HMHX
	 NT4suIiEd5zzo+k20PQGmyJPLrCXZe7YXO//TJ7+F1e4TiGtpBJXHBtFyRKI6HorpV
	 WaL8noqBbPJfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 10/13] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 30 Oct 2024 14:10:34 +0800
Message-ID: <7af9d9c97ab72caef4facd23c7d78cf1c8aa83fd.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 73 ++++++++-----------
 2 files changed, 33 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e845809cd2a8..dbdff62e430f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -732,7 +732,7 @@ static void test_burst(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: burst"))
 		return;
 
-	test_bpf_sched(skel->obj, "burst", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.burst, "burst", WITH_DATA, WITH_DATA);
 	mptcp_bpf_burst__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..f0c9f5984736 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -9,10 +9,14 @@ char _license[] SEC("license") = "GPL";
 
 #define MPTCP_SEND_BURST_SIZE	65428
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
 struct bpf_subflow_send_info {
-	__u8 subflow_id;
+	struct mptcp_subflow_context *subflow;
 	__u64 linger_time;
 };
 
@@ -23,10 +27,6 @@ extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
-#define SSK_MODE_ACTIVE	0
-#define SSK_MODE_BACKUP	1
-#define SSK_MODE_MAX	2
-
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -67,8 +67,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+static int bpf_burst_get_send(struct mptcp_sock *msk)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -80,18 +79,12 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
+		send_info[i].subflow = NULL;
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		bool backup;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
-		backup = subflow->backup || subflow->request_bkup;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
@@ -109,7 +102,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			if (!sk_stream_memory_free(ssk))
+				continue;
+			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -117,13 +112,14 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+		send_info[SSK_MODE_ACTIVE].subflow = send_info[SSK_MODE_BACKUP].subflow;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	subflow = bpf_core_cast(send_info[SSK_MODE_ACTIVE].subflow,
+				struct mptcp_subflow_context);
 	if (!subflow)
 		return -1;
 	ssk = mptcp_subflow_tcp_sock(subflow);
-	if (!ssk || !sk_stream_memory_free(ssk))
+	if (!ssk)
 		return -1;
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
@@ -141,23 +137,18 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+static int bpf_burst_get_retrans(struct mptcp_sock *msk)
 {
-	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
+	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
-	struct sock *ssk;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -166,23 +157,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 		}
 
 		if (subflow->backup || subflow->request_bkup) {
-			if (backup == MPTCP_SUBFLOWS_MAX)
-				backup = i;
+			if (!backup)
+				backup = ssk;
 			continue;
 		}
 
-		if (pick == MPTCP_SUBFLOWS_MAX)
-			pick = i;
+		if (!pick)
+			pick = ssk;
 	}
 
-	if (pick < MPTCP_SUBFLOWS_MAX) {
-		subflow_id = pick;
+	if (pick)
 		goto out;
-	}
-	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
+	pick = min_stale_count > 1 ? backup : NULL;
 
 out:
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
+	if (!pick)
+		return -1;
+	subflow = bpf_mptcp_subflow_ctx(pick);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -194,11 +185,11 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
+		return bpf_burst_get_retrans(msk);
+	return bpf_burst_get_send(msk);
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops burst = {
 	.init		= (void *)mptcp_sched_burst_init,
 	.release	= (void *)mptcp_sched_burst_release,
-- 
2.45.2

