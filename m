Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E91C242C
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801530; cv=none; b=uj68sIhLSvrE4hJGksTG6NbXPYdPE2rBEGDDBi1jVRhEnYR/SoIiozTPooabnQqi5o673GuNyfb4lK0e1BNxgzPQ0xU/5gqhlC06Bg84KpK/tw9+tQ6FnBvG+PreWsi3KURkULz4A5XbBXH5Kfyn/boKpjhhnfB6m0XDH7FXwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801530; c=relaxed/simple;
	bh=f2tjXufOMXq32hAWjBOmYOFogpGgwgMFndc3T1aP6Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjocIW6sl3mbOpb32OBW4WyURH8573qfggs2HKm0K0ax6D2QcihYC0+OFFk6JsXyynxHIjb+BMlYoB7UWtl+xb1/6MdVvWN4JR/v+OwAF0T6bZtVlt3AdA81dMs+N2GUC9lj8LbtG2iAEAKXILM1INS+2363ulgSjR+J7XezNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk7p7MLe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk7p7MLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7F8C4CED6;
	Tue, 10 Dec 2024 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801530;
	bh=f2tjXufOMXq32hAWjBOmYOFogpGgwgMFndc3T1aP6Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fk7p7MLekfl1AGTLWrsodeHAVyDhmKMgVC6i/N6Zdnb+ZBi4Cj3h0afhe+XTFJvab
	 G/I7QeAhwRIExR2rOpaMaKn8x+Op0B55uPky/y74KVv+7enV1T2snQ5W/6dExqevKD
	 UN+2aUqEnRIkV5CdVrjzjLHCbYV4U4j208p3NhHh0eRDTSGBf7UYE+5jF/OgIrBc9B
	 A5VS6Rs+ZbTwZWHbsFdq8/71j+dOrsU20sDn5mxOLvpw+PP8F8E+OtLOUD/eeTgHUZ
	 nRYfSi1VFja2nUvaDr9da5YWw8ynIbjVtQjJcMjhtErQVBWKV8UR3rTspcJZvcwO8Q
	 M/w+H8VQeJOrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 3/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Tue, 10 Dec 2024 11:31:40 +0800
Message-ID: <026738a87b4382abf8452e029a69c52eb9fd353b.1733800335.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..cc9f73de1005 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,38 +34,35 @@ SEC("struct_ops")
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
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-- 
2.45.2

