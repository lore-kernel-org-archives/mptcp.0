Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607238DFC
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042165; cv=none; b=iufinUptjKgmwkRPQsb/Q0BbTdPJe8Qiaj0NsjvHjG+xBcMn5hDPFwzDX3quWilL2h2goW7xY0jt268NeyPcVZoJ61BaOT3Szuayid7nhFDY3PfPbu6U1vwUklRTbCtowD5cLFKmNAPv8ANNtl7++FdjPG1o/JmzICIOr/Y2cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042165; c=relaxed/simple;
	bh=ujos7wz/wPYZHup/NGzIMh3hJkNhEYi/Ko6EPG//BRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tkz8iBgGBhxpLrVjKvZhPcXeojM1gKmx54dUWeKJebNfSa50b921Oyh2T2jDVjfcbNe+WlBcyfjSu8YudKZVCGvuVAqpsiJlkIZNhd/AvM79WbIRF64a1GrPofCB0IaO6xr8ZENtcPylT4Vtdh/79UCT81weK3VM1053uRFXAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDb/zNkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDb/zNkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16AAC43390;
	Tue,  2 Apr 2024 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042165;
	bh=ujos7wz/wPYZHup/NGzIMh3hJkNhEYi/Ko6EPG//BRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDb/zNkh7oFo6gpgeVcsd8oRDoLyQZFo8QVt2x7cMBiJ7i3vUnQOmYHAedbLViO29
	 UGys+ppklL76YMCcCxR8bxE7lJiT+jLOVf/gGJ6NqKk0rhgKiL0aVgdflo+tGdWY65
	 jHlMcuAlTpgvFq2X3VSxoQfNsjHmcAELYK4LrA6Hf+GhSonNQEnXGWhk7D8LrLZ3Hw
	 uoFMpW6C5OTAoX8gt530uMYagBg/AY0N1t0Vqv+m7u0kITlz3hYdL9bOn0qtSpAKvm
	 hORo4E/Qvi7S/DcMDahn+asnd5p0u4Xs5bCfG/tl+opIDnyz56EJeX9O/7sNJ6BUjW
	 Di9VKSSSu6AEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 02/10] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Tue,  2 Apr 2024 15:15:50 +0800
Message-Id: <13d8499431364fa9b386db181b555ce5fa12e3df.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
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
index d3d51aee440d..faa0dc37b78e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -663,12 +663,16 @@ static void test_burst(void)
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

