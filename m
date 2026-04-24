Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258E314D35
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027156; cv=none; b=qxYdv1vsESddswXQfoS0NC/ZeV9Ko2wMpktjObUJ5Kr+8hpaaoVr8teTmotkU43fwamGBm8VmDHnmTJlixcGz++wD+ML8FwjtzIKjOuXwRW4xjlJQzTEJfKJRGoD9xBfAoStSMGacF4d2Z+ucBfbNfareUXXwpn9ZOFvDXVkgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027156; c=relaxed/simple;
	bh=hZ54esWfvtSDC/Udme6pFMmcN0sRtcQiX4ZHQHGs4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIJYmcOq6pCnxwQqsy1sH3ku3n+oEoPqfPkrqg92FSJV5Vi6p9XSHtvEhrtlbs9B5WgeAq+KtUJc18RjD1h6sUo70H6tWGQg3TUnxHSD5ExX/xTJVkYkM1AvmQ9DmGwuJYaWo7da6EFLgl7fsxSPceZ8CJ0lIu5sLmhKmbBPeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfD80+5e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfD80+5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36BAC19425;
	Fri, 24 Apr 2026 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027156;
	bh=hZ54esWfvtSDC/Udme6pFMmcN0sRtcQiX4ZHQHGs4U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfD80+5ecnk6sRGclLPLNk1xM44DcHtm5lZ3MthMPyUdQBLdG8aujgutzQ0Ggk8jg
	 f3n8qZNHs3/xBkjbw+ee45itlV8NOE4YRXRMV2RYFXom0UmAasrqrh3LyuBu5mrTjl
	 tk2pVbFx74VYfEyq12IXWDwMxdY10cer5wLqEZtbCMG0xw3azwsN+ZTRyluPY1NCvu
	 qSmqaxYC+MXj+blp8q7t4Op8ohR0pquM+MGqZc4qw+TP4qiev13NxvzT4RdEU3cwhX
	 sT8e5G5/U8aNEe7vvyPqRaz9Dx+dCRvyoJHPxkc87HD9MEo2OC2JuSV2FWWpNHuH16
	 FdhXh2FBipdqA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Fri, 24 Apr 2026 18:38:35 +0800
Message-ID: <100166d6e10abd517f9ea42ba713f1ad98ca2b8d.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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

