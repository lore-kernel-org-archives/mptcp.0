Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801618A95C
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143502; cv=none; b=VyyXlbLVZkhkG5XJRh3uG8aaH+ESxLL3hIvO/xUPtp7gucsqgfh0GWezhkALjaFHXNvYOv+NJrkV0EG+WjWVtBKv6IXpSaDZ2ggPG34Di0OmQMKyRIq+l8Gcq1L+w/04HNxvfwCsnIZzzhUL77EBpVfeUPtW85K9UVZ3GctGN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143502; c=relaxed/simple;
	bh=q0sWInm+Sgp1El4CWSVsdYIqVX/TwfayABaVariyjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMp+puItGC9WlruTTHlJ6p4mZ09N45hgSJN0AkA+8oVwnMmHnwG4jROlvNDX2YMw31QMPcbHuQYyA8ZzhIhNAbvVPUg2S11hNaQlNdu3BuhAuiQZ0V+DpRBeC3kPUt7Yx3Z//gLzfgTahz9wFTnDmp2YSU2wWNxovMIE10PoUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7EGldNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7EGldNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993B5C4AF09;
	Tue, 20 Aug 2024 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143501;
	bh=q0sWInm+Sgp1El4CWSVsdYIqVX/TwfayABaVariyjCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7EGldNHtry0gY5zRA2w6mGYvO/Q4BKQX3SdhWgAPqbFFN+aU+U3+MbvtdfKyzAw0
	 MsFq+T1lwPQyRvpfGamMQne0mUFU/ySXiUuu81M1s9l340SreUTnY37rNlY3bbYfto
	 N08HdCWeQzDGVgUgjdBAvAmsWaa0wzDwt6F4mkvLkyjtC6HPDxFJx2lW13MPf14gTv
	 ZlmSXJG3g8zdsNb9/ZE+wewlfTiW4dR9F5PeiQIJyAqwFAuk4Rvxrq4D0AQkzLSom5
	 IqCcP6aL4NhcmJFL0Ke1khRpasPxX4sEvqMDjml5FpqKTcsqFgpjcvFudXf7s09V5B
	 aTD2vufYa5KKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect mptcp subflow
Date: Tue, 20 Aug 2024 16:44:54 +0800
Message-ID: <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724142917.git.tanggeliang@kylinos.cn>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
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
bpf_rdonly_cast to cast a pointer to tcp_sock for readonly. It will allow
to inspect all the fields in a tcp_sock.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 11 +++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 26 +++++++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 32 +++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 69fdcb28249d..2178db94f764 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -383,6 +383,7 @@ static void run_subflow(char *new)
 {
 	int server_fd, client_fd, err;
 	char cc[TCP_CA_NAME_MAX];
+	unsigned int mark;
 	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
@@ -407,6 +408,10 @@ static void run_subflow(char *new)
 	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
 	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
 
+	len = sizeof(mark);
+	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
+	ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
+
 	close(client_fd);
 fail:
 	close(server_fd);
@@ -417,6 +422,7 @@ static void test_subflow(void)
 	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
+	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
@@ -442,6 +448,10 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
+	link = bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+		goto close_netns;
+
 	run_subflow(skel->data->cc);
 
 close_netns:
@@ -450,6 +460,7 @@ static void test_subflow(void)
 	mptcp_subflow__destroy(skel);
 close_cgroup:
 	close(cgroup_fd);
+	bpf_link__destroy(link);
 }
 
 static struct nstoken *sched_init(char *flags, char *sched)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 782f36ed027e..2086170e7379 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -7,6 +7,32 @@
 
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
+
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index bc572e1d6df8..c41418ab8db4 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -4,6 +4,7 @@
 
 /* vmlinux.h, bpf_helpers.h and other 'define' */
 #include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -57,3 +58,34 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
 
 	return 1;
 }
+
+SEC("cgroup/getsockopt")
+int _getsockopt(struct bpf_sockopt *ctx)
+{
+	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct mptcp_sock);
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	if (!msk || ctx->level != SOL_SOCKET || ctx->optname != SO_MARK)
+		return 1;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct inet_connection_sock *icsk;
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
+							   struct mptcp_subflow_context));
+		icsk = bpf_core_cast(ssk, struct inet_connection_sock);
+
+		if (ssk->sk_mark != i + 1)
+			ctx->retval = -1;
+		if (ssk->sk_mark == 1 &&
+		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc, TCP_CA_NAME_MAX))
+			ctx->retval = -1;
+
+		if (i++ >= MPTCP_SUBFLOWS_MAX)
+			break;
+	}
+
+	return 1;
+}
-- 
2.43.0

