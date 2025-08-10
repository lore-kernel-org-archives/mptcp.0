Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19F17BEBF
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838202; cv=none; b=odAORxR1535+eOBa+mfSA+dhkhr0w6rHp5XLIXiPKi4gf0o90UzMqCCOjTtbq+IRMnsAdqSLKXZ+iUpt0wEw7XZ6Dt1YBBLSKd0a+i6UEzFz0yMoU2fxe3e1xAYisiULiByxszxLrcX1B/xLjpDw8Jk8Ou2YOCOhpFpkP2ncOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838202; c=relaxed/simple;
	bh=t/iW/gp/Y/wKR6V2FNGhc6b3o6y9QG73trTfzfH91fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXshVdzPqpv/cRoMkofjrcZNCsBUuHq5vtTQ8x8z4rjm+tS+yFHgajmIlyApeXXYQmll+oYes6creS4pvUMD0/5w84QMY8C0xntOgUHKJmyitIDM6qjX3GbIQGFLjRHlPnLTsyraQ4CGSNlxg1CpZ4dZz0iNbS1jGIFBfcM5/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNSyBuDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNSyBuDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB84C4CEEB;
	Sun, 10 Aug 2025 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838201;
	bh=t/iW/gp/Y/wKR6V2FNGhc6b3o6y9QG73trTfzfH91fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNSyBuDvQ2EEChBRS9j9FPCqSABl7D2fJGRxOg9fz4Hw0DTrROeH5a3HaePGLulxf
	 APkmtIlhWuybkyvZFJbYkqnePNBriC5/7nW+Tad/cAbibOFTTf9yZnF4ZQKmdHH/UJ
	 1V8/kOcWRl7dKwDupHEFkUBsXk+9EC6eT7HJ1VCTzljnyUHPUydVlXYujwsHhxhUmb
	 uXl0DZEJs2KPpQxo58JcmITHO5uqrYPLiBXf/yJN6ieDQCgPEKH35eJcIor8V6Gm+G
	 jvD0NYWMcUrEU1NibCROAg51U1ywwrtD6EXKHEbJb3+Nv8jZsD4mHE9YhqJkvcOj+k
	 e2N2QkV6sfB2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/8] selftests: mptcp: sockopt: implement TCP_MD5SIG support
Date: Sun, 10 Aug 2025 23:02:24 +0800
Message-ID: <207ff22972850c55e5d9ad32a3e7539816be3e85.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement socket option handling for TCP_MD5SIG. The do_setsockopt_md5sig()
function configures MD5 keys for connections using the key provided via
the '-m' parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index c15fa0abcfb1..7d17558ccbc6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,7 @@
 
 #include <linux/tcp.h>
 #include <linux/sockios.h>
+#include <arpa/inet.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
@@ -199,6 +200,37 @@ static void do_setsockopt_reuseaddr(int fd)
 		perror("setsockopt(SO_REUSEADDR)");
 }
 
+static void do_setsockopt_md5sig(int fd)
+{
+	const char *addr_str = (pf == AF_INET) ? "127.0.0.1" : "::1";
+	size_t key_len = strlen(key);
+	struct tcp_md5sig md5sig;
+	struct sockaddr_in *addr;
+	int opt = TCP_MD5SIG;
+
+	memset(&md5sig, 0, sizeof(md5sig));
+	addr = (struct sockaddr_in *)&md5sig.tcpm_addr;
+	addr->sin_family = pf;
+
+	if (inet_pton(pf, addr_str, &addr->sin_addr) != 1)
+		die_perror("inet_pton failed");
+
+	if (key_len > sizeof(md5sig.tcpm_key))
+		die_perror("Key too long\n");
+
+	memcpy(md5sig.tcpm_key, key, key_len);
+	md5sig.tcpm_keylen = key_len;
+
+	if (setsockopt(fd, IPPROTO_TCP, opt, &md5sig, sizeof(md5sig)))
+		die_perror("setsockopt(TCP_MD5SIG) failed");
+}
+
+static void do_setsockopts(int fd)
+{
+	if (md5)
+		do_setsockopt_md5sig(fd);
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
@@ -222,6 +254,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 			continue;
 
 		do_setsockopt_reuseaddr(sock);
+		do_setsockopts(sock);
 
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
@@ -260,6 +293,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		do_setsockopts(sock);
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
-- 
2.48.1

