Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5B1EA85
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544342; cv=none; b=Z3dkVvfQKq37mHWY/3uly1afys8Bj2uxd4zaD8XLd0OoR4C/8u8JclEE1kgBHYW5cbfl+7dH2Jd5B6iEmAUZN4MEpLFJlBmnTKU7LIEsvAC+BozJOFZbI8ZKbvPSe4GJuCglHkdal2L/U3wnTH4nHmLpAIM09ypLyeLwltiFkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544342; c=relaxed/simple;
	bh=wxGbqQjO23smCYcbkjfD/xvqSzshUyphD5ZAZvzAy9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0HWAKW2NCWO0htza0KWgDEGlEpDfE9HLnKJrcAeigfuPAoC7zoetxZ3cgYpm9+eS4L14g1f6q3we1qa1QrZBQbaPMM5hpQREVYVcosXXs0V76A9AmVfOCSwtDKUNvBpWLpezckhZT8cfqY3vyBXW283Xt5oAwJeMJDHMTF/LPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uobdIixc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uobdIixc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6165C4CEC5;
	Thu,  5 Sep 2024 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544342;
	bh=wxGbqQjO23smCYcbkjfD/xvqSzshUyphD5ZAZvzAy9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uobdIixcGBuDvarmg28bMAsDdXll1nikhJMA+Pi556Tszk4muxQoe5I3wiHO7pKys
	 tT5r8/apsorf50V025g/207decMDprHJ4GtpxIhj+XRzTZkTqyptgE5/COn8j3KRPV
	 x4d+mu+/kMbWh1vsaBp3LppTx/8EH3LNtqKniLWpmRl52wCFXgQhpIJXf2soZTdP/c
	 L/2GiM1dDYyU4c1oFwuZKzBmyewKBkFsR4EzjKT3nex2jDoZNFBB4xOvg1npqFdphc
	 zqIuvD1V4XL61yLEE3PpUu2gUFYOQPbBIOXYq1wMbmpXeIiheOeUkigjC4GcqhzRiB
	 0l6Ms8MRN+ZqA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] selftests/bpf: Add mptcp_subflow bpf_iter subtest
Date: Thu,  5 Sep 2024 21:52:12 +0800
Message-ID: <bfddbae71db8fb2666b75798ff2c34c57e5f4175.1725544210.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725544210.git.tanggeliang@kylinos.cn>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_bpf_iter to load and verify the newly
added mptcp_subflow type bpf_iter example in test_mptcp. Use endpoint_init()
to add a new subflow endpoint. Use send_byte() to trigger the tracing
program for mptcp_subflow_get_send.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 93869c873cad..2642d97af461 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,6 +10,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
 #include "mptcp_subflow.skel.h"
+#include "mptcp_bpf_iter.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -470,6 +471,58 @@ static void test_subflow(void)
 	close(cgroup_fd);
 }
 
+static void run_bpf_iter(void)
+{
+	int server_fd, client_fd;
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto close_server;
+
+	send_byte(client_fd);
+	wait_for_new_subflows(client_fd);
+	send_byte(client_fd);
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+}
+
+static void test_bpf_iter(void)
+{
+	struct mptcp_bpf_iter *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	skel = mptcp_bpf_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_iter"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = mptcp_bpf_iter__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: mptcp_iter"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_iter"))
+		goto skel_destroy;
+
+	if (endpoint_init("subflow") < 0)
+		goto close_netns;
+
+	run_bpf_iter();
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_bpf_iter__destroy(skel);
+}
+
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
@@ -651,6 +704,8 @@ void test_mptcp(void)
 		test_mptcpify();
 	if (test__start_subtest("subflow"))
 		test_subflow();
+	if (test__start_subtest("bpf_iter"))
+		test_bpf_iter();
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.43.0

