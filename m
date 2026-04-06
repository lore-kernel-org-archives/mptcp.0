Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8DD883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478024; cv=none; b=kztEH586wC4zoT4AuwN8vn9d3OQxUREMmDUJUQQROU4aqT4/iK/2ag1arw8/SledLnuT5AKIshTIVZCL2uj3VJpulhjSboikiA64oFTBfHadqQlqh20gzAOU5tuZMJnVyYyPzlrccyp1cIa+HCzt+L/Tk5PVfpktnP5VuEVEtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478024; c=relaxed/simple;
	bh=OD0wW/fu4V6t1lZ1xY5BRcucZeJuFwOySEpT0FYgpsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XU7TDzNghQgX6P/FRmi0gJ+LZXYn0xZZEx9xMnjEX7GLNrPHFvdDFPCJlYNaDaKukyyR1HOnzRoXKX3jsqTlfWvGr99iBXc2/12K8AUMI3exZgCY4P5axH+5LyeyJribGM68M5UGSyL5Sq2Rvz6VQuy3qSSbW615zcjkw610jtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujH3ct1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujH3ct1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1A8C4CEF7;
	Mon,  6 Apr 2026 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478023;
	bh=OD0wW/fu4V6t1lZ1xY5BRcucZeJuFwOySEpT0FYgpsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujH3ct1/4VJ3BY6p5VxGWRu4cso/S/aMFVGK1hdtxbcjPcLzJq8DL2jVqyZEicdOb
	 wb4301tcXpfEwm8irzuIQ85K2mo59GhxrdE67DajZ+sryqNpvlDTxOrVIqJkWqUJG4
	 5PjiM9USkxjK6k3/i83dT/8m2byCK09y+dRsMV+77TOHYYgIhqz0Z/fhq4qoba1BBX
	 NZ1e5V/nypHCtTk8hsU6BOvpYIRcU7CBQgahkm9T6k/l6tk1pVoyBbAqqvD7PIRBpQ
	 wY7AnUZ4V2hqkOjaHn+0qDP/oiYWw28KM/jRRcBSiERR8FNKJq5qLwyjkpYCjsHVY6
	 wiCf/2HKx3d0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 13/15] selftests: tls: wait close in shutdown_reuse for mptcp
Date: Mon,  6 Apr 2026 20:18:53 +0800
Message-ID: <1b3dc24d50d6df0ef22d08428542c8dd23a4e050.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
index 8bd5def6f3ec..face5bde8c67 100644
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
@@ -1699,6 +1703,25 @@ TEST_F(tls, shutdown_unsent)
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
@@ -1708,6 +1731,9 @@ TEST_F(tls, shutdown_reuse)
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

