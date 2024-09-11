Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB938DD3
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026865; cv=none; b=iysTF/zdW31mAXgvh3Jp8c+1bMl8jVVFbMLk6ZExOh6sglIYMM6xweTkcB5EB9dEqAYd6aRojL4uPYgYVcDlYLrwBtE9L0ydvG7ERuXk+hcKsy54aE5dcwz2JZhAL/pMglQl52R1ZEpw2CubYjZ4VeiIXUGgLefRrkMWOsJWWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026865; c=relaxed/simple;
	bh=2Nk4o8bxYFUz3x8v0W2wjaEhJ1ftIS9t4gSy6U7knwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uktYNN+wQUFk3uCYfGkd89d4o5wrkPnU87EDn5X2zOjjnK43LRol52da2SZMQZxEQ2ltaX3mN3nxYcxKbIin4rOo8mSCHfnTyLUWdzF70gaUATL7AgjTHMLk8MX8R/88BpT+tolGOW/d86L4WfZT2YaTF9lpJs/6ywWjtf+Y7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piVqM9hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piVqM9hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43216C4CEC5;
	Wed, 11 Sep 2024 03:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726026864;
	bh=2Nk4o8bxYFUz3x8v0W2wjaEhJ1ftIS9t4gSy6U7knwE=;
	h=From:To:Cc:Subject:Date:From;
	b=piVqM9hdiWzYLspfMthD6yVtZqgiJQOTUHz4oxX7SRwix+pR+liWMLChqTFsJ2KS/
	 B5M2vPrjU0P7nPdjbL6Z9uXbregf7nieOhzR2tR26FBRLZRF8oRZeHvxJUI4leoa0P
	 zHTSrtCIDL3zFeqhAHm0cjdr3hLAhnRe84dhRanXKwLIrZv36+Xo1PfH0pvVonZ3Ze
	 xJeCflRqfJZ+PF1637+6zRThTZucT1VOyt+f4m1yFSsDhGcK43OO0S4AnelNi0CJg+
	 EulAMXZZKKdJGZBJMlk2wXH0u5mvYDw6S38QBu6OY2LBbmcI3qgWxsXEnFG1toMBBJ
	 V7s0H9bypVjWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3] Squash to "selftests/bpf: Add bpf scheduler test" - drop has_bytes_sent
Date: Wed, 11 Sep 2024 11:54:18 +0800
Message-ID: <a92cdca650b2e3e6ea40e783331d1fe83ac9aae6.1726026758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop ss_search() and has_bytes_sent(), add a new bpf program to check
the bytes_sent.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v3:
 - add msk->pm.server_side check.
v2:
 - address Matt's comments. (thanks)
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++++++---------
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 39 +++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a3e68bc6afa3..53e872bcfbe2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_bytes.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -490,56 +491,59 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
-static int ss_search(char *src, char *dst, char *port, char *keyword)
-{
-	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
-			  NS_TEST, src, dst, port, PORT_1, keyword);
-}
-
-static int has_bytes_sent(char *dst)
-{
-	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
-}
-
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 {
+	int server_fd, client_fd, err;
+	struct mptcp_bpf_bytes *skel;
 	struct timespec start, end;
-	int server_fd, client_fd;
 	unsigned int delta_ms;
 
+	skel = mptcp_bpf_bytes__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load: bytes"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = mptcp_bpf_bytes__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: bytes"))
+		goto skel_destroy;
+
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
-		return;
+		goto skel_destroy;
 
 	client_fd = connect_to_fd(server_fd, 0);
 	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
-		goto fail;
+		goto close_server;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
-		goto fail;
+		goto close_client;
 
 	if (!ASSERT_OK(send_recv_data(server_fd, client_fd, total_bytes),
 		       "send_recv_data"))
-		goto fail;
+		goto close_client;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
-		goto fail;
+		goto close_client;
 
 	delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
 	printf("%s: %u ms\n", sched, delta_ms);
 
 	if (addr1)
-		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
+		ASSERT_GT(skel->bss->bytes_sent_1, 0, "should have bytes_sent on addr1");
 	else
-		CHECK(!has_bytes_sent(ADDR_1), sched, "shouldn't have bytes_sent on addr1\n");
+		ASSERT_EQ(skel->bss->bytes_sent_1, 0, "shouldn't have bytes_sent on addr1");
 	if (addr2)
-		CHECK(has_bytes_sent(ADDR_2), sched, "should have bytes_sent on addr2\n");
+		ASSERT_GT(skel->bss->bytes_sent_2, 0, "should have bytes_sent on addr2");
 	else
-		CHECK(!has_bytes_sent(ADDR_2), sched, "shouldn't have bytes_sent on addr2\n");
+		ASSERT_EQ(skel->bss->bytes_sent_2, 0, "shouldn't have bytes_sent on addr2");
 
+close_client:
 	close(client_fd);
-fail:
+close_server:
 	close(server_fd);
+skel_destroy:
+	mptcp_bpf_bytes__destroy(skel);
 }
 
 static void test_default(void)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
new file mode 100644
index 000000000000..95770b0ebcf0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+u64 bytes_sent_1 = 0;
+u64 bytes_sent_2 = 0;
+int pid;
+
+SEC("fexit/mptcp_sched_get_send")
+int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	if (!msk->pm.server_side)
+		return 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct tcp_sock *tp;
+		struct sock *ssk;
+
+		subflow = bpf_core_cast(subflow, struct mptcp_subflow_context);
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		tp = bpf_core_cast(ssk, struct tcp_sock);
+
+		if (subflow->subflow_id == 1)
+			bytes_sent_1 = tp->bytes_sent;
+		else if (subflow->subflow_id == 2)
+			bytes_sent_2 = tp->bytes_sent;
+	}
+
+	return 0;
+}
-- 
2.43.0

