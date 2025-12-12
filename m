Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5263192B75
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506464; cv=none; b=ZTu+0paFfDG+Zs2MSCVxQNPGlJ7CdDZ9Qp2+TCrL8sLu8MTROvcZ2receuUg4gr+bGS4MUCoW3t40n3zeFU5xBcKYnNDMWb+omk42K6li6xPRMXEVTB4EhiIh3cQdrHTzkcaqcGg2H+yvfCrTGTbilKcKp7KMIuCAhavwoo8+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506464; c=relaxed/simple;
	bh=3RLRIH72HmYZgUYeM9xQ5rFdNU5lF0ekjAuqe7Te4w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqxR6ygMpc2jsfCjgPgH+YpJenx9AO1T6jIAZ2WSJuxO6NKecIHfRajIq6WR8L9jI097h45mvMaT2p59wUgLY4nAcnMDl+A051MCUQKGx8u1Ac9vu60kV5GnqS7A33leHIu7gfGgASB5+UCo1+ci/M7RLShkHPJP6dxuFVYjTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQm6BMlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQm6BMlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0792DC4CEF7;
	Fri, 12 Dec 2025 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506464;
	bh=3RLRIH72HmYZgUYeM9xQ5rFdNU5lF0ekjAuqe7Te4w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQm6BMlmSYSz1pURDE0JZj7ABZ7GzfkaAk98WBjksMTNQLrVzWe0XrXai237310vv
	 pTJRZmZJgjamcEdupg/IL2eZfznKhYsMeNRPhwXbxSMfEOJG3LJEid8RpEf+d7Xu05
	 7lknadeEjGZGPsPMFgiVUHi5bAHc22HQ0klOk69o/sTmxnKKzbJdBgt9/cuoQiMhYC
	 GcKf3GkIp8/KadAL435VtVCFZYd6L4FU67qgthrQ+tW3aUC+H3DdGiiCLkXnlkm6gM
	 L8aGyP/hLJhfAEq344qWKYdgXTX7SoPzoOX5BKcmIgdmdN4iAvZiOSxV4k2wE6XBLF
	 Kr+4uX/QRc+8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 09/10] selftests: mptcp: connect: update sock_test_tcpulp
Date: Fri, 12 Dec 2025 10:27:19 +0800
Message-ID: <8ec35b02f8c253ff49b58b01ad9ea9f53c99a39e.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
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

