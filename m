Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71F18050
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034774; cv=none; b=HLcdW41Xj5GX6O8lYRCkNF2SRGQaCpaHIKETnNgkKlUb0/SUg8gPGfJbmv6icRBLalLU1aYcLkraSjEurkxxGll+C6fEvIkp4YI+b7QcP54hMs8dnRB6TqYxxM0i0jUDRndLfg37rxYUN/UXQEQ/OumStVchAMQ1d8s3B9Hv8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034774; c=relaxed/simple;
	bh=PfHiYV+fHf2Tyl/HDc4X77KNlmuKgSGRvTvsdM9afxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYZ+mrhDXPmtN+Uv10CbVF5cTNmviHd3tc71f9zHlPlitxBI7q1m64OvwMpSJKQ5Alm7USssuDVSamdZyPcUOf8psHGP1skqHp22EtAGDcTaJlGWgwgz609KHusO3+eRBFFpJfsOroUNh5b8Xn/wlKOIB9eS4df6EbARbGx9C6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atU6/9wm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atU6/9wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587BEC433C7;
	Tue,  2 Apr 2024 05:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034774;
	bh=PfHiYV+fHf2Tyl/HDc4X77KNlmuKgSGRvTvsdM9afxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atU6/9wmqa11DZ1IIPKUj3iMjVSlXh+rRkPDXPF5K5aqu6PVn8NOueIJaaKieBYcZ
	 NaFbECYbwSVV3Jb83HXW2khOxFT5kpnSKl75LnjGakc2u0cu3te8+EW6pvAmQK7wqU
	 ALJ4owXaxxxZccxEDm7z4TNqofcL9zB/OvEtmYzVmrbvAPUOo0Oua9MUxG7huX3wd7
	 szazUTy4YMa0ECATKMkfAkuSqh0PdwFL75Jq+Q+2beI2kZPYuCns/m9YkPop7MsQ+K
	 j5UzO5SJcmGziJ/q3f4+9ExuYihKgPqkhX7hWDGmw4MHfUdmbK5jddQXA3sjAYchoE
	 kVb5DDyXamufQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/11] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Tue,  2 Apr 2024 13:12:30 +0800
Message-Id: <9827defb36a163b040790aa2f812217dce397456.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After squashing into this change, the patch "selftests/bpf: Add bpf_first
test" can be merged into the patch "selftests/bpf: Add bpf_first scheduler"
appending the following lines into commit log:

'''
Using MPTCP_SCHED_TEST macro to add a new test for this bpf_first
scheduler, the arguments "1 0" means data has been only sent on the
first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
'''

And update the subject to "selftests/bpf: Add bpf_first scheduler & test".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +------------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  1 +
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index dd625ff0e234..bc46bd5ceb18 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -538,40 +538,7 @@ skel_destroy:							\
 	mptcp_bpf_##name##__destroy(skel);			\
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
-}
+MPTCP_SCHED_TEST(first, 1, 0);
 
 static void test_bkup(void)
 {
@@ -725,8 +692,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
 	RUN_MPTCP_TEST(default);
-	if (test__start_subtest("first"))
-		test_first();
+	RUN_MPTCP_TEST(first);
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 23a3e8e69e8f..2d067b25d60b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, SUSE. */
+/* Copyright (c) 2024, Kylin Software */
 
 #include <linux/bpf.h>
 #include "bpf_tcp_helpers.h"
-- 
2.40.1

