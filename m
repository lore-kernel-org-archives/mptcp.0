Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF01DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926085; cv=none; b=Vk97303XJDQWfWc2Szd4gTdowE+S+eih2MaG830qAllOm11jqmJhlEEQQefAjLR1KvyCUx6Ksr7P4crpXLSkq376lBpWBbv+etit3dQKbse5macpQvbZvNIRDXTuWbu6UoQX3GNllKaUfNyydBRAfN/n8hwcx0ScyU/lJYe97M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926085; c=relaxed/simple;
	bh=Rt+LtTO66E1MVl7IlHvROCv5WAm4TeN8BijU7rCSxc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULeGfPrdqN++ymJeOard4O23LV3TaQEpPl3IENgzqBCfeSOVDvymf2lLIRmhxjBi/jQfPB+/ySTlD/9cOTWaxKdnD/+BGO8kstgZ9ldsG+3WVF5osBdEfrN7rG+e9N+sc9jdEr/LY1luP9Z9qjKRPSwVhSLFt+3gYia71qnL62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arNAw/JV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arNAw/JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B277CC2BCB2;
	Thu, 23 Apr 2026 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926085;
	bh=Rt+LtTO66E1MVl7IlHvROCv5WAm4TeN8BijU7rCSxc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arNAw/JVHD89/8qnSAUL64Uk7Zhvo5ioEAY/V+nyd5U7DmXnWHy6OExHC3w94Jh34
	 DTsF8kB0Q2IN8wjWXcuP5kRETkDT17hoHrzfFsnDWXBhvmfW5ROUNUd4xT979JjmWX
	 AJu/ESAmdbZ6DotNpr2sKRB8x2qzAC9n3b+OFExRLKPrKGbA6j4Oo8YoxbkP7gxjS5
	 pGdWAXPhAC9nBDvqXDTssXs6/EDsX4UBnZ+Kjhpv23DLJZoidOshbvxigVoRP8JKTV
	 koaRpyAtDc6eW+aRFbyGwvQCMeQRbK6BoVfICqL+oewnRZZT2iE7c9XdF7i8igq4kU
	 S/KI0hoY7jSyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 12/16] selftests: tls: increase pollin timeouts for mptcp
Date: Thu, 23 Apr 2026 14:33:05 +0800
Message-ID: <b2bfd08d99598fb57d4676d83d8b281704a9e02b.1776924682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
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
2.51.0

