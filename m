Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1B31577D
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594036; cv=none; b=X01PXucWQR6wzIVrO++bLbJzKu1dEbRtqbSdN5y+XBD4gGFU1rXS09nXHWCTtyleqbvYUBj8wQ494q9UUVTnRzkFMJVWrcQsesRxdEEvqpUB5+q2c54mtoRJ5DDeR/WXIvYdfL5P5JPaNqzanZTOhKI53W+iLlRaYPp1iaXuOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594036; c=relaxed/simple;
	bh=gAnSShawOksymIf9itbH5poxQY94AOV5E34yjtagJu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc7k9+JhpSF39esdFWHSl23EDvp7PM5SWuKiVYMQpHV9PhdjJLkyNVeDzbFJcirEAWnl9zZJvdqbQ3caf9/7q5A5Kyp2VXZKGNrpwei773sXvB2/C/Pn7XkMkn4lMsTaC7D7+EuvyzDbwwT7WEW/3sjD1JD4jkabsAKUZ6/QuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUjRqWZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUjRqWZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706D4C116B1;
	Tue, 19 Aug 2025 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594035;
	bh=gAnSShawOksymIf9itbH5poxQY94AOV5E34yjtagJu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUjRqWZIEyv3amWPgltI2QLg8n5TB1H2umCHtZcl64PLgqKWC2KFGA8QV0372TkBf
	 +D7fTns3SeS7hANkltQVz4jU6kNOCw4L+7lLg6XkXhlS2ddKt3P1xjef8mbSAIWEhQ
	 cPdvHEVaqbs97cmP3F3L2Q/LN42KDDahhxtvQYisCnGMPamHS4iUM/kv56wdUUs5pl
	 HabS3rFvbfnbUCdxlcETrMQuQ+q3piLkDBDqi10oHsIM4+UboVCLE/Z9oUmBDVAK88
	 k715jJnxG0H8q+0ijtezrXEEWM2emkpQw0SxNsoDbf5ysQQN5N1u3ACXTehfwqLVrS
	 QTlur2xumVQJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 07/11] selftests: mptcp: sockopt: add IP_FREEBIND tests
Date: Tue, 19 Aug 2025 17:00:13 +0800
Message-ID: <611145c75ad6579a523a03c4305139174c2f5ae4.1755592822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755592822.git.tanggeliang@kylinos.cn>
References: <cover.1755592822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add tests for IP_FREEBIND (IPv4) and IPV6_FREEBIND (IPv6):
- Setsockopt helpers to enable FREEBIND
- Getsockopt validation of the enabled state
- Test integration for both address families
- Script result reporting

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 37 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 3bef535ce981..1e7cacdebc72 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -241,6 +241,21 @@ static void do_setsockopt_tos(int fd)
 		die_perror("setsockopt(IP_TOS)");
 }
 
+static void do_setsockopt_freebind(int fd)
+{
+	int optname = IP_FREEBIND;
+	int level = SOL_IP;
+	int enable = 1;
+
+	if (pf == AF_INET6) {
+		level = SOL_IPV6;
+		optname = IPV6_FREEBIND;
+	}
+
+	if (setsockopt(fd, level, optname, &enable, sizeof(enable)))
+		perror("setsockopt(IP_FREEBIND)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -248,6 +263,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_bindtodevice(fd);
 	do_setsockopt_bindtoifindex(fd);
 	do_setsockopt_tos(fd);
+	do_setsockopt_freebind(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -704,6 +720,25 @@ static void do_getsockopt_tos(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void do_getsockopt_freebind(int fd)
+{
+	int optname = IP_FREEBIND;
+	int level = SOL_IP;
+	socklen_t len;
+	int enable;
+
+	if (pf == AF_INET6) {
+		level = SOL_IPV6;
+		optname = IPV6_FREEBIND;
+	}
+
+	len = sizeof(enable);
+	if (getsockopt(fd, level, optname, &enable, &len))
+		die_perror("getsockopt(IP_FREEBIND)");
+
+	assert(enable == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -724,6 +759,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_bindtoifindex(fd);
 
 	do_getsockopt_tos(fd);
+
+	do_getsockopt_freebind(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 9972012d08f6..b5054533872b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -293,6 +293,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_TOS sockopt v4"
 
+	print_title "IP_FREEBIND sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IP_FREEBIND sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -327,6 +331,10 @@ do_mptcp_sockopt_tests()
 	print_title "IP_TOS sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "IP_TOS sockopt v6"
+
+	print_title "IPV6_FREEBIND sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "IPV6_FREEBIND sockopt v6"
 }
 
 run_tests()
-- 
2.48.1

