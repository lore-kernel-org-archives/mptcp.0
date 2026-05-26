Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D33A0B3F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788825; cv=none; b=cqSwGkxG+u1TneXweW3kLnMFtyt2syLhApULsr/uPpbdyHU4JOlOcsgTcjAF4L/V0TxQf+XEv2LRnPDQthp3P7P5g1K3XqjQPlPz249bjgZobO7b1UcBJEtnnii5FsfguUSTbQ7QRFZ98j/B9OSN63xdPxtysgPKD5hK245f+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788825; c=relaxed/simple;
	bh=rRi1L4XdllgoCFLl6ER2drBMFkNSL0li5/yrOErw9tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuFrU7FHGfDLfl22k0uyAUzgtnCjl9Z+aXMfrzXWhigJrggfOBw/Wq01Y3T2Ddmj+8L8fMMTpGPSFUG9HgnhiqSIo6YwtuiomAZgabcNv2zgblxFB5U1k2qa8UBT6aAPjcEIeidiFWAk28NCVulqh7vR5eweOsWDD17dFfNizP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4C0cJXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4C0cJXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB701F000E9;
	Tue, 26 May 2026 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788824;
	bh=n/EeXTMwi7WZjvIViyCLsVv3HfIclHR/HPek5xk/qvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4C0cJXBvZLiVnwL8tjzeluZcOn0xsgKZTmSPNENoMdwFs+TGiozwR1BtmeWe8sKQ
	 jQZrZ2G/SPlzUIYTncDDFg6v2gY9SgaGZcsf3JX8VqFp6nmniwPgwU9dHExa0gt+vB
	 0m6JsdvCiaikvvXLYRM2KEQ98/PVYZ2rrkCd18JnVW9EftIH5XWsTWQhnUPuihejfI
	 72TjFzqxFp1Te5UjYWjOvMSpeW3Wytm6VXSLd5mWCpYk9eVwWz0jm/xzfyMx/0tF6g
	 aIj3P2Y2/G35Xw0rtK9pd3xVf4+No7SB03nZrNUv5SRP1GnqnFu73uQ6/3raPJHWpS
	 uob622TtUSsxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 10/15] selftests: tls: add mptcp variant for testing
Date: Tue, 26 May 2026 17:46:28 +0800
Message-ID: <0e47682445f68e964797cf00dc914b63aef1d267.1779788090.git.tanggeliang@kylinos.cn>
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

To enable easy MPTCP socket creation in MPTCP TLS tests, two protocol
parameters (cli_proto and srv_proto) have been added to ulp_sock_pair().
These are passed as third arguments of socket(): 0 creates TCP sockets,
IPPROTO_MPTCP creates MPTCP sockets.

A new variant "mptcp" is added both in FIXTURE_VARIANT(tls) to control
whether to create MPTCP sockets or not for tests.

Add is_mptcp_enable() helper to check MPTCP support. Used in
FIXTURE_SETUP(tls) to skip MPTCP variants when MPTCP is not enabled.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 44 +++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9b9a3cb2700d..5f8382a51558 100644
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
 
+static bool is_mptcp_enable()
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

