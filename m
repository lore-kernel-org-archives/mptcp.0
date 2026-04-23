Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A91DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926123; cv=none; b=uvsR0+LclZOl1tw5cdwkAMYJ8clN4LvGm9W/5BybI8XPdWLUnwTgCSfpK2snCxlyGQ8X8YpYOhqcyccgmfZCS2jx+Pe0k+uqKGTYj5hLeExzOeC3BlDUOtBlWKhJ10b/VaLI4FVcpZUY/TeJ2bM2zNeANf3k4gmIamkhaZ8t6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926123; c=relaxed/simple;
	bh=VmQM9a+zK9JXLT/ZqXNqPpS4ogJdqKXImO7k8ArmbHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dko7hIIsGPsTKdkcDYb6Y2FJQDfk+GWz4K0b8hDbyLRcx8q+u1LFbLNTAE5TPn36E2PzE3oAAUau9GC5o+HPW7VEfArB+djm0Xv5XnENMPDMiwlW+MYon8V2/NMqTr6Tzpuv3TsMrPQRJwT+0cdoQEKTVT2ibbsQJqtwy08vED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAHsEEw4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAHsEEw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9682FC2BCB2;
	Thu, 23 Apr 2026 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926122;
	bh=VmQM9a+zK9JXLT/ZqXNqPpS4ogJdqKXImO7k8ArmbHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAHsEEw4l6N80Qwi5P8WCjYE8RTl3+/7Bpi/ukmmOzXfz46ZME6MJ1k7+bBa5HZRY
	 SLF0tDxF3W05LpeD/p+dl0aycum3TUBj4D1PnSgxV5QLuE36TJsXUNuZ358PGTWghT
	 eDwE5OCmTCzoVWPrL+hTTtfi6KKLSbfj/3lZSPzBChZlcFOhrOCe4kbWJEe9vRxDeI
	 w5o287ZeiFUZh/nKI20i2MeAw83o2wNhTPnJdl2ec8YA98jmEuTts0oze5LFF7YcqW
	 BVeyljLnEB38tFScRlcQqTZBTjTFvWByVB/yb8OSLkXJG0ND7+UygjenFCH7BTmskf
	 Mvmf15uZDD1fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 15/16] selftests: tls: add mptcp test cases
Date: Thu, 23 Apr 2026 14:33:08 +0800
Message-ID: <c36073e748c9d4add96ed8926193b56a9f78e72f.1776924682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
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

The default limit of 1024 for file descriptor values is too low for the
newly added MPTCP tests, causing accept() to fail when the fd number
exceeds 1024. Raise the limit to 4096 to avoid test failures.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 8bedc2cde763..c7922b9f6812 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -411,6 +411,102 @@ FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
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
 static bool is_mptcp_enable(struct __test_metadata *_metadata)
 {
 	char buf[16] = { 0 };
-- 
2.51.0

