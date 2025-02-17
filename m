Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0E15C0
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788891; cv=none; b=OlaSm2VabwtDQDIVSSNp6czwHtROe1ZWteBA6szaP5Hg4wRtQsDqKkxc46GACwpi4IRu0FH1j9Tl5WD9wSUiCawaV4TteAFKSqHD4sjj3YBzkKaOKHrkm2hyhWT9mI1SUqxLhGNS5N8xQ8Xy8dsNfoZgO6jJ5qYYrIma0OeBKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788891; c=relaxed/simple;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDAUBAPFzpJKhtD0L4GkkohfPZK6PQaS2hu4+9ZqyPPamnbOQoa1wnygb7f+F0UjXma4+EEzrerqX0WqKFre3Apr/Nw/upqYi5jX0+PaLxA6Xv3krAWnUg2lrHaDySspvV+g1D5rEz3wBIu8qty4gikKR8rDrBu0vj/XGqVLoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhK1Ynub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhK1Ynub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE2DC4CED1;
	Mon, 17 Feb 2025 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788891;
	bh=NGXQE9Kif6loAReYC7iiycV9qt5iAyr/88XdrWpLpD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhK1Ynubn7ZLLHUbGLdjohx51aarScFoxwod0zLwaZZAo2VvavDE5BjG/MTuDrLv1
	 lnyJVT8zfGC5YaYI2udvkPqwcJ/Ux7LD6GgXy0E/9a+yNGhhx68M143UKOPYNNGMoh
	 8jpbyu3BkULV0B7jFVOQbsQts53gW53m5foq/SWB9BiDbOO6RX2w2K9hELMk270mMI
	 sA+APAEJwPQQPTsL945ypBN+ppjM5kICU/q9B7UxagOcqqXGGXzG5UPGMCOGc5fgh0
	 vxw4IuQV6M+sM1ffALGpLWitMUZipM5zV+1rYqDDDFL51BVfKpNZEuC04Q6VWvsmvk
	 rICEm+Po1hVKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 5/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon, 17 Feb 2025 18:41:15 +0800
Message-ID: <acbc051cb79405e7959a4815acc4533e41958804.1739788598.git.tanggeliang@kylinos.cn>
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

