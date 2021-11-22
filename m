Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328E2C81
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 11:22:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mp7Os-0001QL-TZ; Mon, 22 Nov 2021 12:22:18 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out are the same
Date: Mon, 22 Nov 2021 12:22:05 +0100
Message-Id: <20211122112205.16752-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211122112205.16752-1-fw@strlen.de>
References: <20211122112205.16752-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that getsockopt(IP_TOS) returns what setsockopt(IP_TOS) did set
right before.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 417b11cafafe..87ed6d050e67 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -4,6 +4,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <string.h>
 #include <stdarg.h>
@@ -594,6 +595,30 @@ static int server(int pipefd)
 	return 0;
 }
 
+static void test_ip_tos_sockopt(int fd)
+{
+	uint8_t tos_in, tos_out;
+	socklen_t s;
+	int r;
+
+	tos_in = rand() & 0xfc;
+	r = setsockopt(fd, SOL_IP, IP_TOS, &tos_in, sizeof(tos_out));
+	if (r != 0)
+		die_perror("setsockopt IP_TOS");
+
+	tos_out = 0;
+	s = sizeof(tos_out);
+	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
+	if (r != 0)
+		die_perror("getsockopt IP_TOS");
+
+	if (tos_in != tos_out)
+		xerror("tos %x != %x\n", tos_in, tos_out);
+
+	if (s != 1)
+		xerror("tos should be 1 byte");
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -611,6 +636,8 @@ static int client(int pipefd)
 		xerror("Unknown pf %d\n", pf);
 	}
 
+	test_ip_tos_sockopt(fd);
+
 	connect_one_server(fd, pipefd);
 
 	return 0;
@@ -642,6 +669,22 @@ static int rcheck(int wstatus, const char *what)
 	return 111;
 }
 
+static void init_rng(void)
+{
+	int fd = open("/dev/urandom", O_RDONLY);
+	unsigned int foo;
+
+	if (fd > 0) {
+		int ret = read(fd, &foo, sizeof(foo));
+
+		if (ret < 0)
+			srand(fd + foo);
+		close(fd);
+	}
+
+	srand(foo);
+}
+
 int main(int argc, char *argv[])
 {
 	int e1, e2, wstatus;
@@ -650,6 +693,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	init_rng();
+
 	e1 = pipe(pipefds);
 	if (e1 < 0)
 		die_perror("pipe");
-- 
2.32.0

