Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487117CA12
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318587; cv=none; b=Z3Ofo6BrOl4fpmBpapwLiq+F/+IuXCGJJQH+qwQjjYW1UUmk0zO7u6J48pFa9MOHrrnzYrsczuM/mfSytVFnJ/hKCwloEfyRYGkz5A5E7ltb63hns1aCc+eh2PyeBikN0NFmAcSaBLIFGe8C47hn/CIGZtZCM/uoW44vtrfzZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318587; c=relaxed/simple;
	bh=FzSETpjsjaPxqKoRGWTcl3SzqZZiG8gjKJiafRMmTi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHmyyKM7c+WUFzT1x0z3MLBC7qZ4ZkVuzcuhMAXFC4tV7KLOXQ2OzCA5lNDeqSczbzjUVQbUSnSJUfFyz4+1aiIded2m9VW+pksYEyIM+dlkL0ZpSvlMzIklwMEYo22RvGYoZMXMID5AudqUrZnqjzrRfRmxHFNM9DVLRrJytQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzcF4yPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzcF4yPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C752C32782;
	Thu, 22 Aug 2024 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318586;
	bh=FzSETpjsjaPxqKoRGWTcl3SzqZZiG8gjKJiafRMmTi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzcF4yPYlTWunIXHFB9h3o8YdY66P3kunXaQAedQEvb2Nr8l4QAKoTbGn1gOpYp13
	 HcSkTUdTDbgicCmF3xTn5BtKTaHHn0BIZZh+a4e7wJdO1xF4ak2QQpqnyZ10/d6jJ1
	 Mj5P9tbraAYBFjg5xRfz534honZLYXSJloREdhh2eXU8wz1Qkc+1D4Qpm05jm+by4o
	 jScVKHkPUepAwTL6nKY/Wa48FG7q6eoWALyYcBlLS6IpGFGpe/720Y/zyMaisbOu/B
	 Nwo1xSgGQxFxbAGubq3Kp2dEnIe4Yh0NyIOQbdM/GI/0kS9kJlglyglbIbVn0JuxNV
	 I0Eq16hreuKcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next v3 2/2] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Thu, 22 Aug 2024 17:22:51 +0800
Message-ID: <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724318341.git.tanggeliang@kylinos.cn>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 23 ++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 55 +++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d4c5209fbfaf..143ed1c756e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -371,6 +371,10 @@ static int endpoint_init(char *flags)
 static void run_subflow(void)
 {
 	int server_fd, client_fd;
+	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
+	socklen_t len;
+	int err;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
@@ -382,6 +386,18 @@ static void run_subflow(void)
 
 	send_byte(client_fd);
 
+	sleep(0.1);
+
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	if (!ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)"))
+		goto close_client;
+
+	len = sizeof(cc);
+	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");
+
+close_client:
 	close(client_fd);
 close_server:
 	close(server_fd);
@@ -392,6 +408,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -417,6 +434,11 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
+					  cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
 	run_subflow();
 
 close_netns:
@@ -425,6 +447,7 @@ static void test_subflow(void)
 	mptcp_subflow__destroy(skel);
 close_cgroup:
 	close(cgroup_fd);
+	bpf_link__destroy(link);
 }
 
 static struct nstoken *sched_init(char *flags, char *sched)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..70d9f5888976 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -4,9 +4,44 @@
 
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
 
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
+	     cond_break, pos = list_next_entry(pos, member))
+
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_first_entry(head, typeof(*pos), member),	\
+		n = list_next_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     cond_break, pos = n, n = list_next_entry(n, member))
+
+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)		\
+	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..e8cc157278d2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,7 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +58,57 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
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
+	}
+
+	return 1;
+}
+
+static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
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

