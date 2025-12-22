Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FB17BEBF
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373345; cv=none; b=qEAtXMn0gQr69bBqo6j9ByqUzUET2HrhdgGxUr2g/+2JRp9d9qY1SURLiIOlhU7+wvWscSurJ5GSmxmuRvmaRQfM3Gkl6WIEnn8Dy+CI83PR9QrSPManr8SAzy2EV+cG+3qw1D61EnHVAdfCOdenW63U/5789w6DaHlMVYCXX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373345; c=relaxed/simple;
	bh=3RLRIH72HmYZgUYeM9xQ5rFdNU5lF0ekjAuqe7Te4w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWLlxi37MQki3Hqi8D6KG/DzdSo/518XXf9KUUb4FOHwd8ZmcPHvLMIkkUZ9nqMHc1Byb1T7LQFvVZiBWFbqCY8sdEfcyUx5SRg5Ts0uXbj3Sdw1mxUFOErB+RN2tVXSNbbS5nv+5GqOjbG9w6Uq1Nkc8dNpHp/UZ3oJPMs/Lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg1IjxpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg1IjxpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89109C4CEFB;
	Mon, 22 Dec 2025 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373345;
	bh=3RLRIH72HmYZgUYeM9xQ5rFdNU5lF0ekjAuqe7Te4w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg1IjxpUdcObnc0W098AiGx8KC1ykBW32EBYpVUW/nEZoH71Y1eHOmAi4xa6vgGdG
	 vd8YWNriA+sQlmKb5XIadQNFyko5s+JLPRk9xIh5IfZChbPhoUzaOEtc/QlQ3HrBlF
	 a0YDENLCKhymqruX97KpC9OSO5USi8FPCtF2q3pv/OJgG3UxrahKfF6DAz1QdKnYHv
	 THYv5fCTAnD1zQuCQB84Q+0ihxEcbIUmQ0isYRMddBslW12ZEqewTqBo0d/3BZ0GCP
	 ZmWN0i5wGGvEvfh7GdZt5YCIz6PYPcyBlS/JnEC56jt6we0XbNhuJlhZAavhCCTJ6N
	 SZkrcpyTkUFZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 5/8] selftests: mptcp: connect: update sock_test_tcpulp
Date: Mon, 22 Dec 2025 11:15:24 +0800
Message-ID: <6679775753c0e285b1b218b085d77d2a6208f4e7.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sock_test_tcpulp() to ensure the mptcp_connect.c tests are not
broken.

fallback() helper has been implemented to verify fallback scenarios,
ensuring that MPTCP fallback-to-TCP tests continue to pass.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b82df82e0594..e5c394ea4e11 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -266,6 +266,18 @@ static void set_mptfo(int fd, int pf)
 		perror("TCP_FASTOPEN");
 }
 
+static int fallback(int fd)
+{
+	int is_mptcp = 0;
+	socklen_t optlen;
+
+	optlen = sizeof(is_mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &is_mptcp, &optlen) == -1)
+		perror("TCP_IS_MPTCP");
+
+	return !is_mptcp;
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
@@ -282,7 +294,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, fallback(sock) ? "mptcp" : "tls") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
 		if (ret == 0)
@@ -424,8 +436,6 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	}
 
 	freeaddrinfo(addr);
-	if (sock != -1)
-		SOCK_TEST_TCPULP(sock, proto);
 	return sock;
 }
 
@@ -1197,8 +1207,6 @@ int main_loop_s(int listensock)
 				xerror("can't open %s: %d", cfg_input, errno);
 		}
 
-		SOCK_TEST_TCPULP(remotesock, 0);
-
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
@@ -1371,8 +1379,6 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
-	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
-
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
 	if (cfg_sndbuf)
-- 
2.51.0

