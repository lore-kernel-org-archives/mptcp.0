Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302038B14C
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027160; cv=none; b=lQJbA0v8VKcsGuXmnwBF+94h5V0gVVaIHQcmWyQRhvzkXHdMulJ+gQM1TGiRnLOYOz6Qq8fqlALThEiAUZfHcwfv0P4vSXNGaXeebD0zS/IBz10BgI3ErW2UlCllONgjtdqFt6RBUTWkwklnq6yW8l7Xac8A5L1miuOasGZfIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027160; c=relaxed/simple;
	bh=qgb0Osm6S4pRavM+0JGhfyEGRXZl67LV3MM0GVu9tPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDb3pxf/JbnMWdAwMa6jdl8C4AzCEZt/YuhZyMk80wbmoAySIl64WPa5Bsgll/Cx5gendqgAOOgnt88BsmwQbGk1HuJg5HmwoqNaVYsYDJJBKHh4WvH/1bV6JAV6z+Vixj620tgFJnhO+hVpqs+isYdOvh9aFZ6Z04KovloJbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGU1V/Ua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGU1V/Ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F5C2BCB4;
	Fri, 24 Apr 2026 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027160;
	bh=qgb0Osm6S4pRavM+0JGhfyEGRXZl67LV3MM0GVu9tPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGU1V/UapkQknb4HrvP095S55coYoZiCZ9RIdUObzmc+dWeRx7OYbZKRft2TMlEUp
	 0O8CGmB4z4HXRo9lZsO406WgpWOWBnGJ1FcRDSAu3Lva+8QJs7WPjvl8wklgXyM1JX
	 MgsNFozO29ZqcQmwJAe7oUdxhgr5YSOAtbKc2nRIQP4LigrAqfY1mT3pa7ub7dKyIe
	 Ko1uz4eUnjuDKEc4XedpWfYIbNXfLUnW8+I/tQ+tLNoi0FfMUpmCdv1x43omQ3I0G1
	 AliOlg7y8o3F7DLG+N/E3VlUHQIxccaeLHyqA0a7i1zlgPoYuoXn4/ycq893svZZRu
	 pkIYt0RaqrPBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 13/15] selftests: tls: wait close in shutdown_reuse for mptcp
Date: Fri, 24 Apr 2026 18:38:37 +0800
Message-ID: <29aa08012a22b4bc6d9400e17bf46be81c669a77.1777026753.git.tanggeliang@kylinos.cn>
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

In shutdown_reuse tests, add a delay after shutdown to wait for
MPTCP sockets to reach TCP_CLOSE state before reuse via bind(),
avoiding the following errors:

 #  RUN           tls.12_aes_gcm_mptcp.shutdown_reuse ...
 # tls.c:1790:shutdown_reuse:Expected ret (-1) == 0 (0)
 # shutdown_reuse: Test failed
 #          FAIL  tls.12_aes_gcm_mptcp.shutdown_reuse
 not ok 14 tls.12_aes_gcm_mptcp.shutdown_reuse
 #  RUN           tls.13_aes_gcm_mptcp.shutdown_reuse ...
 # tls.c:1790:shutdown_reuse:Expected ret (-1) == 0 (0)
 # shutdown_reuse: Test failed
 #          FAIL  tls.13_aes_gcm_mptcp.shutdown_reuse
 not ok 15 tls.13_aes_gcm_mptcp.shutdown_reuse
 #  RUN           tls.12_chacha_mptcp.shutdown_reuse ...
 #            OK  tls.12_chacha_mptcp.shutdown_reuse
 ok 16 tls.12_chacha_mptcp.shutdown_reuse
 #  RUN           tls.13_chacha_mptcp.shutdown_reuse ...
 #            OK  tls.13_chacha_mptcp.shutdown_reuse
 ok 17 tls.13_chacha_mptcp.shutdown_reuse
 #  RUN           tls.13_sm4_gcm_mptcp.shutdown_reuse ...
 # tls.c:1790:shutdown_reuse:Expected ret (-1) == 0 (0)
 # shutdown_reuse: Test failed
 #          FAIL  tls.13_sm4_gcm_mptcp.shutdown_reuse
 not ok 18 tls.13_sm4_gcm_mptcp.shutdown_reuse

This TCP_CLOSE check is just for MPTCP, because it should not slow
down plain TCP tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index bf8ecfdfdd18..8bedc2cde763 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -30,6 +30,10 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#ifndef TCP_CLOSE
+#define TCP_CLOSE 7
+#endif
+
 static int fips_enabled;
 
 struct tls_crypto_info_keys {
@@ -1698,6 +1702,25 @@ TEST_F(tls, shutdown_unsent)
 	shutdown(self->cfd, SHUT_RDWR);
 }
 
+static bool wait_for_tcp_close(struct __test_metadata *_metadata,
+			       int fd, int max)
+{
+	struct tcp_info info;
+	socklen_t len;
+	int i, ret;
+
+	for (i = 0; i < max; i++) {
+		len = sizeof(info);
+		ret = getsockopt(fd, IPPROTO_TCP, TCP_INFO, &info, &len);
+		ASSERT_EQ(ret, 0);
+		if (info.tcpi_state == TCP_CLOSE)
+			return true;
+		usleep(1000);
+	}
+
+	return false;
+}
+
 TEST_F(tls, shutdown_reuse)
 {
 	struct sockaddr_in addr;
@@ -1707,6 +1730,9 @@ TEST_F(tls, shutdown_reuse)
 	shutdown(self->cfd, SHUT_RDWR);
 	close(self->cfd);
 
+	if (variant->mptcp)
+		EXPECT_TRUE(wait_for_tcp_close(_metadata, self->fd, 1000));
+
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
-- 
2.53.0

