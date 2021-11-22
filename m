Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAB68
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 15:27:01 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mpBDg-0002XZ-27; Mon, 22 Nov 2021 16:27:00 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out are the same
Date: Mon, 22 Nov 2021 16:26:51 +0100
Message-Id: <20211122152651.28466-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211122152651.28466-1-fw@strlen.de>
References: <20211122152651.28466-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that getsockopt(IP_TOS) returns what setsockopt(IP_TOS) did set
right before.

Also check that socklen_t == 0 and -1 input values match those
of normal tcp sockets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 417b11cafafe..5b87e162e704 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -4,6 +4,7 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <string.h>
 #include <stdarg.h>
@@ -13,6 +14,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <strings.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <sys/socket.h>
@@ -594,6 +596,44 @@ static int server(int pipefd)
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
+		xerror("tos %x != %x socklen_t %d\n", tos_in, tos_out, s);
+
+	if (s != 1)
+		xerror("tos should be 1 byte");
+
+	s = 0;
+	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
+	if (r != 0)
+		die_perror("getsockopt IP_TOS 0");
+	if (s != 0)
+		xerror("expect socklen_t == 0");
+
+	s = -1;
+	r = getsockopt(fd, SOL_IP, IP_TOS, &tos_out, &s);
+	if (r != -1 && errno != EINVAL)
+		die_perror("getsockopt IP_TOS did not indicate -EINVAL");
+	if (s != -1)
+		xerror("expect socklen_t == -1");
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -611,6 +651,8 @@ static int client(int pipefd)
 		xerror("Unknown pf %d\n", pf);
 	}
 
+	test_ip_tos_sockopt(fd);
+
 	connect_one_server(fd, pipefd);
 
 	return 0;
@@ -642,6 +684,23 @@ static int rcheck(int wstatus, const char *what)
 	return 111;
 }
 
+static void init_rng(void)
+{
+	int fd = open("/dev/urandom", O_RDONLY);
+
+	if (fd >= 0) {
+		unsigned int foo;
+
+		/* can't fail */
+		(void)read(fd, &foo, sizeof(foo));
+
+		close(fd);
+		srand(foo);
+	} else {
+		srand(time(NULL));
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int e1, e2, wstatus;
@@ -650,6 +709,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	init_rng();
+
 	e1 = pipe(pipefds);
 	if (e1 < 0)
 		die_perror("pipe");
-- 
2.32.0

