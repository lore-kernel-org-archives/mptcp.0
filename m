Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D212165E6
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737783; cv=none; b=XSQvFm6dGSfJe1CcykSkYfcd666F0VZUXnvVde5qsVEjq8C7euQPBNX8wRwxAfGkdOi+MOSnp6uoJRgLK7TC5aQjBM+a73pTAEp6mT+cFnGpBziYiguXhDBwXE51Ax1n9ObQ6bJiDotHfFno6nqmplajnCPb6P50s6gLNoc3BWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737783; c=relaxed/simple;
	bh=c2fcieJmHCwvULCf+oQbFj0BSemqM4fYSiw7Viduu84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITdE0HaIswijY7dmQoKADksjTOm7SYXuXHiLEt8eWTTiZKzL1Y6IsQtnv9f5ac35ezDyHShRhfO4K67Gh1hfVRPxBKjKUSCkmzrgh5Y1B/4kvhFz+ipCG0y7G3sOJzgKtHfvmWrS+FtJ9ECotS7VZ7rEz/Yx0Hq9YTt4vqa8Hj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/O30fiP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/O30fiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794E8C4CED1;
	Mon,  9 Dec 2024 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737781;
	bh=c2fcieJmHCwvULCf+oQbFj0BSemqM4fYSiw7Viduu84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/O30fiPbnUWy5i/qhukLqZqcHaNh8V/bZo/6OxuGVGZQFyE3pttU0Dti2LKxtRa4
	 3OzjedEuJiVhbqa6IUthIIJTS4i3qN6keQ0GNVoUdVGtboSicDhIQmROBTO3o4gzq1
	 63pOxYx6ytXc84fj9XsPGb/M6lajoFju53oXFBPKKqGkG3H4n+yGIofDSwz96fT5LQ
	 ehodebuqnObZPhAn35dgEiEQVHslbELZ2cuiistbH7fjIQJDpIb4xARMhXM/qgiyGU
	 wv6lfaY2UjsXBSlMbSHQeLCef9YKHchHM/94lAU3B1F7vjpp8eRuynxXzIrlsLo2zv
	 z6cbwbdZf5DhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 5/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon,  9 Dec 2024 17:49:21 +0800
Message-ID: <339006a189bf463eb598c35fa3fc1c061f0b0d75.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 62 +++++++------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..71094790efaa 100644
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
@@ -70,7 +65,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 static int bpf_burst_get_send(struct mptcp_sock *msk,
 			      struct mptcp_sched_data *data)
 {
-	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
+	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
@@ -80,20 +75,14 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
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
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
-		backup = subflow->backup || subflow->request_bkup;
-
-		ssk = mptcp_subflow_tcp_sock(subflow);
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -109,7 +98,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -117,15 +106,16 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
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
@@ -144,20 +134,16 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
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
@@ -166,23 +152,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
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

