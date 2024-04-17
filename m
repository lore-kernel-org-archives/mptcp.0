Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFC1851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321562; cv=none; b=vEShBQ2qQ0maj/yQlhv3RTQf2RlnCEHG70Ru9YTmNogQhBvX3U2jtspT7izQFSdOD53Mlp45gKokGox4cD1f4jJWTTz12lRZLc6VajzwWYiYQKPFzcu9wic4q59bhgMmFFFnONMMDhT8ZMYakcMcX2ag5xki5QYsr19xAxscO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321562; c=relaxed/simple;
	bh=bmwBZ1jN4KSV6hPcFF/5aIus/ySqsdVhAzKbMQChWIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDwcsEdHwOlxqE1d7S7G6v6K/Wc+q3n5cfEaCcn9R/RC1mXI4o7BMOueG6M+zTZB5Jw+H677ffJPQ5BEbaXK3rLJLbSVvcnuZJ19Xyytf2oWyipaRckj85P9+rcXTxLkMEIudMwGt4ss/BLzck8MW448Llqj7GFPB62sagyPxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWAMWky+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWAMWky+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE82C3277B;
	Wed, 17 Apr 2024 02:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321562;
	bh=bmwBZ1jN4KSV6hPcFF/5aIus/ySqsdVhAzKbMQChWIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWAMWky+M9CGQgUauA4vn3fpGkOJ+I51KW9kdA8MaN7GSIee6vyveBy/nUUDy5jCb
	 e3xuM1gY06QiTfO0LNzherJaSZ4SjcTcNmc9KdEBYfCnmp5GFTDzhBoUgJms93Z5jq
	 xNu8iZa4jk2QGx/CBrPSj/dfAlO1b1w7zTw7jbg8qXFjcwFsqVeoZeMt8MXUg0j4xu
	 pFGI7zJpb2fjtckzi8qMMP1LDwYafKes4pwszyFXI/OfwTxl+Tira8Q1YzNbwwAhr/
	 bkKK88xdDJ3eMCJrefwlqOC0lan4aa0AuGy5WjG+lzNkR2TlFuv6tiHkQ9ywax4+yp
	 GQ/M2YoxwpufQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 8/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 17 Apr 2024 10:38:54 +0800
Message-Id: <d4d55ef7caff26195d4a007c8b56edf8c5a3bc2c.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_burst
test" can be merged into the patch "selftests/bpf: Add bpf_burst scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_burst
scheduler, the arguments "1 1" means data has been sent on both net
devices. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_burst scheduler & test".

Drop send_data, using send_recv_data instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 1609a0e1e799..9f17453b2d59 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -542,41 +542,7 @@ MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(bkup, WITH_DATA, WITHOUT_DATA);
 MPTCP_SCHED_TEST(rr, WITH_DATA, WITH_DATA);
 MPTCP_SCHED_TEST(red, WITH_DATA, WITH_DATA);
-
-static void test_burst(void)
-{
-	struct mptcp_bpf_burst *burst_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	burst_skel = mptcp_bpf_burst__open_and_load();
-	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_burst__destroy(burst_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_burst");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_burst");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_burst__destroy(burst_skel);
-}
+MPTCP_SCHED_TEST(burst, WITH_DATA, WITH_DATA);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -593,6 +559,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
-- 
2.40.1

