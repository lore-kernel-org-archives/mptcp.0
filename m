Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F171E7C32
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998034; cv=none; b=r1EoGOxoscNfbzjASw2hZ+DUdFPM2l6dmFNyVVoirpgMEG1YfLDTY2MZ5FsUVkRCi0V4IfC9j96bGxOwL+gnnHNejaqqTw7louw72Aqi8IODO390RhbuEv9bDuV6JPnyy3AtposCi/+p26V5+PbKe6vcNyfZk58JXTJz5MFgvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998034; c=relaxed/simple;
	bh=rAnQKGajgsDwrJkO6LoSKauFlpSITe8Ph+M7eJIoDGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYzWl7NuX3RvLmODDkHuKPvVVlVHh1i9a0IQ3r8MdZHSvQd4sYmWsnUC7l0mxgtvnDKXe2qttDjBRiADLtVtLsGXW1Pe+niTqogLQQwQ6ie2vBnAmWjJN+rizcmjLVXbW54S+AlQq2iTWeHK70mllyAAH4dN+GOTn4mjKkG8I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRXcV7Z3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRXcV7Z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5A3C4CED6;
	Mon,  3 Mar 2025 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998033;
	bh=rAnQKGajgsDwrJkO6LoSKauFlpSITe8Ph+M7eJIoDGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRXcV7Z3fjOZAtIr60mVWlzikbo/9UFr3apuIuhjx6bg+ZU6oJRdaEnHQZbWP5guD
	 vzsRsPf2OYtvUgEvGv8yb1gP1BW6aw6jsVhzQ9C9tem/K4LkeA/Yh9qVZbVWnHpmGu
	 I3PsFILJwFmO3VJUcKiFvFMOZh/bJ8lUcV6zzFtonNlBEcTSJxuRenSzz3eB5Y5jwu
	 t9Je8MqAejcxX/fYC4YjTKjlXs2a2DLMyk5aWZKEA0ygywxSGJeLyj41sWKxCXjTuA
	 L/nP+i3Uae89JIVbq+Up9e4t3chnrcLfTTBlFQi/8+hOPRuXIOrjs+33hAZvMaTjvN
	 92LHAZyBx/obA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Mon,  3 Mar 2025 18:33:37 +0800
Message-ID: <68093cf9d188808f50cf36f6c8ac8d4a69d853b1.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/bpf_experimental.h      | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 5 -----
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 8 ++------
 3 files changed, 3 insertions(+), 12 deletions(-)

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
index fd5691a4073b..a69e88cc191d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -28,10 +28,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
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

