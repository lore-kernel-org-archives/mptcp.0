Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18330AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469722; cv=none; b=b8rF5FsRTl8rERbCKO9aIGLAM1yHKqNyrv8z5s+ycTYh82Sj4b2fLKhx4qqnOow+Nols2Ma4/0AMDzvPo5xiMl1tfd2WsqI0pbyBGl/X9nufQslS6gHlvQaCoJfgVUM1i+dPxG9Jtf+ggnUS53dE5m/D5EhS7JSLPnZDq073w8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469722; c=relaxed/simple;
	bh=uXh0I7JdF5A2waQ6hlA3HXd5IMtboNzJdSIVpsNyyWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmEBOlwQYIqpWF1yoBbNPtyY9EPjzPchHj+sh3yWUQ9Brobn4ROx9C1/0xCGz6nx9Tx1mgoX5LNTyuCcEAsWKNxcjrqlYCvQ4c0C0we44zV5A7pmEPu8nWSpu8ELAlHB0JhWguJBCCleFpEq9js9NfcheEavtZ11N+oUHkFAYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUTVcUO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUTVcUO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CA2C2BCB3;
	Fri, 17 Apr 2026 23:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469721;
	bh=uXh0I7JdF5A2waQ6hlA3HXd5IMtboNzJdSIVpsNyyWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUTVcUO0AT4468zywK6i7GojRUN9mYytfXt+HuFqyCcS7l+bOv2hCJ17iM1I4YBxh
	 aMWEphwYuwZFBXGBXRtro9OVj6yrmrQoGWK+XdEA18X5g9gAGAeYe63RapTbMmYpJj
	 +xgRCcm/C6bch/RyHASEgL5Zh4ny/6cigsEW9Y1+/IMHGO3bmFmu+qY6vFsiDAemOF
	 3k9m48RSyckHNeFFnLoBADlPicWH2pmtl9Kpftw4tblXTFdpb847/4mfUxJyL4BW5a
	 MhbuXImmpgbRyo+nB2ew37+SOPNg1G9kgPmhWqZlJnUNsomAfKTUCMIkdYb2s+TtuW
	 YdkqGzubdfJAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 14/15] selftests: tls: add mptcp test cases
Date: Sat, 18 Apr 2026 07:47:53 +0800
Message-ID: <ced184831757eaae9e690f65d799809ed22cae28.1776469069.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/tls.c | 105 ++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index face5bde8c67..1d30d14efd10 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -20,6 +20,7 @@
 #include <sys/sendfile.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/resource.h>
 
 #include "kselftest_harness.h"
 
@@ -411,6 +412,102 @@ FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
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
@@ -3372,4 +3469,12 @@ static void __attribute__((constructor)) fips_check(void) {
 	}
 }
 
+static void __attribute__((constructor)) increase_rlimit(void)
+{
+	struct rlimit rl = { 4096, 4096 };
+
+	if (setrlimit(RLIMIT_NOFILE, &rl) != 0)
+		perror("setrlimit");
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0

