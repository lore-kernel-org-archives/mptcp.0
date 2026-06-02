Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF63624C9
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367612; cv=none; b=O2Xx5MXsjx1GSUFkMVo5SpqySPBjig2TaynHQy1b39eXA9p2ovUhHx8Z3wZZpoWhgCNeZk1UouH8qFahaEB/3YHxNiej/GmdfVFwbnzufwDXnFma7aPG+BQsAnm1+ZXjj68qtd26YxGCUf6Z5KrO/XZKPsDRKRGHuqepm4C6uAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367612; c=relaxed/simple;
	bh=iqV0zSaCNXM8wzAhRBNqtu6qJvXxNa7FekUqOtiqHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsvJ75PYxTc9qG32DTNVbG5i9SiwUSSrzFXWrMqxylCnyGjzH/lg5wPJ0Nr3VkGFIb/CnW0qPW0W2M7Vqbl37z3OxDpoKdf60DIwBuuX7DZw4YbWoUTFbafbKlhsDy1+zLwVWSHt8ZXcJ7OYPcbdPg/pRlWNKD1d4FUrCJWL4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpVz7w14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpVz7w14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0F81F00898;
	Tue,  2 Jun 2026 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367610;
	bh=VqJYDhrdfYG8x1P+nVzqyFokwQq12zc8vWSKIl8WGmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpVz7w14484UwgkEO3/ZzQdmw+B8cFl0f/Yf2zJK2QPlEBNBKeHw0xZCBm8W+kF32
	 hQNftHB/Z+3g84rGw24sutMfv7K6WADPmixfqLcSNKQCObeibGvRKpYm/cVCKZGSPS
	 6zGed6qHdOgj/Scd4eTRrZtku0Fuxs3k47Gdgjft/obbGkwaDW4Hjpgdqvkc/wva7v
	 57pqob/1MpDlq7kzB8o3yhMuAZHmeRH19/bnzKXQukhpV4kTPAurvqM2MjZC/zENLb
	 56WzUi9AjliCbkwdw2wgLe0o0kLdtMGoLfqFbOp4CYvMtOOmyBfz+AlxAiwOVI5nPD
	 IAxU5d11RQc1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 11/16] selftests: tls: increase pollin timeouts for mptcp
Date: Tue,  2 Jun 2026 10:32:52 +0800
Message-ID: <4e89382196a2d87eb48977e6600d78a31813b1df.1780362942.git.tanggeliang@kylinos.cn>
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

MPTCP requires longer timeouts in pollin test due to subflow establishment
delays and slower state transitions. Increase timeout values to prevent
false failures:

 #  RUN           tls.13_sm4_ccm_mptcp.pollin ...
 # tls.c:1411:pollin:Expected poll(&fd, 1, 20) (0) == 1 (1)
 # tls.c:1412:pollin:Expected fd.revents & POLLIN (0) == 1 (1)
 # pollin: Test failed
 #          FAIL  tls.13_sm4_ccm_mptcp.pollin
 not ok 357 tls.13_sm4_ccm_mptcp.pollin

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index fed83918cd9d..5a6c5ee2757f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1362,6 +1362,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1371,11 +1372,11 @@ TEST_F(tls, pollin)
 	fd.fd = self->cfd;
 	fd.events = POLLIN;
 
-	EXPECT_EQ(poll(&fd, 1, 20), 1);
+	EXPECT_EQ(poll(&fd, 1, timeout), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	/* Test timing out */
-	EXPECT_EQ(poll(&fd, 1, 20), 0);
+	EXPECT_EQ(poll(&fd, 1, timeout), 0);
 }
 
 TEST_F(tls, poll_wait)
-- 
2.53.0

