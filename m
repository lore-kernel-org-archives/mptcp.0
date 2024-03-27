Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2C31A76
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530123; cv=none; b=OTA+97JDabafED3HT0Qy2IHzp1wFggyOm9OpO+YLga56YgDORaP2XAh9CTUavTzUF2+h7eT5hnk4oNg3dknxPNSt73lARYrlJnbC9Sq2384/jL2NC06HS+2BmUSEMbg3C3SXTpAmhoA99e2WwNA+AURFyfk+CxrjkfPLIYQN8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530123; c=relaxed/simple;
	bh=zgggaveCRD4WI4GYq2Y9PJ3bHKjQu/I3gfEKdziM4mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bayeuf32pJLMXQq9k27rImu+ediHSAvXka3FDHL6zQf48QkCigPB7vRXltzWwT+5UvqxVrOmi+C/8e6qfMpawJqfHNFvj4C6VEmYw2fmmAz2HKUngFW73Pp1sX4jN69guSWD1KCA6PYFeHlRCE8kvfIb8RjxlrpYpFYPJnAgC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8ATMlDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8ATMlDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E4C433F1;
	Wed, 27 Mar 2024 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530122;
	bh=zgggaveCRD4WI4GYq2Y9PJ3bHKjQu/I3gfEKdziM4mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8ATMlDr1AU3gQhyd2E+TCxdkxj4FY7TrN2eo2c43vKnUhiNdE+GuaSguEEu6OLqx
	 nk0UkYsaPz773OUbxMugwl24meUr6ZSMdCahgXSv/aUibrAt7gFOcVnlv9IsC29S+h
	 DmBdW4PG+zHXKO7LuiEAQas54okYsqSBT1D0A/LljRccZldi/JKheHURcNdrLypPnt
	 G8eCBZV2GHo7qdoiViAa8Zbn0k5kYUXailUsRlucCOxOLK9Wg0h0l1UANp5nfahbMe
	 r0GNOAFY5r+pMZ72qVSRQ4LocZMqcN8/wDMuOGFB5/TGMB5dhuN8hWcla0pqHbrCDm
	 +1hZwZ+VmcjTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 02/11] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Wed, 27 Mar 2024 17:01:40 +0800
Message-Id: <5ad360a4e7c0f212366428344db9514b9b6f2220.1711529752.git.tanggeliang@kylinos.cn>
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

Each MPTCP subtest tests test__start_subtest(suffix), then invokes
test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
simpolify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7fec91ab19cf..7df2640eabdd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -651,12 +651,16 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(burst_skel);
 }
 
+#define RUN_MPTCP_TEST(suffix)					\
+do {								\
+	if (test__start_subtest(#suffix))			\
+		test_##suffix();				\
+} while (0)
+
 void test_mptcp(void)
 {
-	if (test__start_subtest("base"))
-		test_base();
-	if (test__start_subtest("mptcpify"))
-		test_mptcpify();
+	RUN_MPTCP_TEST(base);
+	RUN_MPTCP_TEST(mptcpify);
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.40.1

