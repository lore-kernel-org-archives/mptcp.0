Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF6312803
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116102; cv=none; b=hCAEe1oFL7D3CNk4ha4wxZGyNMp6yumQietQ7uj9CaOQ/SjC0FcVAndCi/+wO7TI94k5DZjzRbMCxEJodYQTTpiOf8PLgjgLf+Fs++vf9WkU5zHdfgmgWU9gWVm9bq6NG28KrotpW0tUzOzTILc1meZGll7cTUyOeb7eOMEOJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116102; c=relaxed/simple;
	bh=xoJ3bBSG1SCcawQx4SYTYaiMdeRLt6DS489jattyxn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0dmh220Y0l2mNIbYKe+SZDUMZkUaYHpZu+KOG0Ij9OSkbz2FPbaHLFmy0c0UoTacZLF8mmI2kvvBT1WaiyP/b4tCfYd8YDPY+hgj8WRCbVCPUSBboxutOOD0As+zmN0vIUEBvKiC+RXDhxtqx88m5cNjc0TY1LcQ/HEvfmdNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXYGTiMM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXYGTiMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE4C19423;
	Thu,  2 Apr 2026 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116101;
	bh=xoJ3bBSG1SCcawQx4SYTYaiMdeRLt6DS489jattyxn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXYGTiMM0LukphugAfvMblAnC9VKYOK0+6KkhfTe9bo1L4vlkOxr/FWCCcxobX5r8
	 9c+Cx5UGyz+thy7qnBDF45sgXMeBtGpHj4xiuDrfhQshMjHl5jlzd6TBJsIH4GEiJ8
	 AOY+Nkr6bgM8sdmws8V4XUxrvY9Oj0V62ufxmPdsl6aPgzZraVgOd6JcPhPztiDgRH
	 DTRCXpHjLYEvU+K+FasxFIofjbAXY4vsjvec6JKcRZFxW+2Ud6T4h1i+JYm4yGew09
	 y227t8SbfgPEesVDOFUKxLaxr/HB+OnzJq3SJG4+UGaVAbBAHLDqOtTxUS+08BxNHW
	 Liyx8Kw4dESgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 13/15] selftests: tls: wait close in shutdown_reuse for mptcp
Date: Thu,  2 Apr 2026 15:47:48 +0800
Message-ID: <2990c1cf84bd8789ec8f9bc83db71e76cf4d7b7b.1775115102.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index c3227b718160..f12744b178d5 100644
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
@@ -1678,6 +1682,25 @@ TEST_F(tls, shutdown_unsent)
 	shutdown(self->cfd, SHUT_RDWR);
 }
 
+static bool wait_for_tcp_close(struct __test_metadata *_metadata,
+			       int fd, int max)
+{
+	struct tcp_info info;
+	socklen_t len;
+	int i, ret;
+
+	len = sizeof(info);
+	for (i = 0; i < max; i++) {
+		ret = getsockopt(fd, IPPROTO_TCP, TCP_INFO, &info, &len);
+		EXPECT_EQ(ret, 0);
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
@@ -1687,6 +1710,9 @@ TEST_F(tls, shutdown_reuse)
 	shutdown(self->cfd, SHUT_RDWR);
 	close(self->cfd);
 
+	if (variant->mptcp)
+		EXPECT_TRUE(wait_for_tcp_close(_metadata, self->fd, 1000));
+
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
-- 
2.51.0

