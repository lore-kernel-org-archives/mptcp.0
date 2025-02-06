Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD8225A23
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832718; cv=none; b=krKZJ0rTKbtkcj+sy2SoKG+MnK/LMxadMEir9X5ZBweoUFHtGkKigUUb33zrA8SgvhbIRZzV3iXp6QGb2H+ZfDRUMNcahA/sfkSee/CDdF8F/254yrzfm6NxCLaOgDS5rcR3UwgFd0Xl/s01fYi0v91HKr425+Whj3su01RsPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832718; c=relaxed/simple;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCVgFj2Y0MJKLOST7gYK4X+kM5R7Fujp/0wQunm6K3wDvJS8ddbaWmDPTSUNUls8i7vfAEPR2oMYWYEOk4hPRYugzTT+UC94tCfaZN0mrdIQRC2YLZ9iDkj6DNklSxKf7qlLsEb4dcbwQaqgEtlug7FGwrHQhiHjJVsNO1YNIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlvAAE7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlvAAE7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6074BC4CEE2;
	Thu,  6 Feb 2025 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832717;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlvAAE7ZDIHBmEZqqt2OJ54Em5la75IIanhx61Tq46NWvUGp/wVVNCpf6Voj9xGnv
	 ZwpmwWYbMZLaixyNlZ76EFutsRbNDjN4FecZWnl0na0jV3M9xfI6gp7xcIHDEE1tYL
	 0obQUWyX0bFYOepJPegLxalBQETGCT7UM1XOSBamvwVcbkuGX3b6Zy3XFJs9rItyM9
	 qtIuu62nY00OLa0WO4lE/nfCuRKvaJ6LjM0lDCpJYklWpLZeoA5tW0GQkTY5TO8EQk
	 3o3SJm9u8gnphP+bCJMKNiHquQX3H8a+tK6Jb51USXLs45U2MuuqXRxcvlo+3TRdzX
	 Li+SQLzRt+H/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 6/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Thu,  6 Feb 2025 17:04:56 +0800
Message-ID: <906b01c2052eeb25cc933876994511ae15de5a55.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 405e96c116d5..4b109adc3602 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,38 +34,35 @@ SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
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
+	if (!next)
+		return -1;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
-			break;
+	if (!ptr->last_snd)
+		goto out;
 
-		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
-			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
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
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.43.0

