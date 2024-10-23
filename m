Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720B18953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676446; cv=none; b=cDqajwqRQE3Cd89KQ4q3dD4gLlQ+dRIiey2KREPQswvoXDuyJHAP1MIumuTs2e3JyBWo1TAQxb1OM2Azsyzd4Y7EATG/9nQtVY7WN2fxTE88o/tZVZdcnd+zWHCNf/QweNAgwDknqbQrMj8GwFMGLp3hWJixniWXrKigf9G+OJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676446; c=relaxed/simple;
	bh=lqSujFGuRuYfmfl4nwRJ4/W/eXxkgKVZeHZwO6F028Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWH/e1DNcKSNeALEVxCJRP3BgeJsfriejBfXKH32eueqj0pEMzLfrc18bqTHNL4+Oi76q+qelQEGni8ssN28DI3nyunRRqjyYfomX/lgQwRBki4UghMeKjr+6UPst6du8qfkeF/miGKwAFORH0YpfBEesB4/lHOSfGOCNFweHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz9SXmbV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz9SXmbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2557C4CEC6;
	Wed, 23 Oct 2024 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676446;
	bh=lqSujFGuRuYfmfl4nwRJ4/W/eXxkgKVZeHZwO6F028Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mz9SXmbVYyuIKUnTpBtzedGVLLEMYEpXrzTNgH1m43JZFwq3ddHkaunuEpBv9shwQ
	 1q1ORXtC9PtBfAvwF/Cw8xABNPSQu+lCQLXm+480hDbd5k+db1st93YzvZd7N77LVe
	 Kja4ThcHxkU1Gfuqx8pcU+lciDr6MSGksTazHClksV6rTkjPWYtn82GpgJJsyCF/YG
	 PohiRkuDwqXuktN2eSOjBLzCa0Ry5i5iech6NreysHY11vMQ4PLIv0xvo5b8ZybPwp
	 3XLnzlCFtLuPhTqYLMfYszBtRCSbOZjrmIDt/LM0UdeaQ9qsgHIXTukY/SIyJkGpwJ
	 6x7UHq9fTqulw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 09/13] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed, 23 Oct 2024 17:40:19 +0800
Message-ID: <2095b570f23db6afa742abd883176d2517423100.1729676320.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c    |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3d5290b48084..03eacae01b8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -738,7 +738,7 @@ static void test_red(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: red"))
 		return;
 
-	test_bpf_sched(skel->obj, "red", WITH_DATA, WITH_DATA);
+	test_bpf_sched(skel->maps.red, "red", WITH_DATA, WITH_DATA);
 	mptcp_bpf_red__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..35150771e174 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,17 +20,15 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-- 
2.45.2

