Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08A3BC697
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914957; cv=none; b=aADjAHpC2daHfX15L4cUe5hFJzTUDI2d/5rZV75cjUd+6DoiSeF9Rfp3xCwbYY8T+32AX2XSa1KnAxFidVtbibwSag+oqLp0F0dTQU4UqVzeDOIDSQ9JSCOwxrYtejYjplMTOyUsLuEAPj1qjwphoY1GSIHOI3rIBr0jxq6XQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914957; c=relaxed/simple;
	bh=tsDe+JxlsYBbaj5nJOkTXKxPUBEBZnjZgBM+evG90vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvCR+yRa574aHdutgXllGOL9fkEYYRv+npTaEw3IeNx2A34rhSf6F5tqMWxBc3rHhVn51S18UNRnD/u/wcG7ULj6Oez09+kmbPJPRtj3rghTiNuRwCwZVpATpit/C2GYEPkuZ5K0g5URvamzsLsot02s8g3ccrzT7Go7ABRLmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugwGPUpj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugwGPUpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28405C19424;
	Thu, 19 Mar 2026 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914957;
	bh=tsDe+JxlsYBbaj5nJOkTXKxPUBEBZnjZgBM+evG90vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugwGPUpjK1hengCCgWs3sPqFogFad4nVj7UqqiVAfYRON0bOvZNaq0QQg+U6Hsm8L
	 vLAkzKn02KguiEdaOljSYStmQhPXCrT/Z9U9Y/z+a6SbTm8cpMfwZUFc5/yhW+p7zG
	 QYYnv30Qp96svBz0OLIKjI0FXynskYCGVgGPW5iLiMh8XflhdgwMs077B66OxLLmpf
	 Oi99rF/qjj4xAT5eZrgZNc6UfDtgaTMN8fM9WiYuIBrIDnHcYms+wbuuAcqjkOUnjT
	 xN0gu4g4o9FT5n6TcqPeNxSIVH/nRdTwHEf073jAgFMv/8zKcnC1RLPnCtpx4M8/UB
	 GvqtATDz+H9Ww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 11/15] selftests: tls: add mptcp variant for testing
Date: Thu, 19 Mar 2026 18:08:44 +0800
Message-ID: <f9df8943dadf68902f77ec7de7a927e8e564ef7e.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
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

A new variant "mptcp" is added both in FIXTURE_VARIANT(tls) to control
whether to create MPTCP sockets or not for tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 32 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..82631c1b3355 100644
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
 
@@ -2554,8 +2562,8 @@ FIXTURE_SETUP(tls_err)
 	tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
-	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls);
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls, 0, 0);
+	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls, 0, 0);
 	if (self->notls)
 		return;
 
@@ -2906,7 +2914,7 @@ TEST(tls_12_tx_max_payload_len)
 	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
@@ -2955,7 +2963,7 @@ TEST(tls_12_tx_max_payload_len_open_rec)
 	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
@@ -3058,7 +3066,7 @@ TEST(keysizes) {
 	tls12.info.version = TLS_1_2_VERSION;
 	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_256;
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (!notls) {
 		ret = setsockopt(fd, SOL_TLS, TLS_TX, &tls12,
@@ -3084,7 +3092,7 @@ TEST(no_pad) {
 	tls12.info.version = TLS_1_3_VERSION;
 	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_256;
 
-	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls, 0, 0);
 
 	if (notls)
 		exit(KSFT_SKIP);
-- 
2.53.0

