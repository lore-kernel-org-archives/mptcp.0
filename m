Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4987374730
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227981; cv=none; b=DtS6mivpbetNCGw26dVkDM9pv6jNimLr7FAif87/fKdzsolFuyzMIk/LThcnyiHf3BpcUe73LnXAk/QMKWPOUok4b77HIY3rNA72XfRcG5RwVOtApcgPnO5R1bP8P+tjnwVzo4IhdSufzTj+ihUrjo8HNok9pik8F/Hk/g0nhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227981; c=relaxed/simple;
	bh=pcD8gb+mn5Hyv7N/O0iCN9i22C1PsVJhivac82eZRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/Vp4sOC5fTRmes3aboZOSpZ1/f9y2uRqBU36912M7x326HJVc56eAN5lh64FTqGLq4oK3SKWcJPVLrrFNvJPaI4xNo92/rZrs3YXVNBcQHMmO31WYLBY7az/tkclsIZXGS0udTiXcgGg+bdPUBww2olIoAYa33qojoWHueDgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P68jPkiR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P68jPkiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3FCC19421;
	Fri,  3 Apr 2026 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227981;
	bh=pcD8gb+mn5Hyv7N/O0iCN9i22C1PsVJhivac82eZRCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P68jPkiR7yMIaffSmQa2GlOIctqhTqu3GbbO8tNzlwIp6g4qkAySr0Tdc7ZLYm7Ni
	 HdVDZZeQ7m3BApMfoSWlpgraVwhEaVM0kER5H0YpwRgJmxgM2G+JYVT7ZPBARAGHVd
	 NVAfr6gfgTMYhFIEFoo+itmeKGcOR0tTIxS6zLvlc4MLIPPHzIcBUBUW9cA4oLO0mJ
	 2vGdqFR87h7ydduO50LQZHSKPx9OoVAJZGWBNGa9fPhX0RVD+X1J5RMitHLOlHYYwB
	 N8PqtFrcydu7atqNDWR/BGxi+csK0iT0Op1pa1cgk0HnyZljvczl4Ba0+M4nx3AV1q
	 9IQbbuPaST12g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 11/16] selftests: tls: add mptcp variant for testing
Date: Fri,  3 Apr 2026 22:51:29 +0800
Message-ID: <2931fd965bc4dfc70a5cb6fe1b3b0781f0f99070.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/tls.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..21f73a9867ea 100644
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
@@ -122,8 +127,10 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	addr.sin_port = 0;
 
-	*fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
+	*fd = socket(AF_INET, SOCK_STREAM, cli_proto);
+	sfd = socket(AF_INET, SOCK_STREAM, srv_proto);
+	ASSERT_GE(*fd, 0);
+	ASSERT_GE(sfd, 0);
 
 	ret = bind(sfd, &addr, sizeof(addr));
 	ASSERT_EQ(ret, 0);
@@ -153,6 +160,12 @@ static void ulp_sock_pair(struct __test_metadata *_metadata,
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
@@ -310,6 +323,7 @@ FIXTURE_VARIANT(tls)
 	uint16_t tls_version;
 	uint16_t cipher_type;
 	bool nopad, fips_non_compliant;
+	bool mptcp;
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_gcm)
@@ -407,7 +421,9 @@ FIXTURE_SETUP(tls)
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
 			     &tls12, 0);
 
-	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	__ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls,
+			variant->mptcp ? IPPROTO_MPTCP : 0,
+			variant->mptcp ? IPPROTO_MPTCP : 0);
 
 	if (self->notls)
 		return;
-- 
2.51.0

