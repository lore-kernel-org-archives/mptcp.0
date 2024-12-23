Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B62207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948383; cv=none; b=pt8UvfsOUjjH6rm/K+BiB3WAho1LhOh37X4T16XbzTr0neoyXdbpA3oGhY/e6oPsAmsbvbosvwDGiK7OE06Y90MJfggJ4XuMNqBkIyWZhb90fTVqfO5S+HhNIYwtU0/xhAx55+Aq7oLBfhuxkGEleBDsb00pJFFkIYSgFm1LhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948383; c=relaxed/simple;
	bh=I9ih24Wn5nxLDHWk9KOMY35fDvWUZbWxOpMl0ccGzTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwpIzWar0jJT4cmW4/ULcP144oT+EjdHhe+pERQ6GpXJJQR1k0XhEeOrxBe3yqn3BVJtR6uHVz9T9dMpVI50rEIy3obVkQK4f61MwsbkQhtfmi8IYdn5WvpzYJJaZewaPwl6AIOlLoKyNPsWPU3xltblSpQlNKInkMSQwMIGjLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBpcnOgm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBpcnOgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9EDC4CED3;
	Mon, 23 Dec 2024 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948383;
	bh=I9ih24Wn5nxLDHWk9KOMY35fDvWUZbWxOpMl0ccGzTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBpcnOgm54c8K7n+t+1LyIk68B8zWm55EUyKi92OSI8rKsgmDhmsjgoGaK39ASiNj
	 n6atWruZy/6B16ngc7AOp3Zcy1tmyK605hWckH1OTb/DYcCRTnIQBD3dn01WW7TXim
	 GE6Ma3E1fBXac3lOgSEuSO1Hj5J0VG2fe9MMHjLSuiXjf04H8mTvsD/z82GihAlXAf
	 +UbkPPQ+ueU+GIyZfyLtp0BY837tZqvGl2PvMQDHSNA7B9BVY9UA1SkBg7TJcdEG+z
	 rwDxJHQV0EzL4RQuy7eDVVg9ewx1lRaiDu8mVp4Mz5146ziocKJRsRpvhKNvK3zNxc
	 RiQPp86+WmVgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 10/10] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 23 Dec 2024 18:05:52 +0800
Message-ID: <66a4b211db4f06b8c6fddf62bc900d886d8b707b.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Use bpf_mptcp_send_info_to_ssk() helper.

Drop bpf_subflow_send_info, use subflow_send_info instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 68 +++++++------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 5743601df9dc..a33c5f302b76 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -11,11 +11,6 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
-struct bpf_subflow_send_info {
-	__u8 subflow_id;
-	__u64 linger_time;
-};
-
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
@@ -68,10 +63,9 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 {
-	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
+	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
@@ -81,18 +75,12 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
+		send_info[i].ssk = NULL;
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
@@ -110,7 +98,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -118,15 +106,16 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
-	if (!subflow)
-		return -1;
-	ssk = mptcp_subflow_tcp_sock(subflow);
+	ssk = bpf_mptcp_send_info_to_ssk(&send_info[SSK_MODE_ACTIVE]);
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return -1;
 
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (!subflow)
+		return -1;
+
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
@@ -143,23 +132,18 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk)
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
+		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 
-		if (!mptcp_subflow_active(subflow))
+		if (!ssk || !mptcp_subflow_active(subflow))
 			continue;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -168,23 +152,23 @@ int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
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
-- 
2.45.2

