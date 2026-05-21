Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BD1369990
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355836; cv=none; b=HRw8crILDjhwLCm1hR/p6gz31udcjhkjyNdrG/XWljko0/93BgYd0wNFTOuXTRBep6R2WHhQ30PVlaOaRkYkUvI5lSJeAR2VyT5vlXzTKedH4MQhAdQZtsuNct7SetB8vV3J1dOwzt9/XHI97I2uftOU74i0m9jW6GotVAROxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355836; c=relaxed/simple;
	bh=di5qFRo5ayNBzXYinj8icX33yh+Rs9A0TnIZ/nvGZ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeJu/fqlobgIP2zaOwbwvkU7ngubb6ifpx2hB7wSdZStnwuolsW2+UeFmWiagk/Pln5x9+Z5eZFYxRZDo5MILiQd6sVtnV8PhRMGxmqEA18RV6+DUvFx3kWLg7GZ3fEBqBkT7TgyoqHzO9RRD4ylz9gVStzKscQar3kowctgXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyCnJzg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyCnJzg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8DD1F00A3B;
	Thu, 21 May 2026 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355834;
	bh=rQ6ILHJEcxdGfLlAydq+aX8qlH+3iXptwWHurZopQ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyCnJzg9K3YJ6qdgpoBstYxleB2aO+z5z1qsz+xzfdnht5MCvXX32dRDRk1mVV97a
	 Ss5zpqIZ2/lnilNI2lT3ouW8ncqPO6LuZ9hS7zBMLins5vHYMHhiDF06Ob32Ch55or
	 Cm3H/x7W1RejYTPUyW6YgoqHWdY/ZWmIDAryB4t6sUA244x5sjcIEzCFqnnJhAvNuq
	 HIXfHp+EEIqHw3ilKBNLPuXY6EVacgWhBgHNFAMaNI3Mt24PiRQ1dMccjch0XGoqnu
	 y/8JFec9JgF8n3TMsEBd9u7WOsfYslzv9qbLbvhcpqSU54N4aWCNNfYuzoGZs4SEkT
	 Wdm3YlVGpBINw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 13/15] selftests: tls: retry bind on EINVAL in shutdown_reuse
Date: Thu, 21 May 2026 17:29:51 +0800
Message-ID: <c99eeffd98ce363c4d7d4485ea24e3d57e81704d.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
index 0a1b0faa3957..8a95235a7ae8 100644
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

