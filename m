Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC01C0DDF
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788656; cv=none; b=GQ375XNX8qpZIoOcxM1GHy4q/OKhHCPkHWndjUcupNQhQDO7vjCHwuSJk/Y8JekIXt3tIH48cpYr1KjDn+BL7cIMaHWc9gd69lDsSRWDRHwNZHjJ+m4ml42gEpjwEUyN8bT/b8DQ5h2pWMfRqJjZZ54KGia/mBjM1V/I380Nq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788656; c=relaxed/simple;
	bh=XHMEWN+DZO9aWwobxpT5SNp080PVd68tBNehAhYlO/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sq+0CBIuE+m+RTD/6A9AmaFFaQ5PkLgIO3upO77KlABNFsvhccrXvkR1bWTIxen9ACtc8TP3+wgpo4jYcqbZsigGDUExc082BA+cDCG7DUt0ki2Fac+e1ZKOAoOi7qUk0oIDEB+0kDS+qTEjAU19haqJ08RqfhRi5s0EYZXhD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTLzCzI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTLzCzI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA69BC43390;
	Sat, 30 Mar 2024 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788655;
	bh=XHMEWN+DZO9aWwobxpT5SNp080PVd68tBNehAhYlO/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTLzCzI6nEytFdLpl5invJJHCzbvj2CTFeJexSKoABzdo4kUCDoRaJ5gJfd5ruipn
	 Vgm3ECibw6eZf2NSgh95ZDU3C1zDr4a+zO0G+lPDJ3Qauj/oxBqag/yvQsmRvW3RM7
	 SD1zQrd3vWH2ZyEHfDzRJZV7CQ2TxqZaVgLSO/+e8nW7mugbMYvpEcq85M8TbtKLJf
	 rixG2xyeFv8O7PS3a8NeXiW+N0AIGxDwuscaM2l50405JxyQxngtPnwn5XG4x/ipE2
	 frA6wxjcIB3JO/xhJKtodkhQDQ1iluf8IgaDBs/6S1mf7wwIIx2adkMJJrmvLOyzF+
	 /3nXw6M/YSa/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/8] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Sat, 30 Mar 2024 16:50:43 +0800
Message-Id: <34841863f670a80e6d42da4cb8b35b7bebe6f341.1711788593.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711788593.git.tanggeliang@kylinos.cn>
References: <cover.1711788593.git.tanggeliang@kylinos.cn>
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
index 6e28215d7404..8088608f6b28 100644
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

