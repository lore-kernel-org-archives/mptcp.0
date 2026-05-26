Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AF3D88F1
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788831; cv=none; b=QLhH2DNshwBRMXrRV04lptcwR5KRKQFOb5XM9BQCYYjm9iXidSqSczS4CO2oiaD3VZu1DO+/dMA4/UQJmic/BpEOOQgKJDKoIN7ijUVf3YA/sTnlJlWf7YKx2H/vj6OeCpE9W6kZsOoEnL9mfcle1oakL3Ae7UnWo87qR2fp4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788831; c=relaxed/simple;
	bh=AqoiPOAlkAjZjWqeL5w3LjsUV5pqNuJTkZWeuPLb8WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW8niS+Lys+gPcV+EFVxo2rvv08W1Af9bNswW6WM4ImvsWceLGU+o7zBX3w36YXM6O4O1b5c6PA4CbAObQOP8z1u9FZxv7tSM94VrLZWw+nAW5GI+pe9H9+BfpBZ3QyDyfzpSZ7z1C9cGTuj47WroPxIuy358kAOrVASzylltIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnsgvj7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnsgvj7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4DB1F00A3A;
	Tue, 26 May 2026 09:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788830;
	bh=zOVwjOqcoXaYpuFywH410o/i/y/POoysCDkgjzNsFK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lnsgvj7fW0fcFxRQG5TBXRHqbxAJ7acow4yI1Yqcr29ccaveqiWKL7gYEd/h4mr7V
	 pAEWP3f4+KnwxyfARD17phcVIrfQmWYZ/2qOpG1HHPEtJXXQGUtbD0DIL6JfIkASj/
	 KN5lbtf68r5bHslkFk6NozR+sVYyrlr7WkXIQkmy6M2HnOLnYL7eWomEffai4NtWIh
	 P8C8ylea/K+I3pDgLem5D/n4FSxmjeJDlUHjfem/8KTuxHgCcMbRpViyP2PMb5obMH
	 MBkemrW1f60WIdAf/7/h9QAWSkrx6RdeHohmIecAwHmGDhWjvcICfBg4WnyzD7wdmu
	 hu+schYrO/8pg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 13/15] selftests: tls: retry bind on EINVAL in shutdown_reuse
Date: Tue, 26 May 2026 17:46:31 +0800
Message-ID: <3496be93d34ebb1004e1a7c685189ada9648aa2d.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
index 1d2a5661785f..c0737c410db8 100644
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

