Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3F3BB123
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622672; cv=none; b=XUjZ1HOfXvpMZPsQSDo/xSzbEvB7A20+P6tAfcPQ3Q4+ht5mfNttP6RmjPz0wWTOMaizYmIMn+Pg4VdFsjvjj6VtBxtA6rjl3ZB1tNlMhiCg/HDAz2R1IL+//EZR7j5oXX9F7vpu28LmSHMc2kcJS0xrOTmApPLtxVxpSvX1gZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622672; c=relaxed/simple;
	bh=Mqrz92JEPCE1o6xkBk8ggU4pOInHHunzS838mGSLmuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIIycmjv6T49CnszUkWRoA504J+XA1UtsBFwRj4A0TfMFS7tY0y8EPZJ6DCTq6DTLviJWrGB0c6uaffDGICa02yFpTmk09lUDRXHWv6iilTkLA0FCNWRazUWZ41pi4LqWGhqY1/0edxmjlK8hz9p1L3NUDTRglQHmqqhG/D/Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6OVHuWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6OVHuWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02B11F00893;
	Fri,  5 Jun 2026 01:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622665;
	bh=MAO1CzgHEProwfI+nczP+M5IuY8I7OjS+4gtXMDKNlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6OVHuWJc2mGFor/ShRLEclepTQzRNLPuaeY3b7UxeWmeN0t9azi7KskPDcvWRPzG
	 hU+9ohJDUPPzblFtHzWGH0z1od9SIzVETgAU7qRmgyZZSlDuvHqjg8Z56SZIweIrmK
	 fkZTFi3U+qvjhms/jqTebHXioHI80x0mYBrMSigmu0cKRW99+e8EAZQ6bQhqYhGPAj
	 w7wvmwBTGSMOvLhgxgHPNyNb3u0ayx2iSkfVtk9+twk76FtlFsN7EdyezgLPe4wXDz
	 qESCITpQozxDeWt8riNNmc/Kr5NyJzLW0LxzFthb0gStR8x5vshNYFNmmJbUVcy1Rj
	 iAT8n/S/k5Qpg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 12/18] selftests: tls: add mptcp variant for testing
Date: Fri,  5 Jun 2026 09:22:52 +0800
Message-ID: <2ffc433750c6afaca48fcee6b3b83d1657a4dafc.1780621326.git.tanggeliang@kylinos.cn>
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
2.53.0

