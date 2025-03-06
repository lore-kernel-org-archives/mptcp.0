Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF12907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227357; cv=none; b=E2WvHd8SN1ym6WK6nDv1tQWyREBq0KIDYjj9Kc629PnUdXhM5FsVmwksB2b8v/DsdFGPKmkPZB3jc3/1awK/KwLBzETd0efDJqv35C/rBM/iSnbrSJ2ZFs5FO+Q2L8CbjEnyFjzdKceUlOJSeNNhJ+mXso/Hdfj1oXWuP4LVXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227357; c=relaxed/simple;
	bh=pO9cCmvUuDRD2KP7viIxLy2Yejho7yIcGttVzJar1sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqTDO7bmlciEdN/c5v5F8mxdx5JIFzeo0aflaGP2SiVcbckgBFN+uh6mcY8ANy8epewQl2f1jBJE40Q6xMFxt1pUchy6zKdciP89oowhEf7p+8AKL7bpCjoPySbKG5eob1+Icq9Ryf0tzGr69kc4+ouKa0bPgj+WSZymoizCu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH8nUlwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH8nUlwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C4C4CED1;
	Thu,  6 Mar 2025 02:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227356;
	bh=pO9cCmvUuDRD2KP7viIxLy2Yejho7yIcGttVzJar1sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qH8nUlwMjUgs9cGeJRSmv5JUJFUgoXSrzMP/X7qXnDeWIWTdPIMDHcwUHop5aEGH0
	 ej5X7jBlNrFG6GjM0/N/fmetKjRlxTXbaAWKfwd2DpESmNMuFnl6vu8H8GrFMn0qK6
	 ATQAb3Kd54tx7yMQ2uiNMzXQOAmicCPCLxohIOXdF+FortlLyDxV3FNueaHni2uiOH
	 xvNRGlwGmRJXHkK4oaHgThn0UvwHd43s4cA9Vx5gmhah15wHMlZcCSU7DGYULtKJGh
	 WrkzI+PdiSKBTI/uCbUzr5k04/aUV/a/Xbgiw4rkbSSOqeC3FpqLx6GzN8+tPCh7Sc
	 drwnTx1VqCzmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 6/8] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Thu,  6 Mar 2025 10:15:38 +0800
Message-ID: <fddee0806543b6a496bb74079d8d0cbcece194d0.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c   | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ea31b3b28367..ddbf69145d22 100644
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
index 5128a886119d..3c685c77f67f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -65,7 +65,7 @@ int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk)
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-- 
2.43.0

