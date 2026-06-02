Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76876360EEA
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367616; cv=none; b=nw97pncQR9utyR1NvFuaZwAc2MptoAQ61kUDi4D8+l3sLBI4xsJrZ9bzxjlR2F4m09b5agUaCutPSqWCwqOG7sMml9sliF9nTm0XyNIq9wIWh+pwaBqOqrWk+0Gwr7kEw+BiZwhZCEqUegJ4E68+67D3zvISi089uCxRxK0LUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367616; c=relaxed/simple;
	bh=x++q9UrygcGpWHorzTl/tCCzY48BIP0kiZ0SE56jM4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvyQAxgtZjHjbo3U9zU6hVeLA5rSSD98A+8zEmICK0Kfg2023ZwxsLM7sNVqxHd4/SWRa0ESkNjOsIyzzZ3dZhVgegbUcZT2460llKxBTJfe1UmbK2zPNIQcx1lFaeBFoJfjp/3aPGrhbleDVouYrT1x7a0QBK7vgGFmH+hsOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxLfMFZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxLfMFZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1011F00898;
	Tue,  2 Jun 2026 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367615;
	bh=fKDRQclkJ626atSWNQktztDQZTZsZwJhifMsbK6XASA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxLfMFZ7YOM6x/6CTgT6cGha/neZTEt0XT5csdO1sxzRE2mTPGhFUjeggLCW/BUqz
	 Jpsnj/9teML8gtLL7YWvz/1lb52UwqGSbJkFTiyrAsS1zNAj3Se1zZgy8ujeR9ghq6
	 CJ3x9uAKmsh4Ccccd/wkNWGhXycIznSGUdGQCPoXFgL+HmbyuTPMXN1Uk825ouDNUP
	 XIFI7T8wTtg0ndvEyaq+cLz7Jjxuk56a8XBFiKWqAvSUjSqv/YRqTTcTZr74+Zy6Q7
	 jCrs6SYcNApTUScD6nxJ6/PXB6lV1D4BxC3sxqrDM0MKO2Oj5x1XzAd/cFsnAiMlI3
	 wNQvYmGq8Us5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 13/16] selftests: tls: retry bind for mptcp in shutdown_reuse
Date: Tue,  2 Jun 2026 10:32:54 +0800
Message-ID: <4696b2cf5ab78ed77f6a1b39f99c922bc7a1b868.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
the top-level MPTCP socket. Retry bind() on EINVAL for up to 1000
iterations (1 second) to allow the MPTCP socket to complete its state
transition. This fixes the following intermittent failures:

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

