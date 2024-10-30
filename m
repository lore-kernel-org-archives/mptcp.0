Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369A1D0F66
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268667; cv=none; b=Cgwj4ODicQEThsUB9uKQod7PQxQcnrLR0jKdH2nLDvUB6nshoHRL04nWdXPZJsQAqFn4crNQLkPteOAQP317XB0F89oXZKFKsqlfSZ2sUw5SuOZ8o0/m4yODzm84EEctgLXeycKgUMCYXnGl4ZhZAZNgXIYdW9hb5yncwOnbIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268667; c=relaxed/simple;
	bh=dBGH5/nk1NGmoLa1epcOa0DzlFzpTxH0NmWEl3LX+vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq8jm6LKVCWemr1d4+4MGPMNsiCNxbawFVSnunquIS7NqDxw+0l3ErhhSScdPdBJ8DbWhwrX6wMsiGPfvJn0rmfA26+Cmo2hgeT18lGXCYctjbfhaGAOw0tX3nr8ppBY/PD4I7+rKUqLu/v1K9z+JHOeJKFI0BP1xG25DGnTsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzG5iDsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzG5iDsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C9AC4CEE4;
	Wed, 30 Oct 2024 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268667;
	bh=dBGH5/nk1NGmoLa1epcOa0DzlFzpTxH0NmWEl3LX+vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzG5iDsfn+NbJOXR5wtlx2TZziaR6i40rlDrpMgZySUJcbDPbi0WbvvyD+ZSU6j91
	 3WnZkGFKM1ZfinkCOX6VOU8FfM6jR0b1v2iB3TMtJPifGOb3sQFii3WVlwxFLFdhXM
	 0HL4/32n2ep424TShF7orSqoWWwpRLxzLfl1ChDM+fLaxf9VQtmNwZ8BC2M0V7bZVj
	 bS8wfOrnbF/DCNeXKXy/lPiPmMy6tZ7R6qhS8KKmISTdxmXEUQ+D8S8ADbf65KPWY9
	 mCperYqsrMVKZooYvDdwWAljytiK/Tpc+3yILWsTZJxvyhiZGfnDtPs2Ug4HVRStdP
	 jR3BkQgLi7uJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 08/13] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Wed, 30 Oct 2024 14:10:32 +0800
Message-ID: <59e32803f687c2b1369f4aa9a513cd2de84c40ff.1730268415.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 33 ++++++++-----------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d388bfca21bf..524527306958 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -708,7 +708,7 @@ static void test_rr(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: rr"))
 		return;
 
-	test_bpf_sched(skel->obj, "rr", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.rr, "rr", WITH_DATA, WITH_DATA);
 	mptcp_bpf_rr__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..c901ed045fdc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -34,42 +34,37 @@ SEC("struct_ops")
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
+	if (!ptr->last_snd)
+		goto out;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!last_snd || !subflow)
-			break;
-
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
+	next = bpf_core_cast(next, struct mptcp_subflow_context);
+	mptcp_subflow_set_scheduled(next, true);
+	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-- 
2.45.2

