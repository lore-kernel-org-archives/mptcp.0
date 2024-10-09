Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396F18C91B
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469814; cv=none; b=jQuxpKlHRrNE3BrG/mgGwhhFbUdTAS0b13+INv1HN6dT89XtK4u8HPDF/g/VoKZEdLGeP5ba0vi300I0netSeUyV/UirRigiHhAtFG7hiYdwDaCWzGp3ADS0qkUWIszLfL/rv6zgQhVyAxpBC3vVtO84r9RkCTIMFAJ4n9dCwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469814; c=relaxed/simple;
	bh=7p3qLG+8FOxEQeowmflCjeq9LTjG9oH40FX5AUEKVWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLE71CS2UZZO7Qc1sFas3W12Z6+4y9O72ePQC8QcZQNO/RpMKvksBYApA3mA7K/seM3t4FYEhBUifLvtB/ldVMAiYRjQq7agUeo80k/dmkDnb5XXuQoJpWImnGddAd8x8b9qel6qYMno4afrCApJms9KWZWk9DrRfKo5VCKEuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/T7q+TR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/T7q+TR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40797C4CEC5;
	Wed,  9 Oct 2024 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469814;
	bh=7p3qLG+8FOxEQeowmflCjeq9LTjG9oH40FX5AUEKVWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/T7q+TRR1di5XpagwXjnaB0/HsH5gtKSwSP972s/BYfp7lPxTwOwOufpEJwKSuOz
	 jLLhLPCINeuJ3/5PZT3Ffw/9aBxOnduK5m5YmVxca4BB7LCZiD9MI6/hxHyaTpBnOi
	 G9NJmI6Hs2mDQyUAEa4kDTyw1t4yfaap9PEpcZNU5M4X3iycT4R8qEjH1dCR7bR8nK
	 C73fBAW3S2zCa5/Zbbbbby9C02WxmeNPQyWHULkWtIijxpXpg/ueJg5za/utvxCfD5
	 FcSm9evkjdFM/K9mGNquLRaS/rxELhvW/B9EejxJq3T8LI3lslQ1wONpmBhaRIP4qt
	 ZuHDyICfbAcfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/10] Squash to "selftests/bpf: Add bpf scheduler test" - drop has_bytes_sent
Date: Wed,  9 Oct 2024 18:29:51 +0800
Message-ID: <9e5717d59ca4aec2664160ecb32461f6c2ce0642.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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
index 589420f42845..56624f840aff 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
 #include "mptcp_bpf_iters_subflow.skel.h"
+#include "mptcp_bpf_bytes.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -596,56 +597,59 @@ static struct nstoken *sched_init(char *flags, char *sched)
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

