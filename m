Content-Type: multipart/mixed; boundary="===============5500281697061057826=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 1/3] selftests: add mptcp ip set/getsockopt test
 program
Date: Thu, 05 Mar 2020 14:22:29 +0100
Message-ID: <20200305132231.22953-2-fw@strlen.de>
In-Reply-To: 20200305132231.22953-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3870

--===============5500281697061057826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Useless for the time being as this depends on an ugly hack to expose
IP_OPTIONS set/getsockopt.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_setsockopt.c    | 220 ++++++++++++++++++
 1 file changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_setsockopt.c

diff --git a/tools/testing/selftests/net/mptcp/mptcp_setsockopt.c b/tools/t=
esting/selftests/net/mptcp/mptcp_setsockopt.c
new file mode 100644
index 000000000000..aa2405b54013
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_setsockopt.c
@@ -0,0 +1,220 @@
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include <arpa/inet.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+
+#include <netinet/ip.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#define OPT_SIZE 40
+
+enum test_ipopt_state {
+	TEST_OPTS_NONE,
+	TEST_OPTS_SET,
+	TEST_OPTS_RX_SET,
+};
+
+static void die(const char *s)
+{
+	perror(s);
+	exit(1);
+}
+
+static void xgetsockopt(int sockfd, int level, int optname,
+		        void *optval, socklen_t *optlen)
+{
+	int err =3D getsockopt(sockfd, level, optname, optval, optlen);
+
+	if (err < 0)
+		die("getsockopt");
+}
+
+static void xsetsockopt(int sockfd, int level, int optname,
+		        const void *optval, socklen_t optlen)
+{
+	int err =3D setsockopt(sockfd, level, optname, optval, optlen);
+
+	if (err < 0)
+		die("setsockopt");
+}
+
+static void xbind(int fd, struct sockaddr_in *sin, socklen_t l)
+{
+	int err =3D bind(fd, (void *)sin, l);
+
+	if (err < 0)
+		die("bind");
+}
+
+static void set_ipopts(int fd)
+{
+	char options[OPT_SIZE];
+	uint8_t olen =3D 5;
+
+	memset(options, 0, sizeof(options));
+
+	options[0] =3D IPOPT_TS | IPOPT_TS_TSONLY;
+	options[1] =3D sizeof(options);
+	options[2] =3D olen;
+
+	xsetsockopt(fd, SOL_IP, IP_OPTIONS, options, sizeof(options));
+}
+
+static void check_ip_opts(int fd, enum test_ipopt_state state,
+			  const char *prefix)
+{
+	socklen_t bufsz =3D 128;
+	char buf[128];
+
+	memset(buf, 0, sizeof(buf));
+
+	xgetsockopt(fd, SOL_IP, IP_OPTIONS, buf, &bufsz);
+
+	if (state =3D=3D TEST_OPTS_NONE) {
+		printf("%s: expect IP_OPTIONS are cleared ", prefix);
+		if (bufsz =3D=3D 0)
+			puts("[ OK ]");
+		else
+			printf("but got %d [ FAIL ]\n", (int)bufsz);
+
+		return;
+	}
+
+	printf("%s: expect IP_OPTIONS are set ", prefix);
+	if (bufsz =3D=3D OPT_SIZE &&
+	    buf[0] =3D=3D (IPOPT_TS | IPOPT_TS_TSONLY) &&
+	    buf[1] =3D=3D OPT_SIZE)
+		puts("[ OK ]");
+	else if (bufsz =3D=3D 0)
+		puts("[ FAIL ]");
+	else
+		printf(" -- opt length %d, 0x%x/0x%x/0x%x [ FAIL ]\n", (int)bufsz,
+			buf[0], buf[1], buf[2]);
+}
+
+static int server_fd(void)
+{
+	int fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	struct sockaddr_in sin;
+	static const int on =3D 1;
+
+	if (fd < 0)
+		die("socket");
+
+	if (alarm(9))
+		die("alarm");
+
+	xsetsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on));
+
+	sin.sin_family =3D AF_INET;
+	sin.sin_addr.s_addr =3D inet_addr("127.0.0.1");
+	sin.sin_port =3D htons(0x4242);
+	xbind(fd, &sin, sizeof(sin));
+
+	listen(fd, 10);
+
+	return fd;
+}
+
+static void server_handle_client(int fd, enum test_ipopt_state opts,
+				 const char *testname)
+{
+	char buf[8192];
+	int fdc, err;
+
+	if (opts =3D=3D TEST_OPTS_SET)
+		set_ipopts(fd);
+
+	fdc =3D accept(fd, NULL, NULL);
+	if (fdc < 0)
+		die("accept");
+
+	if (opts =3D=3D TEST_OPTS_SET)
+		set_ipopts(fdc);
+
+	do {
+		err =3D (int)read(fdc, buf, sizeof(buf));
+		if (err < 0)
+			die("read");
+		write(fdc, ".", 1);
+	} while (err > 0);
+
+	check_ip_opts(fdc, opts, testname);
+	close(fdc);
+}
+
+static void client(enum test_ipopt_state state, const char *testname)
+{
+	int err, fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	struct sockaddr_in sin;
+	char buf[64];;
+
+	if (fd < 0)
+		die("socket");
+
+	sin.sin_family =3D AF_INET;
+	sin.sin_addr.s_addr =3D inet_addr("127.0.0.1");
+	sin.sin_port =3D htons(0x4242);
+
+	if (state =3D=3D TEST_OPTS_SET)
+		set_ipopts(fd);
+
+	err =3D connect(fd, (void *)&sin, sizeof(sin));
+	if (err < 0)
+		die("connect");
+
+	write(fd, "Test", sizeof("Test"));
+	read(fd, buf, sizeof(buf));
+
+	check_ip_opts(fd, state, testname);
+	close(fd);
+}
+
+int main(void)
+{
+	pid_t ret, pid =3D fork();
+	int wstatus;
+
+	if (pid < 0)
+		die("fork");
+
+	if (pid =3D=3D 0) {
+		int fd =3D server_fd();
+
+		if (fd < 0)
+			die("server_fd");
+
+		server_handle_client(fd, TEST_OPTS_NONE, "srv1");
+		server_handle_client(fd, TEST_OPTS_RX_SET, "srv2");
+		server_handle_client(fd, TEST_OPTS_SET, "srv3");
+
+		close(fd);
+		exit(0);
+	}
+
+	sleep(1);
+	client(TEST_OPTS_NONE, "client1");
+	client(TEST_OPTS_SET, "client2");
+	client(TEST_OPTS_NONE, "client3");
+
+	do {
+		ret =3D wait(&wstatus);
+	} while (ret !=3D pid);
+
+	if (WIFEXITED(wstatus))
+		return WEXITSTATUS(wstatus);
+
+	fprintf(stderr, "Bad return value from %d (signaled %d)\n", (int)pid, WIF=
SIGNALED(wstatus));
+	return 111;
+}
-- =

2.24.1

--===============5500281697061057826==--
