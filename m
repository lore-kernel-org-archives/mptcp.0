Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616501FB4
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714737; cv=none; b=h31ScQGCRNvdaR0eLnN/D2HP2rXH7W9yPkNAvjnyzxU25+Ky8ORgMqtsVBbbu3d7Wgz8gcFN9FQANeowKAWU7DyHC2hUe7qkq/CDpLvpcCY1SfB/Wu7TPx2KAbgjOO5ONM1UxhIkxP/Cdm13bV/3be6sA/DMthr0HrmQ/BTecLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714737; c=relaxed/simple;
	bh=8xvLLtxv5HI3brq/W5uAXfifezPKodIkWD6ZhyEO5b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PD/PiiXeEkYBmA8XRM/9kQin0udNphy+Ni3t3VO+r2zs060diIuDTxzKaZ0tjDLLE8hc0zn8dZpdzxB22zplG3gRTQx5GpkDKbfermHyTDO9RYJ5Ipew0pFM5v/8hXrRcMkadZCwzqWLBKQk5mHV6ZsSoJPz+PdyUv7hvput5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVZm2tOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVZm2tOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140A4C433C7;
	Wed, 10 Apr 2024 02:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714737;
	bh=8xvLLtxv5HI3brq/W5uAXfifezPKodIkWD6ZhyEO5b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVZm2tOMlChsBaCprjESxVBwTGHr+QOwcRzr+PdFc91fDLUPYzk2uv2e69/xcaaC7
	 uPb2ddaeti0YEIwWK5Gh38J2WZt+PIii+AdeBZpBvbCcwaHgEmTWNDEqGbjWj3Hns+
	 XoEJmdp8GdYbqbFlcrmAkIikz91OfQNYTVIWAWfy2Cagqtz55b2Fq/4aVJXuDy+nTQ
	 HKpOeaxe8iTmPwhzcJUvu6DIlNVPmweKQHCYRWxi+6RySaU7je3TBcD1f/kZGbnF0V
	 UxBcXtDoQ1GRLlEXDqMch0HiZnQg24ei8DnB9vsj6e6UUOIumN0SXn43rGlvtObN2m
	 H9XzqCYfUFtaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 2/9] Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
Date: Wed, 10 Apr 2024 10:05:17 +0800
Message-Id: <5c389066c7970455fb69b3ed24db06a3bccda031.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper to avoid duplicated code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c29c81239603..2e1ba03f0398 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -17,6 +17,8 @@
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define WITH_DATA	true
+#define WITHOUT_DATA	false
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -457,23 +459,44 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
+		goto close_server;
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, sched);
+
+	if (addr1)
+		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
+	else
+		CHECK(!has_bytes_sent(ADDR_1), sched, "shouldn't have bytes_sent on addr1\n");
+	if (addr2)
+		CHECK(has_bytes_sent(ADDR_2), sched, "should have bytes_sent on addr2\n");
+	else
+		CHECK(!has_bytes_sent(ADDR_2), sched, "shouldn't have bytes_sent on addr2\n");
 
 	close(client_fd);
+close_server:
 	close(server_fd);
+}
+
+static void test_default(void)
+{
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+
+	send_data_and_verify("default", WITH_DATA, WITH_DATA);
+
 fail:
 	cleanup_netns(nstoken);
 }
@@ -663,8 +686,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1

