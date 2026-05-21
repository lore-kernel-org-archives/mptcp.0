Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA46352024
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355829; cv=none; b=TL4rlVof0eX/Ix3IuuSaybWkCE4UzJqolTCMy3pwlCk23oGRDDBD0H87vaTLjSuwmOXgIlysYdKDKOtHM799WAHTCQKZZ5ADKSP8PQ50IaKhWDVGOeUjho37HjyJnafr9RVO9eSKHO7lsj2Zaab4nKQ0WImteIsCX7bicSIoFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355829; c=relaxed/simple;
	bh=O/mPy7YMI2rfmGxYYjB7zOoDVVL6GYPqE+o45Afmlw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQxYxJAPtcmI21jCMc1nEAfR1iH5ad+y2xICnonxfjbaPS58rF68J0+HbzOjESCVtL8nOMumgVphBZz9QwI/jkdDYSa8unrdjJfrxK5ukQNMO8Ry0205i+BSBDfOkkrKbwpJ9OxG/2LOzt/Oz5q1iYRenE5Nupuy+JP6slOgmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDvVfSxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDvVfSxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CF81F000E9;
	Thu, 21 May 2026 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355828;
	bh=nQZjQ5QWCD0eg9hbBobRUdZaUwAS3MrkpUTwtZyVaIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDvVfSxBiw9ZZV5HJPNovZjCRYyJXSvcSd3Y9WsX/8gA8A2gmIRi8j6db/P1O35XM
	 KKKrVIfFZusWjNXUmr05U2QsKx5N0Jrmavx6EEMCpuwA/dVjxqkUzo+5jcMZ4skiDT
	 KqXbIbFEDOlI3heqqUFeGYLAHPgBw3Bx+8oKi89E4gkWJ7UI4UMQd3GjUcnHmV2u7z
	 y1dziCEy58v9QdFHEBtggH4QDrcM5IiVidnanp0P8xbOZ4KRLzUl/cPYsBdG3t212f
	 cThOBvZKDUt+s7lShYJpLmgCdOGURYsChJVLJgaARFyw7Roub61LJ/bY8CCqmvn2cA
	 8TgndFYlbETvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 10/15] selftests: tls: add mptcp variant for testing
Date: Thu, 21 May 2026 17:29:48 +0800
Message-ID: <1c5c0d55d97b90bbb47e3e55861e964599a69119.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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

Add is_mptcp_enable() to check if MPTCP is enabled on the system.
The function takes a struct __test_metadata * parameter to satisfy the
test framework's callback signature, even though the parameter is unused.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 44 +++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 30a236b8e9f7..580375ce66d3 100644
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
 
+static bool is_mptcp_enable(struct __test_metadata *_metadata)
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
 
+	if (variant->mptcp && !is_mptcp_enable(_metadata))
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

