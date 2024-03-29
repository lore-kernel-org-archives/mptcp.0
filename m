Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722C381B8
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688230; cv=none; b=dBOMNRXoVgDkVi8WCjKV0GwCofa7NQmLeTzIRAHC5RtfD8hI3HO+4J5vLLSkIKjyMZLboRY121ytM8wdhvKfUUA6gH7php1Tb2JtwPO0kQwMkp5VsA1FwIJBNeDtQe1YXGbiEJqou4k014DRDTJr3c3Xyu7rNDg9z8/hPemt4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688230; c=relaxed/simple;
	bh=9XT2EOuqpiizMRjgG5P9Ewz0INMZjOPdb4PwoSYPmpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jk2TRFctsSMCtPpMKm04EE3y/pQG+YWqsPxAsS9VBaJcf+PBzfsmfyduSZW4x7WG3gwbuLQz66z3ZXiYpSlencs/OKGhjnqjwNbkD4+ahmRegnGxtRmF+eqVppIhPdFRun1c6ABZpPFpHDU6m+nJvmcEERNSqcaPGaPFhmbS33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smY5+DpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smY5+DpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3394C43390;
	Fri, 29 Mar 2024 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688229;
	bh=9XT2EOuqpiizMRjgG5P9Ewz0INMZjOPdb4PwoSYPmpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smY5+DpWDH8Cs6HaH9iaBPFiPYMVAgnvz26O9RE8TcEHfUTyMI/R03CydZ5Vbzs+u
	 kw7cRkRc2qn32H6RrdrXL589CuwaGx3udN60d7tryZV/opidakqMF9nyw1MogElJ9F
	 Zi3XDNvtttQcIqGDj4YMP5DJjqyZGYY5Db0fWhs9S/kC1HewGkItpT6ROdqGXfGcsd
	 t11Fgh44RqJ1VZsL9FmLa/CfebuHwlTbprAa0cypAU3x36WyzbyLY3Yi37bY4CXjH4
	 UAsuKogKGdkkxOh1IOI/ZXzEbIc7LYkOangx7o1gb5+1ML+TfUgnhRrbSUUBBz4Lpj
	 bKH/tFsD/aZBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/15] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Fri, 29 Mar 2024 12:56:04 +0800
Message-Id: <f9fbc0732f5a0e9f6936ecaebb070ebab3e6b08c.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
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
index c6185217fef5..a1a39289b7c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -623,12 +623,16 @@ static void test_burst(void)
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
-	if (test__start_subtest("mptcp_sock"))
-		test_mptcp_sock();
-	if (test__start_subtest("mptcpify"))
-		test_mptcpify();
+	RUN_MPTCP_TEST(mptcp_sock);
+	RUN_MPTCP_TEST(mptcpify);
 	if (test__start_subtest("default"))
 		test_default();
 	if (test__start_subtest("first"))
-- 
2.40.1

