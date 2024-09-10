Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AD1386DF
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948207; cv=none; b=AApm3JG9CBjJkynCZ8rAHolT0R0LiODErn5EXRdQW1QqD1ygOhZgpIeCE08cVSca6Y6ykyXWKgwJnjyjkhFkMu0rIPncUXV8B4zCEanEe/vNkpI638XmuVy6bQmrx8W+CMX4GoZMVkxbEht/G1M1GEmBviA8rfMC2uHZhq/E3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948207; c=relaxed/simple;
	bh=uZf/W296Nbgra0hflinj000j7a7UaKEK35HADStf87A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibvhK6U+s5yeLs73gHaUxp6Q8eOYRo/XxOTRwNDrUEI2bMWnf2YhpqyIDkFLkqWLL7u007SmxZYk6bM9Sj2U8MlAqFRgXLzkshG5uRUnFqLfondba5Ta9Fpm/rIIBTvklmJsdL33Te3P6M5p7l9pLqaGtVCpIK0MUBft0BLgq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnVBR3wH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnVBR3wH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8B5C4CEC3;
	Tue, 10 Sep 2024 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725948206;
	bh=uZf/W296Nbgra0hflinj000j7a7UaKEK35HADStf87A=;
	h=From:To:Cc:Subject:Date:From;
	b=VnVBR3wHPgRkEMR2FQsEkrQt4kzGcIAYgqnr+vBra+Twqze/++6mQ9EI6fYR+vJ+N
	 M+A3RIoOjNspkoSPu9bpzqYe7YKoXJdQmCPQm9mcOxZoQybDsQJHGTaa8kxxOicz3+
	 J9n0eU8IynVShEIS98QuMWEvnPCxTGvCbTTBNMc6svm0Q9hRWVxXhd9oFYQNGxGUSH
	 5+LPF3OVUfLMFlSSpKWWuCo4PZMDlTwNSl+gvsVujJKfaJmpUDjhpB6STopNCe43cb
	 VToYLkUgarJdk1ZVe1nAlthwfbfbJoylhxnVRxJrNZybvNqVJ2h97fQTMcx0bd6OYT
	 0r0scrd3RF9dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf scheduler test" - drop has_bytes_sent
Date: Tue, 10 Sep 2024 14:03:20 +0800
Message-ID: <bae090f6945a2621f9ed4de2cb0e29d772a0e760.1725948163.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++++++---------
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 36 ++++++++++++++
 2 files changed, 62 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 2476f0a083bc..273039ecd7ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_bytes.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -489,56 +490,59 @@ static struct nstoken *sched_init(char *flags, char *sched)
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
index 000000000000..93672e00d23e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Kylin Software */
+
+/* vmlinux.h, bpf_helpers.h and other 'define' */
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+char _license[] SEC("license") = "GPL";
+unsigned int bytes_sent_1 = 0;
+unsigned int bytes_sent_2 = 0;
+int pid;
+
+SEC("fentry/mptcp_sched_get_send")
+int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct tcp_sock *tsk;
+		struct sock *ssk;
+
+		subflow = bpf_core_cast(subflow, struct mptcp_subflow_context);
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		tsk = bpf_core_cast(ssk, struct tcp_sock);
+
+		if (subflow->subflow_id == 1)
+			bytes_sent_1 += tsk->bytes_sent;
+		else if (subflow->subflow_id == 2)
+			bytes_sent_2 += tsk->bytes_sent;
+	}
+
+	return 0;
+}
-- 
2.43.0

