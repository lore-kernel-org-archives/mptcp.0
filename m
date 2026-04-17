Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D530AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469717; cv=none; b=Lqim/b1HaglCSoJY8SReEI/3zSVhFzHIi+8F/3VNTLgXq97r894DogZwnyir8rn0KocxagveTUm6aHbeE1/4+zlExDSPB0fjj88CPCHIv2rjAvAoqW4RREjpm91hCrU6ETkJfKwQZHSRPPwHQCpwY4cGQhcFTU+XftFf470CFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469717; c=relaxed/simple;
	bh=fJRguZsPthsi6pvu3nbI6tt5IWEa5y4Jg8LDr2Iak2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=em8Yb61Lg7bmmBVx5GRNZKiG2KTV314+bUHIFlGAAg0oyqwN73nsAc8pCUsIruBjAVl1UeXEqUoLIB22898zGGwu6TXB6kkoIbwB8q/UKsj1BZpCJu0ZUPix/V844obWly33Mff174NEpIXDzWtfhWmKN6rC1hRC222ltiM/cbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I33zDRTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I33zDRTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFC6C2BCB3;
	Fri, 17 Apr 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469717;
	bh=fJRguZsPthsi6pvu3nbI6tt5IWEa5y4Jg8LDr2Iak2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I33zDRTsZN60RWu+Ap+AXA4BqW3bja+KuxtqfBSeJWRUmK9MhCbH+IRyabaLG+9OT
	 4mkozrEuE+25gNIriifUWnHCsXsEABbwjM9xZSv+Dzi2uE0+A87unTfE1rU+YF8AZf
	 68R5vTm6B3+bbrRUm5w9xsjjgzQdb01F8YbDFBcJfD15feQOMM5//78ZXU1ehLqt9d
	 WZSuJD64FetEuXL0eiRlGntanS2TYTNr66px/X/ccQtOFIzD+7R7zCMwYnW2aEwEly
	 4szlGTF7hE6NWDnA4tQf0DTbliNQPWTiGxH3uTKCns4nZRaSFl4ow6P3jW0GyPQ+BE
	 gknSqtKfdM8Cg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Sat, 18 Apr 2026 07:47:50 +0800
Message-ID: <15ec7d1a97589e3294ad3220ef74fb386834c7b0.1776469069.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
index 0d19e5582d3d..048bb4d3e0d8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1320,6 +1320,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1329,11 +1330,11 @@ TEST_F(tls, pollin)
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

