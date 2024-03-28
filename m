Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C037BAE5
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619426; cv=none; b=LV0UUiyciKrwjaEFhPd0Asdb+JpunIOvJ9BxW12iNE9335uMnnoJR7Tfi32PreKL65SazMRJIGNr9h7ZW6iwVzPQy3y4Or1tyTuHkdZXNiiRJBgpvJmk51O5FD1uja7akp6IEWCb+/U3NAMG2Ri7BR4KfNA2x7fH7s08cZThtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619426; c=relaxed/simple;
	bh=BHBYwXS9lNWoRdAsMvuSbxlhme8r34GUIWouANpUUjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JnLolzfIdZJU7/8H9IGAg7UGfTPyfDCckIz57+2a1LABq11APQQMK2znptSHEXvf/bzy+/z6Sm19e1dGj4RCgRU3JhBdRilEk4vY6W5im8fP52Fb6Px3OoyQeUuZMalciImr/BRzxvYEcfCBomCwoGW5bVrTNxpyl0ftEM+qUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqlUZ/Yt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqlUZ/Yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D096C43394;
	Thu, 28 Mar 2024 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619425;
	bh=BHBYwXS9lNWoRdAsMvuSbxlhme8r34GUIWouANpUUjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqlUZ/YtkGCEn51Ilj2zbrYB9AaHrWF0jc3jOtqUPtzyKK2LkoX9PStMk84DbNneo
	 6FyDVjIDejPuigzJxi39DfJrdS93vhHha5Uv46CfhHv0yDd6bXOictVa6b2Bv5enl/
	 kU9cSogVYMTJwkViibUT+n5sYNL4csJ0RoztcFYYZjzJHIASAJGztax+EMrp0EsXYq
	 pnQIHlbndwfkhCnGhaxbPULvIdcdDPNDDSTQXAR7xIKjYG5ZYBB9I1RG+zOrVoidYE
	 BQhJx6UAaRA98wPUp+5WFSxMiUZHBPF1seTTx6ZAQ0TfLFa9XcDlydC/3gHZJf0pRm
	 c/oEOZwP+GNqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 09/11] Squash to "selftests/bpf: Add bpf_rr test"
Date: Thu, 28 Mar 2024 17:50:06 +0800
Message-Id: <1a3f26c3df4dcd3abb74ee056bcfa6ba91a04c81.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
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
index 3c547f38badf..8f41007fc3b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -503,41 +503,7 @@ fail:								\
 
 MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
-
-static void test_rr(void)
-{
-	struct mptcp_bpf_rr *rr_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	rr_skel = mptcp_bpf_rr__open_and_load();
-	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(rr_skel->maps.rr);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_rr__destroy(rr_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_rr");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_rr"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_rr");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_rr__destroy(rr_skel);
-}
+MPTCP_SCHED_TEST(rr, 1, 1);
 
 static void test_red(void)
 {
@@ -622,8 +588,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(default);
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
-	if (test__start_subtest("rr"))
-		test_rr();
+	RUN_MPTCP_TEST(rr);
 	if (test__start_subtest("red"))
 		test_red();
 	if (test__start_subtest("burst"))
-- 
2.40.1

