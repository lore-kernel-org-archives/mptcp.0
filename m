Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D4200B93
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267244; cv=none; b=uwFhdSZloyyjdj4CtBmarY23k5jhbFnHlYT5QwgpMEb1G3AGuv2+6sF4qNJOTLrEBv/uK9ERZRQ9OoEhbpI5t4QRNTItNZIxr4Zkq7NJVY4gxLysPG/td5IkbjrpcsdROcmOfscK7EIdonT3cVHVQMIA8UaKuUvImS6wHeiosUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267244; c=relaxed/simple;
	bh=9cY+q8M8YhQo/6ZqA7vpVGocB5n+bdUr8nGEdtj8xw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxeXqyMJVlHSuLRQsqkvpeTWOOZsTOMiGp1xr/f6Duux4kNbOzrm1xk/hpG9rJslme+hl4xCZOD8MA8XvR7PqNrT8fSFON9QFn8t4fmy+2HWVEBSogJQJO/4mr/ZjI95chNG5Ns3BQCD+UxTvLFrhe3Kmo+Y6xnweXkZjYAFnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeYcy0nD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeYcy0nD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5184DC4CEC3;
	Fri, 18 Oct 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267243;
	bh=9cY+q8M8YhQo/6ZqA7vpVGocB5n+bdUr8nGEdtj8xw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeYcy0nDf/rRoO5VC7c0Uz5NRriBVUhRSKLKtjQH6x0vLGrO1py29E1HNDpKx+Iz+
	 LiD88ozMfEK67VSA/o/STQkhQJqrh8SWaLuyJDmWbC0zHMLgqytLIsL3SW3N4f0jzg
	 CvOEqig7ffyjS4rhxc5bqGVQa8EXdlfmjlH04f3rTHvz8aC7g2jGS22DvRPxcHdFHw
	 ICvtCF7GwsETre69CmlE06mrB1E3zmJmFuWPcPJO8rb1V6bScI0zoHhCwWIEJUCphT
	 PEGS0fAOUuF1nAoODADVpwdOKB9lY2JRv2wlR43/tWP91/jwo33bHp4J8l4ukwx593
	 JfbgDfUEQodMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 5/8] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Sat, 19 Oct 2024 00:00:25 +0800
Message-ID: <716b9fefec475d2623b632406875a3bc8b87778a.1729267039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729267039.git.tanggeliang@kylinos.cn>
References: <cover.1729267039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" program "iters_subflow" to test the
newly added mptcp_subflow bpf_iter.

Export mptcp_subflow helpers bpf_iter_mptcp_subflow_new/_next/_destroy,
bpf_mptcp_sock_acquire/_release and other helpers into bpf_experimental.h.

Use bpf_mptcp_sock_acquire() to acquire the msk, then use bpf_for_each()
to walk the subflow list of this msk. MPTCP-specific packet scheduler kfunc
can be called in the loop. In this test, just add all subflow ids to local
veriable local_ids, then invoke the kfunc bpf_mptcp_subflow_tcp_sock() in
the loop to pick a subsocket.

Out of the loop, use bpf_mptcp_subflow_ctx() to get the subflow context
of the picked subsocket and do some verification. Finally, assign
local_ids to global variable ids so that the application can obtain this
value, and release the msk.

Add a subtest named test_iters_subflow to load and verify the newly added
mptcp_subflow type bpf_iter example in test_mptcp. Use the helper
endpoint_init() to add 3 new subflow endpoints. Send a byte of message
to start the mptcp connection, and wait for new subflows to be added.
getsockopt() is invoked to trigger the "cgroup/getsockopt" test program
"iters_subflow". Check if skel->bss->ids equals 10 to verify whether this
mptcp_subflow bpf_iter loops correctly as expected.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  9 +++
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 64 ++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b0668f29f7b3..d43690b17468 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -575,6 +575,13 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+struct bpf_iter_mptcp_subflow;
+extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
+				      struct mptcp_sock *msk) __weak __ksym;
+extern struct mptcp_subflow_context *
+bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+extern void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
+
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 02fdff87df2d..0799a3c65188 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iters.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -40,6 +41,9 @@
 #ifndef MPTCP_INFO
 #define MPTCP_INFO		1
 #endif
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
 #ifndef MPTCP_INFO_FLAG_FALLBACK
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #endif
@@ -509,6 +513,73 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_iters_subflow(void)
+{
+	int server_fd, client_fd;
+	int is_mptcp, err;
+	socklen_t len;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+
+	len = sizeof(is_mptcp);
+	/* mainly to trigger the BPF program */
+	err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP, &is_mptcp, &len);
+	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_IS_MPTCP)"))
+		ASSERT_EQ(is_mptcp, 1, "is_mptcp");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_iters_subflow(void)
+{
+	struct mptcp_bpf_iters *skel;
+	struct nstoken *nstoken;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/iters_subflow");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
+		return;
+
+	skel = mptcp_bpf_iters__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
+		goto close_cgroup;
+
+	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
+							       cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: iters_subflow"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow", 4) < 0)
+		goto close_netns;
+
+	run_iters_subflow();
+
+	/* 1 + 2 + 3 + 4 = 10 */
+	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_bpf_iters__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -690,6 +761,8 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("iters_subflow"))
+		test_iters_subflow();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index c3800f986ae1..3b20cfd44505 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,6 +43,15 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
+extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
+extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
+
+extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
+extern struct mptcp_subflow_context *
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
+extern struct sock *
+bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
new file mode 100644
index 000000000000..1bede22a7e3d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+int ids;
+
+#ifndef TCP_IS_MPTCP
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+#endif
+
+SEC("cgroup/getsockopt")
+int iters_subflow(struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	struct bpf_sock *sk = ctx->sk;
+	struct sock *ssk = NULL;
+	struct mptcp_sock *msk;
+	int local_ids = 0;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP ||
+	    ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+		return 1;
+
+	msk = bpf_mptcp_sk((struct sock *)sk);
+	if (msk->pm.server_side || !msk->pm.subflows)
+		return 1;
+
+	msk = bpf_mptcp_sock_acquire(msk);
+	if (!msk)
+		return 1;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		/* Here MPTCP-specific packet scheduler kfunc can be called:
+		 * this test is not doing anything really useful, only to
+		 * verify the iteration works.
+		 */
+
+		local_ids += subflow->subflow_id;
+
+		/* only to check the following kfunc works */
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+	}
+
+	if (!ssk)
+		goto out;
+
+	/* assert: if not OK, something wrong on the kernel side */
+	if (ssk->sk_dport != ((struct sock *)msk)->sk_dport)
+		goto out;
+
+	/* only to check the following kfunc works */
+	subflow = bpf_mptcp_subflow_ctx(ssk);
+	if (subflow->token != msk->token)
+		goto out;
+
+	ids = local_ids;
+
+out:
+	bpf_mptcp_sock_release(msk);
+	return 1;
+}
-- 
2.43.0

