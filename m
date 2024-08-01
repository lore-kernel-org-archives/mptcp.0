Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80B1BA885
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517245; cv=none; b=G5PvIhL0GJzVFmyLrpOZgV/uk7MyXro5PIoy96Gzq16eEOUvxSRP9XbfMDHygO5YJ1d4GuKLBq0+4dDUcdpeAXLQkzRzFa3eX7Kx+hiTwejTFP4kJe2QDX4bSAsjtMcPlKcD6JLqwHHKB6jUY2mzlp+zxCV7BhYiG4iHH0co2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517245; c=relaxed/simple;
	bh=wyIZM7mdMCNyUyRsbeUmE+/rtm7RZyhiiKodjcX2+qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enIWqxPKYaqPaC76mUg8nzzynuIgXWv9ZDcm7tGPesnRyOy4y/MINRBq6vqSwB4oyd6IK7tJgGbq10SX4DmlxPbq5pggSveo8EzgliWK/uue/O4RQv08JCSqyAfY20hzTxL5keoDbArTHP5Zl1t1oIHLQa6C1T4MONsRCGHBwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUN+relt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUN+relt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256BCC4AF09;
	Thu,  1 Aug 2024 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517245;
	bh=wyIZM7mdMCNyUyRsbeUmE+/rtm7RZyhiiKodjcX2+qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUN+reltUCcvnMCpW0HpSdo4OsssDkgWIs+RUq/tTZGQ18wlnYVxv28lnbuQWMv3G
	 T+aVHDtD+/VmyEo7ZkynXaZCdLyJALZojf7Vv9bxAy4+Y+PzqYZQXHleAodVRFosie
	 Dkn3+mLN890pSn96nFeIxgWA+I7yxhu/Gl8LwWzNR0KHOFNmOghMk3z5WvhKqxVPJq
	 hMdM6S1y8huxt7RZ5uC5EN0GgXqN2qwFws6x0oc5rJsNV/D1lEz+w+Il5AyI4WT0Yy
	 rB8sdA9YXJH2PuNPNFu4CwG1gZreQ09+5opI0G0qo97lw0ANNTmu6B8uEVbGHp9P/j
	 5LRCZHS1mbN/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Thu,  1 Aug 2024 21:00:36 +0800
Message-ID: <fd9b16b94106d0ee53a2143a380774563c3a4da5.1722517019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722517019.git.tanggeliang@kylinos.cn>
References: <cover.1722517019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Skip the test with test__skip() for systems that do not
support "ip mptcp", so that CI can also pass.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 00f63f3f19f4..a6afced3ca82 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -357,10 +357,11 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
-	 * but the BPF CI is using an old version of IPRoute (5.5.0).
-	 */
-	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+		printf("'ip mptcp' not supported, skip this test.\n");
+		test__skip();
+		goto fail;
+	}
 
 	return 0;
 fail:
@@ -435,7 +436,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+	if (endpoint_init("subflow"))
 		goto close_netns;
 
 	run_subflow(skel->data->cc);
-- 
2.43.0

