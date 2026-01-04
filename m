Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DB22F772
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519335; cv=none; b=hkaJEUGn4CJk7X1t8BDfa8OH0jZ3nVxJrw71GjM+EHhdWLrnY+zF91TXJXQ6NqIz5agCeD4dYP4P7bp1znXhZpoxCRB0cMfKCQ74gDNkTeiIeYePXaBjTeiGovt6hkcTE1jFonPGnvSFSQJcGemfyIDZ/HfSYUehgWf1Yqj2gRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519335; c=relaxed/simple;
	bh=qBrl+DpO/Sk+ePK3jgJZurfHDEprIEjBG1Lfob5lho4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMuWB/xK1vOaYX3QpzuQu5np0ucJ1mMulTS1FkMx6XmUQhDYE66LYU5XyXvGLxFsTlyLLKUz9P0C4iJwh5NeN99IJUXwwyEODTqFCmAIlNtpiiiKaCt6reH50/4p6hTDpuC5LIJh6bQzT/fYj0e+yVNJ2kv3MpW0X5sKLOFv46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SedIalXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SedIalXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C484C4CEF7;
	Sun,  4 Jan 2026 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519334;
	bh=qBrl+DpO/Sk+ePK3jgJZurfHDEprIEjBG1Lfob5lho4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SedIalXmvOMYafEBf3XuDkwRLS8yXLTC0eYDxJWHYCKTvj/u12TB6CO3OTFgcIbN3
	 CUIO1n2CVJtk2T09UfJeK8QtpDDUkpvcdx6gWTct38SH4EUqXfUetXeCSx/29iTO6i
	 J2VmnELk4/ETQdqK4m4WsD1i741ZBuLYpGG1J7xEUT5fnkmSl5bv54bHOJlZFvHf1n
	 a0O6qyq7/Hsia0+PonUwquQ2wbdsmEniierYALs76JxNOhVTZJLDBiBharPTJhW/FO
	 gNOZF8HkAO9Jb76pZ/eaFSdr9HEkpEGJO6qp99hcrGnKf8Pj2U8OkQD2ODo3d42HP2
	 l/i06/rc9yYjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 09/10] selftests: mptcp: connect: add tls sockopt type
Date: Sun,  4 Jan 2026 17:35:10 +0800
Message-ID: <357baa10e3d1ca30150e7517c1fc688ae74e1658.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A new TLS type has been added to cfg_sockopt_types, enabled via the
parameter "-o TLS". do_setsockopt_tls() has been implemented to set
TLS parameters for both the server and client.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 9da32701d2d0..3dd22d7e0460 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/tls.h>
 
 extern int optind;
 
@@ -88,6 +89,7 @@ struct cfg_cmsg_types {
 struct cfg_sockopt_types {
 	unsigned int transparent:1;
 	unsigned int mptfo:1;
+	unsigned int tls:1;
 };
 
 struct tcp_inq_state {
@@ -283,6 +285,39 @@ static int is_mptcp(int fd)
 	return mptcp;
 }
 
+static void do_setsockopt_tls(int fd)
+{
+	struct tls12_crypto_info_aes_gcm_128 tls_tx = {
+		.info = {
+			.version     = TLS_1_2_VERSION,
+			.cipher_type = TLS_CIPHER_AES_GCM_128,
+		},
+	};
+	struct tls12_crypto_info_aes_gcm_128 tls_rx = {
+		.info = {
+			.version     = TLS_1_2_VERSION,
+			.cipher_type = TLS_CIPHER_AES_GCM_128,
+		},
+	};
+	int so_buf = 6553500;
+	int err;
+
+	err = do_ulp_so(fd, "tls");
+	if (err)
+		xerror("setsockopt TCP_ULP");
+
+	err = setsockopt(fd, SOL_TLS, TLS_TX, (void *)&tls_tx, sizeof(tls_tx));
+	if (err)
+		xerror("setsockopt TLS_TX");
+
+	err = setsockopt(fd, SOL_TLS, TLS_RX, (void *)&tls_rx, sizeof(tls_rx));
+	if (err)
+		xerror("setsockopt TLS_RX");
+
+	set_sndbuf(fd, so_buf);
+	set_rcvbuf(fd, so_buf);
+}
+
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
 static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 {
@@ -436,8 +471,11 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	}
 
 	freeaddrinfo(addr);
-	if (sock != -1)
+	if (sock != -1) {
 		SOCK_TEST_TCPULP(sock, proto);
+		if (cfg_sockopt_types.tls)
+			do_setsockopt_tls(sock);
+	}
 	return sock;
 }
 
@@ -1210,6 +1248,8 @@ int main_loop_s(int listensock)
 		}
 
 		SOCK_TEST_TCPULP(remotesock, 0);
+		if (cfg_sockopt_types.tls)
+			do_setsockopt_tls(remotesock);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1310,6 +1350,11 @@ static void parse_setsock_options(const char *name)
 		return;
 	}
 
+	if (strncmp(name, "TLS", len) == 0) {
+		cfg_sockopt_types.tls = 1;
+		return;
+	}
+
 	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
 	exit(1);
 }
-- 
2.51.0

