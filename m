Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D14264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971606; cv=none; b=Q+999EmCIfnzRDkLhqRPozQ/JHxPWedLw2uOd/HQi6BcxYZ9BYnDP+ReYCgWhKUnrhSUYAaHdPhVSeGfHAzpiR0baouB6RWhS2tY33/dHX0JF4pVq+5wE5BhUsuHoQnu1ZbqsKbExmF1+GXUMTueaTjdjm7Nutox7mBl96ShFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971606; c=relaxed/simple;
	bh=PSHYO8Pk8v3Z8MQAJcqJEM59hDIv33+Oxa/ecwAVlYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrsLkWNYfZrviV1ahq1wW6GZcGPRZz+FIVgu586Sm1Xisf0iK0apDUx2ZV8vEXtcFDKjE86W2tAtHFlhBlMrNrNuBqLFBpgR/F0G6aFtqW7OFIFTxEHdZq613WAL7pYM+2+dC98LLcvyWyElTvwUYz9XHOiMUnKM2fowMzV9AXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVaEmSx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVaEmSx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2701F00898;
	Tue,  9 Jun 2026 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971605;
	bh=S/Fkq9y3NgcGU2ulT5l9+cox6coWokFGlmb0jnTr0WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PVaEmSx6eL8bFFU8PsopvivRDAGVHNuq/+SHpqyd7YH7v37eB59iWv5eFAR0vIlvB
	 zIDCnMa0NrTknCgYTdPkqfGkOR2a/Skl9EF8uL0OmB1v7ZSG+fNJO9rTRjesYJA7yW
	 CFux94dpBgmUu1qZWDCMDTFkgN79j96qYgZxcYGfzEFANr6aXMWK97G21qgudWruEb
	 WdteCHbcw8S8ya6ePJ4q6ZoCmfzDcg6jmeOMVfQnufqV1KVRKkpb71Sx0mAN9P/vok
	 gO5BAcfhTRTMgi1brrz6zkmM3JdRbi18Q27MQOoh0tzYjDamT1Bv5/dy6zIM2IIlS0
	 hHkRjZqcmTjYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 19/22] selftests: tls: retry bind for mptcp in shutdown_reuse
Date: Tue,  9 Jun 2026 10:18:45 +0800
Message-ID: <fe705751a406fd84e4c60cff4eb6ecf5478f1fa6.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
2.43.0

