Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581A126F3C
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235838; cv=none; b=QDxfAiSO+Hqi8X6LxhlUM14bXhRR11KftWoz+hx9ZKp5dTYsLP6VjfFls5sWOXtEJa+lvT584PFCw/a0pjR7vM4s6P47OdPJ/8nQdWn2VnX+9xfVuDjnwzYSGGKwAJI5Edn7bRR2R72cLyR16BatPo579JTkmgxm4NWE4d0TL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235838; c=relaxed/simple;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rg0cRv9PUyitKbUstAfyuw/C4fHQz+Lkm2wj+jFnpdxRgUJ6RvnATzeQ2wJC5e8EvSRU/XzJHKZFdycl1RnD5aYsxst/d0Bz2bzXx65CQDrc4dLyEtU8lo3JUAR8CYeZOfgGvJvKvKrx2wtZncW5Fvdcw+m/qxDrnbYCykM77fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI/CDzFg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI/CDzFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC0C43390;
	Thu,  4 Apr 2024 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235838;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RI/CDzFgaLo0h4h5o1X5EUv5ClrEyrz+QB0b2O/W5PjioxB22WcPnJk4/jtdqeb3f
	 T1G2SEcMrb4pBXBmYftftYdStxvmrP573znVlCYd/uSykYXOxAKCzj2UXW8gl6Oaqt
	 /Oew/28WP7TK5PxVTPoF/X+RJKHAQAjBzBc8mEhR0p2MLSDlYS/vPEODaw3OQYC4pm
	 28g1vArEr/CfUt0XPxpIgZB/etP4G8zbRwhtGjiyujyE9FR3zYxiJSEP5/9oDmzZaM
	 C1hPmvaODUrwGdsgAB+Ay6Jc2tMQ5nb5Ws95xRngIDlWz7XxT/tNq5FE3W7PDlEl97
	 +AJ2YzRiB2DxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/9] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Thu,  4 Apr 2024 21:03:03 +0800
Message-Id: <3277d8309eb4f32fe8c26d0590e66c7da439c0f3.1712235379.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712235379.git.tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
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
index cbdb15922949..c29c81239603 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -653,12 +653,16 @@ static void test_burst(void)
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

