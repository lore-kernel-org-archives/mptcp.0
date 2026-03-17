Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773435C1B6
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738831; cv=none; b=HiogSezpOeOu4xEu+SthCDXdkt0jrOHZDs5NcQuaAqhtMO94K90dP+P6JKC0Ym2+gsGteaiDPtzgZshaFEGhmuKr7GdxGJQC2eqlV5NR//sNQnq5vzDsn0gsgJAyAhgdj3Bc9qPCQErsK/GmmNAD7ZjHZaY70hR2CgYPsMVqguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738831; c=relaxed/simple;
	bh=Ws6RugjMpk0QczTIYqDOQId6ELUadNjUojJMRPqKSWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqeO5+8TcyIeHIin8X8KHKMnx4vrOo0CJWku8D7HCoIYzywVthNgKqRJVFEcyEHbrMNAtMZst3rouePx7FSbt+Jkuvs31C8E2adOBv4X9G257VZ2nq5tADK2jOAdtKJcOiL+CqzOvHnInkdRNdehj8gCepqGg9xq5+friiTeD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKW976fg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKW976fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DC4C2BC9E;
	Tue, 17 Mar 2026 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738831;
	bh=Ws6RugjMpk0QczTIYqDOQId6ELUadNjUojJMRPqKSWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKW976fgsGw4RKfLRCVYL15cICuxxFiJPS8HHLqDXw2x1MJz8SE5toKrCDeeJhfGM
	 otuHluFLpL9ggnc/1fqpwFHJ5dYWcXJ5xPz6Kn7O/Rex+lhnf34n0LtCfAVv5LTQUr
	 CILY8O40ULsB8bUbOvItVPtpjujC9IhUyh8xPQgXA6LN3bjdddQuAoIDOXK7jiBJn8
	 7OlgjwAuEQ2aBf3QI64wOCpBqPMElT51muPQKe0VrVJ7dDnvb3seuNcwkgw/kldQxv
	 u9kX7E9iD10r5+BWZiUiUWQoUXdeAKV5mMus8nChQOcHP3JUY6nMfcZPlkxBwEcFs/
	 pcv4QCnHAYy5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 11/14] selftests: tls: add MPTCP variants for testing
Date: Tue, 17 Mar 2026 17:12:47 +0800
Message-ID: <6c3d13576a6ad7b201e30e20174871f04270edb6.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To enable easy MPTCP socket creation in MPTCP TLS tests, two protocol
parameters (cli_proto and srv_proto) have been added to ulp_sock_pair().
These are passed as third arguments of socket(): 0 creates TCP sockets,
IPPROTO_MPTCP creates MPTCP sockets.

New variants "mptcp" are added both in FIXTURE_VARIANT(tls) and
FIXTURE(tls_err) to control whether to create MPTCP sockets or not for
tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 37 +++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..539a2bbea103 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -26,6 +26,10 @@
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 static int fips_enabled;
 
 struct tls_crypto_info_keys {
@@ -109,7 +113,8 @@ static void memrnd(void *s, size_t n)
 }
 
 static void ulp_sock_pair(struct __test_metadata *_metadata,
-			  int *fd, int *cfd, bool *notls)
+			  int *fd, int *cfd, bool *notls,
+			  int cli_proto, int srv_proto)
 {
 	struct sockaddr_in addr;
 	socklen_t len;
@@ -122,8 +127,8 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	*fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	*fd = socket(AF_INET, SOCK_STREAM, cli_proto);
+	sfd = socket(AF_INET, SOCK_STREAM, srv_proto);
 
 	ret = bind(sfd, &addr, sizeof(addr));
 	ASSERT_EQ(ret, 0);
@@ -232,7 +237,7 @@ FIXTURE(tls_basic)
 
 FIXTURE_SETUP(tls_basic)
 {
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls, 0, 0);
 }
 
 FIXTURE_TEARDOWN(tls_basic)
@@ -310,6 +315,7 @@ FIXTURE_VARIANT(tls)
 	uint16_t tls_version;
 	uint16_t cipher_type;
 	bool nopad, fips_non_compliant;
+	bool mptcp;
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_gcm)
@@ -407,7 +413,9 @@ FIXTURE_SETUP(tls)
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls,
+		      variant->mptcp ? IPPROTO_MPTCP : 0,
+		      variant->mptcp ? IPPROTO_MPTCP : 0);
 
 	if (self->notls)
 		return;
@@ -2473,7 +2481,7 @@ FIXTURE_SETUP(zero_len)
 	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls, 0, 0);
 	if (self->notls)
 		return;
 
@@ -2534,6 +2542,7 @@ FIXTURE(tls_err)
 FIXTURE_VARIANT(tls_err)
 {
 	uint16_t tls_version;
+	bool mptcp;
 };
 
 FIXTURE_VARIANT_ADD(tls_err, 12_aes_gcm)
@@ -2554,8 +2563,12 @@ FIXTURE_SETUP(tls_err)
 	tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
-	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls);
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls,
+		      variant->mptcp ? IPPROTO_MPTCP : 0,
+		      variant->mptcp ? IPPROTO_MPTCP : 0);
+	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls,
+		      variant->mptcp ? IPPROTO_MPTCP : 0,
+		      variant->mptcp ? IPPROTO_MPTCP : 0);
 	if (self->notls)
 		return;
 
@@ -2906,7 +2919,7 @@ TEST(tls_12_tx_max_payload_len)
 	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
@@ -2955,7 +2968,7 @@ TEST(tls_12_tx_max_payload_len_open_rec)
 	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
@@ -3058,7 +3071,7 @@ TEST(keysizes) {
 	tls12.info.version = TLS_1_2_VERSION;
 	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_256;
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (!notls) {
 		ret = setsockopt(fd, SOL_TLS, TLS_TX, &tls12,
@@ -3084,7 +3097,7 @@ TEST(no_pad) {
 	tls12.info.version = TLS_1_3_VERSION;
 	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_256;
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
-- 
2.53.0

