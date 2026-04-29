Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70F33F595
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460922; cv=none; b=ZmyBog+D+B6QFPSu8AxTLGEY2YuCe6mHUPzlHVk4MmjX//GcYIjOABZFa+r0i0CMCY1JQtpnP+SoXqQagnNjE6pZ35GlUsTnCa44t0+hkGrslekkgFOyB3SOdDkb3dbB+LG/Swq7j3I8rVdrtMvm+Xg1NW/+NTNvxnUnWwysInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460922; c=relaxed/simple;
	bh=qgb0Osm6S4pRavM+0JGhfyEGRXZl67LV3MM0GVu9tPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVcYjz4CGFQ2vXmDIEe+WKr8kSDzLGQbhGOkSyHlixH7mpu3fqZ/+XHwoJjegxtD28enL70DwCPp7vvWI+pzxZE9MKD6AtU0UInRHBZizWlq0g9wnmMDuAz+orcdQ6YiqIGvMDRF+NppzMYj/JeQIgsKW4MrwemVoGFsbOwnTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT58BH8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT58BH8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B572C2BCB3;
	Wed, 29 Apr 2026 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460922;
	bh=qgb0Osm6S4pRavM+0JGhfyEGRXZl67LV3MM0GVu9tPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT58BH8Fp53JeT22iKedrnFiJYwxFGz2raPCmF9XAEKlbQR/VqzB5WpWBi0gVHBUV
	 Z6trI/L+rUf6J0HawidGpiWcvM6qeNymkEursAL1RZIgUqz8A6t+h6osrcGC/+RJKD
	 LoqIM5lpsvUtdX8vCtYLCPRxZWfFif+er9MPrVlwW6F9KbmTWlTViX5pziygymp5Lc
	 pesusI3Vh/HR0eCGnN5umq0++zfxSIt39ndv3/7oIJ/tyCmyquTBA502oKZ1qEEfpG
	 54TBjJ9+wtXmGgmcC5phmXPC1b4tEAi/DemdbOv50VBM5ejMO4XtmNcsp9UHcwdaWM
	 pkQZa06yulPvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 13/15] selftests: tls: wait close in shutdown_reuse for mptcp
Date: Wed, 29 Apr 2026 19:08:17 +0800
Message-ID: <e09512f76f16c9f4da3ad4abf1c13fe22484cc2c.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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

