Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976433F595
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460914; cv=none; b=jr0S3wG7F/UW50wVXNYWv+gmkE6lGYtcOKR51yonBnH093tmDjUp+5/z4maDDqBWrObfap2wd/UwpIwn3fbWxx2pRX8T+iU+mzWjS6PgGBxqxY1i0aFuC4tN58AKNO1KjU2avRUdOUFhGAaDk75aq+nYs51bjAkIPEbTa/Am4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460914; c=relaxed/simple;
	bh=hZ54esWfvtSDC/Udme6pFMmcN0sRtcQiX4ZHQHGs4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsC9A0lV4ZNY8xtj8giMUhSgU1GPgLvvYFHCdxoMY4uZLwis7JodWQhquKFgieilvkg3EjzQmk5tdZg1o07yJly0AQDqEOEBpykMGyZGhzbvavNzEWcpQvjjekMoYfFyBC1CPAU1RYKPG8bzpQyZhUWkcWtLplvMi+Jz78K/s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyohdXuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyohdXuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27192C19425;
	Wed, 29 Apr 2026 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460913;
	bh=hZ54esWfvtSDC/Udme6pFMmcN0sRtcQiX4ZHQHGs4U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyohdXucGMvKl+Ga7Pa2Sis3KcsPeP7JsK33C2lIJWO5eDTV4YgMJUTzfiQNREqso
	 GU3GLQNe4nSXJm+1SPPD3lPrZj3xg1vpHZELy+MP907KEIcYmx4bA0Q5p+SlI2BKvR
	 dvtdv8aAspeFEkVU7MfEUByep8kxmw5xyQ4E/6AF+Exeqy9NNhkC/Qet5lFfzm+8Mz
	 VNU+x9cDYqNIVY6uCfVKTtfM92M4gDgyFTwcHP3epTSwR11+tQO00UFb1F/KLvW6um
	 kw8+s4nN89FrJZgnZjVqrP0XtCS9Ov/hMmjshfkhKOUBGh2fnutUAWNHswMYHks2Q9
	 l7pVCe1C+NPIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Wed, 29 Apr 2026 19:08:15 +0800
Message-ID: <ee6cdae67061990fc1ce5e599821f281882a745c.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
index 80e8071993c0..0dc6514c2c3f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1319,6 +1319,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1328,11 +1329,11 @@ TEST_F(tls, pollin)
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

