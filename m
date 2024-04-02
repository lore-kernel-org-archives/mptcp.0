Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDA18035
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034768; cv=none; b=rst64CdqX41hk/66YSkxhhigiq/F/YL9MhoSf1f+THdmL0TsYhwNcejP0xeWCdDFVR8kHtvjarLbcTa0l6Vticyfgah98wRLnQHzJFXb2WiaVAuEV1xy90seZ4pfHq2waf6aiSWQdXyjS3eIYjzqQAIKsRZ9My36nziA585ajVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034768; c=relaxed/simple;
	bh=ujos7wz/wPYZHup/NGzIMh3hJkNhEYi/Ko6EPG//BRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUJ/16l8R//d/5B4YGDc9mjfM1uj6/UdxkPbDzHKafde/HmGzKw4wz8AhZw6HTqm9x1WbYisx78IjEeGO+BMh6zbY9qWI6knrkhYu4ZOTJYsn1hBDuVWD+n+4D5ngBsxyXkDAYLRiigcTkfdzzyrIIUNxkfJe8GkQP/4pR8rKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ79KMaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ79KMaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581CC43394;
	Tue,  2 Apr 2024 05:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034767;
	bh=ujos7wz/wPYZHup/NGzIMh3hJkNhEYi/Ko6EPG//BRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZ79KMaFjERfQk+vfOqbb8PsDyp8AmG8npd+iomJUWky7DdiKMDfgp0JxVdsgzLPE
	 BdYXkkRwx78XLATVXprXEobGvOXG1RPyulLBN0hdpxxz3HAYKSY2hxy9D7WLAihjXP
	 5Rg4ezLn9RMwTt6q4q++XF8FsJKB22wROirksRwvkPSu99k62lGxcD07zH+rMYGn92
	 l4XDz0v9FL9vjcnY0/ZntT35IreQBbPCP1jLxB2mmTz3b8XZaJ2oAE2fQayKXobEy9
	 9rtjShYsDr8rokZQcRy7CElAsZ81Jpy1IWrOmdpoJhHXLltCSpbM+BVbSP/7oRDPIR
	 OLq9VNNvu1h0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 02/11] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Tue,  2 Apr 2024 13:12:25 +0800
Message-Id: <13d8499431364fa9b386db181b555ce5fa12e3df.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
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

