Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C293BE14F
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914961; cv=none; b=SnovGQypB6KGFX/DrCLnNk/h+beMK/DD8DVXYwQevBBlwdwM+HjydJunOH12+i3r83j4E0/++OW7PaQwqzZ2EGQoS6LfFBPQ3bfxj5nxgyLBbAwQOqY2rnX94vYRN5gsk241uFoujT6adP1pcA7cfCM0kPVjg+nz5q4T6KjfClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914961; c=relaxed/simple;
	bh=yqVyD0SoK436qWkgcDSH/RKHOhV4qAzNeI9w8pbCgHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTZOZVtUFtPgpwKgDyK4cTpBkw7orESVi5JlPn3Zdc+iI6OgvyF7iuC7ZmlOAl7f0acjAQk6Zg6hLRvYnkILt4RCPXlDro/Crlt6Xp1l079+e/Z6fJNhAAdT9NcFB0jrTJPGSUxgPZc6FL6y3lyruVlEmZFIyEBKdA6RIaSyuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJxKbzd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJxKbzd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E4C19424;
	Thu, 19 Mar 2026 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914960;
	bh=yqVyD0SoK436qWkgcDSH/RKHOhV4qAzNeI9w8pbCgHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJxKbzd8ysU9/qnSqQLxWwGPGmiOIbO1aOLkTjwyM622cgOsXIos7fCpXsozwW/VI
	 Tcd0Ntdp3T/h5sksGY547gCLuq0Vf4eC0+I7cVuVM1dp/sX5iRiiDS3W5sGCSs22pd
	 OiQK8hAYIdbSQw1ZP4Xulr6oHleXN0kqwCijBU+csEC3pSpp9fGD3pGcgKNb/fD+q9
	 OicZtfTioDyAcmljQT6neV5aEI5NGg4LvZWWajJ8AcbMZLIT3oXS5fnrXHisunIHH8
	 v1eBZjw0yrzO8MptG9f6noVpp750ZpUEB1+QN5/Bja+eEsXoxmSZD1x8vaCctjaM9I
	 Gzo0n/LVRIfRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 13/15] selftests: tls: wait TCP_CLOSE in shutdown_reuse for MPTCP
Date: Thu, 19 Mar 2026 18:08:46 +0800
Message-ID: <f09e80d79c728c39c53d93b3239ea008af6ce531.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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
index 534c4ffd8fd1..45cbdfe8aed4 100644
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
@@ -1671,6 +1675,25 @@ TEST_F(tls, shutdown_unsent)
 	shutdown(self->cfd, SHUT_RDWR);
 }
 
+static int wait_for_tcp_close(struct __test_metadata *_metadata,
+			      int fd, int max)
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
+			return 0;
+		usleep(1000);
+	}
+
+	return -1;
+}
+
 TEST_F(tls, shutdown_reuse)
 {
 	struct sockaddr_in addr;
@@ -1680,6 +1703,9 @@ TEST_F(tls, shutdown_reuse)
 	shutdown(self->cfd, SHUT_RDWR);
 	close(self->cfd);
 
+	if (variant->mptcp)
+		EXPECT_EQ(wait_for_tcp_close(_metadata, self->fd, 1000), 0);
+
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
-- 
2.53.0

