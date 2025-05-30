Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673019D8BE
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592240; cv=none; b=BjB5h7kYzgRbN+bGH1irwol1vRAhl7xCuC3Le2jU2NUNPTAVMeOdZOHUeFwp2HkbWt+pzjNFNy+45k1mWpPn6A75cuB2XKIkNysfTJ+dwrw9a6MXFUiW2U4A7s31rnxgl2U+fPjSBwx+Om4h20nGlPDOIAdcUsfLoFHEnmAovEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592240; c=relaxed/simple;
	bh=qfJqsmVsgdLm6qWdPXmBpkv7iQ5c1rfYlKGUuJXyJS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec87YMAMsdN+GVHxyceBPrPUx8o4Qqt8XVO7Gl2yEqfj86nuKaeWPWOQBKmyziuOZodXectRsbnULp05lVUo+Rv6bgSQPyagrmGe8pohAc0mVBoUKAQO/G0o22NedpPriskHThg+PyzTde3pwHZfFcOGVSzhpFYb7eCML2PbTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPaoCczs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPaoCczs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FCEC4CEE9;
	Fri, 30 May 2025 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748592240;
	bh=qfJqsmVsgdLm6qWdPXmBpkv7iQ5c1rfYlKGUuJXyJS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPaoCczstT/wCveb6Z1FPXkOm4Mho2YbTOFUILcNdJErf/CpeEEpSbab7fRhIEt3C
	 quEwCAu4yUiGaZMXU7MPyeC3k7A0QHRjwdWx89YKW4ov7l8hfYq5Nj1Ec5lQ6w6oZc
	 5WbAGpSmPLdIbHJ4Re7TAGPYb9G8f5Gi1qAUMQ6Y9Pf+DzWKqHv+/4dgfEVbKBhDVg
	 OKTA9uGZ27+ZLtOJUG261J0F1y9Y27rfPCsFj5GkuLAwUeEqcCfbB1tegLlI5fe6Wv
	 yinu5ls0c4jzdza4kYWUXW9mN0Nq1ZU1VdVKIeq52Y3hwtItzxadXviV8+FHCb6lzR
	 1nuISSWNrmFEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] Revert "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Fri, 30 May 2025 16:03:47 +0800
Message-ID: <e7b77122a6725d2cf8432bebedd5adf434eced3d.1748592117.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748592117.git.tanggeliang@kylinos.cn>
References: <cover.1748592117.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop this patch as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  8 --
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 -------------------
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 59 ---------------
 3 files changed, 140 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index c68827293cb9..5e512a1d09d1 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -578,14 +578,6 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
-struct bpf_iter_mptcp_subflow;
-extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-				      struct sock *sk) __weak __ksym;
-extern struct mptcp_subflow_context *
-bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
-extern void
-bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
-
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7c51250e7161..d75b402c7706 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,7 +11,6 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
-#include "mptcp_bpf_iters.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -41,9 +40,6 @@
 #ifndef MPTCP_INFO
 #define MPTCP_INFO		1
 #endif
-#ifndef TCP_IS_MPTCP
-#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
-#endif
 #ifndef MPTCP_INFO_FLAG_FALLBACK
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #endif
@@ -495,73 +491,6 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
-static void run_iters_subflow(void)
-{
-	int server_fd, client_fd;
-	int is_mptcp, err;
-	socklen_t len;
-
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
-		return;
-
-	client_fd = connect_to_fd(server_fd, 0);
-	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
-		goto close_server;
-
-	send_byte(client_fd);
-	wait_for_new_subflows(client_fd);
-
-	len = sizeof(is_mptcp);
-	/* mainly to trigger the BPF program */
-	err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP, &is_mptcp, &len);
-	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_IS_MPTCP)"))
-		ASSERT_EQ(is_mptcp, 1, "is_mptcp");
-
-	close(client_fd);
-close_server:
-	close(server_fd);
-}
-
-static void test_iters_subflow(void)
-{
-	struct mptcp_bpf_iters *skel;
-	struct netns_obj *netns;
-	int cgroup_fd;
-
-	cgroup_fd = test__join_cgroup("/iters_subflow");
-	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
-		return;
-
-	skel = mptcp_bpf_iters__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
-		goto close_cgroup;
-
-	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
-							       cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
-		goto skel_destroy;
-
-	netns = netns_new(NS_TEST, true);
-	if (!ASSERT_OK_PTR(netns, "netns_new: iters_subflow"))
-		goto skel_destroy;
-
-	if (endpoint_init("subflow", 4) < 0)
-		goto close_netns;
-
-	run_iters_subflow();
-
-	/* 1 + 2 + 3 + 4 = 10 */
-	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
-
-close_netns:
-	netns_free(netns);
-skel_destroy:
-	mptcp_bpf_iters__destroy(skel);
-close_cgroup:
-	close(cgroup_fd);
-}
-
 static int sched_init(char *flags, char *sched)
 {
 	if (endpoint_init(flags, 2) < 0)
@@ -754,8 +683,6 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
-	if (test__start_subtest("iters_subflow"))
-		test_iters_subflow();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
deleted file mode 100644
index a1d8f9b20259..000000000000
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2024, Kylin Software */
-
-/* vmlinux.h, bpf_helpers.h and other 'define' */
-#include "bpf_tracing_net.h"
-#include "mptcp_bpf.h"
-
-char _license[] SEC("license") = "GPL";
-int ids;
-
-#ifndef TCP_IS_MPTCP
-#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
-#endif
-
-SEC("cgroup/getsockopt")
-int iters_subflow(struct bpf_sockopt *ctx)
-{
-	struct mptcp_subflow_context *subflow;
-	struct bpf_sock *sk = ctx->sk;
-	struct sock *ssk = NULL;
-	struct mptcp_sock *msk;
-	int local_ids = 0;
-
-	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
-		return 1;
-
-	msk = bpf_core_cast(sk, struct mptcp_sock);
-	if (!msk || msk->pm.server_side || !msk->pm.subflows)
-		return 1;
-
-	bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
-		/* Here MPTCP-specific packet scheduler kfunc can be called:
-		 * this test is not doing anything really useful, only to
-		 * verify the iteration works.
-		 */
-
-		local_ids += subflow->subflow_id;
-
-		/* only to check the following helper works */
-		ssk = mptcp_subflow_tcp_sock(subflow);
-	}
-
-	if (!ssk)
-		goto out;
-
-	/* assert: if not OK, something wrong on the kernel side */
-	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
-		goto out;
-
-	/* only to check the following kfunc works */
-	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (!subflow || subflow->token != msk->token)
-		goto out;
-
-	ids = local_ids;
-
-out:
-	return 1;
-}
-- 
2.43.0

