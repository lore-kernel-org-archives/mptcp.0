Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F80F510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368278; cv=none; b=CDojfk/Fdn8i2KRBXupgQL8TiIbcF2HnN13lR7JAsA2mrL72jyrMzpKWPgtTBphEHaDdiPCvXEcmSmY2oekhNQyptK5I5jS3NCXqQ61TUnAIpwrYHyMHOyJTi0MQN+kWEN7ku+LkgRUD//23Jd9AhwuZATxxL+RQhnQ9qoleE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368278; c=relaxed/simple;
	bh=oTWOORozCRRkx+BuuccJDCPwDpq0zB0utA9Z7QbqOj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRtq1pMGSdlab6u83MYqEP8+1RZVbkAP/AViTguaW4oJUMuqQ/db18UlquWy5jL+VlopgK6LbUOANLHKBRiZgnn5FV7qZWV+S2vHeGyeloNphwjLlfDw3Ha6MP+L3y3TjcRM+vNTwRe0UdeFSCZM3rlnrYDn7YpGuzFakI9/hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXks5ur4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXks5ur4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C9DC4CEDD;
	Mon, 24 Feb 2025 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368278;
	bh=oTWOORozCRRkx+BuuccJDCPwDpq0zB0utA9Z7QbqOj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXks5ur4VNlOHNWEeD8Q+be6j0mqgRjO4F7jRuZtIBvfUVcABBAbG2/xZY7pXYxdn
	 ZB715BdjAOBshCIn0k8gk8LmTj2y9iAG4oneXB3TBm6voBimsRsNWzRP+uWqEevsoX
	 HFPyI06byPo9tb59A6cOrsVfkm0CknYr3UkIp1TEEBOQDuXuqffxzZo1z+Guq7Uf7c
	 cSHIWCDGkmTm2ZgzCx3vhqrXftyQ2hHT/qPR6kM79UG3bmAfP1uyoG0ytTEzEDUEcj
	 C7ROxPcWb+3f+SqAcYWpDHilO7qWBsvsxAh08NEzpLcXi+x3x3b3PttlErNFKNh2JK
	 TbizeIy1cUu9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Mon, 24 Feb 2025 11:37:40 +0800
Message-ID: <1250879bf18715fdf7acd525d52db6b83f325581.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use bpf_core_cast() instead of bpf_skc_to_mptcp_sock().
Change the 2nd parameter type of bpf_for_each() as 'struct sock'.
Drop use of bpf_mptcp_sock_acquire/release.
Drop declaration of bpf_mptcp_subflow_tcp_sock. It's no longer used.
Update the comment for mptcp_subflow_tcp_sock(), which is a BPF helper,
not a kfunc.

Please update the commit log as:

'''
This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
newly added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy
and other helpers into bpf_experimental.h.

Use bpf_for_each() to walk the subflow list of this msk. MPTCP-specific
packet scheduler kfunc can be called in the loop. In this test, just
add all subflow ids to local variable local_ids, then invoke the helper
mptcp_subflow_tcp_sock() in the loop to pick a subsocket.

Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
of the picked subsocket and do some verification. Finally, assign
local_ids to global variable ids so that the application can obtain this
value.

Add a subtest named test_iters_subflow to load and verify the newly added
mptcp_subflow type bpf_iter example in test_mptcp. Use the helper
endpoint_init() to add 3 new subflow endpoints. Send a byte of message
to start the mptcp connection, and wait for new subflows to be added.
getsockopt() is invoked to trigger the "cgroup/getsockopt" test program
"iters_subflow". Check if skel->bss->ids equals 10 to verify whether this
mptcp_subflow bpf_iter loops correctly as expected.
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h      |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  5 -----
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 10 +++-------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2ab3f0063c0f..6a96c56f0725 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -577,7 +577,7 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 struct bpf_iter_mptcp_subflow;
 extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-				      struct mptcp_sock *msk) __weak __ksym;
+				      struct sock *sk) __weak __ksym;
 extern struct mptcp_subflow_context *
 bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 extern void
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index b1f6e1fb467e..72263672510a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,13 +43,8 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
-extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
-extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
-
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
-extern struct sock *
-bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index fd5691a4073b..a1d8f9b20259 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -24,14 +24,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
-	msk = bpf_skc_to_mptcp_sock(sk);
+	msk = bpf_core_cast(sk, struct mptcp_sock);
 	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
-	msk = bpf_mptcp_sock_acquire(msk);
-	if (!msk)
-		return 1;
-	bpf_for_each(mptcp_subflow, subflow, msk) {
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
 		/* Here MPTCP-specific packet scheduler kfunc can be called:
 		 * this test is not doing anything really useful, only to
 		 * verify the iteration works.
@@ -39,7 +36,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 
 		local_ids += subflow->subflow_id;
 
-		/* only to check the following kfunc works */
+		/* only to check the following helper works */
 		ssk = mptcp_subflow_tcp_sock(subflow);
 	}
 
@@ -58,6 +55,5 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	ids = local_ids;
 
 out:
-	bpf_mptcp_sock_release(msk);
 	return 1;
 }
-- 
2.43.0

