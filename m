Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D147C081
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619428; cv=none; b=clw/ISgbxG3Xmafhw+qf7XqgP4N4qano0BE6j45hTIEsFj9dHUWwlggTt0YseP5iSK1y1Ez/IkI3+E8e0+hb9it0eihqajUpEZGzwHZHn+4gD9/BxDRrwuG2d95XsJ/hVQBjDwHzjh6i5KK2GaiTMcNqSHib8/deWZt4SzVVikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619428; c=relaxed/simple;
	bh=2xjzF+NqHe+6SFNSqaJ+vjg9oeUGx0dsoUBiUn701CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnHzXmwvqTnqETU8dmCSHhWltaSZKoczDup+1jxM9Krop0x7yf//Fg4pkUnr1kCOU4Ai2RtofXXqb2ikkpy+sGf8uKHgPdmOwLRGUcJ1wxPSc19NO823XysDrJbqugqqLwtuSJhXfiqvh6ofq40ZwGhMZufqOSAcESBW1KBAaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGeI+8as; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGeI+8as"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A598CC433C7;
	Thu, 28 Mar 2024 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619428;
	bh=2xjzF+NqHe+6SFNSqaJ+vjg9oeUGx0dsoUBiUn701CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGeI+8asuPsbz8U6ZbxYt83Ts2DUadRzkAKQtTCPyZDxiBqFe9+A7iUL0e/4vcpJ7
	 vz5S2l5MHvJqZ0pCfBe5mjW5RF7UClpsNregqy4S6EKsr+zX+xONexlIWro8w5Udkw
	 FMYhRFfhdoslw7PV/B4uMhmytIq8guEdU3w4pTtiF1ejRaiBOA6c96Ha9M40bSb0bJ
	 inKs058GktrQ1JhnIjXluMB+iQIbyj5KiR6gi3uVBqHmmoW3D/sFJjBOD0Kgfp1bXw
	 w/3+2bJqMo5ZPUAdaGMbXnOAZaUDA2jd5GHZsbYn4uKX/mB1JEwIXFp5Yo9J9xqc2+
	 I9c6Cu3UrP2Xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 11/11] Squash to "selftests/bpf: Add bpf_burst test"
Date: Thu, 28 Mar 2024 17:50:08 +0800
Message-Id: <c75f678ed7f128ac9a81a954e3c5f1c2da43faaf.1711619108.git.tanggeliang@kylinos.cn>
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
index 572b6e5caa32..ffdcfd094350 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -505,41 +505,7 @@ MPTCP_SCHED_TEST(first, 1, 0);
 MPTCP_SCHED_TEST(bkup, 1, 0);
 MPTCP_SCHED_TEST(rr, 1, 1);
 MPTCP_SCHED_TEST(red, 1, 1);
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
+MPTCP_SCHED_TEST(burst, 1, 1);
 
 #define RUN_MPTCP_TEST(suffix)					\
 do {								\
@@ -556,6 +522,5 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
 	RUN_MPTCP_TEST(red);
-	if (test__start_subtest("burst"))
-		test_burst();
+	RUN_MPTCP_TEST(burst);
 }
-- 
2.40.1

