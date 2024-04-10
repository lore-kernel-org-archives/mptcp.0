Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A810F1
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714736; cv=none; b=X4gBVszorKiG9eMJc78OAYEMc2J6QTDkbGauIdrDt90dNQMy1ch2ccUPR5jqEvauznk3QfHmrG5WV2qS1hN/IZa/pGTGIF7jYEWZTwvHw+V307USHnD9bGwFzrzsl7wWHAWp0XfU5lSsuQm03L/IjV3Bq8iMpyMKDfV/jbieH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714736; c=relaxed/simple;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raW/Zzqittjc3jO7uLL+XOCR6N6DGU/lZcWOWKWn0sTaUF9FitgheIykKQJVkV9GVu4dPgWl53BNKhagx2r0fy1c74ZaUFJIV0V+rciU9qOoImPuaJV6/OLaYEOR42ZfmD4lCvdBwYJN36no1OutHr+puovsTxlXbPCXyPD39rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjRfhmNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjRfhmNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D5DC433C7;
	Wed, 10 Apr 2024 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714735;
	bh=/Pc3wOJ+00tHqo8MDJm/cNhGbriSzwm6ucNRtr1wM7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjRfhmNXM7HowFIOU7iFP0tAyPJiQmwkqt4o0sVCWCeAsOnIdD4U6WQIy3UrlWH03
	 vwzgBqA1SmWU0WwFMOa5G+JVUcHmMupoBg15mNUL/IXzAJvqdqsghqaHMxyes2yNQD
	 BwbHToGroluXJ10P0A0QOoU/hl07BMJL1GvOcz5liHCSEM4sDGCITdbrxyR86yYkYn
	 muleY6GNGkMX5GUIdsmy3zJ55v1/DgcDKlv6xXRTFG5TFVnL8F9dXcNiwJnRE6wRO+
	 TDkeMAykY6X8e8+1G0r2j0IhEuS5liRWT7gRShk6+aHpCP7y6vjxYglmTLOvsjfY24
	 YeIpWNYIX8Ipw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 1/9] selftests/bpf: Add RUN_MPTCP_TEST macro
Date: Wed, 10 Apr 2024 10:05:16 +0800
Message-Id: <1b62f171064b5735f49c7fc0d953763ec0434832.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712714407.git.tanggeliang@kylinos.cn>
References: <cover.1712714407.git.tanggeliang@kylinos.cn>
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

