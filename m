Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AD3ACF1E
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960468; cv=none; b=ntGDxuDxbsxyJ/JryY919OZD6q0Wls6sZHox8cwjVbG9IyaEFC17SMxdxsabEB4F/ZU/khHkW63DO7OfCtmo5lTwm386o2CB/RJ5IN7ulzoomXf6c0ZMIsNCvsxjJ7uAb9+/v3xtxvLEt94MO7xyexoIeA/+1TPKRSjHYBMQQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960468; c=relaxed/simple;
	bh=iqV0zSaCNXM8wzAhRBNqtu6qJvXxNa7FekUqOtiqHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yev6mVjQLBkjzhqSAqd3799GJo56uZJgK14e5gS1CBa5ZM1cjgA5WHm9p99xZGVEgTE6qxqpocvgpO7RYByUC3VnSnVYOJOQjvcn/XRCIGt894DRymXBBz5T+KNCCdxHUwoqsZMN0GywckHHy/t1QNUvysO0X1CvQgqhYTIOvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knINEaDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knINEaDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91331F000E9;
	Thu, 28 May 2026 09:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960464;
	bh=VqJYDhrdfYG8x1P+nVzqyFokwQq12zc8vWSKIl8WGmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=knINEaDK+WJaBDEdUvGnRTyAX4LJSfdlSsREQhOnFmXe+CZu+0aOQIsM/7+dvgFTa
	 61D0hj4h2sOAhda2ppkf4LFu64GL8tZFbuLApvaanCm6YaO0kdi6nC1CxV29u6yHQI
	 OpTJ+6FtqQSXZ/xQiGpNy6rIaDz5q+obWpdWwtO76Q332/yPlphvtW6jnZ1EldWuco
	 atimFYwXfARDm0lWRSO1hp0KT7RTUO8mIe5BKIe+fSd+JwH3hmemtubRbhEwDolho/
	 OytUlEcWwYyOgUtGN57gZeWYZgfQyAbrCeL8h1LNkm4OET7GrLULTiDQv5pQgp3r7H
	 /2wRZ1JFeFdgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 13/18] selftests: tls: increase pollin timeouts for mptcp
Date: Thu, 28 May 2026 17:27:04 +0800
Message-ID: <17ca2687b9513c0f22c47365a2313f1fba7589e8.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

