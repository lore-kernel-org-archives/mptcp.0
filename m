Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77628EB
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261028; cv=none; b=H2gQvpS0LQCU3XM5INyfm3eYcQmwOwId+8Ol3cpWGv+zvDQAJTFrhM+EEpG0H+O+rm7HOPn+X6tsDUCAXlPzSmiH0v7jBXsKzTjV0BWU+TbInxUfO4Axa2g7AejPXRZif0ZqFHsZcRi87LTLSCQHlDZKfDYkr8+c7rKQJyFir8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261028; c=relaxed/simple;
	bh=7JoCTUryXzBGwqSW8UWuGMlgJClakIHPhEpnzr4+Q3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGAJFngkYNdIZEJMwPIzoDIxri07RI7dt8AXSvzonWpWVBZ3EEoYSdnOukjK3mr/8MOZatJf1rji3gu0AOgrG+tn1rHxs6+PAPdmYLPFW8Al+6gSs/rIbvln4oBCHH4V1JCanQ1RXPRFvYbTKUMQ0DHwKBsDHhFTjOqfkgmCkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdH25qWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdH25qWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F03C4CEC7;
	Wed, 30 Oct 2024 04:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730261027;
	bh=7JoCTUryXzBGwqSW8UWuGMlgJClakIHPhEpnzr4+Q3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdH25qWSeR8prpUFEBkY2mflHfd8BN5qYMXJAKQCriZglqc3mVLhnq1lhujYtj5tP
	 dDLAqFmntA2uZmqGtZ1/o7dhx3LtyhxG7kzB4YS/c2yEFlgYFIGpd/hehZ//oQ4nJO
	 Gu/q8FDRiwwWrC0GikTwoFnKvlLj53e7h4PQ87cBJJzXT7g+MdHv1r9CO7NKGWX6M8
	 2BWJBBhSZojMwjhTgGPEIEe1uZvpwpb91fg7oR2yAkOENeUL13ZF+2jOwVMR7Q7Bgx
	 WFfN+iRHDZdFZ1P0uLKa5lNpP4URVcMYXyNFtpeAaMvk15L+ZFOz3cDC4+oSlZLMGz
	 TqQ/mpU++0thA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 30 Oct 2024 12:03:37 +0800
Message-ID: <bc94d4bf1e0295bb15dd91c07d2ba0520e4ca542.1730260715.git.tanggeliang@kylinos.cn>
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

Use new netns helpers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 238d2f1cd96e..8db1def2e219 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -562,12 +562,12 @@ static void test_iters_subflow(void)
 	close(cgroup_fd);
 }
 
-static struct nstoken *sched_init(char *flags, char *sched)
+static struct netns_obj *sched_init(char *flags, char *sched)
 {
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		return NULL;
 
 	if (endpoint_init("subflow", 2) < 0)
@@ -575,9 +575,9 @@ static struct nstoken *sched_init(char *flags, char *sched)
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
 
-	return nstoken;
+	return netns;
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	return NULL;
 }
 
@@ -635,16 +635,16 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 
 static void test_default(void)
 {
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 
-	nstoken = sched_init("subflow", "default");
-	if (!nstoken)
+	netns = sched_init("subflow", "default");
+	if (!netns)
 		goto fail;
 
 	send_data_and_verify("default", WITH_DATA, WITH_DATA);
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 }
 
 static void test_bpf_sched(struct bpf_object *obj, char *sched,
-- 
2.45.2

