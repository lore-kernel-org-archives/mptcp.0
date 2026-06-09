Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B42F8E98
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971600; cv=none; b=WXZFALLCCd5V1kyFrXLco8UCVMQGd4JAD3Z4Wz8R/ua86WQbu6CBx+RuwRFDsHiEsA3x6qCki4ywz/zR1clCGy3ErQR2Rq9I0QdDGps4AMoF40f/NjMtCQZTKZ698Sa/vy8SS6HsE7dqd3s9zIPqpsotSAp8ATKw0FusS3SrW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971600; c=relaxed/simple;
	bh=T24EsLKTudqyZ2DfoDOzxTu5oh3ljNrXUTevnRLMDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byYVvxul+5O/vL7LwoJZJpPSJ2zq9IAM0CUfw6iH4gjG5yDFPfLoN89If52BQ0XG4m2zdLvCLU/ggnbTK3Fx+a/UUhW/oi0STvxFf8TdsaGj7hicYBXFnYE2t+hxYctT3soZhoUBCyudf3xlf2Z6LGwEa22fd4DnqtgUFkCWtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AouuFRjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AouuFRjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B531F00893;
	Tue,  9 Jun 2026 02:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971599;
	bh=TnVYOByNO8/vJriZvMsn/OJ8Yq3gWlPwYk6rv44ZmI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AouuFRjV+LATagneUMLYO18NfTeD37QptfFqFgp/0UhA/yQZIYJ4KORMAhBHoyr3g
	 iba1ZL04z3WgBkoqA1haqcAyP+vE1X+WKI4+zsYFFtEoRk7JoudvACx1bOyPaAJUz6
	 R41MFf0KzOErDzNE+Hs8QKroMLdDICOkua9bwSX8kGrnOML0cwVOq8F2wDlZ250KmP
	 7pnHs/sLMbpu6Nr89y9Gcnsfv4iB4dwh4We53wwmt33/H6ea1LtU+w6aA5RQnvpdEa
	 SIpm6ir8cbDzGaNu47+tF767mOGvOyneDWNSw3PsA+23L3ayBVi5Bg5tK1DnQz9/PM
	 PDzR8FZfonB1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 16/22] selftests: tls: add mptcp variant for testing
Date: Tue,  9 Jun 2026 10:18:42 +0800
Message-ID: <755b1055f8d76c157cd921f7f9e3898a8cc02bfa.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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

Add is_mptcp_enable() helper to check MPTCP support. Used in
FIXTURE_SETUP(tls) to skip MPTCP variants when MPTCP is not enabled.

Also accept EOPNOTSUPP when setting TCP_ULP on MPTCP sockets, as they
may return this error in addition to ENOENT.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 46 +++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9b9a3cb2700d..fed83918cd9d 100644
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
@@ -108,8 +112,9 @@ static void memrnd(void *s, size_t n)
 		*byte++ = rand();
 }
 
-static void ulp_sock_pair(struct __test_metadata *_metadata,
-			  int *fd, int *cfd, bool *notls)
+static void __ulp_sock_pair(struct __test_metadata *_metadata,
+			    int *fd, int *cfd, bool *notls,
+			    int cli_proto, int srv_proto)
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
@@ -143,7 +148,7 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
 
 	ret = setsockopt(*fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
 	if (ret != 0) {
-		ASSERT_EQ(errno, ENOENT);
+		ASSERT_TRUE(errno == ENOENT || errno == EOPNOTSUPP);
 		*notls = true;
 		printf("Failure setting TCP_ULP, testing without tls\n");
 		return;
@@ -153,6 +158,12 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
 	ASSERT_EQ(ret, 0);
 }
 
+static void ulp_sock_pair(struct __test_metadata *_metadata,
+			  int *fd, int *cfd, bool *notls)
+{
+	__ulp_sock_pair(_metadata, fd, cfd, notls, 0, 0);
+}
+
 /* Produce a basic cmsg */
 static int tls_send_cmsg(int fd, unsigned char record_type,
 			 void *data, size_t len, int flags)
@@ -310,6 +321,7 @@ FIXTURE_VARIANT(tls)
 	uint16_t tls_version;
 	uint16_t cipher_type;
 	bool nopad, fips_non_compliant;
+	bool mptcp;
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_gcm)
@@ -395,6 +407,23 @@ FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
 	.cipher_type = TLS_CIPHER_ARIA_GCM_256,
 };
 
+static bool is_mptcp_enable(void)
+{
+	char buf[16] = { 0 };
+	ssize_t n;
+	int fd;
+
+	fd = open("/proc/sys/net/mptcp/enabled", O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return false;
+	return (atoi(buf) == 1);
+}
+
 FIXTURE_SETUP(tls)
 {
 	struct tls_crypto_info_keys tls12;
@@ -404,10 +433,15 @@ FIXTURE_SETUP(tls)
 	if (fips_enabled && variant->fips_non_compliant)
 		SKIP(return, "Unsupported cipher in FIPS mode");
 
+	if (variant->mptcp && !is_mptcp_enable())
+		SKIP(return, "no MPTCP support");
+
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	__ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls,
+			variant->mptcp ? IPPROTO_MPTCP : 0,
+			variant->mptcp ? IPPROTO_MPTCP : 0);
 
 	if (self->notls)
 		return;
-- 
2.43.0

