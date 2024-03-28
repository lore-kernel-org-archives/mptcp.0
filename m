Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676453E37
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613133; cv=none; b=mNfrwYomdJUpWQ1vHXd5M7ZnI67TtggcDk5nyh9iQ6+2zZS+anVZjonn1z52znXrwL7aZCkvTEPUF9rjH8+MXDavt//gE6+a6TOKz9bhIX7bcIaI34rVSR9X+V+mUMd6zLQp0NQ/e7FB2+UIt4APknVq+2AYiVFtgmHlS6uDS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613133; c=relaxed/simple;
	bh=1IxsHAu9vi+do4+Oz7mLos6ifcsCHn7fikAKHeBeBLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODt/oGXr2koKZdVspCsBldFFM8xICf81OlQNHE5PceLonJ+Qvt5IqUV8E4OfV49Nk1b7KD7xg1Q30k9vnoyX/qV/5jrCwizSSDhRJJgHby1KojW3alD4Ojq9Ojd0F2kC0duEO22lR0dcgx5eCzUeajUdrUke8csjjQl3fYFG0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ72NRT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ72NRT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F8DC43390;
	Thu, 28 Mar 2024 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613132;
	bh=1IxsHAu9vi+do4+Oz7mLos6ifcsCHn7fikAKHeBeBLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ72NRT2wgRESIAPHlhKMjW7yK1IlgFsUGyRhqKVN8yEQ52fel73vkM0HKkaCjq0k
	 qfIVNusa/rXMz53fURQmgtSLSWS06sUMyefy0QaUTDGW0cJ5Vg8S+V2/2TnrPWYlSO
	 BvCTj4puVU8hvmaVJ2RovYO9cUfeK4yTUOQzQd0Xyi2t+P/Xo4IG22XNPaYK5ujO9o
	 YlhJA6ho0Qo1kWw3M7gVFhzazWkmzXwEARSywE+Tt7c/HLORvIkgqFhzpwUjuAydXY
	 i9xx1eMy0J8rze6G9OeEiU5wVY8eWOIAMcZWxsyq5rCmdA/AaLAaHmiI1KKE5KTiL8
	 pexXNExYP/LVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 12/14] Squash to "selftests/bpf: Add bpf_red test"
Date: Thu, 28 Mar 2024 16:04:59 +0800
Message-Id: <343fc2231c384cb5e0315c894cdc589157a94b16.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use MPTCP_SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index fbbd7993b0e9..fd160fa04fb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -570,41 +570,7 @@ fail:								\
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
-
-static void test_red(void)
-{
-	struct mptcp_bpf_red *red_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	red_skel = mptcp_bpf_red__open_and_load();
-	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(red_skel->maps.red);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_red__destroy(red_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_red");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_red");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_red__destroy(red_skel);
-}
+MPTCP_SCHED_TEST(red, 1, 1);
 
 static void test_burst(void)
 {
@@ -656,8 +622,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
-	if (test__start_subtest("red"))
-		test_red();
+	RUN_MPTCP_TEST(red);
 	if (test__start_subtest("burst"))
 		test_burst();
 }
-- 
2.40.1

