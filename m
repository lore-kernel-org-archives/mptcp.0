Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CA2BFC85
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460930; cv=none; b=cLbuNY600uYBq2f3OwERJKyhQJUqbYQJFSo+9ZMdhdnLcR7avpSewR3xunkbzTbF2IxQXX8jaH9WkCCKjg1AYULs4tMu0l/pv3B1f19aoE3VkVn12gX59ahtV/K1ulV2SEmJVK9nBg2/gKMWNgh9VtPY20TMQJB5sHJoYI+x89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460930; c=relaxed/simple;
	bh=53cLyz0shDwlj3oIo8fULuL++tU6/Z+rkMHtn/yeNWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZPZ8HmhlxsX5hTpePSWRKDF3JMobajReYMt5T6oQwPXqfCNv5URYKvSTwsQmZtwVykvBk1k5QTQBSH2TMgWvRwB6jlsAjkpQWdOozdU2VufeWCxX3wxtwEUw+Lj4wI3sF0mgjrpZ92Z1KnOJEV1mz74vCdbRpvbYQBhMTVrl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebpWmtol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebpWmtol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7029C2BCB3;
	Wed, 29 Apr 2026 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460929;
	bh=53cLyz0shDwlj3oIo8fULuL++tU6/Z+rkMHtn/yeNWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebpWmtoljICipU1llT0ciaEjQV5YcM60BSwYrji2fbP1kbTXNaissU6jrnYrgkk33
	 QNcAvxk24wOIdldTlJqmVSmqBjRPRJRnm8Id0A7opiYWKlf5OmFc8Ms3bIcmvn0HME
	 BKNwqBVbi73rm7dr2zmgWzQBOSvBwhKtNE9ebXmSHKZKclIuunzI89eGm0TKvTjJh2
	 z8rG5j/NXbvkep/DVPY1zkjWBt8GxfUOp38QC+qcVSJqD7esHrhKWr+XvkGMjYBXH0
	 gqbxqNzPeHGGUZX7e4OqaPUvOJ9ffE7nFCs6CZRYCF6nbO1s3jscYz9rvR4iv92ato
	 apd/dQrQEMrLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 14/15] selftests: tls: add mptcp test cases
Date: Wed, 29 Apr 2026 19:08:18 +0800
Message-ID: <9920843ecf736737e0679e3e28e68e88a201cff1.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
2.53.0

