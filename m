Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81E368947
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053285; cv=none; b=E2ud//4WCZg4saAiCeKpz0mWAmlrl2TaGniLHbpQlONjtgPwcMIaXksuJAiBfOUAPYk2u1XA8Zh6CEkIEjZ7cIp52StEK5ktrbA0zDb63td6Fs1f7FfInnSUO/C7ogtn8mh/ovz1jwekKoQvl8/z5f3hv18Bk6BWur3WnUPXz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053285; c=relaxed/simple;
	bh=iqV0zSaCNXM8wzAhRBNqtu6qJvXxNa7FekUqOtiqHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLJla1yd+3OXlnH35iVN2gALO23yKtJ0W0e2fossEOFWnR6z8iUt3VQkHrjZC7vhRMpbB2QSBdQv+rBYuRC/skCZE5XTLJaW20xdx7WcuLZsiA1ygpCt4IjxK2QO9Rm7MnQnkaLhRS3OyWqjyZ+e0fUzhVe3oM2JlIzQFAT8+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlURIi7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlURIi7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F591F00893;
	Fri, 29 May 2026 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053283;
	bh=VqJYDhrdfYG8x1P+nVzqyFokwQq12zc8vWSKIl8WGmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OlURIi7qd0qx0XDfnutfA11pEmapXXjXoV3K8hyCdo9Q7rcSN9XbnsdqPRTdYk8uu
	 9tx/TFw4QLG5hKjnHfdKp75JkBxajolQc1/8YyTZD9KxkTHQkSzPOrV80Hw9hMx1Pu
	 oDVanRnN1vNkVvJzKojI11gj47hsqlCNoVyY+gScOxj6o9B7lA0HjbTGgA9I177DGN
	 wv3ZPKy0+8KmcJ7Hx3Ed7oq1+Mm9Sd0qvn1vb1hd3rYmDTCDGdASRK9q8QjMdSjyzj
	 0i5RESaG2dya1o8nu1pUjeUpssQk4DXDnbAff/SSCU6cdhYVJ5O9cgcoZJW/60xDEJ
	 grPNNoU9zhzmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 15/20] selftests: tls: increase pollin timeouts for mptcp
Date: Fri, 29 May 2026 19:13:57 +0800
Message-ID: <f94cae7b3d7e40c8cba76b2c39ecab7cd4cd99c7.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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

