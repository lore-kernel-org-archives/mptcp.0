Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA91F1921
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860180; cv=none; b=pbt61iPbGKhC5+o+Bg7HfKSSiW0u4sega5oD9Xskm0hDnRtizhf5/8IXu7tnd3bOLrt965v2SXksa1272LTc3JlXWGGQWI0jiJUuHSXIGmbNKzQUKtbP6AVxTcMKCH7rARlAWQ2yvPrfNpMnRK8K9sahoto9FyyqDQ5bfLp1nKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860180; c=relaxed/simple;
	bh=1NHsVCQEBPxU9SneQfXnxPcuLRPYwsuZLkpyI39muCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyCGH1bnI5wGqf5fL1KUpAZYYwruNaiUJKa8Z6I2vC7/khnxPeshrnhfFwcg/4RQVZOM0dnVfMbCTaIFkczG+MBiN0XoKdC1hkWWTQOjzZquV4TdkmzV6rIAu6F99/TU1J/w/zEIPPg6Gw1EgrzyGeF+A+cTCH3Q76kmptcaKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwHAkLkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwHAkLkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77007C4CEF6;
	Wed, 30 Jul 2025 07:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860180;
	bh=1NHsVCQEBPxU9SneQfXnxPcuLRPYwsuZLkpyI39muCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwHAkLkNRKTvinxIWZPoY/nkqyrrZ0mrBdhlnk2onedOO5VkcaLzvwaQZClU2IoBc
	 881AE4Bbr8C46e54re2wjzC5RrM63KZGL6EQlEcrccu/isfLOlu9zv/uHUccw2juk5
	 UxtLIp8vHoSe9l7YMc0FxraevBUYfsFf3E1q2jJ6xdBhDF4+IaI+RazTrKLJ1hdVEE
	 Cp9mJ7aOVpbq+RpmcjuLmLP4frGLcj3Hp7LYyOe3U31vLL3a5Zbw+PEnOwTzVe3q74
	 yN8mwGiV3xlOdCfoSLEG9uX+WcYQvIGeUV9Wd95sSeIu5R7O3/mtECmThUhkKr0nlR
	 JsypxT/RHvSWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add TCP_MD5SIG tests in sockopt
Date: Wed, 30 Jul 2025 15:22:45 +0800
Message-ID: <42b549e570e3505028f96509196c2623cab93299.1753859907.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753859907.git.tanggeliang@kylinos.cn>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add test cases for TCP_MD5SIG and TCP_MD5SIG_EXT socket options:
- Enable CONFIG_TCP_MD5SIG in test config
- Implement test functions for both options:
  - test_tcp_md5sig_sockopt() - sets basic MD5 key
  - test_tcp_md5sig_ext_sockopt() - sets extended MD5 with flags
- Tests run on both IPv4/IPv6 during server setup

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 968d440c03fe..d9022261b6f8 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_SCH_INGRESS=m
+CONFIG_TCP_MD5SIG=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9934a68df237..b99d7bce96ee 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <arpa/inet.h>
 
 static int pf = AF_INET;
 
@@ -127,6 +128,15 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+struct tcp_md5sig_ext {
+	struct __kernel_sockaddr_storage tcpm_addr;
+	unsigned short	__tcpm_pad1;
+	unsigned short	tcpm_keylen;
+	unsigned char	tcpm_key[TCP_MD5SIG_MAXKEYLEN];
+	unsigned int	tcpm_flags;
+	unsigned int	tcpm_ifindex;
+};
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -697,6 +707,60 @@ static int xaccept(int s)
 	return fd;
 }
 
+static void test_tcp_md5sig_sockopt(int fd)
+{
+	const char *peer_ip = (pf == AF_INET) ? "127.0.0.1" : "::1";
+	const char *key = "0123456789";
+	size_t key_len = strlen(key);
+	struct tcp_md5sig md5sig;
+	struct sockaddr_in *addr;
+
+	memset(&md5sig, 0, sizeof(md5sig));
+	addr = (struct sockaddr_in *)&md5sig.tcpm_addr;
+	addr->sin_family = pf;
+
+	if (inet_pton(pf, peer_ip, &addr->sin_addr) != 1)
+		die_perror("inet_pton failed");
+
+	if (key_len > sizeof(md5sig.tcpm_key))
+		die_perror("Key too long\n");
+
+	memcpy(md5sig.tcpm_key, key, key_len);
+	md5sig.tcpm_keylen = key_len;
+
+	if (setsockopt(fd, IPPROTO_TCP, TCP_MD5SIG, &md5sig, sizeof(md5sig)))
+		die_perror("setsockopt(TCP_MD5SIG) failed");
+}
+
+static void test_tcp_md5sig_ext_sockopt(int sockfd)
+{
+	const char *peer_ip = (pf == AF_INET) ? "127.0.0.1" : "::1";
+	const char *key = "0123456789";
+	size_t key_len = strlen(key);
+	struct tcp_md5sig_ext md5ext;
+	struct sockaddr_in *addr;
+	int ifindex = 2;
+
+	memset(&md5ext, 0, sizeof(md5ext));
+	addr = (struct sockaddr_in *)&md5ext.tcpm_addr;
+	addr->sin_family = pf;
+
+	if (inet_pton(pf, peer_ip, &addr->sin_addr) != 1)
+		die_perror("inet_pton failed");
+
+	if (key_len > TCP_MD5SIG_MAXKEYLEN)
+		die_perror("Key too long\n");
+
+	memcpy(md5ext.tcpm_key, key, key_len);
+	md5ext.tcpm_keylen = key_len;
+
+	md5ext.tcpm_ifindex = ifindex;
+	md5ext.tcpm_flags = TCP_MD5SIG_FLAG_IFINDEX;
+
+	if (setsockopt(sockfd, IPPROTO_TCP, TCP_MD5SIG_EXT, &md5ext, sizeof(md5ext)))
+		die_perror("setsockopt(TCP_MD5SIG_EXT) failed");
+}
+
 static int server(int pipefd)
 {
 	int fd = -1, r;
@@ -721,6 +785,9 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	test_tcp_md5sig_sockopt(fd);
+	test_tcp_md5sig_ext_sockopt(fd);
+
 	return 0;
 }
 
-- 
2.48.1

