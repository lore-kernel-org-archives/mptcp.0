Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAA2F8E98
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971602; cv=none; b=QacKiG08JSOzfHxldFiBB+U2XcBz0qlZZYe5pIHaM4yw7lG9H5s014TFmK+5wpK6ef5dADWY6pZ4q+tnLvVLiPvSHSFOD7CF111me1AzzCS331Rn58k+rFKNRZqTBjOovfhKTxVM5H75/OwVhbJy14/ctW32o18iQ+BuVuKHnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971602; c=relaxed/simple;
	bh=0MC1e1X4134Qk+ppmW3HSRM8Eyr9JD3CJdogsgBVigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUPdp7VL4ziRHkegEZLD5J3jPThJv36MPtKD0u0TM5RZjh9CaRlyPg3EQ0OmpCMfdpR10nbDR1t/6PZ0nasn4nmVbdXASs/T0+MzW/hjlgQwMN7R/PyKqCT89xR645sOVsn5QrQFGqV8OX13396H9MgS8izMMSc7QOT59VguBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAUdOzub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAUdOzub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219CC1F00898;
	Tue,  9 Jun 2026 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971601;
	bh=At1zo6hDfmt/kaK3eOVzt6d52M3LX1QctkxXRyIIboM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QAUdOzubTechU8Nm6kibJh61hXhd4yKtD53Mtr704fFXnko1jFo0Jr0XrEgX8iATC
	 39uXfk+CZzEuwDM6/M6J1MkmVjBPFaXNHm6ujye3WS71PDJkkmWm+e0dX//aBzRqsu
	 jiWHzUe8WrUgqA65nR3mdXMQwfIAOBnhQoEd6CDLe2Yh1fHx9qQ7vP5yW5AVxc4zdG
	 47OUfPgNScOM2sOlOvUlpxFhHkP3IY893zvtu/YXgWAwQa9N1nsZW1PjtczOLnUNub
	 eXT8WjUOPm00uPWTEwxhw4Yo7vfPF3CxKhH3dwxVA/0v8OiK/AbwYn/TkM5Oqb960j
	 CGTqBR7dimsKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 17/22] selftests: tls: increase pollin timeouts for mptcp
Date: Tue,  9 Jun 2026 10:18:43 +0800
Message-ID: <8a29f77d066d34fe94e888046b029fbaceb795c6.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
2.43.0

