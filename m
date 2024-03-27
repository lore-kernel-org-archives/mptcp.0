Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBB1EEFD
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530139; cv=none; b=NIVXI2B/7PDhemOaSzQ5TLHHtF4irLfH4TYFjtokaVbYKTl7W7wLgokKqEYOZ1jlW66mQRtGbm0q3yOrTPl+LH0Qe5jBAnxPgkeLOY+D8uFwBRaxOdzDM1NuXJ2bTUZsouvYZSlpTqhM9dt5UrqbPX/29Kp05SyYGLa7wPEutf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530139; c=relaxed/simple;
	bh=ZG1JrJhuYuGwcwbv4QD/003d6Y3qfkvLmLCAd45cihY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQOc1gDIf3e/iVfJXzrNiuWpzjIi1BH8KRtL5gKnmLVrazezA5599NIF38SU4zYw56SRPEImzqr0sRoKTcEGyovWw7l9Z2Jhb+YjDEB+cjsJMmPlUWuGB9qVnK0jHvMytJ7r4Q8YSUVQOuGW6i8DCoTke5eXZJ+YarhC+P5RYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDAomcGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDAomcGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C6C43399;
	Wed, 27 Mar 2024 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530139;
	bh=ZG1JrJhuYuGwcwbv4QD/003d6Y3qfkvLmLCAd45cihY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDAomcGUVijl4opwocRiZo3VTNAIyfr4oA2e/28xlCp5XILY33VcZnIbY1o1Zaj/N
	 O4pb4otQZXC3hrxpQThRXb4OBvS+bXo+/irF/kbiZkt4bcySuQUsBliDbj8uYfpG2h
	 ttvfn3zqDnB8dp/ILlBGJL/79aqXlR7akcYDTiP/eB5GHSx92Vxg5fft3ZcTyDmNVY
	 e60VNytINyH+ZQ1CPfQR9zPJpaHgOFDi+gm7mmNDzcbRzm5rrDeb98UtrYxuiZ43YQ
	 7Z5Hy8A1yOXQ1iRKrUoIs+q6ne3OA9okVn6KPMowduLF3r/+aUCqYKsPPlj7T1dOCz
	 UtLAKl5d+dC2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 11/11] Squash to "selftests/bpf: Add bpf_burst test"
Date: Wed, 27 Mar 2024 17:01:49 +0800
Message-Id: <9df3ed214b3fdee9e6353aacd3a21635996eeb96.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 04a46a41c964..890791270b84 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -607,41 +607,7 @@ SCHED_TEST(first, 0);
 SCHED_TEST(bkup, 0);
 SCHED_TEST(rr, 1);
 SCHED_TEST(red, 1);
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
+SCHED_TEST(burst, 1);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -659,6 +625,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
-- 
2.40.1

