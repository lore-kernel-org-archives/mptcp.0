Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C02E8DE3
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985259; cv=none; b=CYakAha5IBsJKTODrwncVfzFjpV+EtDN0+3/B7c+WGEgOEIjVIL6sGsCyTUoZAAI3LVK7WCfzzSOwf3bDCREvAr2u7pMPahXUML1+k1XRMk8lTPlDZpn8F5pevHlG+47++1P3qV3RnjIlur80tKP27gRu1O58O/axQ3vEA3qMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985259; c=relaxed/simple;
	bh=wj8lVo6tzFkl+Vy0qQBqCoY9i8jUX7m+o8IQAreL0e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRwE7FtoujcLacxDzgGvFhWpkJns6wyUM5lKomMQ/RORhWOZtIFLMz/AAuN6hz7Pvo4gZ82gXOL01hIn+xyCSpiAPLeC+UwznjMi94j5bgHGt1LtkmPkdt5zAkrYjB7dp6QozbNZfoU7yIwbeu7Ttr8TNcZlVUEclOKzyvzyjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPYVyb5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPYVyb5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E881F000E9;
	Sat, 25 Jul 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985258;
	bh=rQKUOQwkGHcYW9n0GP3LeQK8QxSnFVbnQZ+xUmXIhJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WPYVyb5R3ap/UNNYFTpa3HWzBCzj0PYy+buZDgwnIQCKBSXslUXN+9YIoi/zqUOej
	 +YhdPwiopRFScmnTYLDyxNinXP5LZxXvh1+5I/GYtioPadG96OiKk+1FlhGyv2V/9W
	 /qqm/JQ8HVTXsXsooFj2vwZSEC1P7H6OciFZUN1szeL1wIWu9lO4Rd1JXAaTZJE70Y
	 jQjen1wlkfBeoPAoMsXsIOW+5sUmX7iMrzcxtWa1CELiHXreoqjnkHM/y+SdIfMtKE
	 /fqE2YKRIrCEMIpbQ4NnikvvscQomdWhHeU+oxKCWtkGBIBGO84JEx+EcqKEGXkN79
	 eBOHqORniGJQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/6] selftests: mptcp: sockopt: cover LINGER REUSEADDR PRIORITY NODELAY SYNCNT
Date: Sat, 25 Jul 2026 21:13:43 +0800
Message-ID: <d8365475a20c80c0d4b33d490de4f9885e0838b8.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extend mptcp_sockopt.c with tests for SOL_SOCKET (SO_REUSEADDR,
SO_LINGER, SO_PRIORITY) and SOL_TCP (TCP_NODELAY, TCP_SYNCNT), each
exercising both setsockopt() and getsockopt() on a connected
MPTCP socket.

SO_REUSEADDR on the msk reports 1 (SK_CAN_REUSE) once any non-zero
value is set; this captures the documented behaviour where the
master socket reflects the subflow's reuse state.

TCP_SYNCNT coverage pairs with the kernel side that propagates
icsk_syn_retries to the subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..b04e24df9dfe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -35,6 +35,9 @@ static int pf = AF_INET;
 #ifndef SOL_MPTCP
 #define SOL_MPTCP 284
 #endif
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
 
 #ifndef MPTCP_INFO
 struct mptcp_info {
@@ -229,6 +232,30 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	return sock;
 }
 
+static void test_so_reuseaddr_sockopt(int fd)
+{
+	int val_in = 1, val_out, expected;
+	socklen_t s;
+	int r;
+
+	r = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val_in, sizeof(val_in));
+	if (r != 0)
+		die_perror("setsockopt SO_REUSEADDR");
+
+	s = sizeof(val_out);
+	r = getsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val_out, &s);
+	if (r != 0)
+		die_perror("getsockopt SO_REUSEADDR");
+
+	/* SO_REUSEADDR on MPTCP msk returns 1 (SK_CAN_REUSE) when set,
+	 * regardless of the input value. The actual reuse semantics are
+	 * applied to the nmpc subflow.
+	 */
+	expected = val_in ? 1 : 0;
+	if (val_out != expected)
+		xerror("SO_REUSEADDR %d != %d\n", expected, val_out);
+}
+
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
@@ -247,6 +274,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		test_so_reuseaddr_sockopt(sock);
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
@@ -769,6 +798,89 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_so_linger_sockopt(int fd)
+{
+	struct linger ling_in, ling_out;
+	socklen_t s;
+	int r;
+
+	ling_in.l_onoff = 1;
+	ling_in.l_linger = 30;
+	r = setsockopt(fd, SOL_SOCKET, SO_LINGER, &ling_in, sizeof(ling_in));
+	if (r != 0)
+		die_perror("setsockopt SO_LINGER");
+
+	s = sizeof(ling_out);
+	memset(&ling_out, 0, sizeof(ling_out));
+	r = getsockopt(fd, SOL_SOCKET, SO_LINGER, &ling_out, &s);
+	if (r != 0)
+		die_perror("getsockopt SO_LINGER");
+
+	if (ling_in.l_onoff != ling_out.l_onoff ||
+	    ling_in.l_linger != ling_out.l_linger)
+		xerror("SO_LINGER %d/%d != %d/%d\n",
+		       ling_in.l_onoff, ling_in.l_linger,
+		       ling_out.l_onoff, ling_out.l_linger);
+}
+
+static void test_so_priority_sockopt(int fd)
+{
+	int prio_in, prio_out;
+	socklen_t s;
+	int r;
+
+	prio_in = 5;
+	r = setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &prio_in, sizeof(prio_in));
+	if (r != 0)
+		die_perror("setsockopt SO_PRIORITY");
+
+	s = sizeof(prio_out);
+	r = getsockopt(fd, SOL_SOCKET, SO_PRIORITY, &prio_out, &s);
+	if (r != 0)
+		die_perror("getsockopt SO_PRIORITY");
+
+	if (prio_in != prio_out)
+		xerror("SO_PRIORITY %d != %d\n", prio_in, prio_out);
+}
+
+static void test_tcp_nodelay_sockopt(int fd)
+{
+	int val_in = 1, val_out;
+	socklen_t s;
+	int r;
+
+	r = setsockopt(fd, SOL_TCP, TCP_NODELAY, &val_in, sizeof(val_in));
+	if (r != 0)
+		die_perror("setsockopt TCP_NODELAY");
+
+	s = sizeof(val_out);
+	r = getsockopt(fd, SOL_TCP, TCP_NODELAY, &val_out, &s);
+	if (r != 0)
+		die_perror("getsockopt TCP_NODELAY");
+
+	if (val_in != val_out)
+		xerror("TCP_NODELAY %d != %d\n", val_in, val_out);
+}
+
+static void test_tcp_syncnt_sockopt(int fd)
+{
+	int val_in = 3, val_out;
+	socklen_t s;
+	int r;
+
+	r = setsockopt(fd, SOL_TCP, TCP_SYNCNT, &val_in, sizeof(val_in));
+	if (r != 0)
+		die_perror("setsockopt TCP_SYNCNT");
+
+	s = sizeof(val_out);
+	r = getsockopt(fd, SOL_TCP, TCP_SYNCNT, &val_out, &s);
+	if (r != 0)
+		die_perror("getsockopt TCP_SYNCNT");
+
+	if (val_in != val_out)
+		xerror("TCP_SYNCNT %d != %d\n", val_in, val_out);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +899,10 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_so_linger_sockopt(fd);
+	test_so_priority_sockopt(fd);
+	test_tcp_nodelay_sockopt(fd);
+	test_tcp_syncnt_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0

