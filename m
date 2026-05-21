Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4599369D6F
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355831; cv=none; b=Jo2H2vNFMB8AeDrxaYC7gvtouO9lOMmdPjS2TpppMvnSX2Ys6+xFxteAkCe7zY25LQb8TU7m60gfVlqRNRsewWPi/IeuHfEy3uSl1p0y7sZEVmRC4X7HJdU3KyEgYADyg9QtPNd8AC8EBKbjbO9Myx6j5UM+oSu7hxVTwmnNEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355831; c=relaxed/simple;
	bh=jSnV4eJfWWkKWj394ezkN5pDT8eQ9OzKtEU03h6LuF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly6iy4bIFwx8bsskjptPV0vmVpJTo3UVejW2jBNr50S5ChPmKmeb0qQVEzhd7X3xU25WSBE6EDkGjnjtXo7QhZYEGZZDqwf4vZMVfxT1B0kpgch6jIdlwg31+WgtNbg9p/TwmIIkstWeFO3jHRFbMQXWkptzR1NgGSYpVMykowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAXporFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAXporFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95EB1F00A3B;
	Thu, 21 May 2026 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355830;
	bh=edtL2WNPQXZY+2/vRKc4X+C0emiTO9ixMbmXZcXYqOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAXporFy1iVwj6Lwhki4nX40/YBwf4LnXgrw71+SsAx/ex3RFyqcUXL707rCKo4VV
	 qpF2wRM6uLno8/aQSV7knKJTN9x7vrAkYSmkgw5P0xg9IJkhDbuDlAH9foxcb+yiHG
	 ANGkXlNGEtgkv48o8wTWqEazKu0b6Kvh8DJVTOaKx4Cid9/DrPMiYq+tFSjCLRHSG0
	 dWUzwXQsNa8qESsq6HcSeJbCe/SyFPCSc2EKsKRgWMYRujjxLHXYs2CsjbF0h8poto
	 aJW9ZPHk77IrI7CoC5q5JtsxIPLqwimpKy5+li7E0W2RxiuNeXh/5EZBW3DtQPAKgy
	 LevlM+Q5iyj4A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Thu, 21 May 2026 17:29:49 +0800
Message-ID: <7430c61cf1d274223801c746ed9493a3239f6bdc.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
index 580375ce66d3..1608711177a2 100644
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

