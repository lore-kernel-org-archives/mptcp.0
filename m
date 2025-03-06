Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446002907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227354; cv=none; b=aAAKY12+eHwwYZoT5YrfBqElicfHNMGcWwzpcO+IZO46nMXHtDbr8Xx1XuKT7a1WRfW1zuTWH/DAp8s2jjAL0yLPtSEXy9oQRPtnhnxWbvJAovqMUzZneao1gVeRO4Oyrj5S3ZYAeGQfRJ1NpIPWfWFrnbhvNTJv/Svo4s/JAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227354; c=relaxed/simple;
	bh=STl/bMC/yqtnUXVsb2kGsqXDjXtQnj9zAT98NBMwt+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEGL221PwDIndEWDuaaEnhjZJk2txVlzdrJWlUzjXLABzYf/463+Ix3SD8JJthgwkJgRmxR8/X/HoM2mh43mXAZN7tWve2lvxfSp3RhBCvqGJKbJlNsKjHs/+dw302zJObySNa2LdqpveOqozCL7fuB77ajU9xu/inOGbSzKbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvrGk1nv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvrGk1nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC86C4CED1;
	Thu,  6 Mar 2025 02:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227352;
	bh=STl/bMC/yqtnUXVsb2kGsqXDjXtQnj9zAT98NBMwt+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvrGk1nvkY0JPsYq8Q42h8of7Tk5JVhKUgtSR/TASD4qodolp6C+cXaU9D0JR9XXm
	 27EXFvGnqoEDUU7kQEgKCabkYtGSFYsFeJB/ycFm0aFrB39akOjSTGEPM0xZr47Dbx
	 /0//sKuv/+Kj3dxMaSv/ghH+7GhDv+AIB4Bs2zj5xwZveV3iHT28gLcEcCI9hdk3Ua
	 OKTvHjWBaVo4zGdsuuXIdilIg5NBgh/tlKJMvsJ0DfGCjM03ZPW7fuAZejQZjz733Z
	 Oy8AfuTppZkeFJWYE7nPfTXhy5gm3KTOgFFmNH7BFlJx5bnn4fpzDtDqvQ5sCuWkWI
	 Ij6aogSTO47MQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Thu,  6 Mar 2025 10:15:36 +0800
Message-ID: <e890bf31a49b2e49e936c255b2f20bd37ee19c90.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

1. Update sched_init.

2. For drop bpf_object__find_map_by_name in test_bpf_sched(), change the
first parameter of it as bpf_map.

3. Use .struct_ops.link instead of .struct_ops.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c    | 15 +++++++++------
 .../testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index bd824b19ee13..15f7a2b97623 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -645,27 +645,30 @@ static void test_default(void)
 	netns_free(netns);
 }
 
-static void test_bpf_sched(struct bpf_object *obj, char *sched,
+static void test_bpf_sched(struct bpf_map *map, char *sched,
 			   bool addr1, bool addr2)
 {
 	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
 	struct netns_obj *netns;
 	struct bpf_link *link;
-	struct bpf_map *map;
+	int err;
 
 	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
 		       MPTCP_SCHED_NAME_MAX, "Scheduler name too long"))
 		return;
 
-	map = bpf_object__find_map_by_name(obj, sched);
 	link = bpf_map__attach_struct_ops(map);
-	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
 		return;
 
-	netns = sched_init("subflow", strcat(bpf_sched, sched));
+	netns = netns_new(NS_TEST, true);
 	if (!netns)
 		goto fail;
 
+	err = sched_init("subflow", strcat(bpf_sched, sched));
+	if (!ASSERT_OK(err, "sched_init"))
+		goto fail;
+
 	send_data_and_verify(sched, addr1, addr2);
 
 fail:
@@ -681,7 +684,7 @@ static void test_first(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: first"))
 		return;
 
-	test_bpf_sched(skel->obj, "first", WITH_DATA, WITHOUT_DATA);
+	test_bpf_sched(skel->maps.first, "first", WITH_DATA, WITHOUT_DATA);
 	mptcp_bpf_first__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d71c50c7f441..96b002808ce7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -29,7 +29,7 @@ int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk)
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-- 
2.43.0

