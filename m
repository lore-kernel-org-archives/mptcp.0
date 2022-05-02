Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E915D0
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 16:36:47 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nlZ2T-0000lY-SW; Mon, 02 May 2022 18:36:45 +0200
From: Florian Westphal <fw@strlen.de>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next] selftests: mptcp: add TCP_DEFER test case
Date: Mon,  2 May 2022 18:36:41 +0200
Message-Id: <20220502163641.6146-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that value x can be set and retrieved.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ac9a4d9c1764..12aa2d921fd5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -133,10 +133,43 @@ static void xgetaddrinfo(const char *node, const char *service,
 	}
 }
 
+static void check_tcp_defer(int sock, unsigned int value)
+{
+	unsigned int rv;
+	socklen_t rvl;
+	int err;
+
+	rvl = sizeof(rv);
+	err = getsockopt(sock, IPPROTO_TCP, TCP_DEFER_ACCEPT, &rv, &rvl);
+	if (err) {
+		perror("getsockopt TCP_DEFER_ACCEPT");
+		exit(1);
+	}
+
+	assert(rvl == (int)sizeof(rv));
+	assert(rv == value);
+}
+
+static unsigned int set_tcp_defer(int sock)
+{
+	unsigned int v = rand();
+	int err;
+
+	v &= 0x1f;
+
+	err = setsockopt(sock, IPPROTO_TCP, TCP_DEFER_ACCEPT, &v, sizeof(v));
+	if (err) {
+		perror("setsockopt TCP_DEFER_ACCEPT");
+		exit(1);
+	}
+
+	return v;
+}
+
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock, value;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
@@ -173,9 +206,13 @@ static int sock_listen_mptcp(const char * const listenaddr,
 	if (sock < 0)
 		xerror("could not create listen socket");
 
+	value = set_tcp_defer(sock);
+
 	if (listen(sock, 20))
 		die_perror("listen");
 
+	check_tcp_defer(sock, value);
+
 	return sock;
 }
 
@@ -630,7 +667,7 @@ static void test_ip_tos_sockopt(int fd)
 	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
 	if (r != -1 && errno != EINVAL)
 		die_perror("getsockopt IP_TOS did not indicate -EINVAL");
-	if (s != -1)
+	if ((int)s != -1)
 		xerror("expect socklen_t == -1");
 }
 
-- 
2.35.1

