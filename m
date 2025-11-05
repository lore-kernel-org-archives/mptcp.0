Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D122FE059
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334984; cv=none; b=CaJh4YkB9mzFcSlDLX+Br7yh8CRrHWIdUbbHBkibh9FanN0rOu0OOCEp8RB3GPDrTC+9MylmFaMyXJ0+3FV01VAVTTY019Qnba7FSielH+CVO+qaClfYuqIT3SyhSDDtfnAGHr3wD0snFQ+DfDW179tpIsK0sWVnhlrvnceJbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334984; c=relaxed/simple;
	bh=Id8Y5cCpW8a6fTmhiL7u9VRBktxppJjIW8En60VP3lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBfYNXXDzQDwmPYX2D/mXpoYPB67DQypIRzxF9zFzcahpfSyioWCEUJ1mUWJ7CtsV01NQLvHAzpv2NJPRmCL7pkaNi30GP30Gz7bGSvArqEQYJ2n9N5dC6LwxPgo3y+qqfG9FBNatOnrFJe1rskxhkVlHSjMO2Ovy72jO27FW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn4Ft+jQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn4Ft+jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BAC4CEFB;
	Wed,  5 Nov 2025 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334984;
	bh=Id8Y5cCpW8a6fTmhiL7u9VRBktxppJjIW8En60VP3lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fn4Ft+jQoQdMw7eL/4DrSY48RFyFrmiRCm5GU+D5yypT3LdyeABVfIcLqLTLF2tFt
	 o7mh5beqvgVDHJnud8gW+P54q4sLvQebWdOHMv9pbIf1spMEkDH7OEnI0VrFM3FAbA
	 BwdDG24+0tRsqXI2dzKpWMQz5WAFKMUXR0BZ/Z6o1cRfT/RaY6416yZ9luV9jcUZzt
	 QBML9EJvg0ePC4prkDUX98VClLiXuiQZWimbzyOzaOiq3r2h4raxKtG8NE/53njvDq
	 trOVirW5VQG/jLlmesQkg/KQx0WPJQ5hoPbgTtltLpaZz1MT7EYa8iyUkOumqY9uMa
	 X+KX6q0AG6peA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/7] selftests: mptcp: sockopt: implement TCP_MD5SIG support
Date: Wed,  5 Nov 2025 17:29:28 +0800
Message-ID: <cd55ec725f2233a48cbb82ff51ad4aa3bec04d22.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add socket option handling for TCP_MD5SIG and TCP_MD5SIG_EXT.
Configure MD5 keys using the key provided via '-m' parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index fcf1d7a195d1..e577fbec9373 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <arpa/inet.h>
 
 static int pf = AF_INET;
 static bool md5;
@@ -186,6 +187,50 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static void do_setsockopt_md5sig(int fd)
+{
+	struct sockaddr_storage *addr;
+	size_t key_len = strlen(key);
+	struct tcp_md5sig md5sig;
+	int opt = TCP_MD5SIG;
+
+	memset(&md5sig, 0, sizeof(md5sig));
+	addr = (struct sockaddr_storage *)&md5sig.tcpm_addr;
+	addr->ss_family = pf;
+
+	if ((pf == AF_INET ? inet_pton(pf, "127.0.0.1", &((struct sockaddr_in *)addr)->sin_addr) :
+			     inet_pton(pf, "::1", &((struct sockaddr_in6 *)addr)->sin6_addr)) != 1)
+		perror("inet_pton failed");
+
+	if (key_len > sizeof(md5sig.tcpm_key))
+		perror("Key too long\n");
+
+	memcpy(md5sig.tcpm_key, key, key_len);
+	md5sig.tcpm_keylen = key_len;
+
+	if (prefixlen || ifindex)
+		opt = TCP_MD5SIG_EXT;
+
+	if (prefixlen) {
+		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_PREFIX;
+		md5sig.tcpm_prefixlen = prefixlen;
+	}
+
+	if (ifindex) {
+		md5sig.tcpm_flags |= TCP_MD5SIG_FLAG_IFINDEX;
+		md5sig.tcpm_ifindex = (uint8_t)ifindex;
+	}
+
+	if (setsockopt(fd, IPPROTO_TCP, opt, &md5sig, sizeof(md5sig)))
+		perror("setsockopt(TCP_MD5SIG)");
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
@@ -213,6 +258,8 @@ static int sock_listen_mptcp(const char * const listenaddr,
 				     sizeof(one)))
 			perror("setsockopt");
 
+		do_setsockopts(sock);
+
 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
@@ -250,6 +297,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		do_setsockopts(sock);
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
-- 
2.43.0

