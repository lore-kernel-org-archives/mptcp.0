Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519B3B7B93
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622674; cv=none; b=F8I93PS9/Ew6QY0XfjoonT4Y3g+Oh3nz1S7rtOG/RTeXK8AMYuqJHwMOsrOxk5RSME5HidGg9fpEBYCZDU2u4B49HeU96hYNMgp5bwH71coaOIjNmD+QPtSvgs1R74bntWCOr3vtUYQwRlMf/jHQL67gtwnXb6XVgXLHWN8tk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622674; c=relaxed/simple;
	bh=iqV0zSaCNXM8wzAhRBNqtu6qJvXxNa7FekUqOtiqHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAbet6Mh5SDHCsl1jt7iHDqdmOhfwWxDvxNcLb6SrMvQ40ow1bq/Em26dfk4kO3IlZLX16dHlFF+8FbRIm3WLN/cZxRVQtM/+Ym8Sy+olc5rxRsvONOZDEzWM1NpCUVNd9KRdjf3f2mk8gV9coaNjqgbgAyDWKZqM7nKkSRwReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfNXedSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfNXedSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B29E1F0089A;
	Fri,  5 Jun 2026 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622669;
	bh=VqJYDhrdfYG8x1P+nVzqyFokwQq12zc8vWSKIl8WGmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfNXedSyIBah6ZVtkEnuyaNYDWHvK79+7Ro3l9uslvxbeEliEDmesUekhYx3XTCXd
	 keW8SO9FvVrlOCiJ8/DntO0G+Q2IVryUFtoVpU7LGM8jymQ/t9chCghwDaMJELrlpE
	 cYF186jIzY/1UoYO3FRgkxkrfnIBfS+o/fizVulJahV1kxxzpHJA3Itxfgi0UnPKm9
	 uqYbbazz3j7ocEYKV3aSfcCEnAgny+e3Fx5TcMsLLITQGDN6jN5BL2L6gfuo1WfkXS
	 eq6qXrHB2xeAvr3ggV6K/JvtMKoet0c0eJouLl3WLPOgxO5PeIAXwjI2mufoecvFwP
	 Zo6yXkTf8EbBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 13/18] selftests: tls: increase pollin timeouts for mptcp
Date: Fri,  5 Jun 2026 09:22:53 +0800
Message-ID: <144d06579285a2d2012f92e6028d1742e9a9b26d.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
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
index fed83918cd9d..5a6c5ee2757f 100644
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

