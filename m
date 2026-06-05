Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA63BAD99
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622691; cv=none; b=tEHZrj06OASzrz2feDO0mU1cNIRQCCA4HX5rlId4431QhZbPDBhEPEs7Bc6EtJuwOsNFDKyT6oA/FCePiKMITjvC8IzC9aOcObkqbVWh0ojL4Z5Xc5XwkEMMRcN77/kHqCo0VQy63laYCvM7G2Q0sJmi2yQTMjRJgzjJjD+SJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622691; c=relaxed/simple;
	bh=82iGtqlHP03QmuWGf0VaMBINawAW0bVgPGIo/n8dCzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpZBacZQwj/yzNLrlGD7fi/e6zdpnl7rAwvzJArrw8k1CDQ5oFL26km8ymx1OaqZ6wleZ74GX0MjzvwHduvqzfKyIDkdYcIDrlQRkbi2F9aP+EwZTWvkmzxYgzJ+YrUso8jZKagtWEQ6CO8PeM3oaqTGHkGXW/9gwSY+TPmbeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIMtrIQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIMtrIQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA921F00898;
	Fri,  5 Jun 2026 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622683;
	bh=sD3L1RTJjtvETcJNDdakdqHvduVfdS94pHrk3pmxhy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oIMtrIQboxsBJDiJeTi0JBfLiMBGjDB4LJ5iRsn7ja2x15M5Wz0WRG5XiL6yAHH++
	 A6SYNNueLeIbk9UvcT6EmznUdkeAaOo0+on3uq7wqJTT/t2/Z4Eg4grQJF3ElKuWIw
	 +BWmpu4Ie25oWxGGw+DZE5qn0ikm4KtaiMFhk6yQWdxsxV1beMRhkGmZb9CBWdZRk+
	 kB2v4js8XRY+CI1QWudYbXo8PsAA9U14dpo8by18ovZA3DNpPUo1FwdfTP1WbY1QAw
	 RnpNwBeUhcFxFYg43zdqQze2Jc3hWe2N4EpDrCKPZcBeDUXvqosaa726/UVKa7cUJn
	 EgKZoxCLcpxbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 17/18] selftests: tls: add mptcp test cases
Date: Fri,  5 Jun 2026 09:22:57 +0800
Message-ID: <353562249c2b1b90014f3ef08e10bf5f5bd3d628.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces MPTCP test cases for the TLS fixture. These "mptcp"
variants are configured to create MPTCP sockets specifically for MPTCP TLS
testing purposes.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 6f51da27ef1e..83cdb06da587 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -407,6 +407,102 @@ FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
 	.cipher_type = TLS_CIPHER_ARIA_GCM_256,
 };
 
+FIXTURE_VARIANT_ADD(tls, 12_aes_gcm_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_AES_GCM_128,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_aes_gcm_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_AES_GCM_128,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_chacha_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_chacha_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_sm4_gcm_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_SM4_GCM,
+	.fips_non_compliant = true,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_sm4_ccm_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_SM4_CCM,
+	.fips_non_compliant = true,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aes_ccm_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_AES_CCM_128,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_aes_ccm_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_AES_CCM_128,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aes_gcm_256_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_AES_GCM_256,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_aes_gcm_256_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_AES_GCM_256,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 13_nopad_mptcp)
+{
+	.tls_version = TLS_1_3_VERSION,
+	.cipher_type = TLS_CIPHER_AES_GCM_128,
+	.nopad = true,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_ARIA_GCM_128,
+	.mptcp = true,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256_mptcp)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_ARIA_GCM_256,
+	.mptcp = true,
+};
+
 static bool is_mptcp_enable(void)
 {
 	char buf[16] = { 0 };
-- 
2.53.0

