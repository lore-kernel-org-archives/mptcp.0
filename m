Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33C18953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676448; cv=none; b=Sj3xddCf5DeabkQNHl+a9W1HNfdkx4Py1fdYU8xFChprrw7tyPI37P5ElFhbnl/zQFfQjU1zrhxpdotxDHvWfl5yb33WHY7BVH7slCphr642qgdE584za9TRdgBEVZLH+kxjHrhDZ0nd5j1pwW0WeCWursQbJ5xh40j97i8riu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676448; c=relaxed/simple;
	bh=u5wQJEaQSiZvDWYLH/rv/j1uxC/npMherkaK5E8eyr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCI0riw6qC/F/zzASYxcWPifkl97oRuHugcRHeIuK6fg351qiexstIvhFGTUxYM7AMoe4ksx+4TQOxDgqbnDCd3wnJ+WOTrxtvcrOyI2ZkIpL86cQWOV0WinncR24SuT/xgyM8HSQMLzI5Al6Ok6j6n6oErvhW/9/RSSJGneHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6sYTmIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6sYTmIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDFEC4CECD;
	Wed, 23 Oct 2024 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676448;
	bh=u5wQJEaQSiZvDWYLH/rv/j1uxC/npMherkaK5E8eyr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6sYTmIXeL1Q5HTKn1g2D+61tY+1p2TMY6ftM6Tghpn2eVk7tQrUrNtDcV7gWGs//
	 Bw70iVV+VR5ucoMQ5ra1cHw7iI4ZmA8jLg9hOMoGVlSw2Chhw/N3g1C8muIao10VbT
	 YfwK/lRBZE1w+qbHrh727hYzhsB6C7daJ81dBAt6JzI2f95dPiix/dFtj5Apu1HJLb
	 GABd6jMutJttSszSxytlhjEcEN8QwwuJWxijpcx7N+JN1r3Rt5kO9ZpsmvDYwWRPDb
	 y5mlMvAI9l6i3p7fe1XH/70cOOm2eLe6V3ek1opEQIVaKxOIAXSv6M6lAaojUTgp2T
	 R80Oem7QUyy3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 10/13] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 23 Oct 2024 17:40:20 +0800
Message-ID: <fe873ead4a25fd1909feb99a5853cec7b63f8cdb.1729676320.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 74 ++++++++-----------
 2 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 03eacae01b8d..bee6ca62bb8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -750,7 +750,7 @@ static void test_burst(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: burst"))
 		return;
 
-	test_bpf_sched(skel->obj, "burst", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.burst, "burst", WITH_DATA, WITH_DATA);
 	mptcp_bpf_burst__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..6242430d0330 100644
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
@@ -80,21 +79,16 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
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
-		if (!mptcp_subflow_active(subflow))
+		if (!mptcp_subflow_active(subflow) ||
+		    !sk_stream_memory_free(ssk))
 			continue;
 
 		nr_active += !backup;
@@ -109,7 +103,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -117,13 +111,14 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
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
@@ -141,23 +136,18 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
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
@@ -166,23 +156,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
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
@@ -194,11 +184,11 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
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

