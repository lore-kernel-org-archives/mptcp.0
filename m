Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB13815DB
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027154; cv=none; b=qfOibJpJUBzHZXzCsGT+MzmrnD//cH9pj5Vj29PzGW2NN5SvCrTw9yeJ+A43No53f8y3MRuUhGy0lE0wIcx+KdwjkpGGj0jO0rDV2O3V+9s7sHIrQMyGBpi2b4E11Fktqkm7KtmP6jAbxlg2EJuEhRk8mOV424CwPX6tDwJcmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027154; c=relaxed/simple;
	bh=jk3l49RDP8jV6GKjl8SD9E0b9k2P1Nrw5zS2dhhLetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1PiL8NTQVvK5ScU198xptt7UxLfU2czy2iH1I8EE6JJhmPJdF7s3QMubrmOfboq4wKIqMaElkp9ryvkZVvRIJvoOWBe2EJskfg6mmYTl+XthPnMnz+E/Toh69qVKZGnzzueXdVFHgIc5tfro3I4tMjBwtvETiY9Ur+3T5QAKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg2gUk3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg2gUk3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22179C2BCB5;
	Fri, 24 Apr 2026 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027154;
	bh=jk3l49RDP8jV6GKjl8SD9E0b9k2P1Nrw5zS2dhhLetU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gg2gUk3blM20SuORKq0B1tlceYpWZxjEwx/cAYU5Crp+TRiSmIBpqegofFCwRkQ81
	 okeMVMIvyDz4kQVCe0QnEFVu3oh5DN/uFPx6LFjT5UiLIqvHb/kVy901sWqX7JdQSX
	 ClZNcwtvJt+CHKB7AGcDoxu9ciEV9YJVnaNaXKCZzYALFLsXARszIvZRUvH7zRHdzI
	 tTbc9dK5IN/4+1q+uNVVHjnu5Lcn7GDXRaRPIlS3dOCy8WeV8fk7NEV1V9E0SG4p66
	 3AVEFAVbxOIPHnc++tAy7CTFjDiVFfiEgRRDbwFLeqUMTj3HchCNYGJ/0npb4wYwa5
	 4f+WdKQlHpTKg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 10/15] selftests: tls: add mptcp variant for testing
Date: Fri, 24 Apr 2026 18:38:34 +0800
Message-ID: <57f687850302c9fdd2a1a453c14484e2758fa6d7.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/tls.c | 44 +++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..80e8071993c0 100644
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

