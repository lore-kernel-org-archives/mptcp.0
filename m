Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE403AC0D0
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960471; cv=none; b=j0hIMAgbLIK9mSUgqiZwemjfXftS/1YfKiX01yoMi/PvOW/8Gif82SaMrv3igZt5q6jaiQyA17uo4l6iE4m2t9KJP+aUAVL0J/0Wka+ozs3/c6aVbrw7IFtapnJhifwZKhNV7wBbhl9APTQEk/WdCOFt+hX64lPZhRFgWPRwqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960471; c=relaxed/simple;
	bh=tObZAo0LS5jMzz2TR2El2jbzErgrvVlRvmtiCiaFxJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beWGIdlqDHSM1tUngq0Tpqt7JnV1EvJ5X+9kbF61F3sP8RO/0KZjmfX6kvk4ESYudzMBxO4goMaqVRsTYp7AmB3Gv4DQ5tuYvDQ71TErK1jAMR3bJbnFZ7/tA4f38MBkqNXlBmPdFrByIlDgs1DkGCDbIifAh+J6de6L8IW5iqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvON+Vl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvON+Vl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60131F00A3D;
	Thu, 28 May 2026 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960467;
	bh=KBTULavDNo0rDYPoW2s6IkaqCZ+B1f0yBJdFI74edPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvON+Vl4ra9CM0f8314S6bCjHr7vVROvDkbFjdGvPwWdBiW2alxniOWkXCFfnppbY
	 2nhZgURVyJyBPMOZ7GHg7gHcNQ+M4hpNIo8H0WulXtEfyLXwxvITmGGNkxk3XwRxh3
	 Xm57CYOjP7TWNX2C7ZFei2EhTE+7BSg+O7Nz2jdfn/YxQw5yDO5ljv7n++C3EBjwoU
	 N6pUGev2Bg5F+QL4OaPihqsVOqgwMvCTMHnAvrCvtUz/ocU5HMy8TBwYiOGqHHfB4B
	 1VV0TbaA9OyWiZcPeYJNEzjs4oc57wRAbIADb9TDZucLzCT0EfWBRPYZMR1m7GKb8c
	 Hc533R4cFbtiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 15/18] selftests: tls: retry bind on EINVAL in shutdown_reuse
Date: Thu, 28 May 2026 17:27:06 +0800
Message-ID: <09e714c34a2fc6ae41e23a800532b73747f6a92f.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

