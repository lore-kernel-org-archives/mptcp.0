Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7420FAA5
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046807; cv=none; b=A3ihKTI2HTY/Q9DWAPb48Q7K1j9u/oIG2wgi/TUFQdE6Q1vKs2CwKwtWdZIAxWMdbBtWIZOV5oOnV3D1rO8BTgq53GRk6y80vLyX2uuq6ToTbFBZ2o8ceofDawGcMLCGodZvgLJ5XpAat3dzQ0gT1PCEWpmsGTJlVnc7hjhnCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046807; c=relaxed/simple;
	bh=BuOgDD+bm6N14m3sIF4M6yO0GJOC3GY4OAJjbWNeIp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuXovyb3dNsVhUTPgVzl/SM3pEUzbqJw3MHNdmtzHwaD70nCBg3cdxxbEfv8htB6lWkiXOQbNYZ+tFLwlAdeeZ2flZqpKqG5O3gJRXIhAUHL31q3s6rbUstaxlH3J9IzPCcXY5K2bNd7gWzZxVhMMWtL6LV8I1BnsLJU1QAnDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBd8CUPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBd8CUPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55ACC4CEC6;
	Fri,  4 Oct 2024 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046806;
	bh=BuOgDD+bm6N14m3sIF4M6yO0GJOC3GY4OAJjbWNeIp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBd8CUPPxiPNqsljEdOfWmF2tuqMCdZwlOzBzQGTdFJcGqZ3TnK+GuBlbOZ5ZhbHv
	 qppW4XzVkUf1S2iLsIkfrX1qRj4UvEb/F+kyWl9rNhE0FqHTT3mVp/AYxwHPk2+5eo
	 5WZ1BvcsjtYvEIaUqK0jl4PiqTv5PvT1PxXbTFrq0zBFamYy6Nf9ZBhaaQbUbVcIUv
	 rKHyM+0aS3PkHx3qm3witfg5Ut9MbzKT3SbBCWrNiwOpPJ6BSC5gJq7bnAF/6XPylR
	 ZztjDQcDWdbYnU25NDJ+6o9gCNmIVjcEJR00+f9mw6MaqjVXODWQgyAhbWz5t56g8/
	 msiWXNs6D/svA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Fri,  4 Oct 2024 20:59:47 +0800
Message-ID: <ef39cb7547f58e403a6e3e3c700da78cc0f2f4bc.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Drop mptcp_subflow_active declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++++----------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..87b6d9dc876b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -11,22 +11,21 @@ char _license[] SEC("license") = "GPL";
 
 #define min(a, b) ((a) < (b) ? (a) : (b))
 
+#define SSK_MODE_ACTIVE	0
+#define SSK_MODE_BACKUP	1
+#define SSK_MODE_MAX	2
+
 struct bpf_subflow_send_info {
 	__u8 subflow_id;
 	__u64 linger_time;
 };
 
-extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
 extern bool bpf_mptcp_subflow_queues_empty(struct sock *sk) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
-#define SSK_MODE_ACTIVE	0
-#define SSK_MODE_BACKUP	1
-#define SSK_MODE_MAX	2
-
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
 	return dividend / divisor;
@@ -57,6 +56,19 @@ static __always_inline bool sk_stream_memory_free(const struct sock *sk)
 	return __sk_stream_memory_free(sk, 0);
 }
 
+static struct mptcp_subflow_context *
+mptcp_lookup_subflow_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		if (subflow->subflow_id == id)
+			return subflow;
+	}
+
+	return NULL;
+}
+
 SEC("struct_ops")
 void BPF_PROG(mptcp_sched_burst_init, struct mptcp_sock *msk)
 {
@@ -67,8 +79,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+static int bpf_burst_get_send(struct mptcp_sock *msk)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -84,16 +95,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		bool backup;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
-		backup = subflow->backup || subflow->request_bkup;
-
-		ssk = mptcp_subflow_tcp_sock(subflow);
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -109,7 +114,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].subflow_id = subflow->subflow_id;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -119,10 +124,10 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (!nr_active)
 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	subflow = mptcp_lookup_subflow_by_id(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
 	if (!subflow)
 		return -1;
-	ssk = mptcp_subflow_tcp_sock(subflow);
+	ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return -1;
 
@@ -141,23 +146,18 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
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
+		struct sock *ssk = bpf_mptcp_subflow_tcp_sock(subflow);
 
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		ssk = mptcp_subflow_tcp_sock(subflow);
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
 			mptcp_pm_subflow_chk_stale(msk, ssk);
@@ -166,23 +166,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
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
@@ -194,8 +194,8 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
+		return bpf_burst_get_retrans(msk);
+	return bpf_burst_get_send(msk);
 }
 
 SEC(".struct_ops")
-- 
2.43.0

