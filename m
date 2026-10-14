Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F3488223
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968390; cv=none; b=Yda6JYNIeZPGd5HOE9RMdCXobTUHDebEJSgzHtvVytcTxwYgdyF/evbXBu7lVID+iYr2tewnNMSGcSFnA3AUb6rAE0iVBHTryyC686iWUjnZsjLQnSBNRd1bMXeRlO2rnZaqCgX80YpKeoFXS5eL8qVFE18o6g5+GqTFX+Ohhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968390; c=relaxed/simple;
	bh=oVcOwR0M46fCD00pE9/CVA9WFOddW+Sw9i/Qskj2BVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7+PA3wmCJV+luDFHh4uu8BWlhQwJTyNGyCxMd0fI8k6kJYrmnsCd/j54p9j0ei+6+M+FV4Zmcqr2Z4AZIn0IpXnoQn7fK1p90fjuCDEVzre+YxiTsTHkzH8bUCd8HwaWKBhPdXjWQ4ypW5yfYtbD8KB+ubpVVMCK04B7PKjx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkdsY5V0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkdsY5V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794B1F00898;
	Wed, 14 Oct 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968385;
	bh=iHBE2Mjg65gq4Kz3vDMStX2hxqEnkP51NZqzB6UpznM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OkdsY5V08cFWkeND/FsQBBd2fI0OKsJ8jdfupTFu0QqS1zHZ8JVB3zV0QvNtNJY1g
	 WnAYdYzNG+Htp9Oka+aQrInDWFwy7jixhcomIlOq8IHOTIzXEBqFJkOLzDK6dgqKmm
	 UvTQSQk1PXdm22IKGn3O2eek79kH3Ha4gutz6QkhdrpDtmZezImGpAC0KdLiDJWwGx
	 rThD+ueyj7FTLWbMZn81qs03l42Ub9TZHM8+Rc2ixKqO2BnO53UYo04jFol4QRMeYR
	 Ml3K9YBlx4Fla9CpWqjb7Ugs1RWk3fcnm0/iTvi3SjqaF4hM/7is2yhQWrwvahEXMI
	 mabmWtZQBsKkw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] selftests: tls: update disconnect tests
Date: Wed, 14 Oct 2026 16:59:36 +0800
Message-ID: <8895fee0bf85912767c9f52cdfe320438c136432.1791967771.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791967771.git.tanggeliang@kylinos.cn>
References: <cover.1791967771.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update the TLS disconnect test to verify the full disconnect/reconnect
cycle.

The test first establishes a TLS connection and verifies data transfer
works. It then disconnects both ends of the connection using
connect(AF_UNSPEC) and verifies that send/recv operations fail with
appropriate error codes (EPIPE/ECONNRESET for send, ENOTCONN for recv).
The client socket is then reconnected to a new server, TLS is
re-established, and data transfer is verified to work again.

This ensures TLS sockets can be properly disconnected and reconnected
without state corruption.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 57 +++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9d3cd4fff062..ada2f43d05d3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1985,8 +1985,10 @@ TEST_F(tls_basic, disconnect)
 	int send_len = strlen(test_str) + 1;
 	struct tls_crypto_info_keys key;
 	struct sockaddr_in addr;
+	socklen_t len;
 	char buf[20];
 	int ret;
+	int sfd;
 
 	if (self->notls)
 		return;
@@ -2005,14 +2007,65 @@ TEST_F(tls_basic, disconnect)
 	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &key, key.len);
 	ASSERT_EQ(ret, 0);
 
+	bzero(buf, sizeof(buf));
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+
 	addr.sin_family = AF_UNSPEC;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 	ret = connect(self->cfd, &addr, sizeof(addr));
-	EXPECT_EQ(ret, -1);
-	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(ret, 0);
+
+	/* Verify send/recv fail after disconnect. */
+	EXPECT_EQ(send(self->cfd, buf, sizeof(buf),
+		       MSG_DONTWAIT | MSG_NOSIGNAL), -1);
+	EXPECT_TRUE(errno == EPIPE || errno == ECONNRESET);
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, ENOTCONN);
+
+	/* Disconnect fd as well. */
+	ret = connect(self->fd, &addr, sizeof(addr));
+	ASSERT_EQ(ret, 0);
+	EXPECT_EQ(send(self->fd, buf, sizeof(buf),
+		       MSG_DONTWAIT | MSG_NOSIGNAL), -1);
+	EXPECT_TRUE(errno == EPIPE || errno == ECONNRESET);
+	EXPECT_EQ(recv(self->fd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, ENOTCONN);
+
+	/* Reconnect fd to a new server and re-setup TLS. */
+	addr.sin_family = AF_INET;
+	addr.sin_port = 0;
+	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	EXPECT_GE(sfd, 0);
+	if (sfd < 0)
+		return;
+
+	/* sfd not closed on ASSERT failure, kernel cleans up on test abort */
+	ASSERT_EQ(bind(sfd, &addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(sfd, 10), 0);
+	len = sizeof(addr);
+	ASSERT_EQ(getsockname(sfd, &addr, &len), 0);
+	ASSERT_EQ(connect(self->fd, (struct sockaddr *)&addr, sizeof(addr)), 0);
 
+	ret = accept(sfd, &addr, &len);
+	close(sfd);
+	ASSERT_GE(ret, 0);
+	close(self->cfd);
+	self->cfd = ret;
+
+	ASSERT_EQ(setsockopt(self->fd, IPPROTO_TCP, TCP_ULP, "tls",
+			     sizeof("tls")), 0);
+	ASSERT_EQ(setsockopt(self->cfd, IPPROTO_TCP, TCP_ULP, "tls",
+			     sizeof("tls")), 0);
+	ASSERT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &key, key.len), 0);
+	ASSERT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &key, key.len), 0);
+
+	/* Verify data transfer works after reconnect. */
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+	bzero(buf, sizeof(buf));
 	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
 TEST_F(tls, rekey)
-- 
2.55.0

