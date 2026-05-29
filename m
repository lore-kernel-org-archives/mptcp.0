Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA23016E7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053289; cv=none; b=b4oTzPjQNKhC3FjmaG5pMO7MkcFaNQN7fFBpoDZIUMFPGObU3momG20BlZSo5NWLYz0FlZdypNa49+ZNSk9eHv3A7KA7dqhDp+OJbK7js+6ZZ0mpe5jA3x53QtLLr8I/tAuTCzxjUdatTVuZGzYIJZwo8xK4F1Cvbi3d0EPJnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053289; c=relaxed/simple;
	bh=tObZAo0LS5jMzz2TR2El2jbzErgrvVlRvmtiCiaFxJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg43XECC4ZotqvUuByqcX2ApLycX2h2P6PCkqQrLQ59IV5beiwFKqYjt+COHDWKCF+BinqQW02Wihmkk/u4FoeVjTzjwsLgMmy6qURzM2jP58my2QvU3/+oHe3U4QvihPw9dhpbkpKIWBO9g+SdFiJ+GThqXGVmESRW7XKpKctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouyyxG5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouyyxG5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A781F00893;
	Fri, 29 May 2026 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053288;
	bh=KBTULavDNo0rDYPoW2s6IkaqCZ+B1f0yBJdFI74edPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouyyxG5cR743bYyKUngIea8qAvSUyQY2+fFffZmlWBltVF7Te1qV6v0lPeylH1LQN
	 CBTJ3GZeLlLC7UrP/UI6RMXe53nkQpduDouBTZ6xXUJ26uMOGkV9Ab9auXm0NaBrhX
	 Gtf7oq/fHw6xSb1UxUqe2uVdOLUqRinrok7Im1jGMAvDdSbTcWR2ZmpThWo81ZZ4iV
	 IEVXLYAWdG0sbfsDLx9dMMFQnmMLeJNo/6HciGkk9ibXQoN3kuv2rood8yDieDmy5+
	 Dl7JQt58C/NY0FbbS70YVGmrxAn29zEA9sNrYcUmsiNrVWh6pHgalkyE32unpmxjMZ
	 DTuYAeDr9WI7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 17/20] selftests: tls: retry bind on EINVAL in shutdown_reuse
Date: Fri, 29 May 2026 19:13:59 +0800
Message-ID: <d7920f37c8ce1cc0449cfe438195ef5f2f2efee6.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In the shutdown_reuse test, after shutdown and close, bind() may fail
with EINVAL for MPTCP sockets due to asynchronous state transition of
the top-level MPTCP socket. The subflow may have reached TCP_CLOSE,
but the MPTCP socket state hasn't been updated yet.

Retry bind() on EINVAL for up to 1000 iterations (1 second) to allow
the MPTCP socket to complete its state transition.

This fixes the following intermittent failures:

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

This is only done for MPTCP variants to avoid slowing down plain TCP
tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 64aad661a1b4..4ae7505846f9 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1744,6 +1744,7 @@ TEST_F(tls, shutdown_unsent)
 TEST_F(tls, shutdown_reuse)
 {
 	struct sockaddr_in addr;
+	int i = 0;
 	int ret;
 
 	shutdown(self->fd, SHUT_RDWR);
@@ -1754,7 +1755,13 @@ TEST_F(tls, shutdown_reuse)
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
+retry:
 	ret = bind(self->fd, &addr, sizeof(addr));
+	if (variant->mptcp &&
+	    ret < 0 && errno == EINVAL && i++ < 1000) {
+		usleep(1000);
+		goto retry;
+	}
 	EXPECT_EQ(ret, 0);
 	ret = listen(self->fd, 10);
 	EXPECT_EQ(ret, -1);
-- 
2.53.0

