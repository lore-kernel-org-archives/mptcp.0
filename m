Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8251C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071267; cv=none; b=Ypzq0884eK8vCGte7m4b36wY+BET6ZQyn91qdDk/4AociEYsWwt5xqdBl0U2DRCZm8ZP7bLOOqYQI7gnjlaXRoaA6n7Rtex1d2nUMiQeejK7RaVwW4Q3nYiOy4GQM5aHeK06lKoIl7pb70J/3pnaJI3TF0y3P+D67ZDC69Wwqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071267; c=relaxed/simple;
	bh=sMmLuEbCM1Sf55vle1yIBoPO8ZosmwAZ67dE8QAinAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQjpFXCkxXMBs2VM+v6+ioajCXLCyMaFjMCuz/efxOCuAsgVP1Mj/2gL2i1CR/X7OE9cYD/x077WqOHcnaRltdroiDZJ5i2PBXDVUScXIM0NAcX6bsP88p4OftGl+zS7ioEKZDc/LF7pItUGBroUtOqk/AF4Q884pKTwM4qGC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMN1pffd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMN1pffd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E9BC4CEC5;
	Wed, 16 Oct 2024 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071267;
	bh=sMmLuEbCM1Sf55vle1yIBoPO8ZosmwAZ67dE8QAinAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMN1pffdhXLfWOyoZst7Ov1E5Z7t+mWy/lddGnJxQw5ua8rN/hgDEF9X42UhU24P3
	 iw4Ty6kZXOFVzUtZsHq5j+hs6hKFxs8atM6k+AsMBIIyFv52c3UNmuq6TbLesBBq0Q
	 RWh/HQwwSoSROQP8zlZrBpdoFBEP2P2ty/kdjrG+gfptAw8uegR9y3J3xWLx7txlXP
	 9rkczGt90GVrHDLEZ+fr6ec6V40v/UsyWCLkH/X8ZuMm2l0E4IXID/dhVfVZs+CSfd
	 oA/fiABGf+iyRn10q58lgCmjDPFG39YrIga3wy31cwJjZEH4bsAwL6JyRn8CX/p5T9
	 ajICVLCYCWLCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 10/10] Squash to "selftests/bpf: Add bpf scheduler test" - drop has_bytes_sent
Date: Wed, 16 Oct 2024 17:33:46 +0800
Message-ID: <8c3d8ebd5037a1367757f0749b7b0f4509e4ef49.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 39 +++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ae08be388b84..1850872a9504 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_iters.skel.h"
+#include "mptcp_bpf_bytes.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -603,56 +604,59 @@ static struct nstoken *sched_init(char *flags, char *sched)
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

