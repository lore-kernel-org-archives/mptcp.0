Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66F1B1D57
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226613; cv=none; b=cfh9YZCg8QR4bVhVaDAlsb2VffoaZt5qqhEAUZd03vobRRY0/5toqlqS1LVcwZVnfPQNLPQVk8N45U+ipnB2A/SeTSqBUuLg2UhcUHtVb/uD7G9128Z0uaXKW9u/4ey54oVBoF1FA986r0+Ez3h1K05/UgMHWUWDw4nVqFyI54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226613; c=relaxed/simple;
	bh=Qc7XiQtGv+9Rp2IkhoMDGBJVUcdn9pfnpYwwchCOSik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltRb4nVSNu59QMiRlpWgioIL2vjgFtucLHF8rIdJaPOUImaZZN/V1WW7pqTz7cnoFcJuyz7lqKPb+3v4l2kYfLNb1nx1AX7laevDbyA8/6r+wwH9fhwVGHy18ie2GYGGIYnUiCUG6tvtGi6DtUMcIdJw2X/OA34JA1ZG2WJVh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgTeeBKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgTeeBKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09835C32782;
	Wed, 21 Aug 2024 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724226612;
	bh=Qc7XiQtGv+9Rp2IkhoMDGBJVUcdn9pfnpYwwchCOSik=;
	h=From:To:Cc:Subject:Date:From;
	b=FgTeeBKP8krswvwdxbDf8+w9Ra9RvfPQ84MX5TDQkd6M8cb2v+sadDTFmpy4Ha2do
	 EzoDqeEIZBcZ8l6Ml4KfeyWXN9TEpFxvoXhya0J5zurnUMAOz7byoD7pMzz0ZpjwZs
	 9xbkRQSy/lkcHPdP6bAyC51/se6POpNY2CBmLhLBsvDXEJpev2i86vfwJKH9M7VF3/
	 zQtZ686eM0VGxuCF6DLWb+aWTJYrSVLDjmOjKF/IqWNb2bcBN4BXcmixDqkaQw1ubB
	 nU2+fL7MW8gAarS5HqoD7DaPtN7CtJLyfn/zGUcdtwI4cRfwIxJu1gsJ9LA5Zy/jTu
	 KbXnOSfnEuaQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v2] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Wed, 21 Aug 2024 15:50:05 +0800
Message-ID: <b408bd6c62d50c91e02b995c1a09aae9d2fc619e.1724226530.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "cgroup/getsockopt" way to inspect the subflows of a
mptcp socket.

mptcp_for_each_stubflow() and other helpers related to list_dentry are
added into progs/mptcp_bpf.h.

Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and use
bpf_core_cast to cast a pointer to tcp_sock for readonly. It will allow
to inspect all the fields in a tcp_sock.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 17 ++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 28 +++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 60 +++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 73adc58cd776..75ccab4a9135 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -383,6 +383,7 @@ static void run_subflow(char *new)
 {
 	int server_fd, client_fd, err;
 	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
 	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
@@ -405,6 +406,15 @@ static void run_subflow(char *new)
 	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
 	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
 
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
+		goto close_client;
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");
+
 close_client:
 	close(client_fd);
 close_server:
@@ -416,6 +426,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -441,6 +452,11 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
 	run_subflow(skel->data->cc);
 
 close_netns:
@@ -449,6 +465,7 @@ static void test_subflow(void)
 	mptcp_subflow__destroy(skel);
 close_cgroup:
 	close(cgroup_fd);
+	bpf_link__destroy(link);
 }
 
 static struct nstoken *sched_init(char *flags, char *sched)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..61dbf7670aa7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -7,6 +7,34 @@
 
 #define MPTCP_SUBFLOWS_MAX 8
 
+static inline int list_is_head(const struct list_head *list,
+			       const struct list_head *head)
+{
+	return list == head;
+}
+
+#define list_entry(ptr, type, member)					\
+	container_of(ptr, type, member)
+
+#define list_first_entry(ptr, type, member)				\
+	list_entry((ptr)->next, type, member)
+
+#define list_next_entry(pos, member)					\
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)		\
+	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..b451893d0812 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,8 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "bpf_experimental.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +59,61 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+static int _check_getsockopt_subflows_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+
+		if (ssk->sk_mark != ++i)
+			ctx->retval = -1;
+
+		cond_break;
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if (ssk->sk_mark == 1 &&
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX))
+			ctx->retval = -1;
+
+		cond_break;
+	}
+
+	return 1;
+}
+
+SEC("cgroup/getsockopt")
+int _getsockopt_subflow(struct bpf_sockopt *ctx)
+{
+	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct mptcp_sock);
+
+	if (!msk || !msk->token)
+		return 1;
+
+	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
+		return _check_getsockopt_subflows_mark(msk, ctx);
+	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
+		return _check_getsockopt_subflow_cc(msk, ctx);
+
+	return 1;
+}
-- 
2.43.0

