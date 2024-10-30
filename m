Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4628EB
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261026; cv=none; b=Y2TqHqvHNq11nsZNeGzc1eofWC115wGO316ntKhaj6kMaqyyU72yivHoOY/OcDu0mTkxEz9+tYNLMt648tilk9C47xXcrSTHy6FA0CCC9nwdISwpfXRpQ02R61asALH8qMj2yey0zJ0H4RvURoM4xrfOZhznyDM8zkWgIk8vPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261026; c=relaxed/simple;
	bh=VJQ1aKlsLshIkH3sj6TGGlKsTeHZhvlQK9tA0H0kfnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq8eHxBbidI6E0wUqF8j2ytIP2XF3YiRHIZUr3USVabt5jnjgOI0e3XrQWubfCnuU2PdTajdU97qCUpUFXiLGnan9SAi5L9EkVk7kxmGGPqooDsS7IDyVH4tH0ImMNzmsen004iJS9yVf04Gn181dsTgQq4UUAoFmerq6YsjH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWlJ1b6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWlJ1b6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F5C4CEC7;
	Wed, 30 Oct 2024 04:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730261026;
	bh=VJQ1aKlsLshIkH3sj6TGGlKsTeHZhvlQK9tA0H0kfnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWlJ1b6Oe+p0uTprXYkNH2zAxJiROggBNkHYFToYZydXRlRgol0Duclte2r/T9/aN
	 +60bbGI0lnX+HRdd+oP0lOt+x64WxKGudtD1Y7hhzJopt2Py2Nx6Ty+yNSIOSKnoYh
	 1TPxGFttT4H3at8Jqq8xpinIV67NFfiKDQX+gD9d2pm8rkXSHOtoY6cF7Xxr4bCWZg
	 +XK7MTAZuozs4gXr1kJ7T4gGAeISabqr2fi4oksitoAUovPUOWdM/cFDdvX8ySJpIl
	 DkuCKYsqZyj/0GQYS0J+k8AW7q0Fj/rKUPT9ydWDJp6zR/uuiC8eMwXfKEZNanhv2/
	 pVqlXy0jiYT9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/4] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Wed, 30 Oct 2024 12:03:36 +0800
Message-ID: <d3c4d30642dd6e5ac4d96d40c1d29b2fc04e47f6.1730260715.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e32eceabfc40..238d2f1cd96e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -526,7 +526,7 @@ static void run_iters_subflow(void)
 static void test_iters_subflow(void)
 {
 	struct mptcp_bpf_iters *skel;
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/iters_subflow");
@@ -542,8 +542,8 @@ static void test_iters_subflow(void)
 	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
 		goto skel_destroy;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns: iters_subflow"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: iters_subflow"))
 		goto skel_destroy;
 
 	if (endpoint_init("subflow", 4) < 0)
@@ -555,7 +555,7 @@ static void test_iters_subflow(void)
 	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");
 
 close_netns:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 skel_destroy:
 	mptcp_bpf_iters__destroy(skel);
 close_cgroup:
-- 
2.45.2

