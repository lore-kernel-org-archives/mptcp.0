Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB5101FF
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788895; cv=none; b=TNfASgW6WyvCfrbH0jWCFb6MzsCKlHN2Ho9T53lC5u/qzmxeCXDMR/CTZEpEHt54SPuYU9OB7si7w+XMJ1YmXPX+Pwq/bhVD7BxaJcvB4546hOCa0LmQIaPABvHU4ZnOa8Yr55T2CpRUMakNDcxPLfwYK11fhBXoQSr7K+xtUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788895; c=relaxed/simple;
	bh=g7fP8ZebFsSShxNW7pg6N+TWYUcFSFO2jiRRqlSTSbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD9ycAe331yUwHIkMlHcR4ELQyYweWgJBcsLXCwzks1xWyL1M2+bcFCqGSKsocwKYzk98Ieco3sMZV/6W94dTZgIlX9ZdEZf3+4CdYd7I+N+ulJHvcsxeAxX/uGtZp8UylrzLWzWZA+BD+XjKTvs/iKVSX48ssRD2glzj4tYuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ/s814E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ/s814E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AC2C4CED1;
	Mon, 17 Feb 2025 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788894;
	bh=g7fP8ZebFsSShxNW7pg6N+TWYUcFSFO2jiRRqlSTSbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJ/s814ElgyIQn98M4SVYycjR60BZNXWsxvpQ3kwq6T4LAYhPaNVgHoUQbe6pZNgR
	 YISGN+nHKlv6FIrDPIH+HXN/HNZFVi69PNITG0mOmDtjEWa0xh8wVmhlIvPPuzkd6+
	 TDZbyEh0TNDwMIz5L12ol0ZHXvYjPYoOYmgzqVfe39t7fnVeytfJXRy/lyKa42S4hB
	 ldi79dm2YRG37/GuaAkq3O9Gl3jfPJAgPzhZH+z2IpJdJ0U6LlmUapLy8tZplF8Pkj
	 FKqnSIueT2Yr+bNZJn/ADJeJt4gK2GtZ/vnzv8OVg8ET7A0Up//hYqzzNPX+QVuJCE
	 AaOQCn0wHB3Zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 7/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 17 Feb 2025 18:41:17 +0800
Message-ID: <d66f1e569a27826ee0b9a670e2eebc4d793f1c57.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.
Drop bpf_subflow_send_info, use subflow_send_info instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++------------
 2 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 2eb2c1c3bffb..badcffe0942c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -45,6 +45,8 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 /* ksym */
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 5743601df9dc..482b30cfb011 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -11,15 +11,10 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
-struct bpf_subflow_send_info {
-	__u8 subflow_id;
-	__u64 linger_time;
-};
-
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
-extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
+extern bool bpf_sk_stream_memory_free(const struct sock *sk) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
@@ -44,19 +39,6 @@ static __always_inline bool tcp_rtx_and_write_queues_empty(struct sock *sk)
 	return bpf_mptcp_subflow_queues_empty(sk) && tcp_write_queue_empty(sk);
 }
 
-static __always_inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
-{
-	if (sk->sk_wmem_queued >= sk->sk_sndbuf)
-		return false;
-
-	return tcp_stream_memory_free(sk, wake);
-}
-
-static __always_inline bool sk_stream_memory_free(const struct sock *sk)
-{
-	return __sk_stream_memory_free(sk, 0);
-}
-
 SEC("struct_ops")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
@@ -71,7 +53,7 @@ SEC("struct_ops")
 int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
+	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
@@ -81,18 +63,12 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
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
+	bpf_for_each(mptcp_subflow, subflow, sk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
@@ -110,7 +86,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -118,16 +94,18 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk,
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
+		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
-	if (!subflow)
+	ssk = send_info[SSK_MODE_ACTIVE].ssk;
+	if (!ssk || !bpf_sk_stream_memory_free(ssk))
 		return -1;
-	ssk = mptcp_subflow_tcp_sock(subflow);
-	if (!ssk || !sk_stream_memory_free(ssk))
+
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (!subflow)
 		return -1;
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	ssk = bpf_core_cast(ssk, struct sock);
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
 		goto out;
@@ -146,20 +124,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
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
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 
-		if (!mptcp_subflow_active(subflow))
+		if (!ssk || !mptcp_subflow_active(subflow))
 			continue;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -168,23 +142,23 @@ int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk,
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
2.43.0

