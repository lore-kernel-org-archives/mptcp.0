Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21217F7
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545278; cv=none; b=QAX7wZiaGRnPWsNgvY1f3XofNRsYgcpySmLV1oQgF3HyMdlEVR9u0NRQkuuoZatr5zrZrqUlM0mGkpdDjUYP7wM6FaQ/iui7MtRIsqPj53ZJUmTjhFOyXO/4H4H74++GO7OP8pW2XnmCvnG/bWE45RErMvNgib5HaJQImKN0hWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545278; c=relaxed/simple;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7OL9HVpfnC++a+5h25BU7YUNqGUrOg92KJe7ZhHUWffACfxXYrwwxAJYbznmTWL1TW8q0iNY8LPzPmEKcIZQ3ftLrPR0i5yw8Cj5p+fUrg9U4CbjZPSDUURE1Fw9s4FTVvPPq3HNkSGKz9jADaYBWcuUEYnfvGvDz2sexzK6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INTtpPhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INTtpPhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8273C433C7;
	Mon,  8 Apr 2024 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545277;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INTtpPhbBrCw6f46GJqjWPA0c2ba9pW0pet/jMP7iDUYH6w5kmlWY2MehkMej2MRb
	 2YYoJeUOz5h+SEXbS1i/+699aezfPqD4XLhCIQAJ1k/PHlEzwSOpcmbbKgEFH5Ugcm
	 dLVeVSH1EmLH7aIRrDRsEUppUJx/pqQIJuUJcQD/0Z/SvBzdeHSvvxAGYdMSBvgmmG
	 lfcx+ri5iuTHgDoodDDwesbthFAEYptAA+WPdS5G36gt1YpbDRmBkzfH9dW2v8aPsg
	 pGO2AGXWPIQlUwEAbakuJVwhNDXwQODbxbYqIIcXXFREXOe18zY2wQ46Om0LUD4v/5
	 F3mnUX6c1vUKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 1/9] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Mon,  8 Apr 2024 11:01:03 +0800
Message-Id: <c6aa42298bd0f4815ff29bfe2aa11fed876f9457.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712544986.git.tanggeliang@kylinos.cn>
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
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

