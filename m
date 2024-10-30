Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEB28EB
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261025; cv=none; b=Ivu15AOk7ggP5D1F2775G7lbXbc8qBIjgcFS3kvTUmRkfu1uEiDdu/S0H/92tY05xtPU4Qarx/5W9RoKoiEfalWrWhZawavF2/EMnejniq/REZyldVdyi+waQ4JENZ64nn7ltgYxjQObVcnQob/kOt7MmpMsa9dNEXyXK7P3pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261025; c=relaxed/simple;
	bh=qCYDQ+A3rY5RCgBwXvI0z88JnUEX8dUHouhwvs6OIa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjgkN+PlRJfFvup21bTsZGqINA95RXfTX6ycnR6Y7AZIXG/aylJfL8CeJDk3WDmpwIP+Pcd8Gqi4oDHORA5d8372SAMPTM9QfF3Eo+YAHKWS0zP5n/ytQXRdfNXO3uFQHpMByef2BBa1482Gv2NLbPMgC9n3b9P03a1jde5G0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQvH4lNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQvH4lNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213F8C4CEE6;
	Wed, 30 Oct 2024 04:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730261024;
	bh=qCYDQ+A3rY5RCgBwXvI0z88JnUEX8dUHouhwvs6OIa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQvH4lNkJZQt1e37wFrQ26Z771ncA4dWysc0Ulrv9LbSjw7iENl7sqxLP7//3TSis
	 zeY3jGcdGNEkHudEkdfq+NeXVp1bqUqEDBJ5bJDjpPS4aaqDExxVSfolJC0UMJMaB2
	 npKjdQzQtcHZpdcAcJ4LDPLPmXFHLi+3/tnMuS8T1ASZOUiNSqvqdKS5Pkmg/Dlrl4
	 Xl6HY/iBSJCL8EllwvUfbD/QfXRLzkKX4yxpcQgN8qTjX6bnyrj9hfevFtBo7ymBWx
	 vOYGwZOCzcDfsmKlgEPRqPhXWj36bZC5vHt2kTVanujBVLxH3prIe5NMJgw7ZGT4I1
	 7ls1sS39680OA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/4] selftests/bpf: Drop netns helpers in mptcp
Date: Wed, 30 Oct 2024 12:03:35 +0800
Message-ID: <4666f23dec74e96e610469190687d8b20c3de904.1730260715.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730260715.git.tanggeliang@kylinos.cn>
References: <cover.1730260715.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New netns selftest helpers netns_new() and netns_free() has been added
in network_helpers.c, let's use them in mptcp selftests too instead of
using MPTCP's own helpers create_netns() and cleanup_netns().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 ++++++-------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index be746e0fc393..e32eceabfc40 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -90,24 +90,6 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
-static struct nstoken *create_netns(void)
-{
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
-}
-
-static void cleanup_netns(struct nstoken *nstoken)
-{
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del %s", NS_TEST);
-}
-
 static int start_mptcp_server(int family, const char *addr_str, __u16 port,
 			      int timeout_ms)
 {
@@ -227,15 +209,15 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static void test_base(void)
 {
-	struct nstoken *nstoken = NULL;
+	struct netns_obj *netns = NULL;
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
 	/* without MPTCP */
@@ -258,7 +240,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	close(cgroup_fd);
 }
 
@@ -343,21 +325,21 @@ static int run_mptcpify(int cgroup_fd)
 
 static void test_mptcpify(void)
 {
-	struct nstoken *nstoken = NULL;
+	struct netns_obj *netns = NULL;
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcpify");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
 	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	close(cgroup_fd);
 }
 
@@ -473,7 +455,7 @@ static void run_subflow(void)
 static void test_subflow(void)
 {
 	struct mptcp_subflow *skel;
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
@@ -496,8 +478,8 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(skel->links._getsockopt_subflow, "attach _getsockopt_subflow"))
 		goto skel_destroy;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_subflow"))
 		goto skel_destroy;
 
 	if (endpoint_init("subflow", 2) < 0)
@@ -506,7 +488,7 @@ static void test_subflow(void)
 	run_subflow();
 
 close_netns:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 skel_destroy:
 	mptcp_subflow__destroy(skel);
 close_cgroup:
-- 
2.45.2

