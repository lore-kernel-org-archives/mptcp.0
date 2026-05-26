Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E093A0B3F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788828; cv=none; b=niFVIKPBGHBP+JrCE2UFxugtYf0gjRl6GTyy/sJT15QCtC75LKJ3EPRKC3Sj5P4mXIQQp2zDjzfwbKECmiWqh6AGENdRYnsJ2aFiKAm1gYTiPk7rN6knYdc6vsr7gfsiDngYjULsnjXL7cReert/e3YuRUmQowD03gksOJHvzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788828; c=relaxed/simple;
	bh=o4nnBXLG2pPoQO23y+8Bqj8kWJVmOSVJEbXcno1SML4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boRDNDKOfUZzqXbK9DFdmg6hWyBjya99DqJPgZHwTwlk67d6rZjeWxKRbEB/fg42Uj6SQs/GF0xRA/7zmM+JeeEsmsxSge+A8xzcnN5WA/Cn/fJXxQJvKFCcRlEmjZzyzxhWXMCCGfky7Ze+o93IiVlrHDO+cXD2niC+PrcfiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvLI+X/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvLI+X/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE221F00A3A;
	Tue, 26 May 2026 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788826;
	bh=IYRoBv+hpmAy3FWPcEdvfIhbcYF4kBSk5Jsx8E7Py2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvLI+X/se0g1LgNv+38s7rjaQCb3+QQcoFgQr6lnFTQ0C/I9QSJyN1ZgzXG0Rb7DW
	 h1UOwLDFhvH0tiF/Ok6nZd/+kWGUqq78Iy9FHZ4CsyzfhNyPb7tDq+7MOYzOJ2GHNm
	 DlfLO2rET8RSD9CJQgx1E61B6/Ka4EtDyBfb0j4boklSYIpz7izBPDUEqennu940Wy
	 yfOVtsKra8d250h3nSnnN7aNsAopfbmh2x/ZkSK/M558xGTB+q5KN5DimhuAdmFmWv
	 bu7+/iR2fLwKPdAbqBfS5i5K9jS/BKokCw+MmliECG2iQrg/qglbsuyVuUmKMYLIJg
	 tBaBYSV+KWTHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Tue, 26 May 2026 17:46:29 +0800
Message-ID: <51c4987ead2423542d2dac49eba37ea0d64e8c02.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP requires longer timeouts in pollin test due to subflow establishment
delays and slower state transitions. Increase timeout values to prevent
false failures:

 #  RUN           tls.13_sm4_ccm_mptcp.pollin ...
 # tls.c:1411:pollin:Expected poll(&fd, 1, 20) (0) == 1 (1)
 # tls.c:1412:pollin:Expected fd.revents & POLLIN (0) == 1 (1)
 # pollin: Test failed
 #          FAIL  tls.13_sm4_ccm_mptcp.pollin
 not ok 357 tls.13_sm4_ccm_mptcp.pollin

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5f8382a51558..95875e979ea7 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1362,6 +1362,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1371,11 +1372,11 @@ TEST_F(tls, pollin)
 	fd.fd = self->cfd;
 	fd.events = POLLIN;
 
-	EXPECT_EQ(poll(&fd, 1, 20), 1);
+	EXPECT_EQ(poll(&fd, 1, timeout), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	/* Test timing out */
-	EXPECT_EQ(poll(&fd, 1, 20), 0);
+	EXPECT_EQ(poll(&fd, 1, timeout), 0);
 }
 
 TEST_F(tls, poll_wait)
-- 
2.53.0

