Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5B364B4
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530132; cv=none; b=tz8+Pvg3aDBGTsxoIhOkP83K8DnLhFfr4ThFNa8718ADGRkGCRQFmQOlFKKEwMDmOzmCF4527SvH9GOanZ2WNVHNKKbyKEAC/Syu42kfJ3MGTiSrzDbOlaZB9T+D2UacDvvBS4TVDHYlChtj+GeODpPkNKXDauTva7noew9+ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530132; c=relaxed/simple;
	bh=Hv2E/3cxt/XM8xulJetUYfOErbQPb40P4WzTP4Ibc10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vF6t4uSFMRq3p954dIlxFs33aOyhwM0jX8FhbtoRVF2Jfq8m7N1XzGB4gJLAeeQ293iL3r8QTbzlnw2vAmH3iYu7ZE3a7URT7JQcl4t20iE+43GqYxHGifTWGrQy2ITVpeKppTYlI+7Jx8bCH2XV2yKtAGh3bF6EMcdP+nCM+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYejpAKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYejpAKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EDFC433C7;
	Wed, 27 Mar 2024 09:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530131;
	bh=Hv2E/3cxt/XM8xulJetUYfOErbQPb40P4WzTP4Ibc10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYejpAKMsF1czkng6/U+079vqOHCmMAWYotwaNM3ZyxHdynV5hCA5+82rIvY5YEcV
	 mnUoXnd0L2S2hWRzv+dZwJamciSzpTGf/T3EBINpxDT539WWrSa1r5/1U7X9+L6Pu+
	 NLwn7m58cBJYsfbI6jAaaFW3o2TIvt5ch0s1PmNI1Q5g9I2EZ7o+rmJZj56GXg3VEV
	 n5VHMvdUhcPZX2i9U6uer+4AyZaoK4wA/mlyB/UMxng6+UklWMkgAWyyiAOz0NYGl6
	 0RKl4L1EXF8x4HZkdv7aR1EkWBquGnB0mX1NK+DMvOP/cPtqMX9wO/IkEEvViEsF85
	 aSK7gMN539xrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/11] Squash to "selftests/bpf: Add bpf_first test"
Date: Wed, 27 Mar 2024 17:01:45 +0800
Message-Id: <9dea707f379c76dcf547372030f878894c57141e.1711529752.git.tanggeliang@kylinos.cn>
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

Use SCHED_TEST macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++----------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f86ae0be0167..8d3e2ab9b16a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -573,41 +573,38 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
-static void test_first(void)
-{
-	struct mptcp_bpf_first *first_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	first_skel = mptcp_bpf_first__open_and_load();
-	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(first_skel->maps.first);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_first__destroy(first_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_first");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_first");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_first__destroy(first_skel);
+#define SCHED_TEST(name, addr2)					\
+static void test_##name(void)					\
+{								\
+	struct mptcp_bpf_##name *skel;				\
+	struct nstoken *nstoken;				\
+	struct bpf_link *link;					\
+	struct bpf_map *map;					\
+								\
+	skel = mptcp_bpf_##name##__open_and_load();		\
+	if (!ASSERT_OK_PTR(skel, "open_and_load:" #name))	\
+		return;						\
+								\
+	map = bpf_object__find_map_by_name(skel->obj, #name);	\
+	link = bpf_map__attach_struct_ops(map);			\
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops:" #name))	\
+		goto fail;					\
+								\
+	nstoken = sched_init("subflow", "bpf_" #name);		\
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:" #name))	\
+		goto out;					\
+								\
+	send_data_and_verify(#name, atoi(#addr2));		\
+								\
+	cleanup_netns(nstoken);					\
+out:								\
+	bpf_link__destroy(link);				\
+fail:								\
+	mptcp_bpf_##name##__destroy(skel);			\
 }
 
+SCHED_TEST(first, 0);
+
 static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
@@ -760,8 +757,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(subflow);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
-- 
2.40.1

