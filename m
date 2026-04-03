Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC662248A5
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227986; cv=none; b=CJwYGhNgR1QnWErxRVEpK8PQmPrkAskVzm0CtSM7DWA9wo+odpIvv0xKdcmfIQjhoDWewjy7IjLUihAUN9HRD5h1pvPdlt+Ps1saTi/QBiCW1gM/qvj9x4dnz9CjAgroNgzazZHA42EDyVkFiU4SYx4mvO6DgQWtX06gsp59eIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227986; c=relaxed/simple;
	bh=Coj3K5+cTuOJt1kVCCMY5Nve9QgI6eVg/eO6kq+Dt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scYhqI31tAE9iKSrWYKyWge/EaGpbBxcgPUV1IkINt2lfgjNVMUbjQKrKDsaUSfRkAf3uL0iMTwsijnOgKU7AsZBg39DbfhWSwetquNh6urdMqtS8YdQAxY36lAxeKhNbk4B9RZzNWELCQ3im0S+6qCpxJFz5cHg7u/4nse6OMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyqspAH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyqspAH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F33C4CEF7;
	Fri,  3 Apr 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227986;
	bh=Coj3K5+cTuOJt1kVCCMY5Nve9QgI6eVg/eO6kq+Dt7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyqspAH1uJKgTfCq8qbXM0cmq4Gz0utIJjIG1o+3FRtMexjaaf/gjM0I63QDCSFQc
	 NEgw6BCGQSKK5etTaS+Tu7XdXBkvwBjKgrTnewPmA589X19s/zI/hrnzTcHD3pSl5w
	 fACwn7oIsSx6YYFfdMfSTyXYdFWWNSFzKpJLbxCUpqX1W9vW9IbIDOn3LXbA9YtV3Z
	 vzJM4kd4n55jDSXrllvx/DxO2FqbUQ8P0unXUnYzz8nCRONlU3C3zfFW1s4Bz3f0e5
	 7JMQ7+fux+ewrDlTtS/K7dykeaHO2FPHCfYdtOzRpqK6ZlZpV5iCcMMbTyxwg2hgde
	 U0yoUjGCRnnCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 14/16] selftests: tls: wait close in shutdown_reuse for mptcp
Date: Fri,  3 Apr 2026 22:51:32 +0800
Message-ID: <de0d72824e1c7959af470b17550eaabf7c606070.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
index ced333c9abcf..85f4b16dfa68 100644
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
@@ -1680,6 +1684,25 @@ TEST_F(tls, shutdown_unsent)
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
@@ -1689,6 +1712,9 @@ TEST_F(tls, shutdown_reuse)
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

