Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757ED1D0E2D
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268669; cv=none; b=ncA2zeblFjhQk/+9jRyGJWjuvnfkC+K7YAcV+kiCQ3wn8duLxLId6owKLQ6sNoDI7wVVxpa/5Z9AG7CXjotrTsLwbsgjpROnPteZgH9TLjf5JO8rOxgihl0Qo6OsvKZ70rMa0rYqUQwDTEc0yrRcCsQKF+kvdFAQ/sB0FHhBphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268669; c=relaxed/simple;
	bh=eug7vwOMD9L0g82Pf6+rW3vQHVWWUKMoNLkijWNB9lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sf4nKXsEF1GCw3gpGAyo0us4cbz9/hWrvdINi7iH3qk2pAyYvrTBPXyZN25xdZ0dc+6RgbwzovUSaLCwWe5/RCNZ0/aldnFChjMOK0Uu+cdiXm/HxAnTlfjLpqeMNdiGwnz5CZERojfV78zzAiiTjL6+Mj0grtjN3AaNI4OpeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJlW3IOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJlW3IOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1532C4CEE4;
	Wed, 30 Oct 2024 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268669;
	bh=eug7vwOMD9L0g82Pf6+rW3vQHVWWUKMoNLkijWNB9lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJlW3IOiCaLvZUm8LZ5P5DtKk0l/SrIt8yKmeXVNmZenLmrdF/NQlwPCnJuZLRJqj
	 Nc8iPlnmZGqAYISyrAb5k1j0CtIDquP7NOimQ7n3B/kxWVYTZCxk/q/Xc/8cOevE/1
	 OUhCewUorCuL4RbAkGPRKhpdFxQHJw0d0JGBoLXrFzfUuLBOcJu8FZgnxdQkUUKgGK
	 hmRsONbsFX4LAsTsJOEIN5kaSaCQ427xZmIXvFGCPAfbaRlEuBV19/fU82xo2j9fQC
	 lgGt0LRsioZT1e2acoxFXJ9zXZnM69/7BBEU/ceNIV5ydjjeyz44+WqIoz3/Bydc2N
	 ZlMDqSBLIblOQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 09/13] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed, 30 Oct 2024 14:10:33 +0800
Message-ID: <4d6f46e87cd8b9c645da2dc1445c46f7421bb941.1730268415.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c    |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 524527306958..e845809cd2a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -720,7 +720,7 @@ static void test_red(void)
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

