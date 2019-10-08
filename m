Content-Type: multipart/mixed; boundary="===============0597630949353622438=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] selftests: test setsockopt(..., TCP_ULP, "mptcp",
 ...)
Date: Tue, 08 Oct 2019 16:43:13 +0200
Message-ID: <bcf0f12a631a334f98e59a5b9302695db4854066.1570545679.git.dcaratti@redhat.com>
In-Reply-To: cover.1570545679.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2049

--===============0597630949353622438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add a selftest to verify that the kernel forbids attaching MPTCP subflows
to userspace TCP sockets with setsockopt(..., IPPROTO_TCP, TCP_ULP, ...).

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 49 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index cac71f0ac8f8..12a722e0c527 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -18,7 +18,8 @@
 =

 #include <netdb.h>
 #include <netinet/in.h>
-#include <netinet/tcp.h>
+
+#include <linux/tcp.h>
 =

 extern int optind;
 =

@@ -32,11 +33,12 @@ static int  poll_timeout;
 static const char *cfg_host;
 static const char *cfg_port	=3D "12000";
 static int cfg_sock_proto	=3D IPPROTO_MPTCP;
+static bool tcpulp_audit;
 =

 =

 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-s MPTCP|TCP] [-p port] "
+	fprintf(stderr, "Usage: mptcp_connect [-u] [-s MPTCP|TCP] [-p port] "
 		"[ -l ] [ -t timeout ] connect_address\n");
 	exit(1);
 }
@@ -114,6 +116,41 @@ static int sock_listen_mptcp(const char * const listen=
addr,
 	return sock;
 }
 =

+static bool sock_test_tcpulp(const char * const remoteaddr,
+			     const char * const port)
+{
+
+	struct addrinfo hints =3D {
+		.ai_protocol =3D IPPROTO_TCP,
+		.ai_socktype =3D SOCK_STREAM,
+	};
+	struct addrinfo *a, *addr;
+	int sock =3D -1, ret =3D 0;
+	bool test_pass =3D false;
+
+	hints.ai_family =3D AF_INET;
+
+	xgetaddrinfo(remoteaddr, port, &hints, &addr);
+	for (a =3D addr; a; a =3D a->ai_next) {
+		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
+		if (sock < 0) {
+			perror("socket");
+			continue;
+		}
+
+		ret =3D setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
+				 sizeof("mptcp"));
+		close(sock);
+		if (ret =3D=3D -1) {
+			test_pass =3D true;
+			break;
+		}
+
+		perror("setsockopt(TCP_ULP)");
+	}
+	return test_pass;
+}
+
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto)
 {
@@ -362,7 +399,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "lp:s:ht:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "lp:s:hut:")) !=3D -1) {
 		switch (c) {
 		case 'l':
 			listen_mode =3D true;
@@ -376,6 +413,9 @@ static void parse_opts(int argc, char **argv)
 		case 'h':
 			die_usage();
 			break;
+		case 'u':
+			tcpulp_audit =3D true;
+			break;
 		case 't':
 			poll_timeout =3D atoi(optarg) * 1000;
 			if (poll_timeout <=3D 0)
@@ -395,6 +435,9 @@ int main(int argc, char *argv[])
 =

 	parse_opts(argc, argv);
 =

+	if (tcpulp_audit)
+		return sock_test_tcpulp(cfg_host, cfg_port) ? 0 : 1;
+
 	if (listen_mode) {
 		int fd =3D sock_listen_mptcp(cfg_host, cfg_port);
 =

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 7d312bd9ac77..25f1a181c73e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -134,6 +134,23 @@ check_mptcp_disabled()
 	return 0
 }
 =

+check_mptcp_ulp_setsockopt()
+{
+	local t=3D"ns_ulp" retval=3D
+
+	ip netns add ${t} || exit $ksft_skip
+	if ! ip netns exec ${t} ./mptcp_connect -u -p 10000 -s TCP 127.0.0.1 >/de=
v/null 2>&1; then
+		printf "setsockopt(..., TCP_ULP, \"mptcp\", ...) allowed\t[ FAIL ]\n"
+		retval=3D1
+		ret=3D$retval
+	else
+		printf "setsockopt(..., TCP_ULP, \"mptcp\", ...) blocked\t[ OK ]\n"
+		retval=3D0
+	fi
+	ip netns del ${t}
+	return $retval
+}
+
 do_ping()
 {
 	listener_ns=3D"$1"
@@ -271,6 +288,8 @@ make_file "$sin" "server"
 =

 check_mptcp_disabled
 =

+check_mptcp_ulp_setsockopt
+
 for sender in 1 2 3 4;do
 	do_ping ns1 ns$sender 10.0.1.1
 =

-- =

2.21.0

--===============0597630949353622438==--
