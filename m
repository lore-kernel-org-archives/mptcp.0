Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A035E1BD
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788834; cv=none; b=L8c64F2tO+KtBDY/zPF4pChb0tgB25QPH6UnJ9DuOrvaV93dq7lwIge1YCoayJfuGz57WcBOB1OUrZZZmetpFvroS6252my0c0IqXFYUCfFMiQqL9hdT09eGN8NUmXSn2CwNL666AtK2AtU0xfWUFFe2eExPx7jvnrPmBQ0Y4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788834; c=relaxed/simple;
	bh=RkmeBMNlwh+JCqeHMjIF/YizfGRA17AvINVg/eXoBB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngalqm0KcYYSDw4I/3bKdEKnRwX5aQdGwLsN5NU7TWf6lq/U3AMnta6fgGH34epC+G2b495u2Y2O6cftuXwalXlIuAHh0Ism0UDCaJReeRIYaYLanYoCuQX83ZOa1vYvK5a5YBFjqEcBx3D+/yXUJSnYjQgaJqxqnffmfyPdNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l94KNK9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l94KNK9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C9D1F000E9;
	Tue, 26 May 2026 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788832;
	bh=scxwTsYKwo6snT4eoX6wsPP8CnPsa1FasRTG7s5eVus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l94KNK9N8ph0cmrJMk0cZ7X5bnAfkzhOhx2GGaIPAs2ZQ6rMDpTwuJ+MRcLbBcKCW
	 UTLAX+kGwgI19pJgs0daGQ+bMM+d8vRnUUmOVtzmqU7wzs4+p/9ZX3IjA7CWxVgrQR
	 FAbEDnI1MxPgv1hzVF3YxZ75Vu8ROyAWp+m+PsFtOJQVsKaFyBjuQcRSS5pipn4q/F
	 rvf90A0MSC/7xOjRaexjEGYJeE4DWOx+IlUi34sDTkMoQMsGULwpJH5/fE3Y/GS97E
	 w1lh+3fYkt7ibhsv4d9XKoyhta1rdtis4hpoV9J7Tf/7RcJ5sYSnWb1vH1KWOKtJl7
	 /zvKorjEe2wFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 14/15] selftests: tls: add mptcp test cases
Date: Tue, 26 May 2026 17:46:32 +0800
Message-ID: <8b477668b1b9f359864a5f659bc38114f912c057.1779788090.git.tanggeliang@kylinos.cn>
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
index c0737c410db8..d41b81ba256f 100644
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
 static bool is_mptcp_enable()
 {
 	char buf[16] = { 0 };
-- 
2.53.0

