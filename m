Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29FB1A0BE1
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801535; cv=none; b=AgO34naG9B+nb2jb7pmmbC4+/bLJTt5kvIYDyrYJPyKWBy+i+LNElvVCQTGc8x4sW4uwG+hCsMtlk9ytnamaPSK+XghoAIB+ExtPI8en4mBFnpUEszcEQOnvEAZYhiT9XClZZyMkpXxGtI2zlJQjq3/lyCVpXCQlAzD1CqxNS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801535; c=relaxed/simple;
	bh=50O5atakWFEU/PZauLujbz1lfOIbAa3ZggS1EpKh1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+6ei8ja73Pos3r7lsJWHQBJTnUifCR8t6dsMPumgRWxxCms/akuf8IaeR08hQHo+7UYx2LcSY0ETZhq9zr2k2aTijoG2V4N5EfiwSJouJERalV4Veh2szTy2vNpPzCWIM9gsOwf06/9rIVKmVT+4alaTtTOLt1SWI0Hc2h3Vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYG6GLxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYG6GLxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F3DC4CED6;
	Tue, 10 Dec 2024 03:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801533;
	bh=50O5atakWFEU/PZauLujbz1lfOIbAa3ZggS1EpKh1zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYG6GLxiQ78iJd3ZBXm5R8lIE1Bso8DfZ6B3axMh87RyigT0Y/oy3CGofE7J3CbEb
	 lY6SYkF2hkENaefdKOzhy4wkgKg4RzXO2mruNO3t2Lpj8SI8Pfuca0CxNFh5ZOLoak
	 JDy4LYB+BWUSjtQeAOKMXmdtN+fJC6W2ukffZMaLP5+5ZEIIeYqwUwrxmuuZjSUQVB
	 YHbhDhBPY9Q8pF60E2Xu1xkywzMR7WQmhFZHPhhc6TassiNagWnzPNmfW8dXgkUVgL
	 76c6b3y1c/LglFT+jykzpEzaD8VrgRJ8uRODKWMjKsMeTT+OrOF4WQj1Ajb8WBaNCD
	 +XWCQtlAMiy1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 5/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Tue, 10 Dec 2024 11:31:42 +0800
Message-ID: <a59e374746ba0fd544a52e3d6bcee0a8eaa92871.1733800335.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733800334.git.tanggeliang@kylinos.cn>
References: <cover.1733800334.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 54 ++++++++-----------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..1cfc6d9bb458 100644
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
@@ -80,17 +75,13 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
+		send_info[i].ssk = NULL;
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		bool backup;
 
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
 		backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
@@ -109,7 +100,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].ssk = ssk;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -117,15 +108,16 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
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
@@ -144,16 +136,12 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
-	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
+	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 	struct sock *ssk;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -166,23 +154,23 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
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

