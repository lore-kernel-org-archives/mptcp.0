Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDE1851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321550; cv=none; b=F9wepNJAUpTqFHJ8fXfEAzHmSOkk/BgeiUwoVBmKKb4GtQdWq9g+nKRxi90G6p1/wVxMGhNPIkzJOW+VJpq7KBER29zzg5d6K9gRwwqsMUjYj/bxMOFQKhLUMsUhCUU58a+tlIPr5FlSM7LcMM0k1fwZs2l5EfRYkN18z5jLXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321550; c=relaxed/simple;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtPt5hSvP9G3hnp0ZX3bX4p+7jqxvxnaLuQRP0sqraCLikutHH6nv0vOOAYNIWOkfSpJik+wWofUGvNUnTmAWdEF8hxC7b4o39whFA3ltwIOiLNe3humq3alF0NUR/HCz2O4i/nm8ru0ZUIjUiYIs4FqRQu0kJgcDi3vxoLAY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I96aqztp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I96aqztp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7550C2BD11;
	Wed, 17 Apr 2024 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321549;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I96aqztpUPeuzb2JJdPzO8xNEGOXkRerDs4aSmZZV5K9vDA4DWZjWQlb1TndvHF2O
	 WprsfXcQBHFNI7/Ovf1B4JpY1kQPyHqUGnMtlKcuLbQd4M0jHYh21cI8A70djAU4gF
	 hu5o3PFQsU7IBJnTKX7PkcHWBqL2DC9LKZvefKMZFNMw2oOpxwelxqQg83VLdEcScQ
	 W9k35s0oeuOqfVcuNwtz+uF44XC/Cb4Uq9MV4O+yBkO44FJIDwKfQB2z96su4qWt08
	 00w7gjD/TiH91N805elTzGMIzXuubuLuh5MThbM4eReHsh2Hpb5Hq8uvL9RUaRs9Ti
	 o1xeyJ4ztRtyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/8] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Wed, 17 Apr 2024 10:38:47 +0800
Message-Id: <87f974d9431af3018c35cbd4db147ea807e3c451.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
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

