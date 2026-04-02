Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8642765C4
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116098; cv=none; b=Ctb746DBW/Xg7H0YWmVTW9FQN+K5x0sVzzCsVkT5yR12iHF5vHwex0dpJIhUjpuZwuV43k19kfsNJGG8Hqqaoq7Nfcg4+yhiRR0c+GkQy3YJbL3gXqd1DOw1I0fr9B3kyeMDnLWtAGmTzRh9NkaECzsRM8mHrFvFhIwamECPvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116098; c=relaxed/simple;
	bh=hpMcMQ4pZ/fJu+msC3l2kv7L8UrDzJcO72LJcBD3ah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVKkQqsbhgnTnl4Vf3nUWmmaY4Ga7kSNF9OPsDUoDy9NDRbrn5SjNhMM5CArNel5mtuLARMXDS6/4xat+sXdIfb5zEJ5w+5KEwu+IuFihqZs9UK8BiUfSxiwIKsleqf205Q9mASstW9RNWe6+SGBFuqvG0zS0i4rgS6/ftk7m8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG1T/DMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG1T/DMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E2C19423;
	Thu,  2 Apr 2026 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116097;
	bh=hpMcMQ4pZ/fJu+msC3l2kv7L8UrDzJcO72LJcBD3ah8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JG1T/DMS/35HKRIXBzrqsOZGpUag3T3d0p7Qo0Fb2YDFJ021iCnk5eMq9UYd7YHOB
	 S6wS5MCinW2WxTVvbAFnStasbOO+4Sb1gdCX4q9XNkyq7BfyEbDwwBtSX6ycWGFvK/
	 O6hPLZ+rcMY2x1XvuITWe1MVQu/BIZmo2aAxnKdk3xYnODk3ywroKnrN2oZXdc7Xl/
	 uiPCNscPcrADJW50W+W36E/T5UlsNzZP2XU91Qko+mGsoUY5KYNP+ox6J2OtLDQH4g
	 EcT7Ng89Hgd7EjemkB1+/mrmTkclaRsGP/VblvmXX3J5QV0PFmhTlhR4kFOC5tM6VL
	 F7W3tP+C5jnMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Thu,  2 Apr 2026 15:47:46 +0800
Message-ID: <a3426aa7623615fb6e2bd187365a6c69671385f5.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
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
index 903e80c4267f..64e999c6e14d 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1299,6 +1299,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1308,11 +1309,11 @@ TEST_F(tls, pollin)
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
2.51.0

