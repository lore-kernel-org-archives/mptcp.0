Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD39318EF6
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478026; cv=none; b=G9FQtAw6TqnVhlCvl1GqWPKKdPzykO+Oh/Aiqs9EPWd66a2alBbwh6sUnfDnq0l7NauU2Tix+o3fXMkYcVLY4UzEsMky0q/UOtJGbEkZaOeqKtYyCa3GLvSD6RvsN6R5cb0ZtQTrX/nQRmjYKMEeasi18WMPfiRd7bjoShTVRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478026; c=relaxed/simple;
	bh=6o1g4hjrrojzxB5QfGLLkS5BJTHSZlEMU93AmfZCd+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMh2/BGlub88nNb9qMgys70ZdYTPZl+x+P8Rc/xu5RtJJoYDoh55iY3w+StwknQdd/pdNYOQ1EBec/KA1GEa5GpSTnwz25Wd1jj9lAOeHZYFBcj8yd5nIXHWSDiWw3tFRpjSh7YH7qbFujAqNs4psttF4XwBvfinH596w0/bumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSbQRHjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSbQRHjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E19C19425;
	Mon,  6 Apr 2026 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478026;
	bh=6o1g4hjrrojzxB5QfGLLkS5BJTHSZlEMU93AmfZCd+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSbQRHjgGAm3lyXU6d9dRrpXODySrbx3+2kKVXUQl0m2vz6vDhOGOer28vKINjPbI
	 eP+UD/0X0KFNmH/rwF7J5ZK+xkdlxBhRae7cO4Un4dHqF7O5h0c7UA417UK7BReZUF
	 VFN6qIBGsDN8COtPUcgHZVEmFPAt3LdhfLzN3o7Jf0yEZbIAYGz1Yeo6tDeGCbIeLF
	 NYKnpBCmNJJkY9HibPrHhbRw6uI37eGrCGPff/LmfnQldiyO5P07P1MGseMzpr6WQL
	 s63O4YdEpJ8/0QDLHtQmO21AqECZzQ9cnc+HtkLHsR8FRTdX61meILLesZ8RNHVIhA
	 VlOlLZGk1IY8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 14/15] selftests: tls: add mptcp test cases
Date: Mon,  6 Apr 2026 20:18:54 +0800
Message-ID: <012d02ebb62f707e1e9789555ed9c71c90d3aaf4.1775476921.git.tanggeliang@kylinos.cn>
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
index face5bde8c67..a25961680b5f 100644
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

